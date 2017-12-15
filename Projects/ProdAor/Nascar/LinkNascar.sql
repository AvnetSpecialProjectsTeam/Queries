----Link Nascar and ProdAor



--Auth Type P ProdAor Counts


SELECT Npa.QuoteId, Npa.LineItemNo, Npa.NascarBatchExportId, Npa.Pbg, Npa.PrcStgy, Npa.Tech, Npa.CC, Npa.Grp, Npa.SalesOffice, Npa.SalesGrp, Npa.SoldToCust, Npa.Auth
	--, COUNT(Npa.Auth) AS AuthCount
INTO #NascarProdAor
FROM NascarTest.dbo.ProdAorNascarImport AS Npa
WHERE Npa.AUTH='P'
--GROUP BY Npa.Pbg, Npa.PrcStgy, Npa.Tech, Npa.CC, Npa.Grp, Npa.SalesOffice, Npa.SalesGroup

CREATE NONCLUSTERED INDEX NpaIndex
ON #NascarProdAor(Pbg, PrcStgy, Tech, CC, Grp, SalesOffice, SalesGrp, SoldToCust)


CREATE NONCLUSTERED INDEX NpaIndex2
ON #NascarProdAor(Pbg, PrcStgy, Tech, CC, Grp, SalesOffice, SalesGrp)

CREATE NONCLUSTERED INDEX NpaIndex3
ON #NascarProdAor(Pbg, PrcStgy, Tech, CC, Grp, SalesOffice)

CREATE NONCLUSTERED INDEX NpaIndex4
ON #NascarProdAor(Pbg, PrcStgy, Tech, CC, Grp)








TRUNCATE TABLE NascarTest.dbo.ProdAorNascar;

