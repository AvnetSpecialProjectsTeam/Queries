
-----Get Material Hierarchy
--USE MDM
--CREATE TABLE #ProdHierProdAor
--	(ProductHierarchyCode VARCHAR(15)
--	,Mfg VARCHAR(10)
--    ,SapProductBusGroupCd VARCHAR(3)
--    ,SapProcureStrategyCd VARCHAR(3)
--    ,SapTechnologyCd VARCHAR(3)
--    ,SapCommodityCd VARCHAR(3)
--    ,SapProductGroupCd VARCHAR(3)
--	)

--CREATE NONCLUSTERED INDEX PHPAIndex
--ON #ProdHierProdAor (SapCommodityCd)
--INCLUDE (SapProductBusGroupCd, SapProcureStrategyCd,SapTechnologyCd,SapProductGroupCd)

--INSERT INTO #ProdHierProdAor
--SELECT DISTINCT
--	MPH.ProductHierarchyCode
--	,Party.SapPartyId AS Mfg
--    ,MPH.SapProductBusGroupCd
--    ,MPH.SapProcureStrategyCd
--    ,MPH.SapTechnologyCd
--    ,MPH.SapCommodityCd
--    ,MPH.SapProductGroupCd
--FROM MaterialProdHier AS MPH INNER JOIN Material AS Mat ON MPH.RowIdObject=Mat.MaterialProdHierarchyId INNER JOIN Party ON Mat.MdmManufacturerPartyId=Party.RowidObject
--WHERE MPH.HubStateInd<>-1 AND Party.HubStateInd<>-1 AND Mat.HubStateInd<>-1 AND MPH.SapProductGroupCd IS NOT NULL
--ORDER BY Mfg, ProductHierarchyCode
--GO





--------Combine Ztqtc Hdr, Item, and Prod Hierarchy and filter for active parts
--USE SAP
--GO

--WITH cte AS 
--	(SELECT AorId, AOREmpID, PH, Mfg,  CAST(Left(PH,3) AS VARCHAR(3)) AS PBG, CAST(SUBSTRING(PH,4,3)AS VARCHAR(3)) AS PrcStgy, CAST(SUBSTRING(PH,7,3) AS VARCHAR(3)) AS Tech, CAST(SUBSTRING(PH,10,3) AS VARCHAR(3)) AS cc, CAST(RIGHT(PH,3) AS VARCHAR(3)) AS grp, SaleOff, SaleGrp, GlobEnter, SoldTo AS AccountNbr, RANK() OVER(PARTITION BY Mfg, PH, SaleOff, SaleGrp, GlobEnter, SoldTo ORDER BY Mfg, PH, SaleOff, SaleGrp, GlobEnter, SoldTo, AorID DESC) AS Rank1
--	FROM
--		(SELECT AorId, AOREmpID, Mfg, ProductHierarchyCode AS PH, SaleOff, SaleGrp, GlobEnter, SoldTo, Min(CAT) AS Cat
--		FROM
--			(SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 1 AS Cat
--			FROM Sap.dbo.ZtqtcAorItm AS Itm INNER JOIN Sap.dbo.Ztqtcaorhdr AS Hdr ON Itm.AorId=hdr.AorId INNER JOIN #ProdHierProdAor AS PHPA ON ITM.GrpCode=PHPA.SapProductGroupCd
--			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)
--			UNION
--			SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 2 AS Cat
--			FROM Sap.dbo.ZtqtcAorItm AS Itm INNER JOIN Sap.dbo.Ztqtcaorhdr AS Hdr ON Itm.AorId=hdr.AorId INNER JOIN #ProdHierProdAor AS PHPA ON ITM.ComProdHier=PHPA.SapCommodityCd
--			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)
--			UNION
--			SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 3 AS Cat
--			FROM Sap.dbo.ZtqtcAorItm AS Itm INNER JOIN Sap.dbo.Ztqtcaorhdr AS Hdr ON Itm.AorId=hdr.AorId INNER JOIN #ProdHierProdAor AS PHPA ON ITM.Tech=PHPA.SapTechnologyCd
--			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)
--			UNION
--			SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 4 AS Cat
--			FROM Sap.dbo.ZtqtcAorItm AS Itm INNER JOIN Sap.dbo.Ztqtcaorhdr AS Hdr ON Itm.AorId=hdr.AorId INNER JOIN #ProdHierProdAor AS PHPA ON ITM.ProcStrat=PHPA.SapProcureStrategyCd
--			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)
--			UNION
--			SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 5 AS Cat
--			FROM Sap.dbo.ZtqtcAorItm AS Itm INNER JOIN Sap.dbo.Ztqtcaorhdr AS Hdr ON Itm.AorId=hdr.AorId INNER JOIN #ProdHierProdAor AS PHPA ON ITM.ProdBusiGrp=PHPA.SapProductBusGroupCd
--			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)) AS A
--		GROUP BY Mfg, ProductHierarchyCode, SaleOff, SaleGrp, GlobEnter, SoldTo, AorId, AOREmpID) AS B)
--SELECT *
--INTO #ProdSaleAOR
--FROM cte
----WHERE PH LIKE '%HET%'
--WHERE Rank1=1
--ORDER BY PH, SaleOff, SaleGrp, GlobEnter, AccountNbr


