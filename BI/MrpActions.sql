SELECT Ml.*, CASE WHEN Ml.MrpInd='LA' THEN 'ConfPo/ShpgNote' WHEN Ml.MrpInd='BE' THEN 'PoItem' WHEN Ml.MrpInd='BA' THEN 'PurchReq' WHEN Ml.MrpInd='FE' THEN 'ProdOrder' ELSE NULL END AS ActionType, Inv.TtlStkQty AS QOH, Inv.AvlStkQty AS QAS, So.SoOrderTotal AS OpenSoQty, So.FcOrderTotal AS OpenForecastsQty, So.BufferOrderTotal, PoBl.PoOpenQty, Cr.UnitBookCost
	,Cr.UnitSpecialCost, fc.Xstatus, sq.SupplierMinOrderQt, sq.RoundingValueNo, Sq.SafetyStockQt, sq.LtManual, sq.LtVndrEdi
	,Ma.[SrDir]
	,Ma.[Pld]
	,Ma.[MatlMgr]
	,Ma.[MatlSpclst]
FROM SAP.dbo.MrpList AS Ml
	LEFT JOIN SAP.dbo.MatAor AS Ma 
		ON Ml.materialNbr=Ma.MatNbr
	LEFT JOIN CentralDbs.dbo.CostResale AS Cr
		ON Ml.MaterialNbr=Cr.MaterialNbr
	LEFT JOIN (
			SELECT
				[PoNbr]
				,[PoLine]
				,[PoSchedLine]
				,MaterialNbr
				,[Plant]
				,Sum([PoOpenQty]) AS PoOpenQty
			FROM BI.dbo.BIPoBacklog
			GROUP BY PoNbr, PoLine, PoSchedLine, MaterialNbr, Plant) AS PoBl
		ON Ml.MrpNbr=PoBl.PoNbr AND Ml.MrpItem=PoBl.PoLine AND Ml.SchedItem=PoBl.PoSchedLine
	LEFT JOIN 
		(SELECT SO.MaterialNbr, So.PlantId, SUM(SO.SoRemainingQty) AS SoOrderTotal, SUM(SO.ZfcRemainingQty) AS FcOrderTotal, SUM(SO.ZsbRemainingQty) AS BufferOrderTotal
		FROM
			(SELECT materialNbr
				,SoBl.PlantId
				,CASE WHEN SoBl.SalesDocType='ZOR' THEN SUM(RemainingQty) END AS SoRemainingQty
				,CASE WHEN Sobl.SalesDocType='ZFC' THEN SUM(RemainingQty) END AS ZfcRemainingQty
				,CASE WHEN Sobl.salesDoctype='ZSB' THEN SUM(RemainingQty) END AS ZsbRemainingQty
			FROM Bi.dbo.SoBacklog AS SoBl
			GROUP BY SoBl.MaterialNbr, SoBl.PlantId, SoBl.SalesDocType) AS SO
		GROUP BY MaterialNbr, PlantId) AS SO
		ON Ml.MaterialNbr=so.MaterialNbr AND ml.Plant=So.PlantId
	LEFT JOIN
			(SELECT 
				Di.Mfg
				,Di.materialNbr
				,Di.MfgPartNbr
				,Di.Plant
				,SUM(Di.AvlStkQty) AS AvlStkQty
				,SUM(Di.TtlStkQty) AS TtlStkQty
			FROM Bi.dbo.DailyInv AS Di
			WHERE Di.SpecialStk<>'W' OR Di.SpecialStk IS NULL
			GROUP BY Di.Mfg, Di.MaterialNbr, DI.MfgPartNbr, Di.Plant) AS Inv
		ON Ml.MaterialNbr=Inv.MaterialNbr AND Ml.Plant=Inv.Plant
	LEFT JOIN 
			(SELECT Fc.MaterialNbr, Fc.SapPlantCd, Fc.Xstatus
			FROM CentralDbs.dbo.SapFlagsCodes AS Fc) As Fc
		ON Ml.MaterialNbr=fc.MaterialNbr AND ml.Plant=fc.SapPlantCd
	LEFT JOIN
			(SELECT sq.MaterialNbr, sq.Plant, sq.SafetyStockQt, Sq.SupplierMinOrderQt, Sq.RoundingValueNo, Sq.LtManual, Sq.LtVndrEdi
			FROM CentralDbs.dbo.SapQuantities AS Sq) AS Sq
			
		ON Ml.MaterialNbr=sq.MaterialNbr AND Ml.Plant=Sq.Plant
WHERE (Ml.ExceptnNbr=10 OR Ml.ExceptnNbr=15 OR Ml.ExceptnNbr=20 OR Ml.MrpInd='BA') AND (Ml.NcnrFl IS NULL OR Ml.NcnrFl='') AND (Ma.Pbg='0ST' OR Ma.Pbg='0IT')