--Product Scorecard Bucketless

--Calculate Dates

--0000-01 FIND PREVIOUS MONTHS DATES 
DROP TABLE #PrdScDates1
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates1
FROM (SELECT RefDateAvnet.FyMthNbr, RefDateAvnet.FyTagMth, Min(RefDateAvnet.BusDay99) AS BusDay99, RefDateAvnet.[FyMthNbr]-1 AS prev_FyMthNbr
FROM InventoryEomDetail INNER JOIN RefDateAvnet ON InventoryEomDetail.VersionDt = RefDateAvnet.DateDt
GROUP BY RefDateAvnet.FyMthNbr, RefDateAvnet.FyTagMth, RefDateAvnet.[FyMthNbr]-1) AS subquery1
GO



--0000-02 ADD IN MONTH TAG FROM REF DATE AVNET
DROP TABLE #PrdScDates2
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates2 
FROM (SELECT DISTINCT #PrdScDates1.FyMthNbr, #PrdScDates1.FyTagMth, #PrdScDates1.prev_FyMthNbr, RefDateAvnet.DateDt, RefDateAvnet.FyTagMth AS FyTagMnth
FROM #PrdScDates1 INNER JOIN RefDateAvnet ON #PrdScDates1.prev_FyMthNbr = RefDateAvnet.FyMthNbr) AS subquery2
Go



--0000-03 GET TODAYS DATE
DROP TABLE #PrdScDates3
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates3
FROM (SELECT Cast(DateDt AS DATE) AS DateDt
FROM RefDateAvnet) AS subquery3
GO



--0000-04 GET TODAYS DATE
DROP TABLE #PrdScDates4
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates4
FROM (SELECT DateDt 
FROM #PrdScDates3
WHERE DateDt=CAST(GetDate() AS DATE)) AS subquery4
GO



--0000-05 MAKE TABLE FOR MONTH TAGS 
DROP TABLE #test1
GO
USE CentralDbs
GO
SELECT * INTO #test1
FROM (SELECT RefDateAvnet.FyMthNbr, RefDateAvnet.FyMth, 
CASE WHEN ([FyMth]='Jan' Or [FyMth]='Apr' Or [FyMth]='Jul' Or [FyMth]='Oct')THEN 1 ELSE 0 END AS qm1, 
CASE WHEN ([FyMth]='Feb' Or [FyMth]='May' Or [FyMth]='Aug' Or [FyMth]='Nov')THEN 2 ELSE 0 END AS qm2, 
CASE WHEN ([FyMth]='Mar' Or [FyMth]='Jun' Or [FyMth]='Sep' Or [FyMth]='Dec')THEN 3 ELSE 0 END AS qm3
FROM RefDateAvnet
GROUP BY RefDateAvnet.FyMthNbr, RefDateAvnet.FyMth, 
IIf(([FyMth]='Jan' Or [FyMth]='Apr' Or [FyMth]='Jul' Or [FyMth]='Oct'),1,0),
IIf(([FyMth]='Feb' Or [FyMth]='May' Or [FyMth]='Aug' Or [FyMth]='Nov'),2,0),
IIf(([FyMth]='Mar' Or [FyMth]='Jun' Or [FyMth]='Sep' Or [FyMth]='Dec'),3,0)) AS subquerytest1
Order By FyMthNbr desc
GO


--0000-06
DROP TABLE #test2
GO
USE CentralDbs
GO
SELECT * INTO #test2 
FROM (SELECT #test1.FyMthNbr, #test1.FyMth, CONCAT([qm1],[qm2],[qm3]) AS mth_of_qtr
FROM #test1) AS subquery8b
GO



--0000-07
DROP TABLE #PrdScDates4
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates4 
FROM (SELECT DISTINCT RefDateAvnet.FyMthNbr AS CrntMthNbr, RefDateAvnet.FyTagMth, RefDateAvnet.FyYyyyQtr AS crnt_qtr, /*#PrdScDates8b.mth_of_qtr,*/[RefDateAvnet].[FyMthNbr]-1 AS PrevMthNbr
FROM (#PrdScDates3 INNER JOIN RefDateAvnet ON #PrdScDates3.DateDt = RefDateAvnet.DateDt) INNER JOIN #test1 ON RefDateAvnet.FyMthNbr =#test1.FyMthNbr) AS subquery4
GO


--0000-07
DROP TABLE #PrdScDates5
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates5 
FROM (SELECT DISTINCT RefDateAvnet.FyMthNbr, RefDateAvnet.fyyyyyQtr
FROM RefDateAvnet, #PrdScDates4
WHERE (((RefDateAvnet.fyyyyyQtr)<[crnt_qtr])) --Current qtr in 0000-04
) AS subquery5
GO


--0000-06
DROP TABLE #PrdScDates6
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates6 
FROM (SELECT TOP 8 Max(#PrdScDates5.FyMthNbr) AS FyMthNbr, #PrdScDates5.FyYyyyQtr
FROM #PrdScDates5
GROUP BY #PrdScDates5.FyYyyyQtr
ORDER BY #PrdScDates5.FyYyyyQtr DESC) AS subquery6
GO


--0000-07
DROP TABLE #PrdScDates7
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates7 
FROM (SELECT TOP 1 #PrdScDates6 .FyMthNbr, #PrdScDates6.FyYyyyQtr
FROM #PrdScDates6 
GROUP BY #PrdScDates6.FyMthNbr, #PrdScDates6.FyYyyyQtr
ORDER BY #PrdScDates6.FyMthNbr DESC) AS subquery7
GO


--0000-07a

DROP TABLE #PrdScDates7a
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates7a 
FROM (SELECT RefDateAvnet.DateDt AS version_dt, RefDateAvnet.LastBusDt, RefDateAvnet.BusDay99
FROM RefDateAvnet) AS subquery7a
GO


--0000-07b

DROP TABLE #PrdScDate7b
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates7b 
FROM (SELECT RefDateAvnet.DateDt, RefDateAvnet.FyMthNbr, RefDateAvnet.BusDay99
FROM RefDateAvnet
GROUP BY RefDateAvnet.DateDt, RefDateAvnet.FyMthNbr, RefDateAvnet.BusDay99
HAVING (RefDateAvnet.BusDay99)=99) AS subquery7b
GO


--0000-07c

DROP TABLE #PrdScDates7c
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates7c 
FROM (SELECT #PrdScDates7a.version_dt, #PrdScDates7a.LastBusDt, RefDateAvnet.FyMthNbr, RefDateAvnet.FyTagMth
FROM #PrdScDates7a INNER JOIN (RefDateAvnet INNER JOIN #PrdScDates7b ON RefDateAvnet.DateDt = RefDateAvnet.DateDt) ON #PrdScDates7a.LastBusDt = RefDateAvnet.DateDt
GROUP BY #PrdScDates7a.version_dt, #PrdScDates7a.LastBusDt, RefDateAvnet.FyMthNbr, RefDateAvnet.FyTagMth) AS subquery7c
GO



--0000-08a

DROP TABLE #PrdScDates8a
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates8a 
FROM (SELECT DISTINCT RefDateAvnet.FyMthNbr, RefDateAvnet.FyMth, IIf(([FyMth]='Jan' Or [FyMth]='Apr' Or [FyMth]='Jul' Or [FyMth]='Oct'),1,0) AS qm1, IIf(([FyMth]='Feb' Or [FyMth]='May' Or [FyMth]='Aug' Or [FyMth]='Nov'),2,0) AS qm2, IIf(([FyMth]='Mar' Or [FyMth]='Jun' Or [FyMth]='Sep' Or [FyMth]='Dec'),3,0) AS qm3
FROM RefDateAvnet) AS subquery8a
GO




--0000-08b

DROP TABLE #PrdScDates8b
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates8b 
FROM (SELECT #PrdScDates8a.FyMthNbr, #PrdScDates8a.FyMth --[qm1]+[qm2]+[qm3] AS mth_of_qtr
FROM #PrdScDates8a) AS subquery8b
GO


--0000-09

DROP TABLE #PrdScDates9
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates9 
FROM (SELECT RefDateAvnet.FyMthNbr, RefDateAvnet.FyYyyyQtr
FROM RefDateAvnet INNER JOIN #PrdScDates6 ON RefDateAvnet.FyYyyyQtr = #PrdScDates6.FyYyyyQtr
GROUP BY RefDateAvnet.FyMthNbr, RefDateAvnet.FyYyyyQtr) AS subquery9
GO
 SELECT * from #PrdScDates6; 

--0000-09b

DROP TABLE #PrdScDates9b
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates9b 
FROM (SELECT Min(#PrdScDates9.FyMthNbr) AS fy_first_mth_nbr, Min(#PrdScDates9.FyYyyyQtr) AS FyYyyyQtr
FROM #PrdScDates9) AS subquery9b
GO




--0000-09c

DROP TABLE #PrdScDates9c
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates9c 
FROM (SELECT RefDateAvnet.FyMthNbr
FROM #PrdScDates9b, RefDateAvnet
WHERE (((RefDateAvnet.FyMthNbr)>=[fy_first_mth_nbr]))) AS subquery9c
GO



--0000-09d

DROP TABLE #PrdScDates9d
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates9d 
FROM (SELECT #PrdScDates9c.FyMthNbr AS fy_qtr_plus_mth_nbr
FROM #PrdScDates9c
GROUP BY #PrdScDates9c.FyMthNbr) AS subquery9d
GO

--0000-10a

DROP TABLE #PrdScDates10a
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates10a 
FROM (SELECT RefDateAvnet.FyMthNbr, RefDateAvnet.BusDay99
FROM InventoryEomDetail INNER JOIN RefDateAvnet ON InventoryEomDetail.VersionDt = RefDateAvnet.DateDt
GROUP BY RefDateAvnet.FyMthNbr, RefDateAvnet.BusDay99
HAVING (((RefDateAvnet.BusDay99)>0))) AS subquery10a
GO

--0000-10b

DROP TABLE #PrdScDates10b
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates10b 
FROM (SELECT #PrdScDates10a.FyMthNbr, Min(#PrdScDates10a.BusDay99) AS BusDay99
FROM #PrdScDates10a
GROUP BY #PrdScDates10a.FyMthNbr
) AS subquery10b
GO


--0000-11

DROP TABLE #PrdScDates11
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates11
FROM (SELECT #PrdScDates6.FyMthNbr, #PrdScDates6.FyYyyyQtr, RefDateAvnet.FyTagMth
FROM #PrdScDates6 INNER JOIN RefDateAvnet ON #PrdScDates6.FyMthNbr = RefDateAvnet.FyMthNbr
GROUP BY #PrdScDates6.FyMthNbr, #PrdScDates6.FyYyyyQtr, RefDateAvnet.FyTagMth) AS subquery11
GO





--0000-12a

DROP TABLE #PrdScDates12a
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates12a 
FROM (SELECT RefDateAvnet.FyMthNbr, RefDateAvnet.FyTagMth
FROM RefDateAvnet
GROUP BY RefDateAvnet.FyMthNbr, RefDateAvnet.FyTagMth) AS subquery12a
GO


--0000-12

DROP TABLE #PrdScDates12
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates12
FROM (SELECT #PrdScDates12a.FyMthNbr, #PrdScDates12a.FyTagMth
FROM #PrdScDates12a, #PrdScDates4
WHERE (((#PrdScDates12a.FyMthNbr)<=PrevMthNbr And (#PrdScDates12a.FyMthNbr)>PrevMthNbr-16))) AS subquery12
GO



--Bring in SOBIProdAor
--1000-00

DROP TABLE #PrdScProdAor13
GO
USE CentralDbs
GO
SELECT * INTO #PrdScProdAor13 
FROM (SELECT Sobl.*
 ,Paor.AorEmpId
 ,Paor.[EmpFirstName]
 ,Paor.[EmpLastName]
 ,Stuff(Replace('/'+Convert(varchar(10), Sobl.[LogDt], 101),'/0','/'),1,1,'') AS log_dt
 --,CAST(Paor.SalesDocNbr AS varchar(20)) AS SalesDocNbr
 --,CAST(Paor.SalesDocItemNbr AS varchar(10)) AS SalesDocItemNbr
 --,CAST(Sobl.SalesOffice AS varchar(15)) AS SalesOffice
 --,CAST(Sobl.SalesGrp AS varchar(15)) AS SalesGrp
FROM SAP.dbo.SoblProdAor AS Paor INNER JOIN BI.dbo.SoBacklog AS SoBl ON Paor.SalesDocNbr= SoBl.SalesDocNbr AND Paor.SalesDocItemNbr=SoBl.SalesDocItemNbr) AS subquery13
GO


--1000-01

DROP TABLE #PrdScBillings13a
GO
USE CentralDbs
GO
SELECT * INTO #PrdScBillings13a 
FROM (SELECT #PrdScProdAor13.log_dt
FROM #PrdScProdAor13
GROUP BY #PrdScProdAor13.log_dt
) AS subquery13a
GO



--1000-02

DROP TABLE #PrdScBillings13b
GO
USE CentralDbs
GO
SELECT * INTO #PrdScBillings13b 
FROM (SELECT #PrdScBillings13a.log_dt, RefDateAvnet.FyMthNbr, RefDateAvnet.FyTagMth
FROM #PrdScBillings13a INNER JOIN RefDateAvnet ON #PrdScBillings13a.log_dt = RefDateAvnet.DateTxt) AS subquery13b
GO



--1000-03

DROP TABLE #PrdScBillings13c
GO
USE CentralDbs
GO
SELECT * INTO #PrdScBillings13c 
FROM (SELECT Max(#PrdScBillings13b.log_dt) AS MaxOflog_dt, #PrdScBillings13b.FyMthNbr, #PrdScBillings13b.FyTagMth
FROM #PrdScBillings13b
GROUP BY #PrdScBillings13b.FyMthNbr, #PrdScBillings13b.FyTagMth) AS subquery13c
GO


--1100-00

DROP TABLE #PrdScBillings14
GO
USE CentralDbs
GO
SELECT * INTO #PrdScBillings14
FROM (SELECT BookBill.LogDt, BookBill.LogTime, BookBill.TransDt, BookBill.BusDay99, BookBill.WkNbr, BookBill.FyMnthNbr, BookBill.FyTagMnth, BookBill.MaterialNbr, BookBill.pbg, BookBill.mfg, 
BookBill.PrcStgy, BookBill.cc, BookBill.grp, BookBill.tech, BookBill.MfgPartNbr, BookBill.SalesGrp, BookBill.SalesGrpKey, BookBill.SalesOffice, BookBill.SalesOfficeKey, 
BookBill.CustName, BookBill.CustNbr, BookBill.SalesDocTyp, BookBill.RefBillingNbr, BookBill.BillingsQty, BookBill.Billings, BookBill.cogs, BookBill.BillingsGp, BookBill.BookingsQty, BookBill.Bookings, BookBill.BookingsCost, BookBill.BookingsGp, CAST(SalesDocNbr AS Varchar(30)) AS sales_doc, SalesDocLnItm+'0' AS sales_doc_item
FROM BookBill) AS subquery14
GO


--1100-01

DROP TABLE #PrdScBillings14a
GO
USE CentralDbs
GO
SELECT * INTO #PrdScBillings14a 
FROM (SELECT #PrdScBillings14.Billings AS metric, #PrdScBillings14.LogDt, #PrdScBillings14.LogTime, #PrdScBillings14.TransDt, #PrdScBillings14.BusDay99, 
#PrdScBillings14.WkNbr, #PrdScProdAor13.AorEmpId AS Emp_Id, #PrdScProdAor13.EmpFirstName, #PrdScProdAor13.EmpLastName, #PrdScBillings14.FyMnthNbr, #PrdScBillings14.FyTagMnth, 
#PrdScBillings14.MaterialNbr, #PrdScBillings14.pbg, #PrdScBillings14.mfg, #PrdScBillings14.PrcStgy, #PrdScBillings14.cc, #PrdScBillings14.grp, #PrdScBillings14.tech, 
#PrdScBillings14.MfgPartNbr, #PrdScBillings14.SalesGrp, #PrdScBillings14.SalesGrpKey, #PrdScBillings14.SalesOffice, #PrdScBillings14.SalesOfficeKey, #PrdScBillings14.CustName, 
#PrdScBillings14.CustNbr, #PrdScBillings14.SalesDocTyp, #PrdScBillings14.RefBillingNbr, #PrdScBillings14.sales_doc, #PrdScBillings14.sales_doc_item, #PrdScBillings14.Billings AS [value]
FROM (#PrdScDates9d INNER JOIN #PrdScBillings14 ON #PrdScDates9d.fy_qtr_plus_mth_nbr = #PrdScBillings14.FyMnthNbr) LEFT JOIN #PrdScProdAor13 ON (#PrdScBillings14.sales_doc_item = #PrdScProdAor13.SalesDocItemNbr) AND (#PrdScBillings14.sales_doc = #PrdScProdAor13.SalesDocNbr)
GROUP BY #PrdScBillings14.Billings, #PrdScBillings14.LogDt, #PrdScBillings14.LogTime, #PrdScBillings14.TransDt, #PrdScBillings14.BusDay99, #PrdScBillings14.WkNbr, #PrdScProdAor13.AorEmpId, 
#PrdScProdAor13.EmpFirstName, #PrdScProdAor13.EmpLastName, #PrdScBillings14.FyMnthNbr, #PrdScBillings14.FyTagMnth, #PrdScBillings14.MaterialNbr, #PrdScBillings14.pbg, #PrdScBillings14.mfg, #PrdScBillings14.PrcStgy, 
#PrdScBillings14.cc, #PrdScBillings14.grp, #PrdScBillings14.tech, #PrdScBillings14.MfgPartNbr, #PrdScBillings14.SalesGrp, #PrdScBillings14.SalesGrpKey, #PrdScBillings14.SalesOffice, #PrdScBillings14.SalesOfficeKey, #PrdScBillings14.CustName, #PrdScBillings14.CustNbr, #PrdScBillings14.SalesDocTyp, #PrdScBillings14.RefBillingNbr, #PrdScProdAor13.AtpDt, #PrdScBillings14.sales_doc, #PrdScBillings14.sales_doc_item, #PrdScBillings14.Billings) AS subquery14a
GO


--1100-02a

DROP TABLE #PrdScBillings14b
GO
USE CentralDbs
GO
SELECT * INTO #PrdScBillings14b 
FROM (SELECT 'Net Billings $' AS metric, #PrdScBillings14a.FyTagMnth, #PrdScBillings14a.Emp_Id, #PrdScBillings14a.EmpFirstName, #PrdScBillings14a.EmpLastName, #PrdScBillings14a.pbg, #PrdScBillings14a.mfg, 
#PrdScBillings14a.PrcStgy, #PrdScBillings14a.cc, #PrdScBillings14a.grp, #PrdScBillings14a.tech, #PrdScBillings14a.SalesGrp, #PrdScBillings14a.SalesOffice, #PrdScBillings14a.MaterialNbr, #PrdScBillings14a.value AS [value]
FROM #PrdScDates4, #PrdScBillings14a) AS subquery14b
GO


--1100-02b

DROP TABLE #PrdScBillings14c
GO
USE CentralDbs
GO
SELECT * INTO #PrdScBillings14c 
FROM (SELECT #PrdScBillings14b.metric, #PrdScBillings14b.FyTagMnth, #PrdScBillings14b.Emp_Id, #PrdScBillings14b.EmpFirstName, #PrdScBillings14b.EmpLastName, #PrdScBillings14b.Pbg, #PrdScBillings14b.mfg, 
#PrdScBillings14b.PrcStgy, #PrdScBillings14b.cc, #PrdScBillings14b.grp, #PrdScBillings14b.tech, #PrdScBillings14b.SalesGrp, #PrdScBillings14b.SalesOffice, #PrdScBillings14b.MaterialNbr, 
Sum(#PrdScBillings14b.value) AS [value]
FROM #PrdScBillings14b, #PrdScDates4
GROUP BY #PrdScBillings14b.metric, #PrdScBillings14b.FyTagMnth, #PrdScBillings14b.Emp_Id, #PrdScBillings14b.EmpFirstName, #PrdScBillings14b.EmpLastName, #PrdScBillings14b.Pbg, #PrdScBillings14b.mfg, 
#PrdScBillings14b.PrcStgy, #PrdScBillings14b.cc, #PrdScBillings14b.grp, #PrdScBillings14b.tech, #PrdScBillings14b.SalesGrp, #PrdScBillings14b.SalesOffice, #PrdScBillings14b.MaterialNbr) AS subquery14c
GO



--1100-02c

DROP TABLE #PrdScBillings14d
GO
USE CentralDbs
GO
SELECT * INTO #PrdScBillings14d
FROM (SELECT #PrdScBillings14c.metric, #PrdScBillings14c.FyTagMnth, #PrdScBillings14c.Emp_Id, #PrdScBillings14c.EmpFirstName, #PrdScBillings14c.EmpLastName, #PrdScBillings14c.Pbg, #PrdScBillings14c.Mfg, #PrdScBillings14c.PrcStgy, 
#PrdScBillings14c.Cc, #PrdScBillings14c.Grp, #PrdScBillings14c.tech, #PrdScBillings14c.SalesGrp, #PrdScBillings14c.SalesOffice, #PrdScBillings14c.MaterialNbr, #PrdScBillings14c.value
FROM #PrdScBillings14c
GROUP BY #PrdScBillings14c.metric, #PrdScBillings14c.FyTagMnth, #PrdScBillings14c.Emp_Id, #PrdScBillings14c.EmpFirstName, #PrdScBillings14c.EmpLastName, #PrdScBillings14c.Pbg, #PrdScBillings14c.Mfg, #PrdScBillings14c.PrcStgy, 
#PrdScBillings14c.Cc, #PrdScBillings14c.Grp, #PrdScBillings14c.tech, #PrdScBillings14c.SalesGrp, 
#PrdScBillings14c.SalesOffice, #PrdScBillings14c.MaterialNbr, #PrdScBillings14c.value) AS subquery14d
GO


--1100-03a

DROP TABLE #PrdScBillingsGP15
GO
USE CentralDbs
GO
SELECT * INTO #PrdScBillingsGP15 
FROM (SELECT 'Net Billings GP$' AS metric, #PrdScBillings14a.FyTagMnth, #PrdScBillings14a.Emp_Id, #PrdScBillings14a.EmpFirstName, #PrdScBillings14a.EmpLastName, #PrdScBillings14a.pbg, #PrdScBillings14a.mfg, #PrdScBillings14a.PrcStgy, #PrdScBillings14a.cc, #PrdScBillings14a.grp, #PrdScBillings14a.tech, 
#PrdScBillings14a.SalesGrp, #PrdScBillings14a.SalesOffice, #PrdScBillings14a.MaterialNbr, #PrdScBillings14a.value
FROM #PrdScDates4, #PrdScBillings14a) AS subquery15
GO



--1100-03b
DROP TABLE #PrdScBillingsGP15a
GO
USE CentralDbs
GO
SELECT * INTO #PrdScBillingsGP15a 
FROM (SELECT #PrdScBillingsGP15.metric, #PrdScBillingsGP15.FyTagMnth, #PrdScBillingsGP15.Emp_Id, #PrdScBillingsGP15.EmpFirstName, #PrdScBillingsGP15.EmpLastName, #PrdScBillingsGP15.pbg, #PrdScBillingsGP15.mfg, 
#PrdScBillingsGP15.PrcStgy, #PrdScBillingsGP15.grp, #PrdScBillingsGP15.tech, #PrdScBillingsGP15.Cc, #PrdScBillingsGP15.SalesGrp, #PrdScBillingsGP15.SalesOffice, #PrdScBillingsGP15.MaterialNbr, Sum(#PrdScBillingsGP15.value) AS [value]
FROM #PrdScBillingsGP15, #PrdScDates4
GROUP BY #PrdScBillingsGP15.metric, #PrdScBillingsGP15.FyTagMnth, #PrdScBillingsGP15.Emp_Id, #PrdScBillingsGP15.EmpFirstName, #PrdScBillingsGP15.EmpLastName, #PrdScBillingsGP15.pbg, #PrdScBillingsGP15.mfg, #PrdScBillingsGP15.PrcStgy, 
#PrdScBillingsGP15.grp, #PrdScBillingsGP15.Cc, #PrdScBillingsGP15.tech, #PrdScBillingsGP15.SalesGrp, #PrdScBillingsGP15.SalesOffice, #PrdScBillingsGP15.MaterialNbr
) AS subquery15a
GO



--1100-03c
DROP TABLE #PrdScBillingsGP15b
GO
USE CentralDbs
GO
SELECT * INTO #PrdScBillingsGP15b 
FROM (SELECT #PrdScBillingsGP15a.metric, #PrdScBillingsGP15a.FyTagMnth, #PrdScBillingsGP15a.Emp_Id, #PrdScBillingsGP15a.EmpFirstName, #PrdScBillingsGP15a.EmpLastName, #PrdScBillingsGP15a.tech, #PrdScBillingsGP15a.pbg, #PrdScBillingsGP15a.mfg, 
#PrdScBillingsGP15a.PrcStgy, #PrdScBillingsGP15a.grp, #PrdScBillingsGP15a.Cc,  #PrdScBillingsGP15a.SalesGrp, #PrdScBillingsGP15a.SalesOffice, #PrdScBillingsGP15a.MaterialNbr, Sum(#PrdScBillingsGP15a.value) AS [value]
FROM #PrdScBillingsGP15a
GROUP BY #PrdScBillingsGP15a.metric, #PrdScBillingsGP15a.FyTagMnth, #PrdScBillingsGP15a.Emp_Id, #PrdScBillingsGP15a.EmpFirstName, #PrdScBillingsGP15a.EmpLastName, #PrdScBillingsGP15a.tech, #PrdScBillingsGP15a.pbg, #PrdScBillingsGP15a.mfg, 
#PrdScBillingsGP15a.PrcStgy, #PrdScBillingsGP15a.grp, #PrdScBillingsGP15a.Cc, #PrdScBillingsGP15a.SalesGrp, #PrdScBillingsGP15a.SalesOffice, #PrdScBillingsGP15a.MaterialNbr) AS subquery15b
GO



--1100-04
DROP TABLE #PrdScBookings16
GO
USE CentralDbs
GO
SELECT * INTO #PrdScBookings16 
FROM (SELECT BookBill.LogDt, BookBill.LogTime, BookBill.TransDt, BookBill.BusDay99, BookBill.WkNbr, BookBill.FyMnthNbr, BookBill.FyTagMnth, BookBill.MaterialNbr, BookBill.pbg, BookBill.mfg, BookBill.PrcStgy, 
BookBill.cc, BookBill.grp, BookBill.tech, BookBill.MfgPartNbr, BookBill.SalesGrpKey, BookBill.SalesOfficeKey, BookBill.CustNbr, #PrdScProdAor13.AorEmpId AS Emp_Id, #PrdScProdAor13.EmpFirstName, #PrdScProdAor13.EmpLastName, BookBill.SalesDocTyp, BookBill.SalesDocNbr, BookBill.SalesDocLnItm, BookBill.BookingsQty, BookBill.Bookings, BookBill.BookingsCost
FROM #PrdScProdAor13 INNER JOIN (#PrdScDates9d INNER JOIN BookBill ON #PrdScDates9d.fy_qtr_plus_mth_nbr = BookBill.FyMnthNbr) ON (#PrdScProdAor13.SalesDocItemNbr = BookBill.SalesDocLnItm) AND (#PrdScProdAor13.SalesDocNbr = BookBill.SalesDocNbr)) AS subquery16
GO



--1100-04a

DROP TABLE #PrdScBookings16a
GO
USE CentralDbs
GO
SELECT * INTO #PrdScBookings16a 
FROM (SELECT 'Net Bookings $' AS metric, #PrdScBookings16.LogDt, #PrdScBookings16.FyTagMnth, #PrdScBookings16.Emp_Id, #PrdScBookings16.EmpFirstName, #PrdScBookings16.EmpLastName, #PrdScBookings16.pbg, #PrdScBookings16.mfg, 
#PrdScBookings16.PrcStgy, #PrdScBookings16.cc, #PrdScBookings16.grp, #PrdScBookings16.tech, #PrdScBookings16.SalesGrpKey AS SalesGrp, #PrdScBookings16.SalesOfficeKey AS sales_office, #PrdScBookings16.MaterialNbr, 
#PrdScBookings16.Bookings AS [value]
FROM #PrdScBookings16, #PrdScDates4) AS subquery16a
GO


--1100-04b
DROP TABLE #PrdScBookings16b 
GO
USE CentralDbs
GO
SELECT * INTO #PrdScBookings16b
FROM (SELECT #PrdScBookings16a.metric, #PrdScBookings16a.FyTagMnth, #PrdScBookings16a.Emp_Id, #PrdScBookings16a.EmpFirstName, #PrdScBookings16a.EmpLastName, #PrdScBookings16a.pbg, #PrdScBookings16a.mfg, #PrdScBookings16a.PrcStgy, #PrdScBookings16a.cc, #PrdScBookings16a.grp, #PrdScBookings16a.tech, #PrdScBookings16a.SalesGrp, #PrdScBookings16a.sales_office, #PrdScBookings16a.MaterialNbr, Sum(#PrdScBookings16a.value) AS value
FROM #PrdScDates4, #PrdScBookings16a
GROUP BY #PrdScBookings16a.metric, #PrdScBookings16a.FyTagMnth, #PrdScBookings16a.Emp_Id, #PrdScBookings16a.EmpFirstName, #PrdScBookings16a.EmpLastName, #PrdScBookings16a.pbg, #PrdScBookings16a.mfg, #PrdScBookings16a.PrcStgy, #PrdScBookings16a.cc, #PrdScBookings16a.grp, #PrdScBookings16a.tech, #PrdScBookings16a.SalesGrp, #PrdScBookings16a.sales_office, #PrdScBookings16a.MaterialNbr) AS subquery16b
GO



--Sales Orders
--1200-01

DROP TABLE #PrdScSalesOrders17
GO
USE CentralDbs
GO
SELECT * INTO #PrdScSalesOrders17 
FROM (SELECT SalesOrderBacklogEom.LogDt AS version_dt
FROM SalesOrderBacklogEom
GROUP BY SalesOrderBacklogEom.LogDt
) AS subquery17
GO



--1200-02
DROP TABLE #PrdScSalesOrders17a
GO
USE CentralDbs
GO
SELECT * INTO #PrdScSalesOrders17a
FROM (SELECT #PrdScSalesOrders17.version_dt, RefDateAvnet.FyMthNbr, RefDateAvnet.FyTagMth AS FyTagMnth
FROM #PrdScSalesOrders17 INNER JOIN RefDateAvnet ON #PrdScSalesOrders17.version_dt=RefDateAvnet.DateDt) AS subquery17a
GO



--1200-03
DROP TABLE #PrdscSalesOrders17b
GO
USE CentralDbs
GO
SELECT * INTO #PrdScSalesOrders17b 
FROM (SELECT #PrdScSalesOrders17a.version_dt, #PrdScSalesOrders17a.FyMthNbr, #PrdScSalesOrders17a.FyTagMnth
FROM #PrdScSalesOrders17a INNER JOIN #PrdScDates4 ON #PrdScSalesOrders17a.FyMthNbr=#PrdScDates4.PrevMthNbr) AS subquery17b
GO




--1200-04
DROP TABLE #PrdScSalesOrders17c
GO
USE CentralDbs
GO
SELECT * INTO #PrdScSalesOrders17c 
FROM (SELECT Max(#PrdScSalesOrders17b.version_dt) AS version_dt, #PrdScSalesOrders17b.FyMthNbr, #PrdScSalesOrders17b.FyTagMnth
FROM #PrdScSalesOrders17b
GROUP BY #PrdScSalesOrders17b.FyMthNbr, #PrdScSalesOrders17b.FyTagMnth) AS subquery17c
GO


--1200-05
DROP TABLE #PrdScSalesOrders17d
GO
USE CentralDbs
GO
SELECT * INTO #PrdScSalesOrders17d 
FROM (SELECT 'Sales Orders EOM' AS metric, SalesOrderBacklogEom.LogDt, RefDateAvnet.FyTagMth AS FyTagMnth, #PrdScProdAor13.AorEmpId AS Emp_Id, #PrdScProdAor13.EmpFirstName, #PrdScProdAor13.EmpLastName, SalesOrderBacklogEom.pbg, SalesOrderBacklogEom.cc, SalesOrderBacklogEom.mfg, SalesOrderBacklogEom.PrcStgy, SalesOrderBacklogEom.grp, 
SalesOrderBacklogEom.tech, SalesOrderBacklogEom.MaterialNbr, SalesOrderBacklogEom.PlantId, SalesOrderBacklogEom.SalesOffice, SalesOrderBacklogEom.SalesGrp, SalesOrderBacklogEom.AtpDt, Sum(SalesOrderBacklogEom.TtlStkValue) AS [value]
FROM #PrdScDates4, RefDateAvnet INNER JOIN (#PrdScProdAor13 INNER JOIN SalesOrderBacklogEom ON (#PrdScProdAor13.SalesDocItemNbr = SalesOrderBacklogEom.SalesDocItemNbr) AND (#PrdScProdAor13.SalesDocNbr = SalesOrderBacklogEom.SalesDocNbr)) ON RefDateAvnet.DateDt = SalesOrderBacklogEom.LogDt
GROUP BY 'Sales Orders EOM', SalesOrderBacklogEom.LogDt, RefDateAvnet.FyTagMth, #PrdScProdAor13.AorEmpId, #PrdScProdAor13.EmpFirstName, #PrdScProdAor13.EmpLastName, SalesOrderBacklogEom.pbg, SalesOrderBacklogEom.cc, SalesOrderBacklogEom.mfg, SalesOrderBacklogEom.PrcStgy, SalesOrderBacklogEom.grp, SalesOrderBacklogEom.tech, 
SalesOrderBacklogEom.MaterialNbr, SalesOrderBacklogEom.PlantId, SalesOrderBacklogEom.SalesOffice, SalesOrderBacklogEom.SalesGrp, SalesOrderBacklogEom.AtpDt) AS subquery17d
GO



--1300-01
DROP TABLE #PrdScDelqSalesOrders18
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDelqSalesOrders18
FROM (SELECT SalesOrderBacklogZSB.VersionDt
FROM SalesOrderBacklogZSB
GROUP BY SalesOrderBacklogZSB.VersionDt
ORDER BY SalesOrderBacklogZSB.VersionDt DESC) AS subquery18
GO



--1300-02
DROP TABLE #PrdScDelqSalesOrders18a
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDelqSalesOrders18a
FROM (SELECT #PrdScDelqSalesOrders18.VersionDt, RefDateAvnet.FyMthNbr, RefDateAvnet.FyTagMth AS FyTagMnth
FROM #PrdScDelqSalesOrders18 INNER JOIN RefDateAvnet ON #PrdScDelqSalesOrders18.VersionDt = RefDateAvnet.DateDt) AS subquery18a
GO



--1300-03
DROP TABLE #PrdScDelqSalesOrders18b
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDelqSalesOrders18b 
FROM (SELECT #PrdScDelqSalesOrders18a.VersionDt, #PrdScDelqSalesOrders18a.FyMthNbr, #PrdScDelqSalesOrders18a.FyTagMnth
FROM #PrdScDelqSalesOrders18a INNER JOIN #PrdScDates4 ON #PrdScDelqSalesOrders18a.FyMthNbr = #PrdScDates4.PrevMthNbr) AS subquery18b
GO




--1300-04
DROP TABLE #PrdScDelqSalesOrders18c
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDelqSalesOrders18c
FROM (SELECT Max(#PrdScDelqSalesOrders18b.VersionDt) AS MaxOfversion_dt, #PrdScDelqSalesOrders18b.FyMthNbr, #PrdScDelqSalesOrders18b.FyTagMnth
FROM #PrdScDelqSalesOrders18b
GROUP BY #PrdScDelqSalesOrders18b.FyMthNbr, #PrdScDelqSalesOrders18b.FyTagMnth) AS subquery18c
GO


--1300-05
DROP TABLE #PrdScDelqSalesOrders18d
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDelqSalesOrders18d 
FROM (SELECT 'Delinquent ZSB Sales Orders' AS metric, SalesOrderBacklogZSB.LogDt, RefDateAvnet.FyTagMth AS FyTagMnth, #PrdScProdAor13.AorEmpId AS Emp_Id, #PrdScProdAor13.EmpFirstName, #PrdScProdAor13.EmpLastName, SalesOrderBacklogZSB.SalesDocNbr, SalesOrderBacklogZSB.SalesDocItemNbr, SalesOrderBacklogZSB.grp, SalesOrderBacklogZSB.pbg, SalesOrderBacklogZSB.CC AS cc, SalesOrderBacklogZSB.mfg, SalesOrderBacklogZSB.PrcStgy, SalesOrderBacklogZSB.tech, SalesOrderBacklogZSB.PlantId, SalesOrderBacklogZSB.SalesOffice, SalesOrderBacklogZSB.SalesGrp, SalesOrderBacklogZSB.MaterialNbr, SalesOrderBacklogZSB.ATPDt, Sum(SalesOrderBacklogZSB.TtlOrderValue) AS [value]
FROM #PrdScDates4, RefDateAvnet INNER JOIN (#PrdScProdAor13 INNER JOIN SalesOrderBacklogZSB ON (#PrdScProdAor13.SalesDocItemNbr = SalesOrderBacklogZSB.SalesDocItemNbr) AND (#PrdScProdAor13.SalesDocNbr = SalesOrderBacklogZSB.SalesDocNbr)) ON RefDateAvnet.DateDt = SalesOrderBacklogZSB.LogDt
GROUP BY 'Delinquent ZSB Sales Orders', SalesOrderBacklogZSB.LogDt, RefDateAvnet.FyTagMth, #PrdScProdAor13.AorEmpId, #PrdScProdAor13.EmpFirstName, #PrdScProdAor13.EmpLastName, SalesOrderBacklogZSB.SalesDocNbr, SalesOrderBacklogZSB.SalesDocItemNbr, SalesOrderBacklogZSB.grp, SalesOrderBacklogZSB.pbg, SalesOrderBacklogZSB.CC, SalesOrderBacklogZSB.mfg, SalesOrderBacklogZSB.PrcStgy, SalesOrderBacklogZSB.tech, SalesOrderBacklogZSB.PlantId, SalesOrderBacklogZSB.SalesOffice, SalesOrderBacklogZSB.SalesGrp, SalesOrderBacklogZSB.MaterialNbr, SalesOrderBacklogZSB.ATPDt) AS subquery18d
GO



--8000-01
DROP TABLE #PrdScProdHrchy19
GO
USE CentralDbs
GO
SELECT * INTO #PrdScProdHrchy19
FROM (SELECT InventoryEomDetail.pbg, InventoryEomDetail.mfg, InventoryEomDetail.PrcStgy, InventoryEomDetail.cc, InventoryEomDetail.grp
FROM InventoryEomDetail
GROUP BY InventoryEomDetail.pbg, InventoryEomDetail.mfg, InventoryEomDetail.PrcStgy, InventoryEomDetail.cc, InventoryEomDetail.grp
HAVING (((InventoryEomDetail.pbg)='0IT' Or (InventoryEomDetail.pbg)='0ST') AND ((InventoryEomDetail.mfg)>='AAA') AND ((InventoryEomDetail.PrcStgy) Is Not Null) AND ((InventoryEomDetail.cc) Is Not Null) AND ((InventoryEomDetail.grp) Is Not Null))
) AS subquery19
GO



--8000-02
DROP TABLE #PrdScProdHrchy19a
GO
USE CentralDbs
GO
SELECT * INTO #PrdScProdHrchy19a
FROM (SELECT #PrdScProdAor13.AorEmpId AS Emp_Id, #PrdScProdAor13.EmpFirstName, #PrdScProdAor13.EmpLastName, #PrdScProdAor13.Pbg AS pbg, #PrdScProdAor13.Mfg AS mfg, #PrdScProdAor13.PrcStgy AS PrcStgy, #PrdScProdAor13.Cc AS cc, #PrdScProdAor13.Grp AS grp, #PrdScProdAor13.Tech AS tech, #PrdScProdAor13.SalesGrp AS sales_grp, #PrdScProdAor13.SalesOffice AS sales_office, #PrdScProdAor13.MaterialNbr AS material_nbr
FROM #PrdScProdAor13
WHERE (((#PrdScProdAor13.AorEmpId) Is Not Null) AND ((#PrdScProdAor13.EmpFirstName) Is Not Null) AND ((#PrdScProdAor13.EmpLastName) Is Not Null) AND ((#PrdScProdAor13.Pbg)='0IT' Or (#PrdScProdAor13.Pbg)='0ST') AND ((#PrdScProdAor13.Mfg)>='AAA') AND ((#PrdScProdAor13.PrcStgy) Is Not Null) AND ((#PrdScProdAor13.Cc) Is Not Null) AND ((#PrdScProdAor13.Grp) Is Not Null) AND ((#PrdScProdAor13.Tech) Is Not Null) AND ((#PrdScProdAor13.SalesGrp) Is Not Null) AND ((#PrdScProdAor13.SalesOffice) Is Not Null) AND ((#PrdScProdAor13.MaterialNbr) Is Not Null))
) AS subquery19a
GO



--8000-03
DROP TABLE #PrdScProdHrchy19b
GO
USE CentralDbs
GO
SELECT * INTO #PrdScProdHrchy19b
FROM (SELECT #PrdScProdAor13.AorEmpId AS Emp_Id, #PrdScProdAor13.EmpFirstName, #PrdScProdAor13.EmpLastName, BookBill.pbg, BookBill.mfg, BookBill.PrcStgy, BookBill.cc, BookBill.grp, BookBill.tech, BookBill.SalesGrpKey AS sales_grp, BookBill.SalesOfficeKey AS sales_office, BookBill.MaterialNbr, Sum(BookBill.Billings) AS [billings_$]
FROM #PrdScProdAor13 INNER JOIN BookBill ON (#PrdScProdAor13.SalesDocItemNbr = BookBill.SalesDocLnItm) AND (#PrdScProdAor13.SalesDocNbr = BookBill.SalesDocNbr)
GROUP BY #PrdScProdAor13.AorEmpId, #PrdScProdAor13.EmpFirstName, #PrdScProdAor13.EmpLastName, BookBill.pbg, BookBill.mfg, BookBill.PrcStgy, BookBill.cc, BookBill.grp, BookBill.tech, BookBill.SalesGrpKey, BookBill.SalesOfficeKey, BookBill.MaterialNbr
HAVING (((#PrdScProdAor13.AorEmpId) Is Not Null) AND ((#PrdScProdAor13.EmpFirstName) Is Not Null) AND ((#PrdScProdAor13.EmpLastName) Is Not Null) AND ((BookBill.pbg)='0IT' Or (BookBill.pbg)='0ST') AND ((BookBill.mfg)>='AAA') AND ((BookBill.PrcStgy) Is Not Null) AND ((BookBill.cc) Is Not Null) AND ((BookBill.grp) Is Not Null) AND ((BookBill.tech) Is Not Null) AND ((BookBill.SalesGrpKey) Is Not Null) AND ((BookBill.SalesOfficeKey) Is Not Null) AND ((BookBill.MaterialNbr) Is Not Null) AND ((Sum(BookBill.[billings]))>0))
) AS subquery19b
GO




--8000-97
DROP TABLE #PrdScUnions20
GO
USE CentralDbs
GO
SELECT * INTO #PrdScUnions20 
FROM (SELECT #PrdScProdHrchy19a.Emp_Id, EmpFirstName, EmpLastName, pbg, mfg, PrcStgy, cc, grp, tech, sales_grp, sales_office, material_nbr
FROM #PrdScProdHrchy19a

UNION SELECT Emp_Id, EmpLastName, pbg, mfg, PrcStgy, cc, grp, tech, sales_grp, sales_office, MaterialNbr
FROM #PrdScProdHrchy19b

GROUP BY Emp_Id, EmpFirstName, EmpLastName, pbg, mfg, PrcStgy, cc, grp, tech, sales_grp, sales_office, MaterialNbr
) AS subquery20
GO


--8000-98
DROP TABLE #PrdScUnions20a
GO
USE CentralDbs
GO
SELECT * INTO #PrdScUnions20a 
FROM (SELECT #PrdScUnions20.Emp_Id, #PrdScUnions20.EmpFirstName, #PrdScUnions20.EmpLastName, #PrdScUnions20.pbg, #PrdScUnions20.mfg, #PrdScUnions20.PrcStgy, #PrdScUnions20.cc, #PrdScUnions20.grp, #PrdScUnions20.tech, #PrdScUnions20.sales_grp, #PrdScUnions20.sales_office, #PrdScUnions20.material_nbr, [pbg] & [mfg] & [PrcStgy] & [cc] & [grp] AS ph_key
FROM #PrdScUnions20
GROUP BY #PrdScUnions20.Emp_Id, #PrdScUnions20.EmpFirstName, #PrdScUnions20.EmpLastName, #PrdScUnions20.pbg, #PrdScUnions20.mfg, #PrdScUnions20.PrcStgy, #PrdScUnions20.cc, #PrdScUnions20.grp, #PrdScUnions20.tech, #PrdScUnions20.sales_grp, #PrdScUnions20.sales_office, #PrdScUnions20.material_nbr, [pbg] & [mfg] & [PrcStgy] & [cc] & [grp]) AS subquery20a
GO



--8000-99
DROP TABLE #PrdScUnions20b
GO
USE CentralDbs
GO
SELECT * INTO #PrdScUnions20b 
FROM (SELECT #PrdScUnions20a.ph_key, #PrdScUnions20a.pbg, #PrdScUnions20a.mfg, #PrdScUnions20a.PrcStgy, #PrdScUnions20a.cc, #PrdScUnions20a.grp, #PrdScUnions20a.sales_grp, #PrdScUnions20a.sales_office, #PrdScUnions20a.tech, #PrdScUnions20a.material_nbr,
CASE WHEN (#PrdScProdAor13.[AorEmpId] Is Null) THEN 'Unassigned' ELSE #PrdScProdAor13.[AorEmpId] END AS Emp_Id, 
CASE WHEN (#PrdScProdAor13.EmpFirstName Is Null) THEN 'Unassigned' ELSE #PrdScProdAor13.[EmpFirstName] END AS EmpFirstName, 
CASE WHEN (#PrdScProdAor13.EmpLastName Is Null) THEN 'Unassigned' ELSE #PrdScProdAor13.[EmpLastName] END AS EmpLastName
FROM #PrdScUnions20a INNER JOIN #PrdScProdAor13 ON (#PrdScUnions20a.sales_grp = #PrdScProdAor13.SalesGrp) AND (#PrdScUnions20a.sales_office = #PrdScProdAor13.SalesOffice) AND (#PrdScUnions20a.material_nbr = #PrdScProdAor13.MaterialNbr) AND (#PrdScUnions20a.tech = #PrdScProdAor13.Tech) AND (#PrdScUnions20a.grp = #PrdScProdAor13.Grp) AND (#PrdScUnions20a.cc = #PrdScProdAor13.Cc) AND (#PrdScUnions20a.PrcStgy = #PrdScProdAor13.PrcStgy) AND (#PrdScUnions20a.mfg = #PrdScProdAor13.Mfg) AND (#PrdScUnions20a.pbg = #PrdScProdAor13.Pbg)
GROUP BY #PrdScUnions20a.ph_key, #PrdScUnions20a.pbg, #PrdScUnions20a.mfg, #PrdScUnions20a.PrcStgy, #PrdScUnions20a.cc, #PrdScUnions20a.grp, #PrdScUnions20a.sales_grp, #PrdScUnions20a.sales_office, #PrdScUnions20a.tech, #PrdScUnions20a.material_nbr, #PrdScUnions20a.Emp_Id, #PrdScUnions20a.EmpFirstName, #PrdScUnions20a.EmpLastName
) AS subquery20b
GO



--8100-00a
DROP TABLE #PrdScUnions20c
GO
USE CentralDbs
GO
SELECT * INTO #PrdScUnions20c 
FROM (SELECT metric, FyTagMnth, Emp_Id, EmpFirstName, EmpLastName, Pbg, Mfg, PrcStgy, Grp, Cc, tech, SalesGrp, SalesOffice, MaterialNbr, value
FROM #PrdScBillings14d

UNION SELECT metric, FyTagMnth, Emp_Id, EmpFirstName, EmpLastName,  Pbg, Mfg, PrcStgy, Grp, Cc, tech, SalesGrp, SalesOffice, MaterialNbr, value
FROM #PrdScBillingsGP15b) AS subquery20c
GO



--8100-00b
DROP TABLE #PrdScUnions20d
GO
USE CentralDbs
GO
SELECT * INTO #PrdScUnions20d
FROM (SELECT metric, FyTagMnth, Emp_Id, EmpFirstName, EmpLastName, Pbg, Mfg, PrcStgy, Grp, Cc, tech, SalesGrp, SalesOffice, MaterialNbr, value
FROM #PrdScSalesOrders17d

UNION SELECT metric, FyTagMnth, Emp_Id, EmpFirstName, EmpLastName, Pbg, Mfg, PrcStgy, Grp, Cc, tech, SalesGrp, SalesOffice, MaterialNbr, value
FROM #PrdScDelqSalesOrders18d

--8100-00c
UNION SELECT metric, FyTagMnth, Emp_Id, EmpFirstName, EmpLastName, Pbg, Mfg, PrcStgy, Grp, Cc, tech, SalesGrp, sales_office, MaterialNbr, value
FROM #PrdScBookings16b ) AS subquery20c
GO




--8100-01
DROP TABLE #PrdScUnions20e
GO
USE CentralDbs
GO
SELECT * INTO #PrdScUnions20e
FROM (SELECT metric, FyTagMnth, Emp_Id, EmpFirstName, EmpLastName, Pbg, Mfg, PrcStgy, Grp, Cc, tech, SalesGrp, SalesOffice, MaterialNbr, value, [pbg] & [mfg] & [PrcStgy] & [cc] & [grp] AS ph_key
FROM #PrdScUnions20c

UNION SELECT metric, FyTagMnth, Emp_Id, EmpFirstName, EmpLastName, Pbg, Mfg, PrcStgy, Grp, Cc, tech, SalesGrp, SalesOffice, MaterialNbr, value, [pbg] & [mfg] & [PrcStgy] & [cc] & [grp] AS ph_key
FROM #PrdScUnions20d
) AS subquery20e
GO



--8100-02
DROP TABLE #PrdScUnions20f
GO
USE CentralDbs
GO
SELECT * INTO #PrdScUnions20f
SELECT #PrdScUnions20e.metric, #PrdScUnions20e.FyTagMnth, #PrdScUnions20b.Emp_Id, #PrdScUnions20b.EmpFirstName, #PrdScUnions20b.EmpLastName, #PrdScUnions20b.pbg, #PrdScUnions20b.mfg, #PrdScUnions20b.PrcStgy, #PrdScUnions20b.cc, #PrdScUnions20b.grp, #PrdScUnions20e.tech, #PrdScUnions20e.SalesGrp, #PrdScUnions20e.SalesOffice, #PrdScUnions20e.MaterialNbr, 
CASE WHEN ([value] Is Null) THEN 0 ELSE [value] END AS [value],  #PrdScUnions20e.ph_key
FROM #PrdScUnions20e RIGHT JOIN #PrdScUnions20b ON #PrdScUnions20e.ph_key = #PrdScUnions20b.ph_key;
GO



--8100-02a
DROP TABLE #PrdScUnions20g
GO
USE CentralDbs
GO
SELECT * INTO #PrdScUnions20g
FROM (SELECT #PrdScUnions20e.metric, #PrdScUnions20e.FyTagMnth, #PrdScUnions20b.Emp_Id, #PrdScUnions20b.EmpFirstName, #PrdScUnions20b.EmpLastName, #PrdScUnions20b.pbg, #PrdScUnions20b.mfg, #PrdScUnions20b.PrcStgy, #PrdScUnions20b.cc, #PrdScUnions20b.grp, #PrdScUnions20e.tech, #PrdScUnions20e.SalesGrp, #PrdScUnions20e.SalesOffice, #PrdScUnions20e.MaterialNbr, 
CASE WHEN ([value] Is Null) THEN 0 ELSE [value] END AS [value], #PrdScUnions20b.ph_key
FROM #PrdScUnions20e LEFT JOIN #PrdScUnions20b ON #PrdScUnions20e.ph_key = #PrdScUnions20b.ph_key
WHERE (#PrdScUnions20b.ph_key) Is Null) AS subquery20g
GO



--8100-02b
DROP TABLE #PrdScUnions20h
GO
USE CentralDbs
GO
SELECT * INTO #PrdScUnions20h
FROM (SELECT metric, FyTagMnth, Emp_Id, EmpFirstName, EmpLastName, pbg, mfg, prc_stgy, cc, grp, tech, sales_grp, sales_office, material_nbr, ph_key, value
FROM #PrdScUnions20f
UNION SELECT metric, FyTagMnth, Emp_Id, EmpFirstName, EmpLastName, pbg, mfg, PrcStgy, cc, grp, tech, SalesGrp, SalesOffice, MaterialNbr, ph_key, value
FROM #PrdScUnions20g) AS subquery20h
GO




--8100-03
DROP TABLE #PrdScUnions20i
GO
USE CentralDbs
GO
SELECT * INTO #PrdScUnions20i
FROM (SELECT #PrdScUnions20h.metric, #PrdScUnions20h.FyTagMnth, #PrdScUnions20h.Emp_Id, #PrdScUnions20h.EmpFirstName, #PrdScUnions20h.EmpLastName, #PrdScUnions20h.pbg, #PrdScUnions20h.mfg, #PrdScUnions20h.prc_stgy, #PrdScUnions20h.cc, #PrdScUnions20h.grp, #PrdScUnions20h.tech, #PrdScUnions20h.sales_grp, #PrdScUnions20h.sales_office, #PrdScUnions20h.material_nbr, Sum(#PrdScUnions20h.value) 
FROM ref_metric_list LEFT JOIN #PrdScUnions20h ON ref_metric_list.metric = #PrdScUnions20h.metric
GROUP BY #PrdScUnions20h.metric, #PrdScUnions20h.Emp_Id, #PrdScUnions20h.EmpFirstName, #PrdScUnions20h.EmpLastName, #PrdScUnions20h.pbg, #PrdScUnions20h.mfg, #PrdScUnions20h.prc_stgy, #PrdScUnions20h.cc, #PrdScUnions20h.grp, #PrdScUnions20h.tech, #PrdScUnions20h.sales_grp, #PrdScUnions20h.sales_office, #PrdScUnions20h.material_nbr, ref_metric_list desc
ORDER BY ref_metric_list.sort) AS subquery20i
GO


--9999-01_export
DROP TABLE #PrdScDates1
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates1 
FROM () AS subquery1
GO




--BOOKINGS & BILLINGS & BILLINGS GP$ & SALES ORDERS & DELQ SALES ORDERS
--**********************************************************************


DROP TABLE #RefDate
GO
USE CentralDbs
GO
SELECT * INTO #RefDate 
FROM (SELECT RefDateAvnet.FyTagMth, RefDateAvnet.FyYyyyQtr, RefDateAvnet.BusDay99, RefDateAvnet.DateDt, RefDateAvnet.FyMth
FROM RefDateAvnet) AS subquery0
GO


DROP TABLE #Billings
GO
USE CentralDbs
GO
SELECT * INTO #Billings 
FROM (SELECT 'Billings$' AS metric, BookBill.LogDt, BookBill.LogTime, BookBill.TransDt, BookBill.BusDay99, BookBill.FyMnthNbr, BookBill.FyTagMnth, BookBill.MaterialNbr, BookBill.pbg, BookBill.mfg, BookBill.PrcStgy, BookBill.cc, BookBill.grp, BookBill.tech, BookBill.MfgPartNbr, BookBill.SalesGrp, BookBill.SalesOffice, BookBill.CustName, BookBill.CustNbr+0 AS CustNbr, ProdAorBookBill.SalesDocNbr, ProdAorBookBill.SalesDocLnItm, BookBill.Bookings AS [value], ProdAorBookBill.EmpFirstName, ProdAorBookBill.EmpLastName
FROM ProdAorBookBill RIGHT JOIN BookBill ON (ProdAorBookBill.SalesDocLnItm = BookBill.SalesDocLnItm) AND (ProdAorBookBill.SalesDocNbr = BookBill.SalesDocNbr) AND (ProdAorBookBill.AccountNbr = BookBill.CustNbr)
WHERE ((ISNUMERIC(CustNbr)=1  or CustNbr = '' or CustNbr IS NULL))
)  AS subquery1
GO 


DROP TABLE #BillingsGP$
GO
USE CentralDbs
GO
SELECT * INTO #BillingsGP$ 
FROM (SELECT 'BillingsGP$' AS metric, BookBill.LogDt, BookBill.LogTime, BookBill.TransDt, BookBill.BusDay99, BookBill.FyMnthNbr, BookBill.FyTagMnth, BookBill.MaterialNbr, BookBill.pbg, BookBill.mfg, BookBill.PrcStgy, BookBill.cc, BookBill.grp, BookBill.tech, BookBill.MfgPartNbr, BookBill.SalesGrp, BookBill.SalesOffice, BookBill.CustName, BookBill.CustNbr+0 AS CustNbr, BookBill.SalesDocTyp, BookBill.SalesDocNbr, BookBill.SalesDocLnItm, BookBill.Bookings AS [value], ProdAorBookBill.EmpFirstName, ProdAorBookBill.EmpLastName
FROM ProdAorBookBill RIGHT JOIN BookBill ON (ProdAorBookBill.SalesDocLnItm = BookBill.SalesDocLnItm) AND (ProdAorBookBill.SalesDocNbr = BookBill.SalesDocNbr) AND (ProdAorBookBill.AccountNbr = BookBill.CustNbr)
Where ((ISNUMERIC(CustNbr)=1  or CustNbr = '' or CustNbr IS NULL))
)  AS subquery2
GO

DROP TABLE #Bookings$
GO
USE CentralDbs
GO
SELECT * INTO #Bookings$
FROM (SELECT 'Bookings$' AS metric, BookBill.LogDt, BookBill.LogTime, BookBill.TransDt, BookBill.BusDay99, BookBill.FyMnthNbr, BookBill.FyTagMnth, BookBill.MaterialNbr, BookBill.pbg, BookBill.mfg, BookBill.PrcStgy, BookBill.cc, BookBill.grp, BookBill.tech, BookBill.MfgPartNbr, BookBill.SalesGrp, BookBill.SalesOffice, BookBill.CustName, BookBill.CustNbr+0 AS CustNbr, BookBill.SalesDocTyp, BookBill.SalesDocNbr, BookBill.SalesDocLnItm, BookBill.Bookings AS [value], ProdAorBookBill.EmpFirstName, ProdAorBookBill.EmpLastName
FROM ProdAorBookBill RIGHT JOIN BookBill ON (ProdAorBookBill.SalesDocLnItm = BookBill.SalesDocLnItm) AND (ProdAorBookBill.SalesDocNbr = BookBill.SalesDocNbr) AND (ProdAorBookBill.AccountNbr = BookBill.CustNbr)
Where ((ISNUMERIC(CustNbr)=1  or CustNbr = '' or CustNbr IS NULL))
) AS subquery3
GO

DROP TABLE #SalesOrders
GO
USE SAP
GO
SELECT * INTO #SalesOrders
FROM (SELECT 'Sales Orders' AS metric, RefDateAvnet.FyTagMth, Paor.AorEmpId, Paor.[EmpFirstName], Paor.[EmpLastName], SoBl.AtpDt, SoBl.Pbg, SoBl.Mfg, SoBl.PrcStgy, SoBl.Cc, SoBl.Grp, SoBl.Tech, SoBl.MfgPartNbr, SoBl.BlockedOrders, SoBl.MaterialNbr,
  Stuff(Replace('/'+Convert(varchar(10), Sobl.[LogDt], 101),'/0','/'),1,1,'') AS LogDt
 ,CAST(Paor.[SalesDocNbr] AS varchar(20)) AS SalesDocNbr
 ,CAST(Paor.[SalesDocItemNbr] AS varchar(10)) AS SalesDocItemNbr
 ,CAST(Sobl.[SalesOffice] AS varchar(15)) AS sales_office
 ,CAST(Sobl.[SalesGrp] AS varchar(15)) AS sales_grp
 ,SoBl.TtlOrderValue as [value]
FROM CentralDbs.dbo.RefDateAvnet AS RefDateAvnet, SAP.dbo.SoblProdAor AS Paor INNER JOIN BI.dbo.SoBacklog AS SoBl ON Paor.SalesDocNbr= SoBl.[SalesDocNbr] AND Paor.SalesDocItemNbr=SoBl.SalesDocItemNbr
WHERE RefDateAvnet.DateDt = SoBl.LogDt) AS subquery4
GO

DROP TABLE #DelqSalesOrders
GO
USE SAP
GO
SELECT * INTO #DelqSalesOrders
FROM (SELECT 'Delinquent Sales Orders' AS metric, RefDateAvnet.FyTagMth, Paor.AorEmpId, Paor.[EmpFirstName], Paor.[EmpLastName], SoBl.AtpDt, SoBl.Pbg, SoBl.Mfg, SoBl.PrcStgy, SoBl.Cc, SoBl.Grp, SoBl.Tech, SoBl.MfgPartNbr, SoBl.BlockedOrders, SoBl.MaterialNbr,
  Stuff(Replace('/'+Convert(varchar(10), Sobl.[LogDt], 101),'/0','/'),1,1,'') AS LogDt
 ,CAST(Paor.[SalesDocNbr] AS varchar(20)) AS SalesDocNbr
 ,CAST(Paor.[SalesDocItemNbr] AS varchar(10)) AS SalesDocItemNbr
 ,CAST(Sobl.[SalesOffice] AS varchar(15)) AS sales_office
 ,CAST(Sobl.[SalesGrp] AS varchar(15)) AS sales_grp
 ,CASE WHEN SoBl.CustReqDockDt < Cast(GetDate() as Date) THEN SoBl.TtlOrderValue ELSE 0 END AS [value]
FROM CentralDbs.dbo.RefDateAvnet AS RefDateAvnet, SAP.dbo.SoblProdAor AS Paor INNER JOIN BI.dbo.SoBacklog AS SoBl ON Paor.SalesDocNbr= SoBl.[SalesDocNbr] AND Paor.SalesDocItemNbr=SoBl.SalesDocItemNbr
WHERE RefDateAvnet.DateDt = SoBl.LogDt) AS subquery5
GO

/*
DROP TABLE #PrdScDates1
GO
USE CentralDbs
GO
SELECT * INTO #PrdScDates1 
FROM () AS subquery1
GO
*/