USE SAP
GO

---Create Account Heirarchy
SELECT DISTINCT CAST(C.GlobEnter AS INT) AS GlobEnter, CAST(CH5.Customer AS INT) AS AccountNbr
INTO ##GEAN
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


--Filter down to Active lines and Product Team
SELECT DISTINCT ZtHdr.AORID, ZtHdr.AOREmpID, ZtHdr.EmpFirstName, ZtHdr.EmpLastName, ZtHdr.Job, ZtHdr.Position, ZtHdr.AORRole, ZtHdr.AORFunc, ZtHdr.StartDate, ZtHdr.EndDate
INTO ##AorProdFilter
FROM Ztqtcaorhdr AS ZtHdr
WHERE ZtHdr.AORRole='PRODUCT TEAM' AND ZtHdr.StartDate<=CAST(GETDATE() AS DATE) AND ZtHdr.EndDate>CAST(GETDATE() AS DATE);
GO


-------------Link Active header to the Aor Item 

CREATE TABLE ##AorProdItem
(AorId INT
,AOREmpID INT
,pbg VARCHAR(3)
,mfg VARCHAR(3)
, PrcStgy VARCHAR(3)
, tech VARCHAR(3)
,cc VARCHAR(3)
, grp VARCHAR(3)
, SaleOff INT
, SaleGrp INT
, GlobEnter INT
, AccountNbr INT)

CREATE NONCLUSTERED INDEX APIIndex
ON ##AorProdItem ([cc])
INCLUDE ([AorId],[AOREmpID],[mfg],[grp],[SaleOff],[SaleGrp],[GlobEnter], AccountNbr)