--DROP TABLE #ProdHierProdAor

-----Create Account Heirarchy
--USE SAP
--GO
--SELECT DISTINCT CAST(C.GlobEnter AS INT) AS GlobEnter, CAST(CH5.SoldToPartyId AS INT) AS AccountNbr
--INTO #GEAN
--FROM
--	(SELECT B.GlobEnter, CH4.SoldToPartyId, CH4.HighLvlCust
--	FROM
--		(SELECT A.GlobEnter, CH3.SoldToPartyId, CH3.HighLvlCust
--		FROM 
--			(SELECT CH.SoldToPartyId AS GlobEnter, CH.HighLvlCust, CH.ValidFrom, CH.ValidTo
--			FROM Sap.dbo.Knvh AS CH
--			INNER JOIN Sap.dbo.Knvh AS CH2 ON CH.SoldToPartyId=CH2.HighLvlCust
--			WHERE CH.ValidFrom<GETDATE() AND CH.ValidTo>GETDATE() AND CH.HighLvlCust=' ') AS A
--		INNER JOIN Sap.dbo.Knvh AS CH3 ON A.GlobEnter=CH3.HighLvlCust) AS B
--	INNER JOIN Sap.dbo.Knvh AS CH4 ON B.SoldToPartyId=CH4.HighLvlCust) AS C
--INNER JOIN Sap.dbo.Knvh AS CH5 ON C.SoldToPartyId=CH5.HighLvlCust


-----Create Final ProdAor
--SELECT AorId, AOREmpID, PH, Pbg, PrcStgy, Tech, cc, grp, SaleOff, SaleGrp, PSAor.GlobEnter, GN.AccountNbr
--INTO CentralDbs.dbo.ProdAor
--FROM #ProdSaleAOR AS PSAor LEFT JOIN #GEAN AS GN ON PSAor.GlobEnter=GN.GlobEnter
--GO

--DROP TABLE #ProdSaleAOR
--DROP TABLE #GEAN
GO


--DROP TABLE #Stbl
----Create SO link
SELECT CAST([Sales Doc ] AS BIGINT) AS SO, CAST(ITEM AS INT) AS Item ,[Product hierarchy] AS PH, CAST(Left([Product hierarchy],3) AS VARCHAR(3)) AS PBG, CAST(SUBSTRING([Product hierarchy],4,3)AS VARCHAR(3)) AS Pcrstgy,CAST(SUBSTRING([Product hierarchy],7,3) AS VARCHAR(3)) AS Tech, CAST(SUBSTRING([Product hierarchy],10,3) AS VARCHAR(3)) AS cc, CAST(RIGHT([Product hierarchy],3) AS VARCHAR(3)) AS grp, CAST([SOff ] AS INT) AS Soff, CAST(SGrp AS INT) AS Sgrp, Import.[Sold-to pt] AS AccountNbr
INTO #Stbl
FROM SAP.dbo.ProdAorUpload AS Import
GO



