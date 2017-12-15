TRUNCATE TABLE ProdAor
GO
---Get Material Hierarchy
USE MDM
GO
CREATE TABLE ##ProdAorTblProdHierProdAor
	(ProductHierarchyCode VARCHAR(15)
	,Mfg VARCHAR(10)
    ,SapProductBusGroupCd VARCHAR(3)
    ,SapProcureStrategyCd VARCHAR(3)
    ,SapTechnologyCd VARCHAR(3)
    ,SapCommodityCd VARCHAR(3)
    ,SapProductGroupCd VARCHAR(3)
	)

CREATE NONCLUSTERED INDEX PHPAIndex
ON ##ProdAorTblProdHierProdAor (SapCommodityCd)
INCLUDE (SapProductBusGroupCd, SapProcureStrategyCd,SapTechnologyCd,SapProductGroupCd)

INSERT INTO ##ProdAorTblProdHierProdAor
SELECT DISTINCT
	MPH.ProductHierarchyCode
	,Party.SapPartyId AS Mfg
    ,MPH.SapProductBusGroupCd
    ,MPH.SapProcureStrategyCd
    ,MPH.SapTechnologyCd
    ,MPH.SapCommodityCd
    ,MPH.SapProductGroupCd
FROM MaterialProdHier AS MPH INNER JOIN Material AS Mat ON MPH.RowIdObject=Mat.MaterialProdHierarchyId INNER JOIN Party ON Mat.MdmManufacturerPartyId=Party.RowidObject
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
			FROM ZtqtcAorItm AS Itm INNER JOIN Ztqtcaorhdr AS Hdr ON Itm.AorId=hdr.AorId INNER JOIN ##ProdAorTblProdHierProdAor AS PHPA ON ITM.GrpCode=PHPA.SapProductGroupCd
			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)
			UNION
			SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 2 AS Cat
			FROM ZtqtcAorItm AS Itm INNER JOIN Ztqtcaorhdr AS Hdr ON Itm.AorId=hdr.AorId INNER JOIN ##ProdAorTblProdHierProdAor AS PHPA ON ITM.ComProdHier=PHPA.SapCommodityCd
			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)
			UNION
			SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 3 AS Cat
			FROM ZtqtcAorItm AS Itm INNER JOIN Ztqtcaorhdr AS Hdr ON Itm.AorId=hdr.AorId INNER JOIN ##ProdAorTblProdHierProdAor AS PHPA ON ITM.Tech=PHPA.SapTechnologyCd
			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)
			UNION
			SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 4 AS Cat
			FROM ZtqtcAorItm AS Itm INNER JOIN Ztqtcaorhdr AS Hdr ON Itm.AorId=hdr.AorId INNER JOIN ##ProdAorTblProdHierProdAor AS PHPA ON ITM.ProcStrat=PHPA.SapProcureStrategyCd
			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)
			UNION
			SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 5 AS Cat
			FROM ZtqtcAorItm AS Itm INNER JOIN Ztqtcaorhdr AS Hdr ON Itm.AorId=hdr.AorId INNER JOIN ##ProdAorTblProdHierProdAor AS PHPA ON ITM.ProdBusiGrp=PHPA.SapProductBusGroupCd
			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)) AS A
		GROUP BY Mfg, ProductHierarchyCode, SaleOff, SaleGrp, GlobEnter, SoldTo, AorId, AOREmpID) AS B)
SELECT *
INTO ##ProdAorTblProdSaleAOR
FROM cte
--WHERE PH LIKE '%HET%'
WHERE Rank1=1
ORDER BY PH, SaleOff, SaleGrp, GlobEnter, AccountNbr


DROP TABLE ##ProdAorTblProdHierProdAor

---Create Account Heirarchy
USE SAP
GO
SELECT DISTINCT CAST(C.GlobEnter AS INT) AS GlobEnter, CAST(CH5.Customer AS INT) AS AccountNbr
INTO ##ProdAorTblGEAN
FROM
	(SELECT B.GlobEnter, CH4.Customer, CH4.Hglvcust
	FROM
		(SELECT A.GlobEnter, CH3.Customer, CH3.Hglvcust
		FROM 
			(SELECT CH.Customer AS GlobEnter, CH.Hglvcust, CH.ValidFrom, CH.ValidTo
			FROM Knvh AS CH
			INNER JOIN Knvh AS CH2 ON CH.Customer=CH2.Hglvcust
			WHERE CH.ValidFrom<GETDATE() AND CH.ValidTo>GETDATE() AND CH.Hglvcust=' ') AS A
		INNER JOIN Knvh AS CH3 ON A.GlobEnter=CH3.Hglvcust) AS B
	INNER JOIN Knvh AS CH4 ON B.Customer=CH4.Hglvcust) AS C
INNER JOIN Knvh AS CH5 ON C.Customer=CH5.Hglvcust


---Create Final ProdAor

INSERT INTO ProdAor (AorId, AOREmpID, PH, Pbg, PrcStgy, Tech, cc, grp, SaleOff, SaleGrp, PSAor.GlobEnter, GN.AccountNbr)
SELECT AorId, AOREmpID, PH, Pbg, PrcStgy, Tech, cc, grp, SaleOff, SaleGrp, PSAor.GlobEnter, GN.AccountNbr
FROM ##ProdAorTblProdSaleAOR AS PSAor LEFT JOIN ##ProdAorTblGEAN AS GN ON PSAor.GlobEnter=GN.GlobEnter
GO

DROP TABLE ##ProdAorTblProdSaleAOR
DROP TABLE ##ProdAorTblGEAN