
SELECT *
FROM 
	(SELECT DISTINCT A.MaterialNbr, A.MfgPartNbr, Plant, A.Mfg, A.PrcStgy, A.PackageType, A.MinimumLotSizeQt, A.RoundingValueNo, A.SalesMinimumOrderQt, A.DeliveryUnitQt, A.QOH, A.PoOpenQty, A.QohPoQty, A.SoOpenQty
		--, A.SapMatlPricingGroupCd
		 ,CASE 
			WHEN A.InvPoGreaterSoBl='X' AND A.Breakable='Y' AND A.DeliveryUnitQt<>A.SalesMinimumOrderQt THEN 1 
			WHEN A.InvPoGreaterSoBl='X' AND A.Breakable='N' AND A.DeliveryUnitQt<>A.SalesMinimumOrderQt THEN A.RoundingValueNo 
			ELSE NULL END AS NewSmoq  
		,CASE 
			WHEN A.InvPoGreaterSoBl='X' AND A.Breakable='Y' AND A.SalesMinimumOrderQt<>A.DeliveryUnitQt THEN 1 
			WHEN A.InvPoGreaterSoBl='X' AND A.Breakable='N' AND A.DeliveryUnitQt<>A.SalesMinimumOrderQt THEN A.RoundingValueNo 
			ELSE NULL END AS NewDu, A.Pld, A.MatlSpclst
		,CASE WHEN A.MinimumLotSizeQt*A.MinCost>10000 THEN 'X' ELSE NULL END AS Cost
		
	FROM
		(SELECT DISTINCT Spl.MaterialNbr, Spl.MfgPartNbr, Mp.SapPlantCd AS Plant, Spl.Mfg, Spl.PrcStgy, M.SapMatGroupPackagingCd AS PackageType, Mp.MinimumLotSizeQt, Mp.RoundingValueNo, Mso.SalesMinimumOrderQt, Mso.DeliveryUnitQt, DI.QOH, Pobl.PoOpenQty, Di.QOH+Pobl.PoOpenQty AS QohPoQty, Sobl.SoOpenQty, CASE WHEN ISNULL(Di.QOH,0)+ISNULL(Pobl.PoOpenQty,0)> CASE WHEN Sobl.SoOpenQty IS NULL THEN 0 ELSE sobl.SoOpenQty END THEN 'X' END AS InvPoGreaterSoBl, Cr.MinCost, Pb.Breakable, Mso.SapMatlPricingGroupCd, Ma.Pld, Ma.MatlSpclst
		FROM 
			(SELECT *
			FROM CentralDbs.dbo.SapPartsList AS Spl
			WHERE Spl.MatHubState<>-1 AND Spl.SendToSapFl='Y') AS Spl
			INNER JOIN
				(SELECT M.RowIdObject, M.SapMatGroupPackagingCd
				FROM MDM.dbo.Material AS M
				WHERE M.HubStateInd<>-1 AND M.SendToSapFl='Y') AS M
				ON Spl.MaterialRowIdObject=M.RowIdObject
				INNER JOIN MDM.dbo.MaterialSalesOrg AS Mso
					ON M.RowIdObject=Mso.MdmMaterialId
				INNER JOIN MDM.dbo.MaterialPlant AS Mp
					ON M.RowIdObject=Mp.MdmMaterialId
			LEFT JOIN 
				(SELECT MaterialNbr, Plant, SUM(SchedQty) AS PoOpenQty
				FROM Bi.dbo.BIPoBacklog AS Pobl
				GROUP BY MaterialNbr, Plant) AS Pobl
				ON Spl.MaterialNbr=Pobl.MaterialNbr AND Mp.SapPlantCd=Pobl.Plant
			INNER JOIN Sap.dbo.MatAor AS Ma
				ON Spl.MaterialNbr=Ma.MatNbr
			LEFT JOIN 
				(SELECT Di.MaterialNbr, Di.Plant, SUM(Di.TtlStkQty) AS QOH
				FROM Bi.dbo.DailyInv AS Di
				WHERE (Di.Plant=1300 OR Di.Plant=1360) AND StockType<>'K'
				GROUP BY Di.MaterialNbr, Di.Plant) AS Di
				ON Spl.MaterialNbr=Di.MaterialNbr AND Mp.SapPlantCd=Di.Plant
			LEFT JOIN 
				(SELECT Sobl.MaterialNbr, Sobl.PlantId, SUM(Sobl.RemainingQty) AS SoOpenQty
				FROM Bi.dbo.SoBacklog AS Sobl
				WHERE SObl.SalesDocType='ZOR' AND (Sobl.PlantId=1300 OR Sobl.PlantId=1360)
				GROUP BY Sobl.MaterialNbr, Sobl.PlantId) AS Sobl
				ON Spl.MaterialNbr=Sobl.MaterialNbr AND Mp.SapPlantCd=Sobl.PlantId
			INNER JOIN CentralDbs.dbo.PackageBreaks AS Pb
				ON M.SapMatGroupPackagingCd=Pb.PackageType
			INNER JOIN CentralDbs.dbo.CostResale AS Cr
				ON Spl.MaterialNbr=Cr.MaterialNbr
		WHERE  Mp.HubStateInd<>-1 AND (Ma.SrDir LIKE '%Marco%' OR Ma.SrDir LIKE '%Marna%') AND (Mp.SapPlantCd=1300 OR Mp.SapPlantCd=1360) AND Mso.HubStateInd<>-1) AS A
	) AS B
	
WHERE (B.NewDu IS NOT NULL OR B.NewSmoq IS NOT NULL) AND B.Cost IS NULL
ORDER BY B.MaterialNbr, B.Plant





--SELECT M.SapMaterialStatusCd
--FROM MDM.dbo.MAterial AS M
--WHERE M.SapMaterialStatusCd LIKE '[SP]'