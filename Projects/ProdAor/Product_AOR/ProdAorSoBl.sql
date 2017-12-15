
---Get Material Hierarchy
USE MDM
CREATE TABLE ##ProdHierProdAorSoBl
	(ProductHierarchyCode VARCHAR(15)
	,Mfg VARCHAR(10)
    ,SapProductBusGroupCd VARCHAR(3)
    ,SapProcureStrategyCd VARCHAR(3)
    ,SapTechnologyCd VARCHAR(3)
    ,SapCommodityCd VARCHAR(3)
    ,SapProductGroupCd VARCHAR(3)
	)

CREATE NONCLUSTERED INDEX PHPAIndex
ON ##ProdHierProdAorSoBl (SapCommodityCd)
INCLUDE (SapProductBusGroupCd, SapProcureStrategyCd,SapTechnologyCd,SapProductGroupCd)

INSERT INTO ##ProdHierProdAorSoBl
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
			FROM ZtqtcAorItm AS Itm INNER JOIN Ztqtcaorhdr AS Hdr ON Itm.AorId=hdr.AorId INNER JOIN ##ProdHierProdAorSoBl AS PHPA ON ITM.GrpCode=PHPA.SapProductGroupCd
			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)
			UNION
			SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 2 AS Cat
			FROM ZtqtcAorItm AS Itm INNER JOIN Ztqtcaorhdr AS Hdr ON Itm.AorId=hdr.AorId INNER JOIN ##ProdHierProdAorSoBl AS PHPA ON ITM.ComProdHier=PHPA.SapCommodityCd
			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)
			UNION
			SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 3 AS Cat
			FROM ZtqtcAorItm AS Itm INNER JOIN Ztqtcaorhdr AS Hdr ON Itm.AorId=hdr.AorId INNER JOIN ##ProdHierProdAorSoBl AS PHPA ON ITM.Tech=PHPA.SapTechnologyCd
			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)
			UNION
			SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 4 AS Cat
			FROM ZtqtcAorItm AS Itm INNER JOIN Ztqtcaorhdr AS Hdr ON Itm.AorId=hdr.AorId INNER JOIN ##ProdHierProdAorSoBl AS PHPA ON ITM.ProcStrat=PHPA.SapProcureStrategyCd
			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)
			UNION
			SELECT DISTINCT Itm.AorId, Itm.AOREmpID, Itm.Manuf, CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AS PH, PHPA.Mfg, PHPA.ProductHierarchyCode, Itm.SaleOff, Itm.SaleGrp, Itm.GlobEnter, Itm.SoldTo, 5 AS Cat
			FROM ZtqtcAorItm AS Itm INNER JOIN Ztqtcaorhdr AS Hdr ON Itm.AorId=hdr.AorId INNER JOIN ##ProdHierProdAorSoBl AS PHPA ON ITM.ProdBusiGrp=PHPA.SapProductBusGroupCd
			WHERE hdr.StartDate<CAST(GETDATE() AS DATE) AND hdr.EndDate>CAST(GETDATE() AS DATE) AND Hdr.AORRole='PRODUCT TEAM' AND PHPA.ProductHierarchyCode LIKE CONCAT(ISNULL(Itm.ProdBusiGrp,'___'),ISNULL(Itm.Procstrat,'___'),ISNULL(Itm.Tech,'___'),ISNULL(Itm.ComProdHier,'___'),ISNULL(Itm.GrpCode,'___')) AND (Manuf=Mfg OR Manuf IS NULL)) AS A
		GROUP BY Mfg, ProductHierarchyCode, SaleOff, SaleGrp, GlobEnter, SoldTo, AorId, AOREmpID) AS B)
SELECT *
INTO ##ProdSaleAorSoBl
FROM cte
--WHERE PH LIKE '%HET%'
WHERE Rank1=1
ORDER BY PH, SaleOff, SaleGrp, GlobEnter, AccountNbr


DROP TABLE ##ProdHierProdAorSoBl

