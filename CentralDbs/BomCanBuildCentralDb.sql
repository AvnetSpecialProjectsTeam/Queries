--BOM CAN BUILD REPORT - OWNER KRISTA CROSS

--BRING IN DAILY INVENTORY 0000_01
--1 sec
GO
USE BI
GO
SELECT * INTO #Bom1DailyInventory 
FROM (SELECT dbo.DailyInv.MaterialNbr AS material_nbr, Sum(dbo.DailyInv.AvlStkQty) AS avl_stk_qty, Sum(dbo.DailyInv.TtlStkQty) AS ttl_stk_qty
FROM dbo.DailyInv
GROUP BY dbo.DailyInv.MaterialNbr) AS subquery1
GO



--BRING IN SAP PARTS LIST 0000_02
-- 1 sec
USE CentralDbs
GO
SELECT * INTO #Bom2PartsList 
FROM (SELECT SapPartsList.MaterialNbr, SapPartsList.pbg, SapPartsList.mfg, SapPartsList.MaterialType, SapPartsList.PrcStgy, SapPartsList.cc, SapPartsList.grp, SapPartsList.tech, SapPartsList.MfgPartNbr
FROM CentralDbs.dbo.SapPartsList
WHERE (SapPartsList.MAtHubState<>-1 And ((SapPartsList.pbg)='0IT' Or (SapPartsList.pbg)='0ST'))) AS subquery2
GO



--BRING IN LABOR COST 0000_03
--26 seconds
USE SAP
GO
SELECT * INTO #Bom3LaborCost 
FROM (SELECT DISTINCT Cast(dbo.STPO.BOM AS numeric) AS BOM, Cast(dbo.STPO.BOMComp AS Varchar(20)) AS BomComp, Cast(dbo.STPO.CompQty AS Decimal (35,6)) AS CompQty, dbo.STPO.UnitOfMeasure
FROM dbo.STPO
WHERE (((dbo.STPO.UnitOfMeasure)='LE'))) AS subquery3
Go


--BRING IN LEAD TIME 0000_04
--9 seconds
USE SAP 
GO
SELECT * INTO #Bom4LeadTime
FROM (SELECT dbo.MARC.Material, dbo.MARC.SupplierLeadTime, dbo.MARC.InHouseProdTime, Cast(dbo.MARC.Plant AS Varchar(20)) AS Plnt
FROM dbo.MARC
GROUP BY dbo.MARC.Material, dbo.MARC.SupplierLeadTime, dbo.MARC.InHouseProdTime, dbo.MARC.Plant
HAVING (((dbo.MARC.SupplierLeadTime)<>'777'))) AS subquery4
Go


--BRING IN MATERIAL PRICING GROUP REMOVE LEADING ZEROS 0000_05
--59 seconds
USE SAP 
GO
SELECT * INTO #Bom5MatPricGroup 
FROM (SELECT Cast(dbo.MVKE.Material AS Decimal(20)) AS MaterialNbr, dbo.MVKE.SalesOrg, dbo.MVKE.MatPricingGrp, dbo.MVKE.Plant
FROM dbo.MVKE
GROUP BY dbo.MVKE.Material, dbo.MVKE.SalesOrg, dbo.MVKE.MatPricingGrp, dbo.MVKE.Plant
HAVING dbo.MVKE.SalesOrg='U001') as subquery5
GO


