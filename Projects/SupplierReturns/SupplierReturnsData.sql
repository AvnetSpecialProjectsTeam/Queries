SELECT CAST(inv.MaterialNbr AS varchar(30)) AS MaterialNbr, Inv.Mfg, Packtype.ManufacturerPartNo, Inv.QOH, Inv.QAS, PackType.SapMatGroupPackagingCd, Cr.CostType, Cr.MinCost, FcModel.[ForecastModel], Pobl.PoOpenQty, PoBl.SpecOpenQty, PoBl.StoOpenQty, SoBl.SoOrderTotal, Sobl.FcOrderTotal, SoBl.BufferOrderTotal, Marc.MRPCont, Marc.MinLotSize, Marc.RndValPurOrdQty, Marc.SafeSto, Marc.StoProf, Marc.AvnABCInd, Marc.VendEDILeadTime, Marc.[PlntSpecMatStat], Marc.[IndAutoPurOrdAll], Ma.SrDir, Ma.Pld, Ma.MatlSpclst
, Fc.Ncnr
FROM (SELECT [MaterialNbr] AS MaterialNbr
			,Plant
			,Mfg
			,SUM([AvlStkQty]) AS QAS
			,SUM([TtlStkQty]) AS QOH
	FROM [BI].[dbo].[DailyInv]
	WHERE Plant=1300 AND (AvlStkQty<>0 OR TtlStkQty<>0)
	GROUP BY MaterialNbr,Plant, Mfg) AS Inv
	LEFT JOIN 
		(SELECT DISTINCT
			[SapMaterialId] AS MaterialNbr
			,ManufacturerPartNo
			,SapMatGroupPackagingCd
		FROM [MDM].[dbo].[Material]
		WHERE HubStateInd<>-1 AND SendToSapFl='Y') AS PackType
		ON Inv.MaterialNbr=PackType.MaterialNbr
	LEFT JOIN
		(SELECT MaterialNbr
			,[MinCost]
			,[CostType]
		FROM CentralDbs.dbo.[CostResale] AS Cr) AS Cr
		ON Inv.MaterialNbr=cr.MaterialNbr
	LEFT JOIN
		(SELECT [MaterialNbr], [ForecastModel]
		FROM SAP.dbo.Ztptp384ForMat
		WHERE Plant=1300) AS FcModel
		ON Inv.MaterialNbr=FcModel.MaterialNbr
	LEFT JOIN
		(SELECT A.MaterialNbr, Sum(A.PoOpenQty) AS PoOpenQty, SUM(A.SpecOpenQty) AS SpecOpenQty, SUM(A.StoOpenQty) AS StoOpenQty
		FROM (SELECT CAST([MaterialNbr] AS VARCHAR(30)) AS MaterialNbr
				,CASE WHEN Doctype='NB' THEN SUM([PoOpenQty]) END AS PoOpenQty
				,CASE WHEN Doctype='UB' THEN SUM([PoOpenQty]) END AS StoOpenQty
				,CASE WHEN Doctype='ZSB' THEN SUM([PoOpenQty]) END AS SpecOpenQty
			FROM [BI].[dbo].[BIPoBacklog]
			 WHERE Plant=1300
			GROUP BY MaterialNbr, DocType) AS A
		GROUP BY MaterialNbr) AS PoBl
		ON Inv.MaterialNbr=PoBl.MaterialNbr
	LEFT JOIN 
		(SELECT A.MaterialNbr, SUM(A.SoOrderTotal) AS SoOrderTotal, SUM(A.FcOrderTotal) AS FcOrderTotal, SUM(A.BufferOrderTotal) AS BufferOrderTotal
		FROM (SELECT [MaterialNbr] AS MaterialNbr
			,CASE WHEN [SalesDocType]='ZOR' Then SUM([OrderQty]) END AS SoOrderTotal
			 ,CASE WHEN [SalesDocType]='ZFC' Then SUM([OrderQty]) END AS FcOrderTotal
			 ,CASE WHEN [SalesDocType]='ZSB' Then SUM([OrderQty]) END AS BufferOrderTotal
			 FROM [BI].[dbo].[SoBacklog]
			WHERE PlantId=1300
			GROUP BY MaterialNbr, [SalesDocType]) AS A
		GROUP BY MaterialNbr) AS SoBl
		ON Inv.MaterialNbr=SoBl.MaterialNbr
	LEFT JOIN 
		(SELECT MatNbr,[Plnt], MRPCont, MinLotSize, RndValPurOrdQty, SafeSto, StoProf, AvnABCInd, VendEDILeadTime, [PlntSpecMatStat],[IndAutoPurOrdAll]
		FROM SAP.dbo.MARC
		WHERE Plnt=1300) AS Marc
		ON Inv.MaterialNbr=Marc.MatNbr AND INV.Plant=marc.Plnt
	LEFT JOIN
		(SELECT MaterialNbr, SapPlantCd, Ncnr
		FROM CentralDbs.dbo.SapFlagsCodes
		WHERE SapPlantCd=1300) AS Fc
		ON Inv.MaterialNbr=Fc.MaterialNbr AND Inv.Plant=Fc.SapPlantCd
	LEFT JOIN Sap.dbo.MatAor AS Ma
		ON Inv.MaterialNbr=Ma.MatNbr

		