---Create Account Heirarchy
USE SAP
GO
SELECT DISTINCT CAST(C.GlobEnter AS INT) AS GlobEnter, CAST(CH5.Customer AS INT) AS AccountNbr
INTO ##GeanSoBl
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
SELECT AorId, AOREmpID, PH, Pbg, PrcStgy, Tech, cc, grp, SaleOff, SaleGrp, PSAor.GlobEnter, GN.AccountNbr
INTO ##FinProdAorSoBl
FROM ##ProdSaleAorSoBl AS PSAor LEFT JOIN ##GeanSoBl AS GN ON PSAor.GlobEnter=GN.GlobEnter;
GO

DROP TABLE ##ProdSaleAorSoBl;
DROP TABLE ##GeanSoBl;






----Link SO and ProdAor
WITH cte AS 
(SELECT DISTINCT EID.SalesDocNbr, EID.SalesDocItemNbr, EID.PH , CASE WHEN EID.Saleoff IS NULL THEN 999999999 ELSE EID.Saleoff END AS SaleOff, CASE WHEN EID.SaleGrp IS NULL THEN 999999999 ELSE EID.SaleGrp END AS SaleGrp, CASE WHEN EID.GlobEnter IS NULL THEN 999999999 ELSE EID.GlobEnter END AS GlobEnter, CASE WHEN EID.AccountNbr IS NULL THEN 999999999 ELSE EID.AccountNbr END AS AccountNbr, EID.AorId, EID.AorEmpId, ZHdr.EmpFirstName, ZHdr.EmpLastName, RANK() OVER(PARTITION BY  EID.SalesDocNbr, EID.SalesDocItemNbr ORDER BY EID.SalesDocNbr ASC, EID.SalesDocItemNbr ASC, EID.PH ASC, EID.AccountNbr DESC, EID.GlobEnter DESC, EID.SaleGrp DESC, EID.Saleoff DESC, EID.AorId DESC) AS Rank1
FROM
	--PH, SOff, SGrp, AccountNbr
	(SELECT SoBl.SalesDocNbr, SoBl.SalesDocItemNbr, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM ##FinProdAorSoBl AS PsAor INNER JOIN Bi.dbo.SOBacklog  AS SoBl ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(SoBl.pbg, SoBl.prcstgy, SoBl.tech, SoBl.cc, SoBl.grp) AND PsAor.SaleOff=SoBl.SalesOffice AND PsAor.SaleGrp=SoBl.SalesGrp AND PsAor.AccountNbr=sobl.SoldToPartyId
	UNION
	--PH, Soff, Sgrp 
	SELECT SoBl.SalesDocNbr, SoBl.SalesDocItemNbr, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM ##FinProdAorSoBl AS PsAor INNER JOIN Bi.dbo.SOBacklog AS SoBl ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(SoBl.pbg, SoBl.prcstgy, SoBl.tech, SoBl.cc, SoBl.grp) AND PsAor.SaleOff=SoBl.SalesOffice AND PsAor.SaleGrp=SoBl.SalesGrp AND PsAor.AccountNbr IS NULL
	UNION
	--PH, Soff
	SELECT SoBl.SalesDocNbr, SoBl.SalesDocItemNbr, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM ##FinProdAorSoBl AS PsAor INNER JOIN Bi.dbo.SOBacklog AS SoBl ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(SoBl.pbg, SoBl.prcstgy, SoBl.tech, SoBl.cc, SoBl.grp) AND PsAor.SaleOff=SoBl.SalesOffice  AND PsAor.Salegrp IS NULL AND PsAor.AccountNbr IS NULL
	UNION
	--PH
	SELECT SoBl.SalesDocNbr, SoBl.SalesDocItemNbr, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM ##FinProdAorSoBl AS PsAor INNER JOIN Bi.dbo.SOBacklog AS SoBl ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(SoBl.pbg, SoBl.prcstgy, SoBl.tech, SoBl.cc, SoBl.grp) AND PsAor.SaleOff IS NULL  AND PsAor.Salegrp IS NULL AND PsAor.AccountNbr IS NULL
	UNION
	--PH, SOff, AccountNbr
	SELECT SoBl.SalesDocNbr, SoBl.SalesDocItemNbr, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM ##FinProdAorSoBl AS PsAor INNER JOIN Bi.dbo.SOBacklog AS SoBl ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(SoBl.pbg, SoBl.prcstgy, SoBl.tech, SoBl.cc, SoBl.grp) AND PsAor.SaleOff=SoBl.SalesOffice AND PsAor.SaleGrp IS NULL AND PsAor.AccountNbr=SoBl.SoldToPartyId
	UNION
	--PH, AccountNbr
	SELECT SoBl.SalesDocNbr, SoBl.SalesDocItemNbr, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM ##FinProdAorSoBl AS PsAor INNER JOIN Bi.dbo.SOBacklog AS SoBl ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(SoBl.pbg, SoBl.prcstgy, SoBl.tech, SoBl.cc, SoBl.grp) AND PsAor.SaleOff IS NULL AND PsAor.SaleGrp IS NULL AND PsAor.AccountNbr=SoBl.SoldToPartyId
	UNION
	--PH, SGrp, AccountNbr
	SELECT SoBl.SalesDocNbr, SoBl.SalesDocItemNbr, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM ##FinProdAorSoBl AS PsAor INNER JOIN Bi.dbo.SOBacklog AS SoBl ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(SoBl.pbg, SoBl.prcstgy, SoBl.tech, SoBl.cc, SoBl.grp) AND PsAor.SaleOff IS NULL AND PsAor.SaleGrp=SoBl.SalesGrp AND PsAor.AccountNbr=SoBl.SoldToPartyId) AS EID
INNER JOIN Ztqtcaorhdr AS ZHdr ON EID.AorId= ZHdr.AORID
)
INSERT INTO SoblProdAor
SELECT *
FROM cte
--WHERE PH LIKE '%HTD%'
WHERE Rank1=1
ORDER BY SalesDocNbr, SalesDocItemNbr

DROP TABLE ##FinProdAorSoBl




--reset 999999999 values to NULL
UPDATE SoBlProdAor
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

SELECT	
	[SalesDocNbr]
	,[SalesDocItemNbr]
	,[SoSchedLine]
	,[PlantId]
	,[MaterialNbr]
	,[MfgPartNbr]
	,[FyMthNbr]
	,[OutsideSalesRep]
	,[InsideSalesRep]
	,[SoldToPartyId]
	,[SoldToParty]
	,[SalesDocItCreateDt] 
	,[CustomerPoNbr]
	,[CustomerPartNbr]
	,[MaterialTxt]
	,[Grp]
	,[Pbg]
	,[Cc]
	,[Mfg]
	,[PrcStgy]
	,[Tech]
	,[BillingBlock]
	,[PricingBlock]
	,[ShipAndDebitBlock]
	,[CreditBlock]
	,[DlvryBlock]
	,[ProgrammingBlock]
	,[CustReqDockDt]
	,[LastConfPromDt]
	,[DlvryDt]
	,[OrginPromDt]
	,[AtpDt]
	,[OrderQty]
	,[RemainingQty]
	,[UnitPrice]
	,MinCost
	,CostType
	,LineValue
	,[ExtResale]
	,[TtlOrderValue]
	,[MrpCntrl]
	,[Abc]
	,[StockProfile]
	,[OrderReason]
	,[BufferType]
	,[PlantSpecificMatl]
	,[SalesDocType]
	,[ResaleSource]
	,[PurGrp]
	,[BlockedOrders]
	,[SalesOrg]
	,[SalesOffice]
	,[SalesGrp]
	,[MatBaseUnit]
	,[CondType]
	,[OverallDlvryStatus]
	,[ExtCost]
	,[MatGpPercent]
	,[DlvryStatus]
	,A.AOREmpID
	,ProductSpecialist
	,[Supervisor]
	,B.SupervisorId
	,B.SupervisorName
	,[SqlStartTime]
FROM 
	(SELECT SoBl.[SalesDocNbr]
		  ,SoBl.[SalesDocItemNbr]
		  ,[SoSchedLine]
		  ,[PlantId]
		  ,[MaterialNbr]
		  ,[MfgPartNbr]
		  ,[FyMthNbr]
		  ,[OutsideSalesRep]
		  ,[InsideSalesRep]
		  ,[SoldToPartyId]
		  ,[SoldToParty]
		  ,CAST([SalesDocItCreateDt] AS DATE) AS [SalesDocItCreateDt] 
		  ,[CustomerPoNbr]
		  ,[CustomerPartNbr]
		  ,[MaterialTxt]
		  ,[Grp]
		  ,[Pbg]
		  ,[Cc]
		  ,[Mfg]
		  ,[PrcStgy]
		  ,[Tech]
		  ,[BillingBlock]
		  ,[PricingBlock]
		  ,[ShipAndDebitBlock]
		  ,[CreditBlock]
		  ,[DlvryBlock]
		  ,[ProgrammingBlock]
		  ,CAST([CustReqDockDt] AS DATE) AS [CustReqDockDt]
		  ,CAST([LastConfPromDt] AS DATE) AS [LastConfPromDt]
		  ,CAST([DlvryDt] AS DATE) AS [DlvryDt]
		  ,CAST([OrginPromDt] AS DATE) AS [OrginPromDt]
		  ,CAST([AtpDt] AS DATE) AS [AtpDt]
		  ,[OrderQty]
		  ,[RemainingQty]
		  ,[UnitPrice]
		  ,cr.MinCost
		  ,CR.CostType
		  ,UnitPrice*RemainingQty AS LineValue
		  ,[ExtResale]
		  ,[TtlOrderValue]
		  ,[MrpCntrl]
		  ,[Abc]
		  ,[StockProfile]
		  ,[OrderReason]
		  ,[BufferType]
		  ,[PlantSpecificMatl]
		  ,[SalesDocType]
		  ,[ResaleSource]
		  ,[PurGrp]
		  ,[BlockedOrders]
		  ,[SalesOrg]
		  ,[SalesOffice]
		  ,[SalesGrp]
		  ,[MatBaseUnit]
		  ,[CondType]
		  ,[OverallDlvryStatus]
		  ,[ExtCost]
		  ,[MatGpPercent]
		  ,[DlvryStatus]
		  ,SoBlPA.AOREmpID
		  ,CONCAT(SoBlPA.EmpLastName, ', ', SoBlPA.EmpFirstName) AS ProductSpecialist
		  ,ZAH.[Supervisor]
	--	  ,supname.AOREmpID AS SupervisorId
		  ,CAST([SqlStartTime] AS DATE) AS [SqlStartTime]
	FROM Bi.dbo.SoBacklog AS SoBl LEFT JOIN SoBlProdAor AS SoBlPA ON SoBl.SalesDocNbr=SoBlPA.SalesDocNbr AND  SoBl.SalesDocItemNbr=SoBlPA.SalesDocItemNbr
	INNER JOIN Ztqtcaorhdr AS ZAH ON ZAH.AORID=SoBlPA.AorId
	LEFT JOIN MDM.dbo.CostResale AS CR ON SoBl.MaterialNbr=cr.material_nbr
	WHERE ([SalesDocType]= 'ZOR' OR [SalesDocType]='ZKE1') AND [RemainingQty]<>0 AND ZAH.startdate<=CAST(GETDATE() AS DATE) AND ZAH.EndDate>CAST(GETDATE() AS DATE)) AS A
LEFT JOIN 
	(SELECT DISTINCT emp.AOREmpID, Supname.AorEmpId AS SupervisorId, CONCAT(Supname.EmpLastName, ', ', Supname.EmpFirstName) AS SupervisorName
	FROM [dbo].[Ztqtcaorhdr] AS Emp INNER JOIN ztqtcaorhdr AS SupName ON Emp.supervisor=supname.AorEmpId
	WHERE Emp.startdate<=CAST(GETDATE() AS DATE) AND Emp.EndDate>CAST(GETDATE() AS DATE) AND supname.startdate<=CAST(GETDATE() AS DATE) AND supname.EndDate>CAST(GETDATE() AS DATE)) AS B ON A.Supervisor=B.SupervisorId




--SELECT *
--FROM #SoProdAor
--WHERE PH LIKE '%HTD%'
--ORDER BY PH


--DROP TABLE ##SoProdAor