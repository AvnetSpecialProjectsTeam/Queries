
-----Get Material Hierarchy
--USE MDM
--CREATE TABLE #ProdHierProdAorCopa
--	(ProductHierarchyCode VARCHAR(15)
--	,Mfg VARCHAR(10)
--    ,SapProductBusGroupCd VARCHAR(3)
--    ,SapProcureStrategyCd VARCHAR(3)
--    ,SapTechnologyCd VARCHAR(3)
--    ,SapCommodityCd VARCHAR(3)
--    ,SapProductGroupCd VARCHAR(3)
--	)

--CREATE NONCLUSTERED INDEX PHPAIndex
--ON #ProdHierProdAorCopa (SapCommodityCd)
--INCLUDE (SapProductBusGroupCd, SapProcureStrategyCd,SapTechnologyCd,SapProductGroupCd)

--INSERT INTO #ProdHierProdAorCopa
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
--			FROM ZtqtcAorItm AS Itm INNER JOIN Ztqtcaorhdr AS Hdr ON Itm.AorId=hdr.AorId INNER JOIN #ProdHierProdAorCopa AS PHPA ON ITM.GrpCode=PHPA.SapProductGroupCd
--			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)
--			UNION
--			SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 2 AS Cat
--			FROM ZtqtcAorItm AS Itm INNER JOIN Ztqtcaorhdr AS Hdr ON Itm.AorId=hdr.AorId INNER JOIN #ProdHierProdAorCopa AS PHPA ON ITM.ComProdHier=PHPA.SapCommodityCd
--			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)
--			UNION
--			SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 3 AS Cat
--			FROM ZtqtcAorItm AS Itm INNER JOIN Ztqtcaorhdr AS Hdr ON Itm.AorId=hdr.AorId INNER JOIN #ProdHierProdAorCopa AS PHPA ON ITM.Tech=PHPA.SapTechnologyCd
--			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)
--			UNION
--			SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 4 AS Cat
--			FROM ZtqtcAorItm AS Itm INNER JOIN Ztqtcaorhdr AS Hdr ON Itm.AorId=hdr.AorId INNER JOIN #ProdHierProdAorCopa AS PHPA ON ITM.ProcStrat=PHPA.SapProcureStrategyCd
--			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)
--			UNION
--			SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 5 AS Cat
--			FROM ZtqtcAorItm AS Itm INNER JOIN Ztqtcaorhdr AS Hdr ON Itm.AorId=hdr.AorId INNER JOIN #ProdHierProdAorCopa AS PHPA ON ITM.ProdBusiGrp=PHPA.SapProductBusGroupCd
--			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)) AS A
--		GROUP BY Mfg, ProductHierarchyCode, SaleOff, SaleGrp, GlobEnter, SoldTo, AorId, AOREmpID) AS B)
--SELECT *
--INTO #ProdSaleAorCopa
--FROM cte
----WHERE PH LIKE '%HET%'
--WHERE Rank1=1
--ORDER BY PH, SaleOff, SaleGrp, GlobEnter, AccountNbr


--DROP TABLE #ProdHierProdAorCopa

-----Create Account Heirarchy
--USE SAP
--GO
--SELECT DISTINCT CAST(C.GlobEnter AS INT) AS GlobEnter, CAST(CH5.SoldToPartyId AS INT) AS AccountNbr
--INTO #GeanCopa
--FROM
--	(SELECT B.GlobEnter, CH4.SoldToPartyId, CH4.HighLvlCust
--	FROM
--		(SELECT A.GlobEnter, CH3.SoldToPartyId, CH3.HighLvlCust
--		FROM
--			(SELECT CH.SoldToPartyId AS GlobEnter, CH.HighLvlCust, CH.ValidFrom, CH.ValidTo
--			FROM SAP.dbo.Knvh AS CH
--			INNER JOIN SAP.dbo.Knvh AS CH2 ON CH.SoldToPartyId=CH2.HighLvlCust
--			WHERE CH.ValidFrom<GETDATE() AND CH.ValidTo>GETDATE() AND CH.HighLvlCust=' ') AS A
--		INNER JOIN SAP.dbo.Knvh AS CH3 ON A.GlobEnter=CH3.HighLvlCust) AS B
--	INNER JOIN SAP.dbo.Knvh AS CH4 ON B.SoldToPartyId=CH4.HighLvlCust) AS C
--INNER JOIN SAP.dbo.Knvh AS CH5 ON C.SoldToPartyId=CH5.HighLvlCust


-----Create Final ProdAor
--SELECT AorId, AOREmpID, PH, Pbg, PrcStgy, Tech, cc, grp, SaleOff, SaleGrp, PSAor.GlobEnter, GN.AccountNbr
--INTO #FinProdAorCopa
--FROM #ProdSaleAorCopa AS PSAor LEFT JOIN #GeanCopa AS GN ON PSAor.GlobEnter=GN.GlobEnter;
--GO

--DROP TABLE #ProdSaleAorCopa;
--DROP TABLE #GeanCopa;




TRUNCATE TABLE CentralDbs.dbo.ProdAorCopaFinal;

