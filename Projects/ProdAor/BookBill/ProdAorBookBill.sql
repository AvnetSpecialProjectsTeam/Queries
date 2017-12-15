

TRUNCATE TABLE Centraldbs.dbo.ProdAorBookbill;

----Link Bb and ProdAor
WITH cte AS 
(SELECT DISTINCT EID.SalesDocNbr, EID.SalesDocLnItm, Eid.[Type], EID.PH , CASE WHEN EID.Saleoff IS NULL THEN 999999999 ELSE EID.Saleoff END AS SaleOff, CASE WHEN EID.SaleGrp IS NULL THEN 999999999 ELSE EID.SaleGrp END AS SaleGrp, CASE WHEN EID.GlobEnter IS NULL THEN 999999999 ELSE EID.GlobEnter END AS GlobEnter, CASE WHEN EID.AccountNbr IS NULL THEN 999999999 ELSE EID.AccountNbr END AS AccountNbr, EID.AorId, EID.AorEmpId, ZHdr.EmpFirstName, ZHdr.EmpLastName, RANK() OVER(PARTITION BY  EID.SalesDocNbr, EID.SalesDocLnItm, EID.[Type] ORDER BY EID.SalesDocNbr ASC, EID.SalesDocLnItm ASC, EID.[Type], EID.PH ASC, EID.AccountNbr DESC, EID.GlobEnter DESC, EID.SaleGrp DESC, EID.Saleoff DESC, EID.AorId DESC) AS Rank1
FROM
	--PH, SOff, SGrp, AccountNbr
	(SELECT Bb.SalesDocNbr, Bb.SalesDocLnItm, Bb.[Type], CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor 
		INNER JOIN CentralDbs.dbo.BookBill  AS Bb 
			ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Bb.pbg, Bb.prcstgy, Bb.tech, Bb.cc, Bb.grp) AND PsAor.SaleOff=Bb.SalesOffice AND PsAor.SaleGrp=Bb.SalesGrp AND PsAor.AccountNbr=Bb.CustNbr
	WHERE Try_CAST(bb.CustNbr AS INT)>0
	UNION
	--PH, Soff, Sgrp 
	SELECT Bb.SalesDocNbr, Bb.SalesDocLnItm, Bb.[Type], CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor 
		INNER JOIN CentralDbs.dbo.BookBill AS Bb
			ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Bb.pbg, Bb.prcstgy, Bb.tech, Bb.cc, Bb.grp) AND PsAor.SaleOff=Bb.SalesOffice AND PsAor.SaleGrp=Bb.SalesGrp AND PsAor.AccountNbr IS NULL
	WHERE Try_CAST(bb.CustNbr AS INT)>0
	UNION
	--PH, Soff
	SELECT Bb.SalesDocNbr, Bb.SalesDocLnItm, Bb.[Type], CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor
		INNER JOIN CentralDbs.dbo.BookBill AS Bb 
			ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Bb.pbg, Bb.prcstgy, Bb.tech, Bb.cc, Bb.grp) AND PsAor.SaleOff=Bb.SalesOffice  AND PsAor.Salegrp IS NULL AND PsAor.AccountNbr IS NULL
	WHERE Try_CAST(bb.CustNbr AS INT)>0
	UNION
	--PH
	SELECT Bb.SalesDocNbr, Bb.SalesDocLnItm, Bb.[Type], CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor 
		INNER JOIN CentralDbs.dbo.BookBill AS Bb
			ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Bb.pbg, Bb.prcstgy, Bb.tech, Bb.cc, Bb.grp) AND PsAor.SaleOff IS NULL  AND PsAor.Salegrp IS NULL AND PsAor.AccountNbr IS NULL
	WHERE Try_CAST(bb.CustNbr AS INT)>0
	UNION
	--PH, SOff, AccountNbr
	SELECT Bb.SalesDocNbr, Bb.SalesDocLnItm, Bb.[Type], CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor
		INNER JOIN CentralDbs.dbo.BookBill AS Bb 
			ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Bb.pbg, Bb.prcstgy, Bb.tech, Bb.cc, Bb.grp) AND PsAor.SaleOff=Bb.SalesOffice AND PsAor.SaleGrp IS NULL AND PsAor.AccountNbr=Bb.CustNbr
	WHERE Try_CAST(bb.CustNbr AS INT)>0
	UNION
	--PH, AccountNbr
	SELECT Bb.SalesDocNbr, Bb.SalesDocLnItm, Bb.[Type], CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor 
		INNER JOIN CentralDbs.dbo.BookBill AS Bb
			ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Bb.pbg, Bb.prcstgy, Bb.tech, Bb.cc, Bb.grp) AND PsAor.SaleOff IS NULL AND PsAor.SaleGrp IS NULL AND PsAor.AccountNbr=Bb.CustNbr
	WHERE Try_CAST(bb.CustNbr AS INT)>0
	UNION
	--PH, SGrp, AccountNbr
	SELECT Bb.SalesDocNbr, Bb.SalesDocLnItm, Bb.[Type], CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp) AS PH, PsAor.Saleoff, PsAor.SaleGrp, PsAor.GlobEnter, PsAor.AccountNbr, PsAor.AorEmpId, PsAor.AorId
	FROM CentralDbs.dbo.ProdAor AS PsAor
	 INNER JOIN CentralDbs.dbo.BookBill AS Bb 
		ON CONCAT(PsAor.pbg, PsAor.prcstgy, PsAor.tech, PsAor.cc, PsAor.grp)=CONCAT(Bb.pbg, Bb.prcstgy, Bb.tech, Bb.cc, Bb.grp) AND PsAor.SaleOff IS NULL AND PsAor.SaleGrp=Bb.SalesGrp AND PsAor.AccountNbr=Bb.CustNbr
	WHERE Try_CAST(bb.CustNbr AS INT)>0
	) AS EID