WITH cte AS 
(SELECT DISTINCT EID.QuoteId, EID.LineItemNo, EID.NascarBatchExportId, EID.PH , CASE WHEN EID.Saleoff IS NULL THEN 999999999 ELSE EID.Saleoff END AS SaleOff, CASE WHEN EID.SaleGrp IS NULL THEN 999999999 ELSE EID.SaleGrp END AS SaleGrp, CASE WHEN EID.GlobEnter IS NULL THEN 999999999 ELSE EID.GlobEnter END AS GlobEnter, CASE WHEN EID.AccountNbr IS NULL THEN 999999999 ELSE EID.AccountNbr END AS AccountNbr, EID.AorId, EID.AorEmpId, ZHdr.EmpFirstName, ZHdr.EmpLastName, EID.Auth
, RANK() OVER(PARTITION BY  EID.QuoteId, EID.LineItemNo, EID.NascarBatchExportId ORDER BY EID.QuoteId ASC, EID.LineItemNo ASC, EID.NascarBatchExportId ASC, EID.PH ASC, EID.AccountNbr DESC, EID.GlobEnter DESC, EID.SaleGrp DESC, EID.Saleoff DESC, EID.AorId DESC) AS Rank1
FROM
	--PH, SOff, SGrp, AccountNbr
	(SELECT Npa.QuoteId, Npa.LineItemNo, Npa.NascarBatchExportId, Npa.AUTH, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN #NascarProdAor AS Npa ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Npa.pbg, Npa.prcstgy, Npa.tech, Npa.cc, Npa.grp) AND PsAor.SaleOff=Npa.SalesOffice AND PsAor.SaleGrp=Npa.SalesGrp AND PsAor.AccountNbr=Npa.SoldToCust
	UNION 
	--PH, Soff, Sgrp 
	SELECT Npa.QuoteId, Npa.LineItemNo, Npa.NascarBatchExportId, Npa.AUTH, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN #NascarProdAor AS Npa ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Npa.pbg, Npa.prcstgy, Npa.tech, Npa.cc, Npa.grp) AND PsAor.SaleOff=Npa.SalesOffice AND PsAor.SaleGrp=Npa.SalesGrp AND PsAor.AccountNbr IS NULL
	UNION
	--PH, Soff
	SELECT Npa.QuoteId, Npa.LineItemNo, Npa.NascarBatchExportId, Npa.AUTH, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN #NascarProdAor AS Npa ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Npa.pbg, Npa.prcstgy, Npa.tech, Npa.cc, Npa.grp) AND PsAor.SaleOff=Npa.SalesOffice  AND PsAor.Salegrp IS NULL AND PsAor.AccountNbr IS NULL
	UNION
	--PH
	SELECT Npa.QuoteId, Npa.LineItemNo, Npa.NascarBatchExportId, Npa.AUTH, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN #NascarProdAor AS Npa ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Npa.pbg, Npa.prcstgy, Npa.tech, Npa.cc, Npa.grp) AND PsAor.SaleOff IS NULL  AND PsAor.Salegrp IS NULL AND PsAor.AccountNbr IS NULL
	UNION
	--PH, SOff, AccountNbr
	SELECT Npa.QuoteId, Npa.LineItemNo, Npa.NascarBatchExportId, Npa.AUTH, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN #NascarProdAor AS Npa ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Npa.pbg, Npa.prcstgy, Npa.tech, Npa.cc, Npa.grp) AND PsAor.SaleOff=Npa.SalesOffice AND PsAor.SaleGrp IS NULL AND PsAor.AccountNbr=Npa.SoldToCust
	UNION
	--PH, AccountNbr
	SELECT  Npa.QuoteId, Npa.LineItemNo, Npa.NascarBatchExportId, Npa.AUTH, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN #NascarProdAor AS Npa ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Npa.pbg, Npa.prcstgy, Npa.tech, Npa.cc, Npa.grp) AND PsAor.SaleOff IS NULL AND PsAor.SaleGrp IS NULL AND PsAor.AccountNbr=Npa.SoldToCust
	UNION
	--PH, SGrp, AccountNbr
	SELECT Npa.QuoteId, Npa.LineItemNo, Npa.NascarBatchExportId, Npa.AUTH, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN #NascarProdAor AS Npa ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Npa.pbg, Npa.prcstgy, Npa.tech, Npa.cc, Npa.grp) AND PsAor.SaleOff IS NULL AND PsAor.SaleGrp=Npa.SalesGrp AND PsAor.AccountNbr=Npa.SoldToCust) AS EID
INNER JOIN SAP.dbo.Ztqtcaorhdr AS ZHdr ON EID.AorId= ZHdr.AORID
)
INSERT INTO NascarTest.dbo.ProdAorNascar
SELECT *
--INTO NascarTest.dbo.ProdAorNascar
FROM cte
--WHERE PH LIKE '%HTD%'
WHERE Rank1=1
ORDER BY QuoteId, LineItemNo, NascarBatchExportId



		DROP TABLE #NascarProdAor
GO

--Auth Type N ProdAor Counts

SELECT Npa.QuoteId, Npa.LineItemNo, Npa.NascarBatchExportId, Npa.Pbg, Npa.PrcStgy, Npa.Tech, Npa.CC, Npa.Grp, Npa.SalesOffice, Npa.SalesGrp, Npa.SoldToCust, Npa.Auth
	--, COUNT(Npa.Auth) AS AuthCount
INTO #NascarProdAor
FROM NascarTest.dbo.ProdAorNascarImport AS Npa
WHERE Npa.AUTH='N'
--GROUP BY Npa.Pbg, Npa.PrcStgy, Npa.Tech, Npa.CC, Npa.Grp, Npa.SalesOffice, Npa.SalesGroup


CREATE NONCLUSTERED INDEX NpaIndex
ON #NascarProdAor(Pbg, PrcStgy, Tech, CC, Grp, SalesOffice, SalesGrp, SoldToCust)


CREATE NONCLUSTERED INDEX NpaIndex2
ON #NascarProdAor(Pbg, PrcStgy, Tech, CC, Grp, SalesOffice, SalesGrp)

CREATE NONCLUSTERED INDEX NpaIndex3
ON #NascarProdAor(Pbg, PrcStgy, Tech, CC, Grp, SalesOffice)

CREATE NONCLUSTERED INDEX NpaIndex4
ON #NascarProdAor(Pbg, PrcStgy, Tech, CC, Grp);




WITH cte AS 
(SELECT DISTINCT EID.QuoteId, EID.LineItemNo, EID.NascarBatchExportId, EID.PH , CASE WHEN EID.Saleoff IS NULL THEN 999999999 ELSE EID.Saleoff END AS SaleOff, CASE WHEN EID.SaleGrp IS NULL THEN 999999999 ELSE EID.SaleGrp END AS SaleGrp, CASE WHEN EID.GlobEnter IS NULL THEN 999999999 ELSE EID.GlobEnter END AS GlobEnter, CASE WHEN EID.AccountNbr IS NULL THEN 999999999 ELSE EID.AccountNbr END AS AccountNbr, EID.AorId, EID.AorEmpId, ZHdr.EmpFirstName, ZHdr.EmpLastName, EID.Auth
, RANK() OVER(PARTITION BY  EID.QuoteId, EID.LineItemNo, EID.NascarBatchExportId ORDER BY EID.QuoteId ASC, EID.LineItemNo ASC, EID.NascarBatchExportId ASC, EID.PH ASC, EID.AccountNbr DESC, EID.GlobEnter DESC, EID.SaleGrp DESC, EID.Saleoff DESC, EID.AorId DESC) AS Rank1
FROM
	--PH, SOff, SGrp, AccountNbr
	(SELECT Npa.QuoteId, Npa.LineItemNo, Npa.NascarBatchExportId, Npa.AUTH, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN #NascarProdAor AS Npa ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Npa.pbg, Npa.prcstgy, Npa.tech, Npa.cc, Npa.grp) AND PsAor.SaleOff=Npa.SalesOffice AND PsAor.SaleGrp=Npa.SalesGrp AND PsAor.AccountNbr=Npa.SoldToCust
	UNION 
	--PH, Soff, Sgrp 
	SELECT Npa.QuoteId, Npa.LineItemNo, Npa.NascarBatchExportId, Npa.AUTH, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN #NascarProdAor AS Npa ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Npa.pbg, Npa.prcstgy, Npa.tech, Npa.cc, Npa.grp) AND PsAor.SaleOff=Npa.SalesOffice AND PsAor.SaleGrp=Npa.SalesGrp AND PsAor.AccountNbr IS NULL
	UNION
	--PH, Soff
	SELECT Npa.QuoteId, Npa.LineItemNo, Npa.NascarBatchExportId, Npa.AUTH, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN #NascarProdAor AS Npa ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Npa.pbg, Npa.prcstgy, Npa.tech, Npa.cc, Npa.grp) AND PsAor.SaleOff=Npa.SalesOffice  AND PsAor.Salegrp IS NULL AND PsAor.AccountNbr IS NULL
	UNION
	--PH
	SELECT Npa.QuoteId, Npa.LineItemNo, Npa.NascarBatchExportId, Npa.AUTH, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN #NascarProdAor AS Npa ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Npa.pbg, Npa.prcstgy, Npa.tech, Npa.cc, Npa.grp) AND PsAor.SaleOff IS NULL  AND PsAor.Salegrp IS NULL AND PsAor.AccountNbr IS NULL
	UNION
	--PH, SOff, AccountNbr
	SELECT Npa.QuoteId, Npa.LineItemNo, Npa.NascarBatchExportId, Npa.AUTH, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN #NascarProdAor AS Npa ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Npa.pbg, Npa.prcstgy, Npa.tech, Npa.cc, Npa.grp) AND PsAor.SaleOff=Npa.SalesOffice AND PsAor.SaleGrp IS NULL AND PsAor.AccountNbr=Npa.SoldToCust
	UNION
	--PH, AccountNbr
	SELECT  Npa.QuoteId, Npa.LineItemNo, Npa.NascarBatchExportId, Npa.AUTH, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN #NascarProdAor AS Npa ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Npa.pbg, Npa.prcstgy, Npa.tech, Npa.cc, Npa.grp) AND PsAor.SaleOff IS NULL AND PsAor.SaleGrp IS NULL AND PsAor.AccountNbr=Npa.SoldToCust
	UNION
	--PH, SGrp, AccountNbr
	SELECT Npa.QuoteId, Npa.LineItemNo, Npa.NascarBatchExportId, Npa.AUTH, CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor INNER JOIN #NascarProdAor AS Npa ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Npa.pbg, Npa.prcstgy, Npa.tech, Npa.cc, Npa.grp) AND PsAor.SaleOff IS NULL AND PsAor.SaleGrp=Npa.SalesGrp AND PsAor.AccountNbr=Npa.SoldToCust) AS EID
INNER JOIN SAP.dbo.Ztqtcaorhdr AS ZHdr ON EID.AorId= ZHdr.AORID
)
INSERT INTO NascarTest.dbo.ProdAorNascar
SELECT *
--INTO NascarTest.dbo.ProdAorNascar
FROM cte
WHERE Rank1=1
ORDER BY QuoteId, LineItemNo, NascarBatchExportId




--reset 999999999 values to NULL
UPDATE NascarTest.dbo.ProdAorNascar
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

--SELECT	

--	,A.AOREmpID
--	,ProductSpecialist
--	,[Supervisor]
--	,MC.[Mgmt Chain 5]
--	,MC.[Mgmt Chain 6]
--	,MC.[Mgmt Chain 7]
--FROM 
--	(






SELECT 
	CONCAT(Pan.EmpLastName, ', ', Pan.EmpFirstName) AS ProductSpecialist
	,Auth
	,COUNT(Pan.[Auth]) AS CountAuth
FROM NascarTest.dbo.ProdAorNascar AS Pan
	INNER JOIN SAP.dbo.Ztqtcaorhdr AS ZAH
		ON ZAH.AORID=Pan.AorId
GROUP BY CONCAT(Pan.EmpLastName, ', ', Pan.EmpFirstName), Auth
ORDER BY CONCAT(Pan.EmpLastName, ', ', Pan.EmpFirstName), Auth, COUNT(Pan.[Auth]) DESC


	SELECT [PH]
		  ,[SaleOff]
		  ,[SaleGrp]
		  ,[GlobEnter]
		  ,[AccountNbr]
		  ,Pan.[AorId]
		  ,Pan.[AOREmpID]
		  ,Pan.[EmpFirstName]
		  ,Pan.[EmpLastName]
		  ,CONCAT(Pan.EmpLastName, ', ', Pan.EmpFirstName) AS ProductSpecialist
		  ,ZAH.[Supervisor]
		  ,COUNT(Pan.[Auth]) AS CountAuth
	--	  ,supname.AOREmpID AS SupervisorId
	FROM NascarTest.dbo.ProdAorNascar AS Pan
		INNER JOIN SAP.dbo.Ztqtcaorhdr AS ZAH
			ON ZAH.AORID=Pan.AorId
	GROUP BY [PH]
		  ,[SaleOff]
		  ,[SaleGrp]
		  ,[GlobEnter]
		  ,[AccountNbr]
		  ,Pan.[AorId]
		  ,Pan.[AOREmpID]
		  ,Pan.[EmpFirstName]
		  ,Pan.[EmpLastName]
		  ,CONCAT(Pan.EmpLastName, ', ', Pan.EmpFirstName)
		  ,ZAH.[Supervisor]
		  ORDER BY COUNT(Pan.[Auth]) DESC

--	) AS A
--LEFT JOIN 
--	Sap.[dbo].[ManagementChain] AS Mc ON A.AOREmpID=MC.[Employee ID]




--Testing purposes

--SELECT DISTINCT *
--FROM NascarTest.dbo.ProdAorNascar AS Pan
--WHERE Pan.PH='0STTIS0SA0CSSLS'


--SELECT *
--FROM Centraldbs.dbo.ProdAor
--WHERE AccountNbr=40036044 AND PH IS NULL
--WHERE prcStgy='ONS' AND Tech ='0SA' AND CC='0CS' AND Grp='SLP' AND (SaleOff=6100 or SaleOff IS null) AND (SaleGrp=105 or SaleGrp IS null)
--ORDER BY prcStgy, tech, cc, grp, saleoff, salegrp



