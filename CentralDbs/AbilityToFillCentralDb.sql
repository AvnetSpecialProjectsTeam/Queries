--ABILITY TO FILL REPORT DATABASE - OWNER KRISTA CROSS 
--BUILT 09/29/2017


--0000's GATHER DATES 
--1000's GATER INPUTS  
--2000's JOIN INPUTS
--3000's CALCULATE METRICS
--4000's ADD METRICS
--5000's MERGE WITH HISTORICAL DATA  
--6000's SUMMARIZE FINALIIZE TABLES
--9000's EXPORT QUERIES FINAL REPORT 


--0000_01 GET CURRENT DATE 
DROP TABLE #Atf1CurrentDt
USE CentralDbs
GO
SELECT * INTO #Atf1CurrentDt
FROM (SELECT DateDt, FyMthNbr, WkNbr, FyYyyyWw, BusDayNbr
FROM dbo.RefDateAvnet
WHERE (dbo.RefDateAvnet.DateDt)=CAST(SYSDATETIME() AS DATE)) AS Subquery1
GO
		


--0000_02 ID PRIOR 13 WEEKS
DROP TABLE #Atf2prev13wks
USE CentralDbs
GO
SELECT * INTO #Atf2prev13wks
FROM (SELECT dbo.RefDateAvnet.FyYyyyWw, dbo.RefDateAvnet.FyTagMth 
FROM dbo.RefDateAvnet, #Atf1CurrentDt
WHERE (((dbo.RefDateAvnet.FyYyyyWw)>=#Atf1CurrentDt.FyYyyyWw-13 AND (dbo.RefDateAvnet.FyYyyyWw)<#Atf1CurrentDt.FyYyyyWw))) AS subquery2
GO
		


--0000_03 GROUP BY ID 13 PRIOR WEEKS
DROP TABLE #Atf3GroupBy13Wks
USE CentralDbs
GO
SELECT * INTO #Atf3GroupBy13Wks
FROM (SELECT FyYyyyWw, FyTagMth 
FROM #Atf2prev13wks
GROUP BY FyYyyyWw, FyTagMth) AS subquery3
GO
		


--0000_04 ID WEEK 14
DROP TABLE #Atf4IdWk14
USE CentralDbs
GO
SELECT * INTO #Atf4IdWk14
FROM (SELECT FyYyyyWw-13 AS FyYyyyWw
FROM #Atf1CurrentDt) AS subquery4
GO
		


--1000_01  FORMAT BOOKBILL AND SALES DATA 
DROP TABLE #Atf5BookBill
USE CentralDbs
GO
SELECT * INTO #Atf5BookBill
FROM (SELECT dbo.BookBill.LogDt, dbo.BookBill.BusDay99, dbo.BookBill.WkNbr, dbo.BookBill.FyMnthNbr, dbo.BookBill.FyTagMnth, dbo.BookBill.MaterialNbr, dbo.BookBill.Pbg, dbo.BookBill.Mfg, dbo.BookBill.PrcStgy, dbo.BookBill.Cc, dbo.BookBill.Grp, dbo.BookBill.Tech, dbo.BookBill.MfgPartNbr, SUM(dbo.BookBill.BillingsQty) AS BillingsQty,SUM(dbo.BookBill.Billings) AS Billings,SUM(dbo.BookBill.Cogs) AS Cogs,SUM(dbo.BookBill.BookingsQty) AS BookingsQty,SUM(dbo.BookBill.Bookings) AS Bookings,SUM(dbo.BookBill.BookingsCost) AS BookingsCost, dbo.BookBill.Type
FROM dbo.BookBill
GROUP BY dbo.BookBill.LogDt, dbo.BookBill.BusDay99, dbo.BookBill.WkNbr, dbo.BookBill.FyMnthNbr, dbo.BookBill.FyTagMnth, dbo.BookBill.MaterialNbr, dbo.BookBill.Pbg, dbo.BookBill.Mfg, dbo.BookBill.PrcStgy, dbo.BookBill.Cc, dbo.BookBill.Grp, dbo.BookBill.Tech, dbo.BookBill.MfgPartNbr, dbo.BookBill.Type) AS subquery5
GO
	


--1000_02 6 MONTHS OF SALES DATA 
DROP TABLE #Atf6BookBill6Mth
USE CentralDbs
GO
SELECT * INTO #Atf6BookBill6Mth
FROM (SELECT #Atf5BookBill.LogDt, #Atf5BookBill.BusDay99, #Atf5BookBill.WkNbr, #Atf5BookBill.FyMnthNbr, #Atf5BookBill.FyTagMnth, #Atf5BookBill.MaterialNbr, #Atf5BookBill.Pbg, #Atf5BookBill.Mfg ,#Atf5BookBill.PrcStgy, #Atf5BookBill.Cc, #Atf5BookBill.Grp, #Atf5BookBill.Tech, #Atf5BookBill.MfgPartNbr, #Atf5BookBill.BillingsQty, #Atf5BookBill.Billings,  #Atf5BookBill.Cogs,#Atf5BookBill.BookingsQty, #Atf5BookBill.Bookings, #Atf5BookBill.BookingsCost, #Atf5BookBill.Type
FROM #Atf5BookBill, #Atf1CurrentDt
WHERE #Atf5BookBill.FyMnthNbr >= #Atf1CurrentDt.FyMthNbr-6) AS subquery6
GO
		

--1000_03 SAP PARTS LIST FILTER
DROP TABLE #Atf7PartsList 
USE CentralDbs
GO
SELECT * INTO #Atf7PartsList 
FROM (SELECT DISTINCT MaterialNbr, pbg, mfg, MaterialType, PrcStgy, cc, grp, tech, MfgPartNbr
FROM dbo.SapPartsList
WHERE (MAtHubState<>-1 And ((pbg)='0IT' Or (pbg)='0ST'))) AS subquery7
GO
		

--1000_04 DAILY INVENTROY FILTER
DROP TABLE #Atf8DailyInventory
USE BI
GO
SELECT * INTO #Atf8DailyInventory 
FROM (SELECT MaterialNbr, MfgPartNbr, Sum(AvlStkQty) AS Qas, Sum(TtlStkQty) AS Qoh, SUM(TtlStkValue) AS TtlStkValue
FROM dbo.DailyInv
GROUP BY MaterialNbr, MfgPartNbr) AS subquery8
GO
		

--1000_05 CALC AVERAGE UNIT COST OF INVENTORY 
DROP TABLE #Atf9InvAvgCost
USE BI
GO
SELECT * INTO #Atf9InvAvgCost 
FROM (SELECT MaterialNbr, MfgPartNbr, Qas, Qoh, TtlStkValue, CASE WHEN (Qoh=0) THEN 0 ELSE (TtlStkValue/Qoh) END AS AvgUnitCost
FROM #Atf8DailyInventory) AS subquery9
GO
		

--1000_06 SAP QTY'S: LEAD TIME, MPQ, MOQ, SMOQ
DROP TABLE #Atf10SapQty
USE CentralDbs
GO
SELECT * INTO #Atf10SapQty
FROM (SELECT MaterialNbr, Min(SupplierMinPackageQt) AS SMPQ, MIN(SupplierMinOrderQt) AS SMOQ, MIN(LTPlanDlvry) AS LeadTime
FROM dbo.SapQuantities
GROUP BY MaterialNbr) AS subquery10
GO



--10000_07 MULTI COLUMN COSTS
DROP TABLE #Atf11MultiColCosts
USE MDM
GO
SELECT * INTO #Atf11MultiColCosts
FROM (SELECT MaterialNbr,
CASE 
    WHEN [col10qty]>0 THEN [col10qty]
	WHEN [col10qty]=0 AND [col9qty]>0 THEN [col9qty]
	WHEN [col9qty]=0 AND [col8qty]>0 THEN [col8qty]
	WHEN [col8qty]=0 AND [col7qty]>0 THEN [col7qty]
	WHEN [col7qty]=0 AND [col6qty]>0 THEN [col6qty]
	WHEN [col6qty]=0 AND [col5qty]>0 THEN [col5qty]
	WHEN [col5qty]=0 AND [col4qty]>0 THEN [col4qty]
	WHEN [col4qty]=0 AND [col3qty]>0 THEN [col3qty]
	WHEN [col3qty]=0 AND [col2qty]>0 THEN [col2qty]
	WHEN [col2qty]=0 AND [col1qty]>0 THEN [col1qty]
	ELSE 999
END AS MinMCQty,
CASE 
    WHEN [col10$]>0 THEN [col10$]
	WHEN [col10$]=0 AND [col9$]>0 THEN [col9$]
	WHEN [col9$]=0 AND [col8$]>0 THEN [col8$]
	WHEN [col8$]=0 AND [col7$]>0 THEN [col7$]
	WHEN [col7$]=0 AND [col6$]>0 THEN [col6$]
	WHEN [col6$]=0 AND [col5$]>0 THEN [col5$]
	WHEN [col5$]=0 AND [col4$]>0 THEN [col4$]
	WHEN [col4$]=0 AND [col3$]>0 THEN [col3$]
	WHEN [col3$]=0 AND [col2$]>0 THEN [col2$]
	WHEN [col2$]=0 AND [col1$]>0 THEN [col1$]
	ELSE 999
END AS MinMCCost
FROM mdm.dbo.MultiColumnCost) as subquery11
GO


-- 1000_08 FLAGS AND CODES
DROP TABLE #Atf12FlagsCodes
USE CentralDbs
GO
SELECT * INTO #Atf12FlagsCodes 
FROM (SELECT MaterialNbr, SapPlantCd AS Plant, AbcCd AS Abc, SapStockingProfile AS StkProf, Ecomm, RANK() OVER(PARTITION BY MaterialNbr ORDER BY MaterialNbr, SapPlantCd ASC) AS Rank1
FROM Centraldbs.dbo.SapFlagsCodes) as subquery12
WHERE Rank1=1
Order BY MaterialNbr, Rank1
GO


-- 1000_09 MATERIAL ASSIGNMENTS
DROP TABLE #Atf13MatAor
USE SAP
GO
SELECT * INTO #Atf13MatAor
FROM (SELECT DISTINCT MatNbr, SrDir, Pld, MatlMgr, MatlSpclst
FROM MatAor) as subquery13
GO


-- 1000_10 PURCHASE ORDERS 
DROP TABLE #Atf14POs
USE BI
GO
SELECT * INTO #Atf14POs
FROM (SELECT DISTINCT MaterialNbr, Mfg, PoNbr, SchedLineDeliveryDt, PoOpenQty, PoRemainingValue AS PoOpenValue
FROM BIPoBacklog
WHERE Mfg<>'AVT' AND SchedLineDeliveryDt<=(CAST(SYSDATETIME() AS DATE))) as subquery14
GO

----------------------------------------------------------------------------------------------------------------------------------------------------------HERE
-- BEST GUESS ON HOW TO CALCULATE RUN RATE REQ NEEDS VALIDATION
-- SINCE THIS IS A TEST ONLY INCLUDES HR PARTS NEEDS CALC FOR OTHER PARTS 

-- 1000_11a CALC RUN RATE REQ -high runners for last two weeks of billings 
DROP TABLE #Atf15RunRate
USE CentralDbs
GO
SELECT * INTO #Atf15RunRate
FROM (SELECT  #Atf6BookBill6Mth.LogDt, #Atf6BookBill6Mth.WkNbr, #Atf6BookBill6Mth.FyMnthNbr, #Atf6BookBill6Mth.FyTagMnth, #Atf6BookBill6Mth.MaterialNbr, #Atf6BookBill6Mth.BillingsQty, #Atf6BookBill6Mth.Billings
FROM #Atf6BookBill6Mth LEFT JOIN #Atf12FlagsCodes ON #Atf6BookBill6Mth.MaterialNbr = #Atf12FlagsCodes.MaterialNbr INNER JOIN dbo.RefDateAvnet ON #Atf6BookBill6Mth.LogDt = dbo.RefDateAvnet.DateDt
WHERE RefDateAvnet.DateDt BETWEEN DATEADD(DAY,-14, GETDATE()) AND GETDATE() AND #Atf12FlagsCodes.StkProf='HR') as subquery15


-- 1000_11b CALC RUN RATE REQ - current qas for hr billings parts 
DROP TABLE #Atf16RunRate
USE CentralDbs
GO
SELECT * INTO #Atf16RunRate
FROM (SELECT  #Atf15RunRate.FyTagMnth, #Atf15RunRate.MaterialNbr, SUM(#Atf15RunRate.BillingsQty) as BillingsQty, SUM(#Atf15RunRate.Billings) as Billings, SUM(#Atf8DailyInventory.Qas) as Qas
FROM #Atf15RunRate LEFT JOIN #Atf8DailyInventory ON  #Atf15RunRate.MaterialNbr = #Atf8DailyInventory.MaterialNbr
GROUP BY #Atf15RunRate.FyTagMnth, #Atf15RunRate.MaterialNbr) as subquery16


-- 1000_11c CALC RUN RATE REQ - replace 0's with nulls 
DROP TABLE #Atf17RunRate
USE CentralDbs
GO
SELECT * INTO #Atf17RunRate
FROM (SELECT  #Atf16RunRate.FyTagMnth, #Atf16RunRate.MaterialNbr, #Atf16RunRate.Billings, CASE WHEN #Atf16RunRate.BillingsQty=0 THEN NULL ELSE #Atf16RunRate.BillingsQty END as BillingsQty, CASE WHEN #Atf16RunRate.Qas=0 THEN NULL ELSE #Atf16RunRate.Qas END as Qas
FROM #Atf16RunRate) as subquery17


-- 1000_11d CALC RUN RATE REQ - divide billings qty by qas to get the run rate 
DROP TABLE #Atf18RunRate
USE CentralDbs
GO
SELECT * INTO #Atf18RunRate
FROM (SELECT  #Atf17RunRate.FyTagMnth, #Atf17RunRate.MaterialNbr, #Atf17RunRate.Billings, #Atf17RunRate.BillingsQty ,#Atf17RunRate.Qas,  (#Atf17RunRate.Qas/#Atf17RunRate.BillingsQty) as RunRateReq
FROM #Atf17RunRate) as subquery18
--------------------------------------------------------------------------------------------------------------------------------------------------------------


--2000_01 SALES TO INVENTORY 
DROP TABLE #Atf15SalesToInv
USE CentralDbs
GO
SELECT * INTO #Atf15SalesToInv
FROM (SELECT DISTINCT #Atf6BookBill6Mth.LogDt, #Atf6BookBill6Mth.BusDay99, #Atf6BookBill6Mth.WkNbr, #Atf6BookBill6Mth.FyMnthNbr, #Atf6BookBill6Mth.FyTagMnth, #Atf6BookBill6Mth.MaterialNbr, #Atf6BookBill6Mth.Pbg, #Atf6BookBill6Mth.Mfg, #Atf6BookBill6Mth.PrcStgy, #Atf6BookBill6Mth.Cc, #Atf6BookBill6Mth.Grp, #Atf6BookBill6Mth.Tech, #Atf6BookBill6Mth.MfgPartNbr, #Atf6BookBill6Mth.BillingsQty, #Atf6BookBill6Mth.Billings, #Atf6BookBill6Mth.Cogs, #Atf6BookBill6Mth.BookingsQty, #Atf6BookBill6Mth.Bookings, #Atf6BookBill6Mth.BookingsCost,#Atf6BookBill6Mth.Type, #Atf9InvAvgCost.Qas, #Atf9InvAvgCost.Qoh, #Atf9InvAvgCost.TtlStkValue, #Atf9InvAvgCost.AvgUnitCost
FROM #Atf6BookBill6Mth LEFT JOIN #Atf9InvAvgCost ON #Atf6BookBill6Mth.MaterialNbr=#Atf9InvAvgCost.MaterialNbr) AS subquery15
GO


--2000_02 ADD COST ATTRIBUTES 		
DROP TABLE #Atf16CostAtt
USE CentralDbs
GO
SELECT * INTO #Atf16CostAtt
FROM (SELECT #Atf15SalesToInv.LogDt, #Atf15SalesToInv.BusDay99, #Atf15SalesToInv.WkNbr, #Atf15SalesToInv.FyMnthNbr, #Atf15SalesToInv.FyTagMnth, #Atf15SalesToInv.MaterialNbr, #Atf15SalesToInv.Pbg, #Atf15SalesToInv.Mfg, #Atf15SalesToInv.PrcStgy, #Atf15SalesToInv.Cc, #Atf15SalesToInv.Grp, #Atf15SalesToInv.Tech, #Atf15SalesToInv.MfgPartNbr, #Atf15SalesToInv.BillingsQty, #Atf15SalesToInv.Billings, #Atf15SalesToInv.Cogs, #Atf15SalesToInv.BookingsQty, #Atf15SalesToInv.Bookings, #Atf15SalesToInv.BookingsCost,#Atf15SalesToInv.Type, #Atf15SalesToInv.Qas, #Atf15SalesToInv.Qoh, #Atf15SalesToInv.TtlStkValue, #Atf15SalesToInv.AvgUnitCost, #Atf10SapQty.SMPQ, #Atf10SapQty.SMOQ, #Atf10SapQty.LeadTime
FROM #Atf15SalesToInv LEFT JOIN #Atf10SapQty ON #Atf15SalesToInv.MaterialNbr=#Atf10SapQty.MaterialNbr) AS subquery16
GO


--2000_03 ADD MULTI COLUMN COSTS
DROP TABLE #Atf17MultiColumnCosts
USE CentralDbs
GO
SELECT * INTO #Atf17MultiColumnCosts
FROM (SELECT #Atf16CostAtt.LogDt,  #Atf16CostAtt.BusDay99,  #Atf16CostAtt.WkNbr,  #Atf16CostAtt.FyMnthNbr,  #Atf16CostAtt.FyTagMnth,  #Atf16CostAtt.MaterialNbr,  #Atf16CostAtt.Pbg,  #Atf16CostAtt.Mfg,  #Atf16CostAtt.PrcStgy,  #Atf16CostAtt.Cc,  #Atf16CostAtt.Grp,  #Atf16CostAtt.Tech,  #Atf16CostAtt.MfgPartNbr,  #Atf16CostAtt.BillingsQty,  #Atf16CostAtt.Billings,  #Atf16CostAtt.Cogs,  #Atf16CostAtt.BookingsQty,  #Atf16CostAtt.Bookings,  #Atf16CostAtt.BookingsCost, #Atf16CostAtt.Type,  #Atf16CostAtt.Qas,  #Atf16CostAtt.Qoh,  #Atf16CostAtt.TtlStkValue,  #Atf16CostAtt.AvgUnitCost,  #Atf16CostAtt.SMPQ,  #Atf16CostAtt.SMOQ,  #Atf16CostAtt.LeadTime, MIN(#Atf11MultiColCosts.MinMCCost) AS MinMCCOst, MIN(#Atf11MultiColCosts.MinMCQty) AS MinMCQty
FROM #Atf16CostAtt LEFT JOIN #Atf11MultiColCosts ON #Atf16CostAtt.MaterialNbr=#Atf11MultiColCosts.MaterialNbr
GROUP BY #Atf16CostAtt.LogDt,  #Atf16CostAtt.BusDay99,  #Atf16CostAtt.WkNbr,  #Atf16CostAtt.FyMnthNbr,  #Atf16CostAtt.FyTagMnth,  #Atf16CostAtt.MaterialNbr,  #Atf16CostAtt.Pbg,  #Atf16CostAtt.Mfg,  #Atf16CostAtt.PrcStgy,  #Atf16CostAtt.Cc,  #Atf16CostAtt.Grp,  #Atf16CostAtt.Tech,  #Atf16CostAtt.MfgPartNbr,  #Atf16CostAtt.BillingsQty,  #Atf16CostAtt.Billings,  #Atf16CostAtt.Cogs,  #Atf16CostAtt.BookingsQty,  #Atf16CostAtt.Bookings,  #Atf16CostAtt.BookingsCost, #Atf16CostAtt.Type,  #Atf16CostAtt.Qas,  #Atf16CostAtt.Qoh,  #Atf16CostAtt.TtlStkValue,  #Atf16CostAtt.AvgUnitCost,  #Atf16CostAtt.SMPQ,  #Atf16CostAtt.SMOQ,  #Atf16CostAtt.LeadTime) AS subquery17
GO


--2000_04 ADD FLAGS AND CODES 
DROP TABLE #Atf18FlagsCodes
USE CentralDbs
GO
SELECT * INTO #Atf18FlagsCodes
FROM (SELECT #Atf17MultiColumnCosts.LogDt,  #Atf17MultiColumnCosts.BusDay99,  #Atf17MultiColumnCosts.WkNbr,  #Atf17MultiColumnCosts.FyMnthNbr,  #Atf17MultiColumnCosts.FyTagMnth,  #Atf17MultiColumnCosts.MaterialNbr,  #Atf17MultiColumnCosts.Pbg,  #Atf17MultiColumnCosts.Mfg,  #Atf17MultiColumnCosts.PrcStgy,  #Atf17MultiColumnCosts.Cc,  #Atf17MultiColumnCosts.Grp,  #Atf17MultiColumnCosts.Tech,  #Atf17MultiColumnCosts.MfgPartNbr,  #Atf17MultiColumnCosts.BillingsQty,  #Atf17MultiColumnCosts.Billings,  #Atf17MultiColumnCosts.Cogs,  #Atf17MultiColumnCosts.BookingsQty,  #Atf17MultiColumnCosts.Bookings,  #Atf17MultiColumnCosts.BookingsCost, #Atf17MultiColumnCosts.Type,  #Atf17MultiColumnCosts.Qas,  #Atf17MultiColumnCosts.Qoh,  #Atf17MultiColumnCosts.TtlStkValue,  #Atf17MultiColumnCosts.AvgUnitCost,  #Atf17MultiColumnCosts.SMPQ,  #Atf17MultiColumnCosts.SMOQ,  #Atf17MultiColumnCosts.LeadTime,  #Atf17MultiColumnCosts.MinMCCost, #Atf17MultiColumnCosts.MinMCQty, #Atf12FlagsCodes.Abc, #Atf12FlagsCodes.StkProf, #Atf12FlagsCodes.Plant, #Atf12FlagsCodes.Ecomm
FROM #Atf17MultiColumnCosts LEFT JOIN #Atf12FlagsCodes ON #Atf17MultiColumnCosts.MaterialNbr=#Atf12FlagsCodes.MaterialNbr) AS subquery18
GO


--2000_05 ADD MAT ASSIGN 
DROP TABLE #Atf19MatAssign
USE CentralDbs
GO
SELECT * INTO #Atf19MatAssign
FROM (SELECT #Atf18FlagsCodes.LogDt,  #Atf18FlagsCodes.BusDay99,  #Atf18FlagsCodes.WkNbr,  #Atf18FlagsCodes.FyMnthNbr,  #Atf18FlagsCodes.FyTagMnth,  #Atf18FlagsCodes.MaterialNbr,  #Atf18FlagsCodes.Pbg,  #Atf18FlagsCodes.Mfg,  #Atf18FlagsCodes.PrcStgy,  #Atf18FlagsCodes.Cc,  #Atf18FlagsCodes.Grp,  #Atf18FlagsCodes.Tech,  #Atf18FlagsCodes.MfgPartNbr,  #Atf18FlagsCodes.BillingsQty,  #Atf18FlagsCodes.Billings,  #Atf18FlagsCodes.Cogs,  #Atf18FlagsCodes.BookingsQty,  #Atf18FlagsCodes.Bookings,  #Atf18FlagsCodes.BookingsCost, #Atf18FlagsCodes.Type,  #Atf18FlagsCodes.Qas,  #Atf18FlagsCodes.Qoh,  #Atf18FlagsCodes.TtlStkValue,  #Atf18FlagsCodes.AvgUnitCost,  #Atf18FlagsCodes.SMPQ,  #Atf18FlagsCodes.SMOQ,  #Atf18FlagsCodes.LeadTime,  #Atf18FlagsCodes.MinMCCost, #Atf18FlagsCodes.MinMCQty, #Atf18FlagsCodes.Abc, #Atf18FlagsCodes.StkProf, #Atf18FlagsCodes.Plant, #Atf18FlagsCodes.Ecomm, #Atf13MatAor.SrDir, #Atf13MatAor.Pld, #Atf13MatAor.MatlMgr, #Atf13MatAor.MatlSpclst
FROM #Atf18FlagsCodes LEFT JOIN #Atf13MatAor ON #Atf18FlagsCodes.MaterialNbr=#Atf13MatAor.MatNbr) AS subquery19
GO


--3000_01 TARGET QAS 
