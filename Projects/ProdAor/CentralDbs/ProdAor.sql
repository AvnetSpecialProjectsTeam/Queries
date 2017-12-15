/*												PROD AOR Centraldbs

Tables used:
Mdm.dbo.MaterialProdHier
Mdm.dbo.Material
Mdm.dbo.Party 
SAP.dbo.ZtqtcAorItm
SAP.dbo.Ztqtcaorhdr
SAP.dbo.Knvh

*/






---Get Material Hierarchy
USE MDM
CREATE TABLE #ProdHierProdAorSoBl
	(ProductHierarchyCode VARCHAR(15)
	,Mfg VARCHAR(10)
    ,SapProductBusGroupCd VARCHAR(3)
    ,SapProcureStrategyCd VARCHAR(3)
    ,SapTechnologyCd VARCHAR(3)
    ,SapCommodityCd VARCHAR(3)
    ,SapProductGroupCd VARCHAR(3)
	)

CREATE NONCLUSTERED INDEX PHPAIndex
ON #ProdHierProdAorSoBl (SapCommodityCd)
INCLUDE (SapProductBusGroupCd, SapProcureStrategyCd,SapTechnologyCd,SapProductGroupCd)

INSERT INTO #ProdHierProdAorSoBl
SELECT DISTINCT
	MPH.ProductHierarchyCode
	,Party.SapPartyId AS Mfg
    ,MPH.SapProductBusGroupCd
    ,MPH.SapProcureStrategyCd
    ,MPH.SapTechnologyCd
    ,MPH.SapCommodityCd
    ,MPH.SapProductGroupCd
FROM Mdm.dbo.MaterialProdHier AS MPH 
	INNER JOIN Mdm.dbo.Material AS Mat 
		ON MPH.RowIdObject=Mat.MaterialProdHierarchyId 
		INNER JOIN Mdm.dbo.Party 
			ON Mat.MdmManufacturerPartyId=Party.RowidObject
WHERE MPH.HubStateInd<>-1 AND Party.HubStateInd<>-1 AND Mat.HubStateInd<>-1 AND MPH.SapProductGroupCd IS NOT NULL
ORDER BY Mfg, ProductHierarchyCode
GO





------Combine Ztqtc Hdr, Item, and Prod Hierarchy and filter for active parts
USE SAP
GO

WITH cte AS 
	(SELECT AorId, AOREmpID, PH, Mfg,  CAST(Left(PH,3) AS VARCHAR(3)) AS PBG, CAST(SUBSTRING(PH,4,3)AS VARCHAR(3)) AS PrcStgy, CAST(SUBSTRING(PH,7,3) AS VARCHAR(3)) AS Tech, CAST(SUBSTRING(PH,10,3) AS VARCHAR(3)) AS cc, CAST(RIGHT(PH,3) AS VARCHAR(3)) AS grp, SaleOff, SaleGrp, GlobEnter, SoldTo AS AccountNbr, RANK() OVER(PARTITION BY Mfg, PH, SaleOff, SaleGrp, GlobEnter, SoldTo ORDER BY Mfg, PH, SaleOff, SaleGrp, GlobEnter, SoldTo, AorID DESC) AS Rank1
	FROM
		(SELECT AorId, AOREmpID, Mfg, ProductHierarchyCode AS PH, SaleOff, SaleGrp, GlobEnter, SoldTo, Min(CAT) AS Cat
		FROM
			(SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 1 AS Cat
			FROM SAP.dbo.ZtqtcAorItm AS Itm 
				INNER JOIN SAP.dbo.Ztqtcaorhdr AS Hdr 
					ON Itm.AorId=hdr.AorId 
				INNER JOIN #ProdHierProdAorSoBl AS PHPA 
					ON ITM.GrpCode=PHPA.SapProductGroupCd
			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)
			UNION
			SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 2 AS Cat
			FROM SAP.dbo.ZtqtcAorItm AS Itm 
				INNER JOIN SAP.dbo.Ztqtcaorhdr AS Hdr 
					ON Itm.AorId=hdr.AorId 
				INNER JOIN #ProdHierProdAorSoBl AS PHPA 
					ON ITM.ComProdHier=PHPA.SapCommodityCd
			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)
			UNION
			SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 3 AS Cat
			FROM SAP.dbo.ZtqtcAorItm AS Itm 
				INNER JOIN SAP.dbo.Ztqtcaorhdr AS Hdr 
					ON Itm.AorId=hdr.AorId 
				INNER JOIN #ProdHierProdAorSoBl AS PHPA 
					ON ITM.Tech=PHPA.SapTechnologyCd
			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)
			UNION
			SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 4 AS Cat
			FROM SAP.dbo.ZtqtcAorItm AS Itm 
				INNER JOIN SAP.dbo.Ztqtcaorhdr AS Hdr 
					ON Itm.AorId=hdr.AorId 
				INNER JOIN #ProdHierProdAorSoBl AS PHPA 
					ON ITM.ProcStrat=PHPA.SapProcureStrategyCd
			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)
			UNION
			SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 5 AS Cat
			FROM SAP.dbo.ZtqtcAorItm AS Itm 
				INNER JOIN SAP.dbo.Ztqtcaorhdr AS Hdr 
					ON Itm.AorId=hdr.AorId 
				INNER JOIN #ProdHierProdAorSoBl AS PHPA 
					ON ITM.ProdBusiGrp=PHPA.SapProductBusGroupCd
			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)) AS A
		GROUP BY Mfg, ProductHierarchyCode, SaleOff, SaleGrp, GlobEnter, SoldTo, AorId, AOREmpID) AS B)