----Link SO and ProdAor
WITH cte AS 
(SELECT DISTINCT EID.SO, EID.Item, EID.PH , CASE WHEN EID.Saleoff IS NULL THEN 999999999 ELSE EID.Saleoff END AS SaleOff, CASE WHEN EID.SaleGrp IS NULL THEN 999999999 ELSE EID.SaleGrp END AS SaleGrp, CASE WHEN EID.GlobEnter IS NULL THEN 999999999 ELSE EID.GlobEnter END AS GlobEnter, CASE WHEN EID.AccountNbr IS NULL THEN 999999999 ELSE EID.AccountNbr END AS AccountNbr, EID.AorId, EID.AorEmpId, ZHdr.EmpFirstName, ZHdr.EmpLastName, RANK() OVER(PARTITION BY  EID.SO, EID.Item ORDER BY EID.SO ASC, EID.Item ASC, EID.PH ASC, EID.AccountNbr DESC, EID.GlobEnter DESC, EID.SaleGrp DESC, EID.Saleoff DESC, EID.AorId DESC) AS Rank1
FROM
	--PH, SOff, SGrp, AccountNbr
	(SELECT ST.SO, ST.Item, CONCAT(ProdAor.pbg, ProdAor.prcstgy, ProdAor.tech, ProdAor.cc, ProdAor.grp) AS PH, ProdAor.Saleoff, ProdAor.SaleGrp, ProdAor.GlobEnter, ProdAor.AccountNbr, ProdAor.AorEmpId, ProdAor.AorId
	FROM CentralDbs.dbo.ProdAor AS ProdAor 
		INNER JOIN #Stbl AS ST 
			ON CONCAT(ProdAor.pbg, ProdAor.prcstgy, ProdAor.tech, ProdAor.cc, ProdAor.grp)=ST.PH AND ProdAor.SaleOff=ST.Soff AND ProdAor.SaleGrp=ST.Sgrp AND ProdAor.AccountNbr=ST.AccountNbr
	UNION
	--PH, Soff, Sgrp 
	SELECT ST.SO, ST.Item, CONCAT(ProdAor.pbg, ProdAor.prcstgy, ProdAor.tech, ProdAor.cc, ProdAor.grp) AS PH, ProdAor.Saleoff, ProdAor.SaleGrp, ProdAor.GlobEnter, ProdAor.AccountNbr, ProdAor.AorEmpId, ProdAor.AorId
	FROM CentralDbs.dbo.ProdAor AS ProdAor 
		INNER JOIN #Stbl AS ST 
			ON CONCAT(ProdAor.pbg, ProdAor.prcstgy, ProdAor.tech, ProdAor.cc, ProdAor.grp)=ST.PH AND ProdAor.SaleOff=ST.Soff AND ProdAor.SaleGrp=ST.Sgrp AND ProdAor.AccountNbr IS NULL
	UNION
	--PH, Soff
	SELECT ST.SO, ST.Item, CONCAT(ProdAor.pbg, ProdAor.prcstgy, ProdAor.tech, ProdAor.cc, ProdAor.grp) AS PH, ProdAor.Saleoff, ProdAor.SaleGrp, ProdAor.GlobEnter, ProdAor.AccountNbr, ProdAor.AorEmpId, ProdAor.AorId
	FROM CentralDbs.dbo.ProdAor AS ProdAor 
		INNER JOIN #Stbl AS ST 
			ON CONCAT(ProdAor.pbg, ProdAor.prcstgy, ProdAor.tech, ProdAor.cc, ProdAor.grp)=ST.PH AND ProdAor.SaleOff=ST.Soff  AND ProdAor.Salegrp IS NULL AND ProdAor.AccountNbr IS NULL
	UNION
	--PH
	SELECT ST.SO, ST.Item, CONCAT(ProdAor.pbg, ProdAor.prcstgy, ProdAor.tech, ProdAor.cc, ProdAor.grp) AS PH, ProdAor.Saleoff, ProdAor.SaleGrp, ProdAor.GlobEnter, ProdAor.AccountNbr, ProdAor.AorEmpId, ProdAor.AorId
	FROM CentralDbs.dbo.ProdAor AS ProdAor 
		INNER JOIN #Stbl AS ST 
			ON CONCAT(ProdAor.pbg, ProdAor.prcstgy, ProdAor.tech, ProdAor.cc, ProdAor.grp)=ST.PH AND ProdAor.SaleOff IS NULL  AND ProdAor.Salegrp IS NULL AND ProdAor.AccountNbr IS NULL
	UNION
	--PH, SOff, AccountNbr
	SELECT ST.SO, ST.Item, CONCAT(ProdAor.pbg, ProdAor.prcstgy, ProdAor.tech, ProdAor.cc, ProdAor.grp) AS PH, ProdAor.Saleoff, ProdAor.SaleGrp, ProdAor.GlobEnter, ProdAor.AccountNbr, ProdAor.AorEmpId, ProdAor.AorId
	FROM CentralDbs.dbo.ProdAor AS ProdAor 
		INNER JOIN #Stbl AS ST 
			ON CONCAT(ProdAor.pbg, ProdAor.prcstgy, ProdAor.tech, ProdAor.cc, ProdAor.grp)=ST.PH AND ProdAor.SaleOff=ST.Soff AND ProdAor.SaleGrp IS NULL AND ProdAor.AccountNbr=ST.AccountNbr
	UNION
	--PH, AccountNbr
	SELECT ST.SO, ST.Item, CONCAT(ProdAor.pbg, ProdAor.prcstgy, ProdAor.tech, ProdAor.cc, ProdAor.grp) AS PH, ProdAor.Saleoff, ProdAor.SaleGrp, ProdAor.GlobEnter, ProdAor.AccountNbr, ProdAor.AorEmpId, ProdAor.AorId
	FROM CentralDbs.dbo.ProdAor AS ProdAor 
		INNER JOIN #Stbl AS ST 
			ON CONCAT(ProdAor.pbg, ProdAor.prcstgy, ProdAor.tech, ProdAor.cc, ProdAor.grp)=ST.PH AND ProdAor.SaleOff IS NULL AND ProdAor.SaleGrp IS NULL AND ProdAor.AccountNbr=ST.AccountNbr
	UNION
	--PH, SGrp, AccountNbr
	SELECT ST.SO, ST.Item, CONCAT(ProdAor.pbg, ProdAor.prcstgy, ProdAor.tech, ProdAor.cc, ProdAor.grp) AS PH, ProdAor.Saleoff, ProdAor.SaleGrp, ProdAor.GlobEnter, ProdAor.AccountNbr, ProdAor.AorEmpId, ProdAor.AorId
	FROM CentralDbs.dbo.ProdAor AS ProdAor 
		INNER JOIN #Stbl AS ST 
			ON CONCAT(ProdAor.pbg, ProdAor.prcstgy, ProdAor.tech, ProdAor.cc, ProdAor.grp)=ST.PH AND ProdAor.SaleOff IS NULL AND ProdAor.SaleGrp=ST.Sgrp AND ProdAor.AccountNbr=ST.AccountNbr) AS EID
	INNER JOIN Sap.dbo.Ztqtcaorhdr AS ZHdr 
		ON EID.AorId= ZHdr.AORID
)
INSERT INTO CentralDbs.dbo.ProdAorBlocks
SELECT *
--INTO CentralDbs.dbo.ProdAorBlocks
FROM cte
--WHERE PH LIKE '%HTD%'
WHERE Rank1=1
ORDER BY SO, ITEM