--CONVERT MATERIAL PRICING GROUP TO VARCHAR 0000_06
--1 second
SELECT * INTO #Bom6MatPricGroup
FROM (SELECT Cast([MaterialNbr] AS varchar(20)) AS MaterialNbr, SalesOrg, MatPricingGrp, Plant
FROM #Bom5MatPricGroup) As subquery6
GO


--CREATE MULTICOLUMN COSTS 0000_07
--3 seconds
USE MDM
GO
SELECT * INTO #Bom7MultiColCosts
FROM (SELECT mdm.dbo.MultiColumnCost.MaterialNbr,
CASE 
    WHEN [Col10qty]>0 THEN [Col10qty]
 WHEN [Col10qty]=0 AND [Col9qty]>0 THEN [Col10qty]
 WHEN [col9qty]=0 AND [Col8qty]>0 THEN [Col8qty]
 WHEN [Col8qty]=0 AND [Col7qty]>0 THEN [Col7qty]
 WHEN [Col7qty]=0 AND [Col6qty]>0 THEN [Col6qty]
 WHEN [Col6qty]=0 AND [col5qty]>0 THEN [col5qty]
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
FROM mdm.dbo.MultiColumnCost) AS subquery7
GO


-- BRING IN COST RESALE 0000_08
--1 second
SELECT * INTO #Bom8Costs 
FROM(SELECT centraldbs.dbo.CostResale.MaterialNbr, centraldbs.dbo.CostResale.UnitBookCost, centraldbs.dbo.CostResale.MinCost
FROM centraldbs.dbo.CostResale
GROUP BY centraldbs.dbo.CostResale.MaterialNbr, centraldbs.dbo.CostResale.UnitBookCost, centraldbs.dbo.CostResale.MinCost
HAVING centraldbs.dbo.CostResale.UnitBookCost IS NOT NULL) AS subquery8
GO


--BRING IN FLAGS AND CODES 0000_09
--4 seconds
SELECT * INTO #Bom9FlagsCodes 
FROM (SELECT DISTINCT centraldbs.dbo.sapFlagscodes.MaterialNbr AS MaterialNbr, centraldbs.dbo.sapFlagscodes.AbcCd AS Abc, centraldbs.dbo.sapFlagscodes.SapStockingProfile AS StkProf, centraldbs.dbo.sapFlagscodes.SapPlantCd AS Plant
FROM centraldbs.dbo.sapFlagscodes) AS subquery9
GO


--CONNECT MAST TO STPO _ BEGIN BUILD 2000_00
--18 seconds
USE SAP
GO
SELECT * INTO #Bom10MastStpo
FROM (SELECT CAST(dbo.MAST.Material AS Varchar (15)) AS MatNbrTla, CAST(dbo.MAST.BOM AS numeric (50)) AS Bom, CAST(dbo.STPO.BOMComp AS Varchar (225)) AS CompMatNbr, CAST(dbo.STPO.CompQty AS decimal(38,6)) AS CompQty, dbo.MAST.Plant AS Plant
FROM dbo.MAST LEFT JOIN dbo.STPO ON dbo.MAST.BOM = dbo.STPO.BOM
GROUP BY dbo.MAST.Material, dbo.MAST.BOM, dbo.STPO.BOMComp, dbo.STPO.CompQty, dbo.MAST.Plant
HAVING ((dbo.STPO.BOMComp)<>0)) AS subquery10
GO


--ADD QAS AND QOH TO BOMS 2000_01
--5 secpmds
SELECT * INTO #Bom11QasQoh
FROM (SELECT #Bom10MastStpo.MatNbrTla,#Bom10MastStpo.Bom,#Bom10MastStpo.CompMatNbr,#Bom10MastStpo.CompQty, Sum(#Bom1DailyInventory.avl_stk_qty) AS Qas, Sum(#Bom1DailyInventory.ttl_stk_qty) AS Qoh,#Bom10MastStpo.Plant
FROM #Bom10MastStpo LEFT JOIN #Bom1DailyInventory ON #Bom10MastStpo.CompMatNbr = #Bom1DailyInventory.material_nbr
GROUP BY #Bom10MastStpo.MatNbrTla,#Bom10MastStpo.Bom,#Bom10MastStpo.CompMatNbr,#Bom10MastStpo.CompQty,#Bom10MastStpo.Plant) AS subquery11
GO


--ADD PRODUCT HEIRARCHY 2000_02
--3 seconds
SELECT * INTO #Bom12ProdHrchy
FROM (SELECT #Bom11QasQoh.MatNbrTla, #Bom11QasQoh.Bom, #Bom2PartsList.PrcStgy AS CompPrcStgy, #Bom11QasQoh.CompMatNbr,  #Bom2PartsList.MfgPartNbr AS CompMfgPartNbr, #Bom11QasQoh.CompQty, #Bom11QasQoh.Qas, #Bom11QasQoh.Qoh,  #Bom2PartsList.grp AS Grp,  #Bom2PartsList.MaterialType AS MatTyp, #Bom11QasQoh.Plant
FROM #Bom11QasQoh LEFT JOIN #Bom2PartsList ON #Bom11QasQoh.CompMatNbr=#Bom2PartsList.MaterialNbr) AS subquery12
GO


--MOVING AVERAGE PRICE 2000_03
--10 seconds
SELECT * INTO #Bom13Map
FROM (SELECT #Bom12ProdHrchy.MatNbrTla, #Bom12ProdHrchy.Bom, #Bom12ProdHrchy.CompPrcStgy, #Bom12ProdHrchy.CompMfgPartNbr, #Bom12ProdHrchy.CompMatNbr, #Bom12ProdHrchy.CompQty, #Bom12ProdHrchy.Qas, #Bom12ProdHrchy.Qoh, #Bom12ProdHrchy.Grp, #Bom12ProdHrchy.Plant, #Bom12ProdHrchy.MatTyp, Min(Round(CentralDbs.dbo.Map.MapPerUnit,6)) AS Map
FROM #Bom12ProdHrchy LEFT JOIN CentralDbs.dbo.Map ON #Bom12ProdHrchy.CompMatNbr = CentralDbs.dbo.Map.Material
GROUP BY #Bom12ProdHrchy.MatNbrTla, #Bom12ProdHrchy.Bom, #Bom12ProdHrchy.CompPrcStgy, #Bom12ProdHrchy.CompMfgPartNbr, #Bom12ProdHrchy.CompMatNbr, #Bom12ProdHrchy.CompQty, #Bom12ProdHrchy.Qas, #Bom12ProdHrchy.Qoh, #Bom12ProdHrchy.Grp, #Bom12ProdHrchy.Plant, #Bom12ProdHrchy.MatTyp) as subquery13
GO


--BOOK COST 2000_04  
--8 seconds   
SELECT * INTO #Bom14BookCost 
FROM (SELECT #Bom13Map.MatNbrTla, #Bom13Map.Bom, #Bom13Map.CompPrcStgy, #Bom13Map.CompMfgPartNbr, #Bom13Map.CompMatNbr, #Bom13Map.CompQty, #Bom13Map.Qas, #Bom13Map.Qoh, #Bom13Map.Grp, #Bom13Map.Plant, #Bom13Map.MatTyp, #Bom13Map.Map, MIN(#Bom8Costs.UnitBookCost) AS BookCost, 
MIN(CASE WHEN #Bom13Map.map<#Bom8Costs.UnitBookCost THEN #Bom13Map.map
   WHEN #Bom8Costs.UnitBookCost=0 THEN #Bom8Costs.UnitBookCost
   ELSE #Bom13Map.map END) AS MinCost
FROM #Bom13Map LEFT JOIN #Bom8Costs ON #Bom13Map.CompMatNbr = #Bom8Costs.MaterialNbr
GROUP BY #Bom13Map.MatNbrTla, #Bom13Map.Bom, #Bom13Map.CompPrcStgy, #Bom13Map.CompMfgPartNbr, #Bom13Map.CompMatNbr, #Bom13Map.CompQty, #Bom13Map.Qas, #Bom13Map.Qoh, #Bom13Map.Grp, #Bom13Map.Plant, #Bom13Map.MatTyp, #Bom13Map.Map) as subquery14
GO


--ADD LABOR COST 2000_05
--3 seconds
SELECT * INTO #Bom15AddLabor 
FROM (SELECT #Bom14BookCost.MatNbrTla, #Bom14BookCost.Bom, #Bom14BookCost.CompPrcStgy, #Bom14BookCost.CompMfgPartNbr, #Bom14BookCost.CompMatNbr, #Bom14BookCost.CompQty, #Bom14BookCost.Qas, #Bom14BookCost.Qoh, #Bom14BookCost.Grp, #Bom14BookCost.Plant, #Bom14BookCost.MatTyp, #Bom14BookCost.Map, #Bom14BookCost.BookCost, #Bom14BookCost.CompQty*#Bom14BookCost.MinCost AS ExtCompCost,
CASE 
WHEN(#Bom3LaborCost.CompQty Is Null) THEN 0 ELSE #Bom3LaborCost.CompQty END AS LaborCost
FROM #Bom14BookCost LEFT JOIN #Bom3LaborCost ON (#Bom14BookCost.Bom = #Bom3LaborCost.BOM) AND (#Bom14BookCost.CompMatNbr = #Bom3LaborCost.BomComp)) AS subquery15
GO


--ADD FLAGS AND CODES 2000_06
--25 seconds
SELECT * INTO #Bom16AddFlags 
FROM (SELECT #Bom15AddLabor.MatNbrTla, #Bom15AddLabor.Bom, #Bom15AddLabor.CompPrcStgy, #Bom15AddLabor.CompMfgPartNbr, #Bom15AddLabor.CompMatNbr, #Bom15AddLabor.CompQty, #Bom15AddLabor.Qas, #Bom9FlagsCodes.Abc, #Bom9FlagsCodes.StkProf, #Bom15AddLabor.Qoh, #Bom15AddLabor.Grp, #Bom15AddLabor.Plant, #Bom15AddLabor.MatTyp, #Bom15AddLabor.Map, #Bom15AddLabor.BookCost, #Bom15AddLabor.ExtCompCost, #Bom15AddLabor.LaborCost
FROM #Bom15AddLabor LEFT JOIN #Bom9FlagsCodes ON #Bom15AddLabor.CompMatNbr = #Bom9FlagsCodes.MaterialNbr) as subquery16
GO


--ADD MAT PRIC GROUP 2000_07
--39 seconds
USE SAP 
GO 
SELECT * INTO #Bom17AddMatPricGrp 
FROM (SELECT #Bom16AddFlags.MatNbrTla, #Bom16AddFlags.Bom, #Bom16AddFlags.CompMfgPartNbr, #Bom16AddFlags.CompMatNbr, #Bom16AddFlags.CompPrcStgy, #Bom16AddFlags.CompQty, #Bom16AddFlags.Qas, #Bom16AddFlags.Qoh, #Bom6MatPricGroup.MatPricingGrp AS MatPricGrp, #Bom16AddFlags.Grp, #Bom16AddFlags.MatTyp, #Bom16AddFlags.Abc, #Bom16AddFlags.StkProf, #Bom16AddFlags.Map, #Bom16AddFlags.BookCost, #Bom16AddFlags.ExtCompCost, #Bom16AddFlags.LaborCost, #Bom16AddFlags.Plant
FROM #Bom16AddFlags LEFT JOIN #Bom6MatPricGroup ON #Bom16AddFlags.CompMatNbr = #Bom6MatPricGroup.MaterialNbr) as subquery17
GO


--ADD MULTI CLOUMN COSTS 2000_08
-- 51 seconds
SELECT * INTO #Bom18AddMCC 
FROM (SELECT #Bom17AddMatPricGrp.MatNbrTla, #Bom17AddMatPricGrp.Bom, #Bom17AddMatPricGrp.CompMfgPartNbr, #Bom17AddMatPricGrp.CompMatNbr, #Bom17AddMatPricGrp.CompPrcStgy, #Bom17AddMatPricGrp.CompQty, #Bom17AddMatPricGrp.Qas, #Bom17AddMatPricGrp.Qoh, #Bom17AddMatPricGrp.MatPricGrp, #Bom17AddMatPricGrp.Grp, #Bom17AddMatPricGrp.MatTyp, #Bom17AddMatPricGrp.Abc, #Bom17AddMatPricGrp.StkProf, #Bom17AddMatPricGrp.Map, #Bom17AddMatPricGrp.BookCost, #Bom17AddMatPricGrp.ExtCompCost, #Bom17AddMatPricGrp.LaborCost, #Bom7MultiColCosts.MinMCQty AS BestReplCostQty, #Bom7MultiColCosts.MinMCCost AS BestReplCost$, #Bom17AddMatPricGrp.Plant
FROM #Bom17AddMatPricGrp LEFT JOIN #Bom7MultiColCosts ON #Bom17AddMatPricGrp.CompMatNbr = #Bom7MultiColCosts.MaterialNbr) as subquery18
GO
 

--REPLACE NULLS 2000_09
-- 43 seconds 
SELECT * INTO #Bom19ReplaceNulls 
FROM (SELECT #Bom18AddMCC.MatNbrTla, #Bom18AddMCC.Bom, #Bom18AddMCC.CompMatNbr, #Bom18AddMCC.CompPrcStgy, #Bom18AddMCC.MatPricGrp, #Bom18AddMCC.Grp, #Bom18AddMCC.Plant, #Bom18AddMCC.CompMfgPartNbr, #Bom18AddMCC.MatTyp, #Bom18AddMCC.Abc, #Bom18AddMCC.StkProf, 
CASE WHEN (#Bom18AddMCC.CompQty Is Null) THEN 0 ELSE #Bom18AddMCC.CompQty END AS Qty, 
CASE WHEN (#Bom18AddMCC.Qas Is Null) THEN 0 ELSE #Bom18AddMCC.Qas END AS Qas, 
CASE WHEN (#Bom18AddMCC.Qoh Is Null) THEN 0 ELSE #Bom18AddMCC.Qoh END AS Qoh, 
CASE WHEN (#Bom18AddMCC.Map Is Null) THEN 0 ELSE #Bom18AddMCC.Map END AS Map, 
CASE WHEN (#Bom18AddMCC.BookCost Is Null) THEN 0 ELSE #Bom18AddMCC.BookCost END AS BookCost, 
CASE WHEN (#Bom18AddMCC.LaborCost Is Null) THEN 0 ELSE #Bom18AddMCC.LaborCost END AS LaborCost, 
CASE WHEN (#Bom18AddMCC.BestReplCostQty Is Null) THEN 0 ELSE #Bom18AddMCC.BestReplCostQty END AS BestReplCostQty, 
CASE WHEN (#Bom18AddMCC.BestReplCost$ Is Null) THEN 0 ELSE #Bom18AddMCC.BestReplCost$ END AS BestReplCost$,
CASE WHEN (#Bom18AddMCC.ExtCompCost Is Null) THEN 0 ELSE #Bom18AddMCC.ExtCompCost END AS ExtCompCost
FROM #Bom18AddMCC) as subquery19
GO


--ADD LEAD TIME 2000_10
--2 mins 21 seconds
SELECT * INTO #Bom20LeadTime 
FROM (SELECT Distinct #Bom19ReplaceNulls.MatNbrTla, #Bom19ReplaceNulls.Bom, #Bom19ReplaceNulls.CompMatNbr, #Bom19ReplaceNulls.CompPrcStgy, #Bom19ReplaceNulls.MatPricGrp, #Bom19ReplaceNulls.Grp, #Bom19ReplaceNulls.CompMfgPartNbr, #Bom19ReplaceNulls.MatTyp, #Bom19ReplaceNulls.Plant, #Bom19ReplaceNulls.Abc, #Bom19ReplaceNulls.StkProf, #Bom19ReplaceNulls.Qty, #Bom19ReplaceNulls.Qas, #Bom19ReplaceNulls.Qoh, #Bom19ReplaceNulls.Map, #Bom19ReplaceNulls.BookCost, #Bom19ReplaceNulls.LaborCost, #Bom19ReplaceNulls.BestReplCostQty, #Bom19ReplaceNulls.BestReplCost$, #Bom19ReplaceNulls.ExtCompCost, MAX(#Bom4LeadTime.SupplierLeadTime) AS LeadTime
FROM #Bom19ReplaceNulls LEFT JOIN #Bom4LeadTime ON (#Bom19ReplaceNulls.Plant = #Bom4LeadTime.Plnt) AND (#Bom19ReplaceNulls.CompMatNbr = #Bom4LeadTime.Material)
GROUP BY #Bom19ReplaceNulls.MatNbrTla, #Bom19ReplaceNulls.Bom, #Bom19ReplaceNulls.CompMatNbr, #Bom19ReplaceNulls.CompPrcStgy, #Bom19ReplaceNulls.MatPricGrp, #Bom19ReplaceNulls.Grp, #Bom19ReplaceNulls.CompMfgPartNbr, #Bom19ReplaceNulls.MatTyp, #Bom19ReplaceNulls.Plant, #Bom19ReplaceNulls.Abc, #Bom19ReplaceNulls.StkProf, #Bom19ReplaceNulls.Qty, #Bom19ReplaceNulls.Qas, #Bom19ReplaceNulls.Qoh, #Bom19ReplaceNulls.Map, #Bom19ReplaceNulls.BookCost, #Bom19ReplaceNulls.LaborCost, #Bom19ReplaceNulls.BestReplCostQty, #Bom19ReplaceNulls.BestReplCost$, #Bom19ReplaceNulls.ExtCompCost) as subquery20
GO



--ADD TLA DATA 2000_11
--4 seconds
SELECT * INTO #Bom21AddTlaData 
FROM (SELECT #Bom2PartsList.mfg AS MfgTla, #Bom2PartsList.PrcStgy AS PrcStgyTla, #Bom2PartsList.MfgPartNbr AS MfgPartNbrTla, #Bom20LeadTime.MatNbrTla, #Bom20LeadTime.Bom, #Bom20LeadTime.CompMatNbr, #Bom20LeadTime.CompPrcStgy, #Bom20LeadTime.MatPricGrp, #Bom20LeadTime.Grp, #Bom20LeadTime.CompMfgPartNbr, #Bom20LeadTime.MatTyp, #Bom20LeadTime.Plant, #Bom20LeadTime.Abc, #Bom20LeadTime.StkProf, #Bom20LeadTime.Qty, #Bom20LeadTime.Qas, #Bom20LeadTime.Qoh, #Bom20LeadTime.Map, #Bom20LeadTime.BookCost, #Bom20LeadTime.LaborCost, #Bom20LeadTime.BestReplCostQty, #Bom20LeadTime.BestReplCost$, #Bom20LeadTime.ExtCompCost, #Bom20LeadTime.LeadTime FROM #Bom20LeadTime LEFT JOIN #Bom2PartsList ON #Bom20LeadTime.MatNbrTla = #Bom2PartsList.MaterialNbr) AS subquery21
GO


--MAKE COMPONENTS TABLE 2000_12
--3 seconds
TRUNCATE TABLE centraldbs.dbo.BomComponents 
GO
INSERT INTO  centraldbs.dbo.BomComponents
SELECT DISTINCT #Bom21AddTlaData.PrcStgyTla, #Bom21AddTlaData.MfgPartNbrTla, #Bom21AddTlaData.MatNbrTla, #Bom21AddTlaData.Bom, #Bom21AddTlaData.CompMatNbr, #Bom21AddTlaData.CompMfgPartNbr, #Bom21AddTlaData.CompPrcStgy, #Bom21AddTlaData.MatPricGrp, #Bom21AddTlaData.Grp, #Bom21AddTlaData.MatTyp, #Bom21AddTlaData.Abc, #Bom21AddTlaData.StkProf AS StkProfile, #Bom21AddTlaData.LeadTime, #Bom21AddTlaData.Qty, #Bom21AddTlaData.Qas, #Bom21AddTlaData.Qoh, #Bom21AddTlaData.Map, #Bom21AddTlaData.BookCost, #Bom21AddTlaData.LaborCost, #Bom21AddTlaData.BestReplCostQty, #Bom21AddTlaData.ExtCompCost, #Bom21AddTlaData.BestReplCost$
FROM #Bom21AddTlaData;
GO



--CAN BUILD QTY 4000_01
--4 seconds
SELECT * INTO #Bom22CanBuildQty 
FROM (SELECT centraldbs.dbo.BomComponents.CompPrcStgy, centraldbs.dbo.BomComponents.CompMfgPartNbr, BomComponents.MatNbrTla, centraldbs.dbo.BomComponents.Bom, #Bom6MatPricGroup.MatPricingGrp AS MatPricGrp, centraldbs.dbo.BomComponents.Map, centraldbs.dbo.BomComponents.BookCost, centraldbs.dbo.BomComponents.BestReplCost$, centraldbs.dbo.BomComponents.LaborCost, centraldbs.dbo.BomComponents.ExtCompCost, centraldbs.dbo.BomComponents.LeadTime,
CASE WHEN (centraldbs.dbo.BomComponents.LaborCost>0) THEN 0 ELSE centraldbs.dbo.BomComponents.Qty END AS Qty,
CASE WHEN (centraldbs.dbo.BomComponents.LaborCost>0) THEN Null ELSE ([Qas]/[Qty]) END AS CanBuild
FROM centraldbs.dbo.BomComponents LEFT JOIN #Bom6MatPricGroup ON centraldbs.dbo.BomComponents.MatNbrTla = #Bom6MatPricGroup.MaterialNbr) as subquery22
GO


--QTY * COSTS 4000_02
--7 seconds
SELECT * INTO #Bom23CalcCosts
FROM (SELECT #Bom22CanBuildQty.MatNbrTla, #Bom22CanBuildQty.Bom, #Bom22CanBuildQty.Qty, #Bom22CanBuildQty.MatPricGrp, (#Bom22CanBuildQty.Qty*#Bom22CanBuildQty.Map) AS Map, (#Bom22CanBuildQty.Qty*#Bom22CanBuildQty.BookCost) AS BookCost, #Bom22CanBuildQty.BestReplCost$, 
CASE WHEN (#Bom22CanBuildQty.Map=0 OR #Bom22CanBuildQty.BookCost=0 OR #Bom22CanBuildQty.BestReplCost$=0) THEN 0 ELSE #Bom22CanBuildQty.ExtCompCost END AS ExtCompCost, 
CASE WHEN ((#Bom22CanBuildQty.Map=0 OR #Bom22CanBuildQty.BookCost=0 OR #Bom22CanBuildQty.BestReplCost$=0) AND #Bom22CanBuildQty.LaborCost=0) THEN '1' ELSE 0 END AS MissingCost, 
#Bom22CanBuildQty.LaborCost, #Bom22CanBuildQty.CanBuild, #Bom22CanBuildQty.LeadTime
FROM #Bom22CanBuildQty) AS subquery23
GO


--SET LABOR COST TO 999999 4000_03
SELECT * INTO #Bom24SetLabor
FROM (SELECT #Bom23CalcCosts.MatNbrTla, #Bom23CalcCosts.Bom, #Bom23CalcCosts.Qty, #Bom23CalcCosts.MatPricGrp, #Bom23CalcCosts.Map, #Bom23CalcCosts.BookCost,#Bom23CalcCosts.BestReplCost$, #Bom23CalcCosts.ExtCompCost, #Bom23CalcCosts.LaborCost, #Bom23CalcCosts.LeadTime, #Bom23CalcCosts.MissingCost, CASE WHEN #Bom23CalcCosts.LaborCost>0 THEN 9999999 ELSE #Bom23CalcCosts.CanBuild END AS CanBuild
FROM #Bom23CalcCosts
GROUP BY #Bom23CalcCosts.MatNbrTla, #Bom23CalcCosts.Bom, #Bom23CalcCosts.Qty, #Bom23CalcCosts.MatPricGrp, #Bom23CalcCosts.Map, #Bom23CalcCosts.BookCost,#Bom23CalcCosts.BestReplCost$, #Bom23CalcCosts.ExtCompCost, #Bom23CalcCosts.LaborCost, #Bom23CalcCosts.LeadTime, #Bom23CalcCosts.MissingCost, #Bom23CalcCosts.CanBuild) AS subquery24
GO

--RANK CAN BUILD 4000_04
SELECT * INTO #Bom25RankCanBuild
FROM (SELECT #Bom24SetLabor.MatNbrTla, #Bom24SetLabor.Bom, #Bom24SetLabor.Qty, #Bom24SetLabor.MatPricGrp, #Bom24SetLabor.Map, #Bom24SetLabor.BookCost, #Bom24SetLabor.BestReplCost$, #Bom24SetLabor.ExtCompCost, #Bom24SetLabor.LaborCost, #Bom24SetLabor.LeadTime,#Bom24SetLabor.MissingCost, #Bom24SetLabor.CanBuild, Dense_Rank() Over (Partition By #Bom24SetLabor.MatNbrTla, #Bom24SetLabor.Bom Order by #Bom24SetLabor.CanBuild ASC) AS RANK
FROM #Bom24SetLabor) AS subquery25
GO

--REMOVE LEADTIME 4000_05
SELECT * INTO #Bom26MaxLeadTime
FROM (SELECT #Bom25RankCanBuild.MatNbrTla, #Bom25RankCanBuild.Bom, MAX(#Bom25RankCanBuild.LeadTime) AS LeadTime
FROM #Bom25RankCanBuild
GROUP BY #Bom25RankCanBuild.MatNbrTla, #Bom25RankCanBuild.Bom) AS subquery26
GO

--REMOVE CAN BUILD 4000_06
SELECT * INTO #Bom27MinCanBuild
FROM (SELECT DISTINCT #Bom25RankCanBuild.MatNbrTla, #Bom25RankCanBuild.Bom,#Bom25RankCanBuild.CanBuild
FROM #Bom25RankCanBuild
WHERE Rank=1) AS subquery27
GO

--GROUP BY WITHOUT LEAD TIME OR CAN BUILD 4000_07
SELECT * INTO #Bom28NoLTNoCB
FROM (SELECT #Bom25RankCanBuild.MatNbrTla, #Bom25RankCanBuild.Bom, SUM(#Bom25RankCanBuild.Qty) AS Qty, #Bom25RankCanBuild.MatPricGrp, SUM(#Bom25RankCanBuild.Map) AS Map, SUM(#Bom25RankCanBuild.BookCost) AS BookCost, SUM(#Bom25RankCanBuild.BestReplCost$) AS BestReplCost$, SUM(#Bom25RankCanBuild.ExtCompCost) AS ExtCompCost, SUM(#Bom25RankCanBuild.LaborCost) AS LaborCost, SUM(#Bom25RankCanBuild.MissingCost) AS MissingCost
FROM #Bom25RankCanBuild
GROUP BY #Bom25RankCanBuild.MatNbrTla, #Bom25RankCanBuild.Bom, #Bom25RankCanBuild.MatPricGrp) AS subquery28
GO

--ADD BACK LT 4000_08
SELECT * INTO #Bom29LT
FROM (SELECT #Bom28NoLTNoCB.MatNbrTla, #Bom28NoLTNoCB.Bom, #Bom28NoLTNoCB.Qty, #Bom28NoLTNoCB.MatPricGrp, #Bom28NoLTNoCB.Map, #Bom28NoLTNoCB.BookCost, #Bom28NoLTNoCB.BestReplCost$, #Bom28NoLTNoCB.ExtCompCost, #Bom28NoLTNoCB.LaborCost, #Bom26MaxLeadTime.LeadTime, #Bom28NoLTNoCB.MissingCost
FROM #Bom28NoLTNoCB INNER JOIN #Bom26MaxLeadTime ON #Bom28NoLTNoCB.MatNbrTla=#Bom26MaxLeadTime.MatNbrTla AND #Bom28NoLTNoCB.Bom=#Bom26MaxLeadTime.Bom) AS subquery29
GO

--ADD BACK CB 4000_09
SELECT * INTO #Bom30CB
FROM (SELECT #Bom29LT.MatNbrTla, #Bom29LT.Bom, #Bom29LT.Qty, #Bom29LT.MatPricGrp, #Bom29LT.Map, #Bom29LT.BookCost, #Bom29LT.BestReplCost$, #Bom29LT.ExtCompCost, #Bom29LT.LaborCost, #Bom29LT.LeadTime, #Bom29LT.MissingCost, #Bom27MinCanBuild.CanBuild
FROM #Bom29LT INNER JOIN #Bom27MinCanBuild ON #Bom29LT.MatNbrTla=#Bom27MinCanBuild.MatNbrTla AND #Bom29LT.Bom=#Bom27MinCanBuild.Bom) AS subquery30
GO

--ADD MISSING COST FLAG 4000_10
SELECT * INTO #Bom31MissingCostFlg
FROM (SELECT #Bom30CB.MatNbrTla, #Bom30CB.Bom, #Bom30CB.Qty, #Bom30CB.MatPricGrp, #Bom30CB.Map, #Bom30CB.BookCost, #Bom30CB.BestReplCost$, #Bom30CB.ExtCompCost, #Bom30CB.LaborCost, #Bom30CB.LeadTime, CASE WHEN #Bom30CB.MissingCost>0 THEN 'X' ELSE NULL END AS MissingCost, #Bom30CB.CanBuild
FROM #Bom30CB) AS subquery31
GO

--ADD TLA DATA TO CAN BUILD 4000_11
SELECT * INTO #Bom32CBTlaProdHrchy 
FROM (SELECT #Bom2PartsList.PrcStgy, #Bom2PartsList.MfgPartNbr, #Bom2PartsList.grp, #Bom31MissingCostFlg.MatNbrTla, #Bom31MissingCostFlg.Bom, #Bom31MissingCostFlg.Qty, #Bom31MissingCostFlg.MatPricGrp, #Bom31MissingCostFlg.Map, #Bom31MissingCostFlg.BookCost, #Bom31MissingCostFlg.BestReplCost$, #Bom31MissingCostFlg.LaborCost, #Bom31MissingCostFlg.MissingCost, #Bom31MissingCostFlg.CanBuild, #Bom31MissingCostFlg.LeadTime, #Bom31MissingCostFlg.ExtCompCost
FROM #Bom31MissingCostFlg LEFT JOIN #Bom2PartsList ON #Bom31MissingCostFlg.MatNbrTla = #Bom2PartsList.MaterialNbr
GROUP BY #Bom2PartsList.PrcStgy, #Bom2PartsList.MfgPartNbr, #Bom2PartsList.grp, #Bom31MissingCostFlg.MatNbrTla, #Bom31MissingCostFlg.Bom, #Bom31MissingCostFlg.Qty, #Bom31MissingCostFlg.MatPricGrp, #Bom31MissingCostFlg.Map, #Bom31MissingCostFlg.BookCost, #Bom31MissingCostFlg.BestReplCost$, #Bom31MissingCostFlg.LaborCost, #Bom31MissingCostFlg.MissingCost, #Bom31MissingCostFlg.CanBuild, #Bom31MissingCostFlg.ExtCompCost, #Bom31MissingCostFlg.LeadTime) as subquery32
GO


--ADD CAN BUILD FLAGS AND CODES 4000_12
SELECT * INTO #Bom33CBFlagsCodes 
FROM (SELECT  #Bom32CBTlaProdHrchy.PrcStgy, #Bom32CBTlaProdHrchy.MfgPartNbr, #Bom32CBTlaProdHrchy.MatNbrTla, #Bom32CBTlaProdHrchy.Bom, #Bom32CBTlaProdHrchy.Qty, #Bom9FlagsCodes.StkProf AS StkProfile, #Bom9FlagsCodes.abc AS abc, #Bom32CBTlaProdHrchy.MatPricGrp, #Bom32CBTlaProdHrchy.LeadTime, #Bom32CBTlaProdHrchy.BookCost, #Bom32CBTlaProdHrchy.Map, #Bom32CBTlaProdHrchy.BestReplCost$, #Bom32CBTlaProdHrchy.LaborCost,  #Bom32CBTlaProdHrchy.ExtCompCost, #Bom32CBTlaProdHrchy.MissingCost, #Bom32CBTlaProdHrchy.CanBuild, #Bom32CBTlaProdHrchy.grp
FROM #Bom32CBTlaProdHrchy  LEFT JOIN #Bom9FlagsCodes ON #Bom32CBTlaProdHrchy.MatNbrTla = #Bom9FlagsCodes.MaterialNbr
GROUP BY #Bom32CBTlaProdHrchy.PrcStgy, #Bom32CBTlaProdHrchy.MfgPartNbr, #Bom32CBTlaProdHrchy.MatNbrTla, #Bom32CBTlaProdHrchy.Bom, #Bom32CBTlaProdHrchy.Qty, #Bom9FlagsCodes.StkProf, #Bom9FlagsCodes.abc, #Bom32CBTlaProdHrchy.MatPricGrp, #Bom32CBTlaProdHrchy.LeadTime, #Bom32CBTlaProdHrchy.BookCost, #Bom32CBTlaProdHrchy.Map, #Bom32CBTlaProdHrchy.BestReplCost$, #Bom32CBTlaProdHrchy.ExtCompCost, #Bom32CBTlaProdHrchy.LaborCost, #Bom32CBTlaProdHrchy.MissingCost, #Bom32CBTlaProdHrchy.CanBuild, #Bom32CBTlaProdHrchy.grp) AS subquery33
GO


--ADD CAN BUILD QAS 4000_13
SELECT * INTO #Bom34CBQas 
FROM (SELECT #Bom33CBFlagsCodes.PrcStgy, #Bom33CBFlagsCodes.MfgPartNbr, #Bom33CBFlagsCodes.MatNbrTla, #Bom33CBFlagsCodes.Bom, #Bom33CBFlagsCodes.Qty, #Bom33CBFlagsCodes.StkProfile, #Bom33CBFlagsCodes.abc, #Bom33CBFlagsCodes.MatPricGrp, #Bom33CBFlagsCodes.LeadTime, #Bom33CBFlagsCodes.BookCost, #Bom33CBFlagsCodes.Map, #Bom33CBFlagsCodes.BestReplCost$, #Bom33CBFlagsCodes.LaborCost, #Bom33CBFlagsCodes.MissingCost, #Bom33CBFlagsCodes.CanBuild, #Bom33CBFlagsCodes.grp, #Bom33CBFlagsCodes.ExtCompCost, 
CASE WHEN (#Bom1DailyInventory.avl_stk_qty Is Null) THEN 0 ELSE #Bom1DailyInventory.avl_stk_qty END AS Qas
FROM #Bom33CBFlagsCodes LEFT JOIN #Bom1DailyInventory ON #Bom33CBFlagsCodes.MatNbrTla = #Bom1DailyInventory.material_nbr
WHERE (#Bom33CBFlagsCodes.MatNbrTla Is Not Null)
GROUP BY #Bom33CBFlagsCodes.PrcStgy, #Bom33CBFlagsCodes.MfgPartNbr, #Bom33CBFlagsCodes.MatNbrTla, #Bom33CBFlagsCodes.Bom, #Bom33CBFlagsCodes.Qty, #Bom33CBFlagsCodes.StkProfile, #Bom33CBFlagsCodes.abc, #Bom1DailyInventory.avl_stk_qty, #Bom33CBFlagsCodes.MatPricGrp, #Bom33CBFlagsCodes.LeadTime, #Bom33CBFlagsCodes.BookCost, #Bom33CBFlagsCodes.Map, #Bom33CBFlagsCodes.BestReplCost$, #Bom33CBFlagsCodes.LaborCost, #Bom33CBFlagsCodes.MissingCost, #Bom33CBFlagsCodes.CanBuild, #Bom33CBFlagsCodes.grp, #Bom33CBFlagsCodes.ExtCompCost) AS subquery34
GO


--MAKE BOM CAN BUILD TABLE 4000_14
TRUNCATE TABLE centraldbs.dbo.BomCanBuild
GO
INSERT INTO  centraldbs.dbo.BomCanBuild(
       [PrcStgy],[MfgPartNbr],[MatNbrTla],[Bom],[Qty],[StkProfile],[abc],[grp],[MatPricGrp],[LeadTime],[BookCost],[Map],[BestReplCost$],[LaborCost],[ExtCompCost],[MissingCost],[CanBuild])   
SELECT #Bom34CBQas.PrcStgy, #Bom34CBQas.MfgPartNbr, #Bom34CBQas.MatNbrTla, #Bom34CBQas.Bom, #Bom34CBQas.Qty, #Bom34CBQas.StkProfile, #Bom34CBQas.abc, #Bom34CBQas.grp, #Bom34CBQas.MatPricGrp, #Bom34CBQas.LeadTime, #Bom34CBQas.BookCost, #Bom34CBQas.Map, #Bom34CBQas.BestReplCost$, #Bom34CBQas.LaborCost, #Bom34CBQas.ExtCompCost, #Bom34CBQas.MissingCost, #Bom34CBQas.CanBuild
FROM #Bom34CBQas;
GO


--MAKE WEBI TABLE 6000_01
--34 seconds
TRUNCATE TABLE centraldbs.dbo.BomCanBuildWebI
GO
INSERT INTO centraldbs.dbo.BomCanBuildWebI 
SELECT Cast(centraldbs.dbo.BomCanBuild.MatNbrTla as BigInt) AS MATERIAL_NO, centraldbs.dbo.BomCanBuild.CanBuild AS QUANTITY, sap.dbo.MARC.InHouseProdTime AS LEAD_TIME 
FROM centraldbs.dbo.BomCanBuild LEFT JOIN sap.dbo.MARC ON centraldbs.dbo.BomCanBuild.MatNbrTla = sap.dbo.MARC.Material
WHERE (((sap.dbo.MARC.Plant)=1360))
GO 