SELECT *
INTO #ProdSaleAorSoBl
FROM cte
--WHERE PH LIKE '%HET%'
WHERE Rank1=1
ORDER BY PH, SaleOff, SaleGrp, GlobEnter, AccountNbr


DROP TABLE #ProdHierProdAorSoBl

---Create Account Heirarchy
USE SAP
GO
SELECT DISTINCT CAST(C.GlobEnter AS INT) AS GlobEnter, CAST(CH5.SoldToPartyId AS INT) AS AccountNbr
INTO #GeanSoBl
FROM
	(SELECT B.GlobEnter, CH4.SoldToPartyId, CH4.HighLvlCust
	FROM
		(SELECT A.GlobEnter, CH3.SoldToPartyId, CH3.HighLvlCust
		FROM 
			(SELECT CH.SoldToPartyId AS GlobEnter, CH.HighLvlCust, CH.ValidFrom, CH.ValidTo
			FROM SAP.dbo.Knvh AS CH
			INNER JOIN SAP.dbo.Knvh AS CH2 
				ON CH.SoldToPartyId=CH2.HighLvlCust
			WHERE CH.ValidFrom<GETDATE() AND CH.ValidTo>GETDATE() AND CH.HighLvlCust=' ') AS A
		INNER JOIN SAP.dbo.Knvh AS CH3 
			ON A.GlobEnter=CH3.HighLvlCust) AS B
	INNER JOIN SAP.dbo.Knvh AS CH4 
		ON B.SoldToPartyId=CH4.HighLvlCust) AS C
INNER JOIN SAP.dbo.Knvh AS CH5 
	ON C.SoldToPartyId=CH5.HighLvlCust


---Create Final ProdAor
TRUNCATE TABLE CentralDbs.dbo.ProdAor
INSERT INTO Centraldbs.dbo.ProdAor
SELECT AorId, AOREmpID, PH, Pbg, PrcStgy, Tech, cc, grp, SaleOff, SaleGrp, PSAor.GlobEnter, GN.AccountNbr
--INTO Centraldbs.dbo.ProdAor
FROM #ProdSaleAorSoBl AS PSAor
	LEFT JOIN #GeanSoBl AS GN
		ON PSAor.GlobEnter=GN.GlobEnter;
GO



--DROP TABLE #ProdSaleAorSoBl;
----DROP TABLE #GeanSoBl;
--SELECT COUNT(*)
--FROM CentralDbs.dbo.ProdAor