--reset 999999999 values to NULL
UPDATE SAP.dbo.SoProdAor
	SET SaleOff=
		CASE
			WHEN SaleOff=999999999 THEN NULL
			ELSE SaleOff
		END,
	SaleGrp=
		CASE
			WHEN SaleGrp=999999999 THEN NULL
			ELSE SaleGrp
		END,
	GlobEnter=
		CASE
			WHEN GlobEnter=999999999 THEN NULL
			ELSE GlobEnter
		END,
	AccountNbr=
		CASE
			WHEN AccountNbr=999999999 THEN NULL
			ELSE AccountNbr
		END


SELECT PAU.[Sales Doc ]
      ,PAU.[Item]
	  ,SPA.AorId
	  ,SPA.AorEmpId
	  ,SPA.EmpFirstName
	  ,SPA.EmpLastName
	  ,ZAH.Supervisor AS SupervisorId
	  ,PAU.[SaTy]
      ,PAU.[POtyp]
      ,PAU.[SOrg ]
      ,PAU.[Sales Organization]
	  ,[SOff ]
      ,PAU.[Description]
      ,PAU.[SGrp]
      ,PAU.[Description2]
      ,PAU.[Material]
      ,PAU.[MPN]
      ,PAU.[Pers No ]
      ,PAU.[Account Type]
      ,PAU.[Sold-to pt]
      ,PAU.[Sold-to party]
      ,PAU.[Created on]
      ,PAU.[Deliv  date]
      ,PAU.[Last Confirmed Promise Date]
      ,PAU.[ Multiple Confirmed Dates Exis]
      ,PAU.[ATP Date]
      ,PAU.[Multiple ATP Dates Exist]
      ,PAU.[Item price approval block]
      ,PAU.[Manufact ]
      ,PAU.[Product hierarchy]
      ,PAU.[MPG]
      ,PAU.[ItCa]
      ,PAU.[Rj]
      ,PAU.[DS]
      ,PAU.[DS2]
      ,PAU.[Ship Debit Status]
      ,PAU.[Ship Debit Stat 2]
      ,PAU.[Ship Debit Stat 3]
      ,PAU.[Ship Debit Stat 4]
      ,PAU.[Ship Debit Stat 5]
      ,PAU.[Ship Debit Stat 6]
      ,PAU.[Sales Cost USD]
      ,PAU.[Sales Cost USD2]
      ,PAU.[Cost Source Value]
      ,PAU.[Subtotal 4 USD]
      ,PAU.[Resale Price USD]
      ,PAU.[Extended Resale USD]
      ,PAU.[Subtotal 5 USD]
      ,PAU.[Material GP% USD]
      ,PAU.[Subtotal 6 USD]
      ,PAU.[CnTy]
      ,PAU.[Rate (text)]
      ,PAU.[Value (text)]
      ,PAU.[Crcy]
FROM SAP.dbo.ProdAorUpload AS PAU 
	LEFT JOIN CentralDbs.dbo.ProdAorBlocks AS SPA 
		ON PAU.[Sales Doc ]=SPA.SO AND  PAU.Item=SPA.Item 
		INNER JOIN Sap.dbo.Ztqtcaorhdr AS ZAH 
			ON ZAH.AORID=SPA.AorId