INSERT INTO ##AorProdItem
SELECT A.*, GN.AccountNbr
FROM
	(SELECT DISTINCT ZAI.AorId, ZAI.AOREmpID, ZAI.ProdBusiGrp AS pbg, ZAI.Manuf AS mfg, ZAI.ProcStrat AS prc_stgy, ZAI.Tech AS tech, ZAI.ComProdHier AS cc, ZAI.GrpCode AS grp, ZAI.SaleOff, ZAI.SaleGrp, ZAI.GlobEnter
	FROM ##AorProdFilter AS APF INNER JOIN ZtqtcAorItm AS ZAI ON APF.AORID = ZAI.AORID) AS A
	LEFT JOIN ##GEAN AS GN ON A.GlobEnter=GN.GlobEnter
GO
	
DROP TABLE ##GEAN
DROP TABLE ##AorProdFilter
GO

--TEST
			--SELECT * FROM ##AorProdItem
			--WHERE AOREmpID=28521
			--ORDER BY PBG ASC, mfg ASC, PrcStgy ASC, tech ASC, cc ASC, grp ASC
			--GO

			--SELECT DISTINCT Aorid
			--FROM ##AorProdItem



USE MDM


CREATE TABLE ##ProdHierProdAor
(ProductHierarchyCode VARCHAR(15)
    ,SapProductBusGroupCd VARCHAR(3)
    ,SapProcureStrategyCd VARCHAR(3)
    ,SapTechnologyCd VARCHAR(3)
    ,SapCommodityCd VARCHAR(3)
    ,SapProductGroupCd VARCHAR(3)
	)

CREATE NONCLUSTERED INDEX PHPAIndex
ON ##ProdHierProdAor (SapCommodityCd)
INCLUDE (SapProductBusGroupCd, SapProcureStrategyCd,SapTechnologyCd,SapProductGroupCd)


INSERT INTO ##ProdHierProdAor
SELECT 
	ProductHierarchyCode
    ,SapProductBusGroupCd
    ,SapProcureStrategyCd
    ,SapTechnologyCd
    ,SapCommodityCd
    ,SapProductGroupCd
FROM MaterialProdHier
WHERE HubStateInd<>-1 AND SapProductGroupCd IS NOT NULL
GO







USE SAP
GO


WITH cte AS 
--Connect on PrcStgy, Grp
(SELECT A.*, RANK() OVER(PARTITION BY  A.pbg, A. Mfg, A.PrcStgy, A.cc, A.SaleOff, A.SaleGrp, A.GlobEnter, A.AccountNbr ORDER BY A.pbg, A. Mfg, A.PrcStgy, A.cc, A.SaleOff, A.SaleGrp, A.GlobEnter, A.AccountNbr, A.AorId DESC) AS Rank1
FROM
	(SELECT DISTINCT PHPA.SapProductBusGroupCd AS pbg, API.mfg, PHPA.SapProcureStrategyCd AS PrcStgy, PHPA.SapTechnologyCd AS tech, PHPA.SapCommodityCd AS cc, PHPA.SapProductGroupCd AS grp, API.SaleOff, API.SaleGrp, API.GlobEnter, API.AccountNbr, API.AorId, API.AOREmpID
	FROM ##AorProdItem AS API INNER JOIN ##ProdHierProdAor AS PHPA ON API.PrcStgy=PHPA.SapProcureStrategyCd AND API.grp=PHPA.SapProductGroupCd) AS A
),
--Connect on PrcStgy, Cc
cte2 AS 
(SELECT A.*, RANK() OVER(PARTITION BY  A.pbg, A. Mfg, A.PrcStgy, A.cc, A.SaleOff, A.SaleGrp, A.GlobEnter, A.AccountNbr ORDER BY A.pbg, A. Mfg, A.PrcStgy, A.cc, A.SaleOff, A.SaleGrp, A.GlobEnter, A.AccountNbr, A.AorId DESC) AS Rank1
FROM
	(SELECT DISTINCT PHPA.SapProductBusGroupCd AS pbg, API.mfg, PHPA.SapProcureStrategyCd AS PrcStgy, PHPA.SapTechnologyCd AS tech, PHPA.SapCommodityCd AS cc, PHPA.SapProductGroupCd AS grp, API.SaleOff, API.SaleGrp, API.GlobEnter, API.AccountNbr, API.AorId, API.AOREmpID
	FROM ##AorProdItem AS API INNER JOIN ##ProdHierProdAor AS PHPA ON API.PrcStgy=PHPA.SapProcureStrategyCd AND API.cc=PHPA.SapCommodityCd AND (API.grp<>PHPA.SapProductGroupCd OR API.grp IS NULL)) AS A
),
--Connect on PrcStgy, Tech
cte3 AS
(SELECT A.*, RANK() OVER(PARTITION BY  A.pbg, A. Mfg, A.PrcStgy, A.cc, A.SaleOff, A.SaleGrp, A.GlobEnter, A.AccountNbr ORDER BY A.pbg, A. Mfg, A.PrcStgy, A.cc, A.SaleOff, A.SaleGrp, A.GlobEnter, A.AccountNbr, A.AorId DESC) AS Rank1
FROM
	(SELECT DISTINCT PHPA.SapProductBusGroupCd AS pbg, API.mfg, PHPA.SapProcureStrategyCd AS PrcStgy, PHPA.SapTechnologyCd AS tech, PHPA.SapCommodityCd AS cc, PHPA.SapProductGroupCd AS grp, API.SaleOff, API.SaleGrp, API.GlobEnter, API.AccountNbr, API.AorId, API.AOREmpID
	FROM ##AorProdItem AS API INNER JOIN ##ProdHierProdAor AS PHPA ON API.PrcStgy=PHPA.SapProcureStrategyCd AND API.tech=PHPA.SapTechnologyCd AND (API.cc<>PHPA.SapCommodityCd OR API.cc IS NULL) AND (API.grp<>PHPA.SapProductGroupCd OR API.grp IS NULL)) AS A
--WHERE NOT EXIST
),
--Connect on Prc_stgy
cte4 AS
(SELECT A.*, RANK() OVER(PARTITION BY  A.pbg, A. Mfg, A.PrcStgy, A.cc, A.SaleOff, A.SaleGrp, A.GlobEnter, A.AccountNbr ORDER BY A.pbg, A. Mfg, A.PrcStgy, A.cc, A.SaleOff, A.SaleGrp, A.GlobEnter, A.AccountNbr, A.AorId DESC) AS Rank1
FROM
	(SELECT DISTINCT PHPA.SapProductBusGroupCd AS pbg, API.mfg, PHPA.SapProcureStrategyCd AS PrcStgy, PHPA.SapTechnologyCd AS tech, PHPA.SapCommodityCd AS cc, PHPA.SapProductGroupCd AS grp, API.SaleOff, API.SaleGrp, API.GlobEnter, API.AccountNbr, API.AorId, API.AOREmpID
	FROM ##AorProdItem AS API INNER JOIN ##ProdHierProdAor AS PHPA ON API.PrcStgy=PHPA.SapProcureStrategyCd AND (API.tech<>PHPA.SapTechnologyCd OR API.tech IS NULL) AND (API.cc<>PHPA.SapCommodityCd OR API.cc IS NULL) AND (API.grp<>PHPA.SapProductGroupCd OR API.grp IS NULL)) AS A
),
--Connet on Pbg
cte5 AS
(SELECT A.*, RANK() OVER(PARTITION BY  A.pbg, A. Mfg, A.PrcStgy, A.cc, A.SaleOff, A.SaleGrp, A.GlobEnter, A.AccountNbr ORDER BY A.pbg, A. Mfg, A.PrcStgy, A.cc, A.SaleOff, A.SaleGrp, A.GlobEnter, A.AccountNbr, A.AorId DESC) AS Rank1
FROM
	(SELECT DISTINCT PHPA.SapProductBusGroupCd AS pbg, API.mfg, PHPA.SapProcureStrategyCd AS PrcStgy, PHPA.SapTechnologyCd AS tech, PHPA.SapCommodityCd AS cc, PHPA.SapProductGroupCd AS grp, API.SaleOff, API.SaleGrp, API.GlobEnter, API.AccountNbr, API.AorId, API.AOREmpID
	FROM ##AorProdItem AS API INNER JOIN ##ProdHierProdAor AS PHPA ON API.pbg=PHPA.SapProductBusGroupCd AND (API.PrcStgy<>PHPA.SapProcureStrategyCd OR API.PrcStgy IS NULL) AND (API.tech<>PHPA.SapTechnologyCd OR API.tech IS NULL) AND (API.cc<>PHPA.SapCommodityCd OR API.cc IS NULL) AND (API.grp<>PHPA.SapProductGroupCd OR API.grp IS NULL)) AS A
)
SELECT DISTINCT *
INTO ##ProdSaleAOR
FROM cte
WHERE Rank1=1 
UNION
SELECT *
FROM cte2
WHERE Rank1=1
UNION
SELECT *
FROM cte3
WHERE Rank1=1
UNION
SELECT *
FROM cte4
WHERE Rank1=1
UNION
SELECT *
FROM cte5
WHERE Rank1=1
ORDER BY  pbg, Mfg, PrcStgy, cc, grp, SaleOff, SaleGrp, GlobEnter, AccountNbr, AorId DESC

GO


DROP TABLE ##AorProdItem
DROP TABLE ##ProdHierProdAor









SELECT *
FROM ##ProdSaleAOR AS PSAor
WHERE PH='0STSTM0SA0SNTLP' AND SaleOff=6117 AND SaleGrp=111
WHERE PSAor.PrcStgy='NFW' AND PSAor.tech='09C' AND PSAor.cc='0SN' AND [PSAor].grp='TLI' AND SaleOff=6102

DROP TABLE ##ProdSaleAOR