INNER JOIN SAP.dbo.Ztqtcaorhdr AS ZHdr ON EID.AorId= ZHdr.AORID
)
INSERT INTO Centraldbs.dbo.ProdAorBookBill
SELECT *
--INTO Centraldbs.dbo.ProdAorBookBill
FROM cte
--WHERE PH LIKE '%HTD%'
WHERE Rank1=1
ORDER BY SalesDocNbr, SalesDocLnItm






--reset 999999999 values to NULL
UPDATE Centraldbs.dbo.ProdAorBookBill
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

SELECT DISTINCT	A.*

	,ProductSpecialist
	,[Supervisor]
	,B.SupervisorId
	,B.SupervisorName

FROM 
	(SELECT [LogDt]
		  ,[LogTime]
		  ,[TransDt]
		  ,[BusDay99]
		  ,[WkNbr]
		  ,[FyMnthNbr]
		  ,[FyTagMnth]
		  ,Bb.Material
		  ,[Pbg]
		  ,[Mfg]
		  ,[PrcStgy]
		  ,[Cc]
		  ,[Grp]
		  ,[Tech]
		  ,[MfgPartNbr]
		  ,[SalesGrp]
		  ,[SalesGrpKey]
		  ,[SalesOffice]
		  ,[SalesOfficeKey]
		,[CustName]
		,[CustNbr]
		,[SalesDocTyp]
		,[RefBillingNbr]
		,Bb.[SalesDocNbr]
		,Bb.[SalesDocLnItm]
		,[BillingsQty]
		,[Billings]
		,[Cogs]
		,[BillingsGp]
		,[BookingsQty]
		,[Bookings]
		,[BookingsCost]
		,[BookingsGp]
		,Bb.[Type]
		,ProdAorBb.AOREmpID
		,CONCAT(ProdAorBb.EmpLastName, ', ', ProdAorBb.EmpFirstName) AS ProductSpecialist
		,ZAH.[Supervisor]
		--	  ,supname.AOREmpID AS SupervisorId
	FROM CentralDbs.dbo.BookBill AS Bb 
		LEFT JOIN Centraldbs.dbo.ProdAorBookBill AS ProdAorBb 
			ON Bb.SalesDocNbr=ProdAorBb.SalesDocNbr AND  Bb.SalesDocLnItm=ProdAorBb.SalesDocLnItm AND Bb.[Type]=ProdAorBb.[Type]
			INNER JOIN SAP.dbo.Ztqtcaorhdr AS ZAH ON 
				ZAH.AORID=ProdAorBb.AorId
		LEFT JOIN CentralDbs.dbo.CostResale AS CR 
			ON Bb.Material=cr.MaterialNbr
	WHERE (Bb.BillingsQty<>0 OR Bb.BookingsQty<>0) AND ZAH.startdate<=CAST(GETDATE() AS DATE) AND ZAH.EndDate>CAST(GETDATE() AS DATE)) AS A
LEFT JOIN 
	(SELECT DISTINCT emp.AOREmpID, Supname.AorEmpId AS SupervisorId, CONCAT(Supname.EmpLastName, ', ', Supname.EmpFirstName) AS SupervisorName
	FROM Sap.[dbo].[Ztqtcaorhdr] AS Emp
		INNER JOIN SAP.dbo.ztqtcaorhdr AS SupName
			ON Emp.supervisor=supname.AorEmpId
	WHERE Emp.startdate<=CAST(GETDATE() AS DATE) AND Emp.EndDate>CAST(GETDATE() AS DATE) AND supname.startdate<=CAST(GETDATE() AS DATE) AND supname.EndDate>CAST(GETDATE() AS DATE)) AS B
	ON A.Supervisor=B.SupervisorId


--SELECT *
--FROM #SoProdAor
--WHERE PH LIKE '%HTD%'
--ORDER BY PH


--DROP TABLE ##SoProdAor\


--SELECT COUNT(*)
--FROM CentralDbs.dbo.BookBill

--SELECT *
--FROM CentralDbs.dbo.ProdAorBookBill