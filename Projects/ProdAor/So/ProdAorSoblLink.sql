TRUNCATE TABLE CentralDbs.dbo.ProdAorSobl;

----Link SO and ProdAor
WITH cte AS 
(SELECT DISTINCT EID.SalesDocNbr, EID.SalesDocItemNbr, EID.PH , CASE WHEN EID.Saleoff IS NULL THEN 999999999 ELSE EID.Saleoff END AS SaleOff, CASE WHEN EID.SaleGrp IS NULL THEN 999999999 ELSE EID.SaleGrp END AS SaleGrp, CASE WHEN EID.GlobEnter IS NULL THEN 999999999 ELSE EID.GlobEnter END AS GlobEnter, CASE WHEN EID.AccountNbr IS NULL THEN 999999999 ELSE EID.AccountNbr END AS AccountNbr, EID.AorId, EID.AorEmpId, ZHdr.EmpFirstName, ZHdr.EmpLastName, RANK() OVER(PARTITION BY  EID.SalesDocNbr, EID.SalesDocItemNbr ORDER BY EID.SalesDocNbr ASC, EID.SalesDocItemNbr ASC, EID.PH ASC, EID.AccountNbr DESC, EID.GlobEnter DESC, EID.SaleGrp DESC, EID.Saleoff DESC, EID.AorId DESC) AS Rank1
FROM
	--PH, SOff, SGrp, AccountNbr
	(SELECT SoBl.SalesDocNbr, SoBl.SalesDocItemNbr, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN Bi.dbo.SOBacklog  AS SoBl ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(SoBl.pbg, SoBl.prcstgy, SoBl.tech, SoBl.cc, SoBl.grp) AND PsAor.SaleOff=SoBl.SalesOffice AND PsAor.SaleGrp=SoBl.SalesGrp AND PsAor.AccountNbr=sobl.SoldToPartyId
	UNION
	--PH, Soff, Sgrp 
	SELECT SoBl.SalesDocNbr, SoBl.SalesDocItemNbr, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN Bi.dbo.SOBacklog AS SoBl ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(SoBl.pbg, SoBl.prcstgy, SoBl.tech, SoBl.cc, SoBl.grp) AND PsAor.SaleOff=SoBl.SalesOffice AND PsAor.SaleGrp=SoBl.SalesGrp AND PsAor.AccountNbr IS NULL
	UNION
	--PH, Soff
	SELECT SoBl.SalesDocNbr, SoBl.SalesDocItemNbr, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN Bi.dbo.SOBacklog AS SoBl ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(SoBl.pbg, SoBl.prcstgy, SoBl.tech, SoBl.cc, SoBl.grp) AND PsAor.SaleOff=SoBl.SalesOffice  AND PsAor.Salegrp IS NULL AND PsAor.AccountNbr IS NULL
	UNION
	--PH
	SELECT SoBl.SalesDocNbr, SoBl.SalesDocItemNbr, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN Bi.dbo.SOBacklog AS SoBl ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(SoBl.pbg, SoBl.prcstgy, SoBl.tech, SoBl.cc, SoBl.grp) AND PsAor.SaleOff IS NULL  AND PsAor.Salegrp IS NULL AND PsAor.AccountNbr IS NULL
	UNION
	--PH, SOff, AccountNbr
	SELECT SoBl.SalesDocNbr, SoBl.SalesDocItemNbr, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN Bi.dbo.SOBacklog AS SoBl ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(SoBl.pbg, SoBl.prcstgy, SoBl.tech, SoBl.cc, SoBl.grp) AND PsAor.SaleOff=SoBl.SalesOffice AND PsAor.SaleGrp IS NULL AND PsAor.AccountNbr=SoBl.SoldToPartyId
	UNION
	--PH, AccountNbr
	SELECT SoBl.SalesDocNbr, SoBl.SalesDocItemNbr, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN Bi.dbo.SOBacklog AS SoBl ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(SoBl.pbg, SoBl.prcstgy, SoBl.tech, SoBl.cc, SoBl.grp) AND PsAor.SaleOff IS NULL AND PsAor.SaleGrp IS NULL AND PsAor.AccountNbr=SoBl.SoldToPartyId
	UNION
	--PH, SGrp, AccountNbr
	SELECT SoBl.SalesDocNbr, SoBl.SalesDocItemNbr, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN Bi.dbo.SOBacklog AS SoBl ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(SoBl.pbg, SoBl.prcstgy, SoBl.tech, SoBl.cc, SoBl.grp) AND PsAor.SaleOff IS NULL AND PsAor.SaleGrp=SoBl.SalesGrp AND PsAor.AccountNbr=SoBl.SoldToPartyId) AS EID
INNER JOIN SAp.dbo.Ztqtcaorhdr AS ZHdr ON EID.AorId= ZHdr.AORID
)
INSERT INTO CentralDbs.dbo.ProdAorSobl
SELECT *
--INTO #ProdAorSobl
FROM cte
--WHERE PH LIKE '%HTD%'
WHERE Rank1=1
ORDER BY SalesDocNbr, SalesDocItemNbr





--reset 999999999 values to NULL
UPDATE CentralDbs.dbo.ProdAorSobl
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

SELECT DISTINCT	
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
	,MC.[Mgmt Chain 5]
	,MC.[Mgmt Chain 6]
	,MC.[Mgmt Chain 7]
	,[SqlStartTime]
FROM 
	(SELECT SoBl.[SalesDocNbr]
		  ,SoBl.[SalesDocItemNbr]
		  ,[SoSchedLine]
		  ,[PlantId]
		  ,Sobl.[MaterialNbr]
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
		  ,PaSobl.AOREmpID
		  ,CONCAT(PaSobl.EmpLastName, ', ', PaSobl.EmpFirstName) AS ProductSpecialist
		  ,ZAH.[Supervisor]
	--	  ,supname.AOREmpID AS SupervisorId
		  ,CAST([SqlStartTime] AS DATE) AS [SqlStartTime]
	FROM Bi.dbo.SoBacklog AS SoBl LEFT JOIN CentralDbs.dbo.ProdAorSobl AS PaSobl ON SoBl.SalesDocNbr=PaSobl.SalesDocNbr AND  SoBl.SalesDocItemNbr=PaSobl.SalesDocItemNbr
	INNER JOIN SAP.dbo.Ztqtcaorhdr AS ZAH ON ZAH.AORID=PaSobl.AorId
	LEFT JOIN CentralDbs.dbo.CostResale AS CR ON SoBl.MaterialNbr=cr.MaterialNbr
	WHERE ([SalesDocType]= 'ZOR' OR [SalesDocType]='ZKE1') AND [RemainingQty]<>0 AND ZAH.startdate<=CAST(GETDATE() AS DATE) AND ZAH.EndDate>CAST(GETDATE() AS DATE)) AS A
LEFT JOIN 
	Sap.[dbo].[ManagementChain] AS Mc ON A.AOREmpID=MC.[Employee ID]