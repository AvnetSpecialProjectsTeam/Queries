SELECT DISTINCT
	Mc.Material
	,[MfgPartNbr]
	, Mc.Plant
	,[CoreMaterialNbr]
	,[Pbg]
	,Spl.[Mfg]
	,Spl.[ProdHrchy]
	,[PrcStgy]
	,[Tech]
	,[CC]
	,Spl.[Grp]
	,[VendorNbr]
	,[VendorPartNbr]
	,[BknNoCore]
	,Di.QOH
	,Di.QAS
	,Di.QAS*Cr.MinCost AS InvValue
	,Pobl.UnConfirmedQty
	,Pobl.UnConfirmedQty* Cr.MinCost AS UnConfirmedPoVal
	,Pobl.ConfirmedQty
	,Pobl.ConfirmedQty * Cr.MinCost AS ConfirmedPoVal
	,(Pobl.UnConfirmedQty+Pobl.ConfirmedQty) * Cr.MinCost AS TotalPoVal
	,Sobl.SoQty
	 ,Sobl.SoQty* Cr.UnitResale AS SoVal
	,Mc.MinLotQty
	,CASE WHEN Mc.RoundingVal< ISNULL(Pobl.ConfirmedQty,0)+ISNULL(Pobl.UnConfirmedQty,0) THEN 'X' END AS ExcessPO
	,Mc.RoundingVal
	,CASE WHEN RoundingVal<Di.QAS THEN 'X' END AS ExcessInv
FROM SAP.dbo.Marc AS Mc
	INNER JOIN
		(SELECT *
		FROM CentralDbs.dbo.SapPartsList AS Spl
		WHERE Spl.MfgPartNbr LIKE '%/BKN%' AND MatHubState<>-1 AND SendToSapFl='Y') AS Spl
		ON Mc.Material=Spl.MaterialNbr
	LEFT JOIN 
		(SELECT Pobl.MaterialNbr, Pobl.plant, Pobl.PoNbr, Pobl.PoLine, Pobl.PoSchedLine, CASE WHEN Pobl.ConfDlvryDt IS NULL THEN SUM(Pobl.SchedQty) ELSE 0 END AS UnConfirmedQty, CASE WHEN Pobl.ConfDlvryDt IS NOT NULL THEN SUM(Pobl.SchedQty) ELSE 0 END AS ConfirmedQty
		FROM Bi.dbo.BIPoBacklog AS Pobl
		GROUP BY Pobl.MaterialNbr, Pobl.plant, Pobl.PoNbr, Pobl.PoLine, Pobl.PoSchedLine, Pobl.ConfDlvryDt) AS Pobl
		ON Mc.Material=Pobl.MaterialNbr AND Mc.Plant=Pobl.Plant
	LEFT JOIN
		(SELECT Di.MaterialNbr, Di.Plant, SUM(Di.TtlStkQty) AS QOH, SUM(Di.AvlStkQty) AS QAS
		FROM Bi.dbo.DailyInv AS Di
		WHERE Di.StockType<>'K' AND (Di.AvlStkQty>0 OR Di.TtlStkQty>0)
		GROUP BY Di.MaterialNbr, Di.Plant) AS Di
		ON Mc.Material=Di.MaterialNbr AND Mc.Plant=Di.Plant
	LEFT JOIN
		(SELECT Sobl.MaterialNbr, Sobl.PlantId, SUM(Sobl.RemainingQty) AS SoQty
		FROM Bi.dbo.SoBacklog AS Sobl
		GROUP BY Sobl.MaterialNbr, Sobl.PlantId) AS Sobl
		ON Mc.Material=Sobl.MaterialNbr AND Mc.Plant=Sobl.PlantId
	LEFT JOIN CentralDbs.dbo.CostResale AS Cr
		ON Spl.MaterialNbr=Cr.MaterialNbr
ORDER BY Mc.Material, Mc.Plant