----Link SO and ProdAorCopaFinal
WITH cte AS 
(SELECT DISTINCT EID.OrigSalesOrdNum, EID.SalesOrdLiItem, EID.PH , CASE WHEN EID.Saleoff IS NULL THEN 999999999 ELSE EID.Saleoff END AS SaleOff, CASE WHEN EID.SaleGrp IS NULL THEN 999999999 ELSE EID.SaleGrp END AS SaleGrp, CASE WHEN EID.GlobEnter IS NULL THEN 999999999 ELSE EID.GlobEnter END AS GlobEnter, CASE WHEN EID.AccountNbr IS NULL THEN 999999999 ELSE EID.AccountNbr END AS AccountNbr, EID.AorId, EID.AorEmpId, ZHdr.EmpFirstName, ZHdr.EmpLastName, RANK() OVER(PARTITION BY  EID.OrigSalesOrdNum, EID.SalesOrdLiItem ORDER BY EID.OrigSalesOrdNum ASC, EID.SalesOrdLiItem ASC, EID.PH ASC, EID.AccountNbr DESC, EID.GlobEnter DESC, EID.SaleGrp DESC, EID.Saleoff DESC, EID.AorId DESC) AS Rank1
FROM
	--PH, SOff, SGrp, AccountNbr
	(SELECT Pacu.OrigSalesOrdNum, Pacu.SalesOrdLiItem, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor
		INNER JOIN Bi.dbo.ProdAorCopaUpdate  AS Pacu ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Pacu.[ProdHier(3)Pbg], Pacu.ProcurementStrategy, Pacu.TechnologyCode, Pacu.CommodityCode, Pacu.GroupCode) AND PsAor.SaleOff=Pacu.SalesOffice AND PsAor.SaleGrp=Pacu.SalesGroup AND PsAor.AccountNbr=Pacu.CustomerNumber
	UNION
	--PH, Soff, Sgrp 
	SELECT Pacu.OrigSalesOrdNum, Pacu.SalesOrdLiItem, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN Bi.dbo.ProdAorCopaUpdate AS Pacu ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Pacu.[ProdHier(3)Pbg], Pacu.ProcurementStrategy, Pacu.TechnologyCode, Pacu.CommodityCode, Pacu.GroupCode) AND PsAor.SaleOff=Pacu.SalesOffice AND PsAor.SaleGrp=Pacu.SalesGroup AND PsAor.AccountNbr IS NULL
	UNION
	--PH, Soff
	SELECT Pacu.OrigSalesOrdNum, Pacu.SalesOrdLiItem, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN Bi.dbo.ProdAorCopaUpdate AS Pacu ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Pacu.[ProdHier(3)Pbg], Pacu.ProcurementStrategy, Pacu.TechnologyCode, Pacu.CommodityCode, Pacu.GroupCode) AND PsAor.SaleOff=Pacu.SalesOffice  AND PsAor.Salegrp IS NULL AND PsAor.AccountNbr IS NULL
	UNION
	--PH
	SELECT Pacu.OrigSalesOrdNum, Pacu.SalesOrdLiItem, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN Bi.dbo.ProdAorCopaUpdate AS Pacu ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Pacu.[ProdHier(3)Pbg], Pacu.ProcurementStrategy, Pacu.TechnologyCode, Pacu.CommodityCode, Pacu.GroupCode) AND PsAor.SaleOff IS NULL  AND PsAor.Salegrp IS NULL AND PsAor.AccountNbr IS NULL
	UNION
	--PH, SOff, AccountNbr
	SELECT Pacu.OrigSalesOrdNum, Pacu.SalesOrdLiItem, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN Bi.dbo.ProdAorCopaUpdate AS Pacu ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Pacu.[ProdHier(3)Pbg], Pacu.ProcurementStrategy, Pacu.TechnologyCode, Pacu.CommodityCode, Pacu.GroupCode) AND PsAor.SaleOff=Pacu.SalesOffice AND PsAor.SaleGrp IS NULL AND PsAor.AccountNbr=Pacu.CustomerNumber
	UNION
	--PH, AccountNbr
	SELECT Pacu.OrigSalesOrdNum, Pacu.SalesOrdLiItem, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor 
		INNER JOIN Bi.dbo.ProdAorCopaUpdate AS Pacu ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Pacu.[ProdHier(3)Pbg], Pacu.ProcurementStrategy, Pacu.TechnologyCode, Pacu.CommodityCode, Pacu.GroupCode) AND PsAor.SaleOff IS NULL AND PsAor.SaleGrp IS NULL AND PsAor.AccountNbr=Pacu.CustomerNumber
	UNION
	--PH, SGrp, AccountNbr
	SELECT Pacu.OrigSalesOrdNum, Pacu.SalesOrdLiItem, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN Bi.dbo.ProdAorCopaUpdate AS Pacu ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Pacu.[ProdHier(3)Pbg], Pacu.ProcurementStrategy, Pacu.TechnologyCode, Pacu.CommodityCode, Pacu.GroupCode) AND PsAor.SaleOff IS NULL AND PsAor.SaleGrp=Pacu.SalesGroup AND PsAor.AccountNbr=Pacu.CustomerNumber) AS EID
INNER JOIN SAP.dbo.Ztqtcaorhdr AS ZHdr ON EID.AorId= ZHdr.AORID
)
INSERT INTO CentralDbs.dbo.ProdAorCopaFinal
SELECT *
--INTO CentralDbs.dbo.ProdAorCopaFinal
FROM cte
--WHERE PH LIKE '%HTD%'
WHERE Rank1=1
ORDER BY OrigSalesOrdNum, SalesOrdLiItem




--reset 999999999 values to NULL
UPDATE Centraldbs.dbo.ProdAorCopaFinal
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