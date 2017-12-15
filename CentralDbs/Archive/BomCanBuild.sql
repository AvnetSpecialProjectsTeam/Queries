--FIRST PART OF BOM CAN BUILD REPORT - OWNER KRISTA CROSS

--BRING IN DAILY INVENTORY 0000_01
--1 sec
USE BI
GO
SELECT * INTO #Bom1DailyInventory 
FROM (SELECT dbo.DailyInv.MaterialNbr AS material_nbr, Sum(dbo.DailyInv.AvlStkQty) AS avl_stk_qty, Sum(dbo.DailyInv.TtlStkQty) AS ttl_stk_qty
FROM dbo.DailyInv
GROUP BY dbo.DailyInv.MaterialNbr) AS subquery1
Go

--BRING IN SAP PARTS LIST 0000_02
-- 1 sec
USE CentralDbs
GO
SELECT * INTO #Bom2PartsList 
FROM (SELECT SapPartsList.MaterialNbr, SapPartsList.pbg, SapPartsList.mfg, SapPartsList.MaterialType, SapPartsList.PrcStgy, SapPartsList.cc, SapPartsList.grp, SapPartsList.tech, SapPartsList.MfgPartNbr
FROM CentralDbs.dbo.SapPartsList
WHERE (SapPartsList.MAtHubState<>-1 And ((SapPartsList.pbg)='0IT' Or (SapPartsList.pbg)='0ST'))) AS subquery2
Go

--BRING IN LABOR COST 0000_03
--26 seconds
USE SAP
GO
SELECT * INTO #Bom3LaborCost 
FROM (SELECT DISTINCT Cast(dbo.STPO.BOM AS numeric) AS BOM, Cast(dbo.STPO.BOMComp AS Varchar(20)) AS BomComp, Cast(dbo.STPO.CompQty AS Decimal (35,6)) AS CompQty, dbo.STPO.CompUnitMeas
FROM dbo.STPO
WHERE (((dbo.STPO.CompUnitMeas)='LE'))) AS subquery3
Go

--BRING IN LEAD TIME 0000_04
--9 seconds
USE SAP 
GO
SELECT * INTO #Bom4LeadTime
FROM (SELECT dbo.MARC.MatNbr, dbo.MARC.SupLeadTime, dbo.MARC.InhProdTime, Cast(dbo.MARC.Plnt AS Varchar(20)) AS Plnt
FROM dbo.MARC
GROUP BY dbo.MARC.MatNbr, dbo.MARC.SupLeadTime, dbo.MARC.InhProdTime, dbo.MARC.Plnt
HAVING (((dbo.MARC.SupLeadTime)<>'777'))) AS subquery4
Go

--BRING IN MATERIAL PRICING GROUP REMOVE LEADING ZEROS 0000_05
--59 seconds
USE SAP 
GO
SELECT * INTO #Bom5MatPricGroup 
FROM (SELECT Cast(dbo.MVKE.[MaterialNbr] AS Decimal(20)) AS MaterialNbr, dbo.MVKE.SalesOrg, dbo.MVKE.MaterialPricingGrp, dbo.MVKE.DeliveringPlantOwnorExternal
FROM dbo.MVKE
GROUP BY dbo.MVKE.MaterialNbr, dbo.MVKE.SalesOrg, dbo.MVKE.MaterialPricingGrp, dbo.MVKE.DeliveringPlantOwnorExternal
HAVING dbo.MVKE.SalesOrg='U001') as subquery5
Go

--CONVERT MATERIAL PRICING GROUP TO VARCHAR 0000_06
--1 second
SELECT * INTO #Bom6MatPricGroup
FROM (SELECT Cast([MaterialNbr] AS varchar(20)) AS MaterialNbr, SalesOrg, MaterialPricingGrp, DeliveringPlantOwnorExternal
FROM #Bom5MatPricGroup) As subquery6
DROP TABLE #Bom5MatPricGroup
Go

--CREATE MULTICOLUMN COSTS 0000_07
--3 seconds
USE MDM
GO
SELECT * INTO #Bom7MultiColCosts
FROM (SELECT mdm.dbo.MultiColumnCostSap.MaterialNbr,
CASE 
	WHEN [col_10_qty]>0 THEN [col_10_qty]
	WHEN [col_10_qty]=0 AND [col_9_qty]>0 THEN [col_9_qty]
	WHEN [col_9_qty]=0 AND [col_8_qty]>0 THEN [col_8_qty]
	WHEN [col_8_qty]=0 AND [col_7_qty]>0 THEN [col_7_qty]
	WHEN [col_7_qty]=0 AND [col_6_qty]>0 THEN [col_6_qty]
	WHEN [col_6_qty]=0 AND [col_5_qty]>0 THEN [col_5_qty]
	WHEN [col_5_qty]=0 AND [col_4_qty]>0 THEN [col_4_qty]
	WHEN [col_4_qty]=0 AND [col_3_qty]>0 THEN [col_3_qty]
	WHEN [col_3_qty]=0 AND [col_2_qty]>0 THEN [col_2_qty]
	WHEN [col_2_qty]=0 AND [col_1_qty]>0 THEN [col_1_qty]
	ELSE 999
END AS MinMCQty,
CASE 
	WHEN [col_10_$]>0 THEN [col_10_$]
	WHEN [col_10_$]=0 AND [col_9_$]>0 THEN [col_9_$]
	WHEN [col_9_$]=0 AND [col_8_$]>0 THEN [col_8_$]
	WHEN [col_8_$]=0 AND [col_7_$]>0 THEN [col_7_$]
	WHEN [col_7_$]=0 AND [col_6_$]>0 THEN [col_6_$]
	WHEN [col_6_$]=0 AND [col_5_$]>0 THEN [col_5_$]
	WHEN [col_5_$]=0 AND [col_4_$]>0 THEN [col_4_$]
	WHEN [col_4_$]=0 AND [col_3_$]>0 THEN [col_3_$]
	WHEN [col_3_$]=0 AND [col_2_$]>0 THEN [col_2_$]
	WHEN [col_2_$]=0 AND [col_1_$]>0 THEN [col_1_$]
	ELSE 999
END AS MinMCCost
FROM mdm.dbo.MultiColumnCostSap) as subquery7
Go

-- BRING IN COST RESALE 0000_08
--1 second
SELECT * INTO #Bom8Costs 
FROM(SELECT mdm.dbo.CostResale.material_nbr, mdm.dbo.CostResale.unit_book_cost, mdm.dbo.CostResale.MinCost
FROM mdm.dbo.CostResale
GROUP BY mdm.dbo.CostResale.material_nbr, mdm.dbo.CostResale.unit_book_cost, mdm.dbo.CostResale.MinCost
HAVING mdm.dbo.CostResale.unit_book_cost IS NOT NULL) AS subquery8
Go

--BRING IN FLAGS AND CODES 0000_09
--4 seconds
SELECT * INTO #Bom9FlagsCodes 
FROM (SELECT DISTINCT centraldbs.dbo.sapFlagscodes.MaterialNbr AS MaterialNbr, centraldbs.dbo.sapFlagscodes.AbcCd AS Abc, centraldbs.dbo.sapFlagscodes.SapStockingProfile AS StkProf, centraldbs.dbo.sapFlagscodes.SapPlantCd AS Plant
FROM centraldbs.dbo.sapFlagscodes) as subquery9
Go

--CONNECT MAST TO STPO _ BEGIN BUILD 2000_00
--18 seconds
USE SAP
GO
SELECT * INTO #Bom10MastStpo
FROM (SELECT CAST(dbo.MAST.MatNum AS Varchar (15)) AS MatNbrTla, CAST(dbo.MAST.BOM AS numeric (50)) AS Bom, CAST(dbo.STPO.BOMComp AS Varchar (225)) AS CompMatNbr, CAST(dbo.STPO.CompQty AS decimal(38,6)) AS CompQty, dbo.MAST.Plnt AS Plant
FROM dbo.MAST LEFT JOIN dbo.STPO ON dbo.MAST.BOM = dbo.STPO.BOM
GROUP BY dbo.MAST.MatNum, dbo.MAST.BOM, dbo.STPO.BOMComp, dbo.STPO.CompQty, dbo.MAST.Plnt
HAVING ((dbo.STPO.BOMComp)<>0)) AS subquery10
Go

--ADD QAS AND QOH TO BOMS 2000_01
--5 secpmds
SELECT * INTO #Bom11QasQoh
FROM (SELECT #Bom10MastStpo.MatNbrTla,#Bom10MastStpo.Bom,#Bom10MastStpo.CompMatNbr,#Bom10MastStpo.CompQty, Sum(#Bom1DailyInventory.avl_stk_qty) AS Qas, Sum(#Bom1DailyInventory.ttl_stk_qty) AS Qoh,#Bom10MastStpo.Plant
FROM #Bom10MastStpo LEFT JOIN #Bom1DailyInventory ON #Bom10MastStpo.CompMatNbr = #Bom1DailyInventory.material_nbr
GROUP BY #Bom10MastStpo.MatNbrTla,#Bom10MastStpo.Bom,#Bom10MastStpo.CompMatNbr,#Bom10MastStpo.CompQty,#Bom10MastStpo.Plant) AS subquery11
GO
DROP TABLE #Bom10MastStpo


--ADD PRODUCT HEIRARCHY 2000_02
--3 seconds
SELECT * INTO #Bom12ProdHrchy
FROM (SELECT #Bom11QasQoh.MatNbrTla, #Bom11QasQoh.Bom, #Bom2PartsList.PrcStgy AS CompPrcStgy, #Bom11QasQoh.CompMatNbr,  #Bom2PartsList.MfgPartNbr AS CompMfgPartNbr, #Bom11QasQoh.CompQty, #Bom11QasQoh.Qas, #Bom11QasQoh.Qoh,  #Bom2PartsList.grp AS Grp,  #Bom2PartsList.MaterialType AS MatTyp, #Bom11QasQoh.Plant
FROM #Bom11QasQoh LEFT JOIN #Bom2PartsList ON #Bom11QasQoh.CompMatNbr=#Bom2PartsList.MaterialNbr) AS subquery12
GO
DROP TABLE #Bom11QasQoh


--MOVING AVERAGE PRICE 2000_03
--10 seconds
SELECT * INTO #Bom13Map
FROM (SELECT #Bom12ProdHrchy.MatNbrTla, #Bom12ProdHrchy.Bom, #Bom12ProdHrchy.CompPrcStgy, #Bom12ProdHrchy.CompMfgPartNbr, #Bom12ProdHrchy.CompMatNbr, #Bom12ProdHrchy.CompQty, #Bom12ProdHrchy.Qas, #Bom12ProdHrchy.Qoh, #Bom12ProdHrchy.Grp, #Bom12ProdHrchy.Plant, #Bom12ProdHrchy.MatTyp, Min(Round(sap.dbo.Map.Map,6)) AS Map
FROM #Bom12ProdHrchy LEFT JOIN sap.dbo.Map ON #Bom12ProdHrchy.CompMatNbr = sap.dbo.Map.MatNbr
GROUP BY #Bom12ProdHrchy.MatNbrTla, #Bom12ProdHrchy.Bom, #Bom12ProdHrchy.CompPrcStgy, #Bom12ProdHrchy.CompMfgPartNbr, #Bom12ProdHrchy.CompMatNbr, #Bom12ProdHrchy.CompQty, #Bom12ProdHrchy.Qas, #Bom12ProdHrchy.Qoh, #Bom12ProdHrchy.Grp, #Bom12ProdHrchy.Plant, #Bom12ProdHrchy.MatTyp) as subquery13
GO
DROP TABLE #Bom12ProdHrchy


--BOOK COST 2000_04  
--8 seconds   
SELECT * INTO #Bom14BookCost 
FROM (SELECT #Bom13Map.MatNbrTla, #Bom13Map.Bom, #Bom13Map.CompPrcStgy, #Bom13Map.CompMfgPartNbr, #Bom13Map.CompMatNbr, #Bom13Map.CompQty, #Bom13Map.Qas, #Bom13Map.Qoh, #Bom13Map.Grp, #Bom13Map.Plant, #Bom13Map.MatTyp, #Bom13Map.Map, MIN(#Bom8Costs.unit_book_cost) AS BookCost, 
MIN(CASE WHEN #Bom13Map.map<#Bom8Costs.unit_book_cost THEN #Bom13Map.map
		 WHEN #Bom8Costs.unit_book_cost=0 THEN #Bom8Costs.unit_book_cost
		 ELSE #Bom13Map.map END) AS MinCost
FROM #Bom13Map LEFT JOIN #Bom8Costs ON #Bom13Map.CompMatNbr = #Bom8Costs.material_nbr
GROUP BY #Bom13Map.MatNbrTla, #Bom13Map.Bom, #Bom13Map.CompPrcStgy, #Bom13Map.CompMfgPartNbr, #Bom13Map.CompMatNbr, #Bom13Map.CompQty, #Bom13Map.Qas, #Bom13Map.Qoh, #Bom13Map.Grp, #Bom13Map.Plant, #Bom13Map.MatTyp, #Bom13Map.Map) as subquery14
GO
DROP TABLE #Bom8Costs
DROP TABLE #Bom13Map


--ADD LABOR COST 2000_05
--3 seconds
SELECT * INTO #Bom15AddLabor 
FROM (SELECT #Bom14BookCost.MatNbrTla, #Bom14BookCost.Bom, #Bom14BookCost.CompPrcStgy, #Bom14BookCost.CompMfgPartNbr, #Bom14BookCost.CompMatNbr, #Bom14BookCost.CompQty, #Bom14BookCost.Qas, #Bom14BookCost.Qoh, #Bom14BookCost.Grp, #Bom14BookCost.Plant, #Bom14BookCost.MatTyp, #Bom14BookCost.Map, #Bom14BookCost.BookCost, #Bom14BookCost.CompQty*#Bom14BookCost.MinCost AS ExtCompCost,
CASE 
WHEN(#Bom3LaborCost.CompQty Is Null) THEN 0 ELSE #Bom3LaborCost.CompQty END AS LaborCost
FROM #Bom14BookCost LEFT JOIN #Bom3LaborCost ON (#Bom14BookCost.Bom = #Bom3LaborCost.BOM) AND (#Bom14BookCost.CompMatNbr = #Bom3LaborCost.BomComp)) AS subquery15
GO
DROP TABLE #Bom3LaborCost
DROP TABLE #Bom14BookCost


--ADD FLAGS AND CODES 2000_06
--25 seconds
SELECT * INTO #Bom16AddFlags 
FROM (SELECT #Bom15AddLabor.MatNbrTla, #Bom15AddLabor.Bom, #Bom15AddLabor.CompPrcStgy, #Bom15AddLabor.CompMfgPartNbr, #Bom15AddLabor.CompMatNbr, #Bom15AddLabor.CompQty, #Bom15AddLabor.Qas, #Bom9FlagsCodes.Abc, #Bom9FlagsCodes.StkProf, #Bom15AddLabor.Qoh, #Bom15AddLabor.Grp, #Bom15AddLabor.Plant, #Bom15AddLabor.MatTyp, #Bom15AddLabor.Map, #Bom15AddLabor.BookCost, #Bom15AddLabor.ExtCompCost, #Bom15AddLabor.LaborCost
FROM #Bom15AddLabor LEFT JOIN #Bom9FlagsCodes ON #Bom15AddLabor.CompMatNbr = #Bom9FlagsCodes.MaterialNbr) as subquery16
GO
DROP TABLE #Bom15AddLabor


--ADD MAT PRIC GROUP 2000_07
--39 seconds
USE SAP 
GO 
SELECT * INTO #Bom17AddMatPricGrp 
FROM (SELECT #Bom16AddFlags.MatNbrTla, #Bom16AddFlags.Bom, #Bom16AddFlags.CompMfgPartNbr, #Bom16AddFlags.CompMatNbr, #Bom16AddFlags.CompPrcStgy, #Bom16AddFlags.CompQty, #Bom16AddFlags.Qas, #Bom16AddFlags.Qoh, #Bom6MatPricGroup.MaterialPricingGrp AS MatPricGrp, #Bom16AddFlags.Grp, #Bom16AddFlags.MatTyp, #Bom16AddFlags.Abc, #Bom16AddFlags.StkProf, #Bom16AddFlags.Map, #Bom16AddFlags.BookCost, #Bom16AddFlags.ExtCompCost, #Bom16AddFlags.LaborCost, #Bom16AddFlags.Plant
FROM #Bom16AddFlags LEFT JOIN #Bom6MatPricGroup ON #Bom16AddFlags.CompMatNbr = #Bom6MatPricGroup.MaterialNbr) as subquery17
GO
DROP TABLE #Bom16AddFlags


--ADD MULTI CLOUMN COSTS 2000_08
-- 51 seconds
SELECT * INTO #Bom18AddMCC FROM ( 
SELECT #Bom17AddMatPricGrp.MatNbrTla, #Bom17AddMatPricGrp.Bom, #Bom17AddMatPricGrp.CompMfgPartNbr, #Bom17AddMatPricGrp.CompMatNbr, #Bom17AddMatPricGrp.CompPrcStgy, #Bom17AddMatPricGrp.CompQty, #Bom17AddMatPricGrp.Qas, #Bom17AddMatPricGrp.Qoh, #Bom17AddMatPricGrp.MatPricGrp, #Bom17AddMatPricGrp.Grp, #Bom17AddMatPricGrp.MatTyp, #Bom17AddMatPricGrp.Abc, #Bom17AddMatPricGrp.StkProf, #Bom17AddMatPricGrp.Map, #Bom17AddMatPricGrp.BookCost, #Bom17AddMatPricGrp.ExtCompCost, #Bom17AddMatPricGrp.LaborCost, #Bom7MultiColCosts.MinMCQty AS BestReplCostQty, #Bom7MultiColCosts.MinMCCost AS BestReplCost$, #Bom17AddMatPricGrp.Plant
FROM #Bom17AddMatPricGrp LEFT JOIN #Bom7MultiColCosts ON #Bom17AddMatPricGrp.CompMatNbr = #Bom7MultiColCosts.MaterialNbr) as subquery18
GO
DROP TABLE #Bom7MultiColCosts
 

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
DROP TABLE #Bom18AddMCC


--ADD LEAD TIME 2000_10
--2 mins 21 seconds
SELECT * INTO #Bom20LeadTime FROM (
SELECT Distinct #Bom19ReplaceNulls.MatNbrTla, #Bom19ReplaceNulls.Bom, #Bom19ReplaceNulls.CompMatNbr, #Bom19ReplaceNulls.CompPrcStgy, #Bom19ReplaceNulls.MatPricGrp, #Bom19ReplaceNulls.Grp, #Bom19ReplaceNulls.CompMfgPartNbr, #Bom19ReplaceNulls.MatTyp, #Bom19ReplaceNulls.Plant, #Bom19ReplaceNulls.Abc, #Bom19ReplaceNulls.StkProf, #Bom19ReplaceNulls.Qty, #Bom19ReplaceNulls.Qas, #Bom19ReplaceNulls.Qoh, #Bom19ReplaceNulls.Map, #Bom19ReplaceNulls.BookCost, #Bom19ReplaceNulls.LaborCost, #Bom19ReplaceNulls.BestReplCostQty, #Bom19ReplaceNulls.BestReplCost$, #Bom19ReplaceNulls.ExtCompCost, #Bom4LeadTime.SupLeadTime AS LeadTime
FROM #Bom19ReplaceNulls LEFT JOIN #Bom4LeadTime ON (#Bom19ReplaceNulls.Plant = #Bom4LeadTime.Plnt) AND (#Bom19ReplaceNulls.CompMatNbr = #Bom4LeadTime.MatNbr)) as subquery20
GO
DROP TABLE #Bom4LeadTime
DROP TABLE #Bom19ReplaceNulls


--ADD TLA DATA 2000_11
--4 seconds
SELECT * INTO #Bom21AddTlaData 
FROM (SELECT #Bom2PartsList.mfg AS MfgTla, #Bom2PartsList.PrcStgy AS PrcStgyTla, #Bom2PartsList.MfgPartNbr AS MfgPartNbrTla, #Bom20LeadTime.MatNbrTla, #Bom20LeadTime.Bom, #Bom20LeadTime.CompMatNbr, #Bom20LeadTime.CompPrcStgy, #Bom20LeadTime.MatPricGrp, #Bom20LeadTime.Grp, #Bom20LeadTime.CompMfgPartNbr, #Bom20LeadTime.MatTyp, #Bom20LeadTime.Plant, #Bom20LeadTime.Abc, #Bom20LeadTime.StkProf, #Bom20LeadTime.Qty, #Bom20LeadTime.Qas, #Bom20LeadTime.Qoh, #Bom20LeadTime.Map, #Bom20LeadTime.BookCost, #Bom20LeadTime.LaborCost, #Bom20LeadTime.BestReplCostQty, #Bom20LeadTime.BestReplCost$, #Bom20LeadTime.ExtCompCost, #Bom20LeadTime.LeadTime FROM #Bom20LeadTime LEFT JOIN #Bom2PartsList ON #Bom20LeadTime.MatNbrTla = #Bom2PartsList.MaterialNbr) AS subquery21
GO
DROP TABLE #Bom20LeadTime


--MAKE COMPONENTS TABLE 2000_12
--3 seconds
TRUNCATE TABLE centraldbs.dbo.BomComponents 
GO
INSERT INTO  centraldbs.dbo.BomComponents
SELECT #Bom21AddTlaData.PrcStgyTla, #Bom21AddTlaData.MfgPartNbrTla, #Bom21AddTlaData.MatNbrTla, #Bom21AddTlaData.Bom, #Bom21AddTlaData.CompMatNbr, #Bom21AddTlaData.CompMfgPartNbr, #Bom21AddTlaData.CompPrcStgy, #Bom21AddTlaData.MatPricGrp, #Bom21AddTlaData.Grp, #Bom21AddTlaData.MatTyp, #Bom21AddTlaData.Abc, #Bom21AddTlaData.StkProf AS StkProfile, #Bom21AddTlaData.LeadTime, #Bom21AddTlaData.Qty, #Bom21AddTlaData.Qas, #Bom21AddTlaData.Qoh, #Bom21AddTlaData.Map , #Bom21AddTlaData.BookCost, #Bom21AddTlaData.LaborCost, #Bom21AddTlaData.BestReplCostQty, #Bom21AddTlaData.ExtCompCost, #Bom21AddTlaData.BestReplCost$
FROM #Bom21AddTlaData;
GO
DROP TABLE #Bom21AddTlaData


--CAN BUILD QTY 4000_01
--4 seconds
SELECT * INTO #Bom22CanBuildQty 
FROM (SELECT centraldbs.dbo.BomComponents.CompPrcStgy, centraldbs.dbo.BomComponents.CompMfgPartNbr, BomComponents.MatNbrTla, centraldbs.dbo.BomComponents.Bom, 
#Bom6MatPricGroup.MaterialPricingGrp AS MatPricGrp, centraldbs.dbo.BomComponents.Map, centraldbs.dbo.BomComponents.BookCost, centraldbs.dbo.BomComponents.BestReplCost$, centraldbs.dbo.BomComponents.LaborCost, centraldbs.dbo.BomComponents.LeadTime,
CASE WHEN (centraldbs.dbo.BomComponents.LaborCost>0) THEN 0 ELSE centraldbs.dbo.BomComponents.Qty END AS Qty,
CASE WHEN (centraldbs.dbo.BomComponents.LaborCost>0) THEN Null ELSE ([Qas]/[Qty]) END AS CanBuild
FROM centraldbs.dbo.BomComponents LEFT JOIN #Bom6MatPricGroup ON centraldbs.dbo.BomComponents.MatNbrTla = #Bom6MatPricGroup.MaterialNbr) as subquery22
GO
DROP TABLE  #Bom6MatPricGroup


--MIN CAN BUILD QTY 4000_02
--7 seconds
SELECT * INTO #Bom23MinCanBuild 
FROM (SELECT #Bom22CanBuildQty.MatNbrTla, #Bom22CanBuildQty.Bom, Sum(#Bom22CanBuildQty.Qty) AS Qty, #Bom22CanBuildQty.MatPricGrp, Sum(#Bom22CanBuildQty.Map) AS Map, Sum(#Bom22CanBuildQty.BookCost) AS BookCost, Sum(#Bom22CanBuildQty.BestReplCost$) AS BestReplCost$, Sum(#Bom22CanBuildQty.LaborCost) AS LaborCost, Min(#Bom22CanBuildQty.CanBuild) AS CanBuild, #Bom22CanBuildQty.LeadTime
FROM #Bom22CanBuildQty
GROUP BY #Bom22CanBuildQty.MatNbrTla, #Bom22CanBuildQty.Bom, #Bom22CanBuildQty.MatPricGrp, #Bom22CanBuildQty.LeadTime) AS subquery23
GO
DROP TABLE #Bom22CanBuildQty


--SUM THE CAN BUILD 4000_03
--3 seconds
SELECT * INTO #Bom24SumCanBuild 
FROM (SELECT #Bom23MinCanBuild.MatNbrTla, #Bom23MinCanBuild.Bom, Sum(#Bom23MinCanBuild.Qty) AS Qty, #Bom23MinCanBuild.MatPricGrp, Sum(#Bom23MinCanBuild.Map) AS Map, Sum(#Bom23MinCanBuild.BookCost) AS BookCost, Sum(#Bom23MinCanBuild.BestReplCost$) AS BestReplCost$, Sum(#Bom23MinCanBuild.LaborCost) AS LaborCost, Sum(#Bom23MinCanBuild.CanBuild) AS CanBuild, Sum(#Bom23MinCanBuild.LeadTime) AS LeadTime
FROM #Bom23MinCanBuild
GROUP BY #Bom23MinCanBuild.MatNbrTla, #Bom23MinCanBuild.Bom, #Bom23MinCanBuild.MatPricGrp) AS subquery24
GO
DROP TABLE #Bom23MinCanBuild


--ADD TLA DATA TO CAN BUILD 4000_04
--2 seconds
SELECT * INTO #Bom25CBTlaProdHrchy 
FROM (SELECT #Bom2PartsList.PrcStgy, #Bom2PartsList.MfgPartNbr, #Bom2PartsList.grp, #Bom24SumCanBuild.MatNbrTla, #Bom24SumCanBuild.Bom, #Bom24SumCanBuild.Qty, #Bom24SumCanBuild.MatPricGrp, #Bom24SumCanBuild.Map, #Bom24SumCanBuild.BookCost, #Bom24SumCanBuild.BestReplCost$, #Bom24SumCanBuild.LaborCost, #Bom24SumCanBuild.CanBuild, #Bom24SumCanBuild.LeadTime
FROM #Bom24SumCanBuild LEFT JOIN #Bom2PartsList ON #Bom24SumCanBuild.MatNbrTla = #Bom2PartsList.MaterialNbr
GROUP BY #Bom2PartsList.PrcStgy, #Bom2PartsList.MfgPartNbr, #Bom2PartsList.grp, #Bom24SumCanBuild.MatNbrTla, #Bom24SumCanBuild.Bom, #Bom24SumCanBuild.Qty, #Bom24SumCanBuild.MatPricGrp, #Bom24SumCanBuild.Map, #Bom24SumCanBuild.BookCost, #Bom24SumCanBuild.BestReplCost$, #Bom24SumCanBuild.LaborCost, #Bom24SumCanBuild.CanBuild, #Bom24SumCanBuild.LeadTime) as subquery25
GO
DROP TABLE #Bom2PartsList
DROP TABLE #Bom24SumCanBuild


--ADD CAN BUILD FLAGS AND CODES 4000_05
--9 seconds
SELECT * INTO #Bom26CBFlagsCodes 
FROM (SELECT #Bom25CBTlaProdHrchy.PrcStgy, #Bom25CBTlaProdHrchy.MfgPartNbr, #Bom25CBTlaProdHrchy.MatNbrTla, #Bom25CBTlaProdHrchy.Bom, #Bom25CBTlaProdHrchy.Qty, #Bom9FlagsCodes.StkProf AS StkProfile, #Bom9FlagsCodes.abc AS abc, #Bom25CBTlaProdHrchy.MatPricGrp, #Bom25CBTlaProdHrchy.LeadTime, #Bom25CBTlaProdHrchy.BookCost, #Bom25CBTlaProdHrchy.Map, #Bom25CBTlaProdHrchy.BestReplCost$, #Bom25CBTlaProdHrchy.LaborCost, #Bom25CBTlaProdHrchy.CanBuild, #Bom25CBTlaProdHrchy.grp
FROM #Bom25CBTlaProdHrchy LEFT JOIN #Bom9FlagsCodes ON #Bom25CBTlaProdHrchy.MatNbrTla = #Bom9FlagsCodes.MaterialNbr
GROUP BY #Bom25CBTlaProdHrchy.PrcStgy, #Bom25CBTlaProdHrchy.MfgPartNbr, #Bom25CBTlaProdHrchy.MatNbrTla, #Bom25CBTlaProdHrchy.Bom, #Bom25CBTlaProdHrchy.Qty, #Bom9FlagsCodes.StkProf, #Bom9FlagsCodes.abc, #Bom25CBTlaProdHrchy.MatPricGrp, #Bom25CBTlaProdHrchy.LeadTime, #Bom25CBTlaProdHrchy.BookCost, #Bom25CBTlaProdHrchy.Map, #Bom25CBTlaProdHrchy.BestReplCost$, #Bom25CBTlaProdHrchy.LaborCost, #Bom25CBTlaProdHrchy.CanBuild, #Bom25CBTlaProdHrchy.grp) AS subquery26
GO
DROP TABLE #Bom9FlagsCodes
DROP TABLE #Bom25CBTlaProdHrchy


--ADD CAN BUILD QAS 4000_06
--2 seconds
SELECT * INTO #Bom27CBQas 
FROM (SELECT #Bom26CBFlagsCodes.PrcStgy, #Bom26CBFlagsCodes.MfgPartNbr, #Bom26CBFlagsCodes.MatNbrTla, #Bom26CBFlagsCodes.Bom, #Bom26CBFlagsCodes.Qty, #Bom26CBFlagsCodes.StkProfile, #Bom26CBFlagsCodes.abc, #Bom26CBFlagsCodes.MatPricGrp, #Bom26CBFlagsCodes.LeadTime, #Bom26CBFlagsCodes.BookCost, #Bom26CBFlagsCodes.Map, #Bom26CBFlagsCodes.BestReplCost$, #Bom26CBFlagsCodes.LaborCost, #Bom26CBFlagsCodes.CanBuild, #Bom26CBFlagsCodes.grp,
CASE WHEN (#Bom1DailyInventory.avl_stk_qty Is Null) THEN 0 ELSE #Bom1DailyInventory.avl_stk_qty END AS Qas
FROM #Bom26CBFlagsCodes LEFT JOIN #Bom1DailyInventory ON #Bom26CBFlagsCodes.MatNbrTla = #Bom1DailyInventory.material_nbr
WHERE (#Bom26CBFlagsCodes.MatNbrTla Is Not Null)
GROUP BY #Bom26CBFlagsCodes.PrcStgy, #Bom26CBFlagsCodes.MfgPartNbr, #Bom26CBFlagsCodes.MatNbrTla, #Bom26CBFlagsCodes.Bom, #Bom26CBFlagsCodes.Qty, #Bom26CBFlagsCodes.StkProfile, #Bom26CBFlagsCodes.abc, #Bom1DailyInventory.avl_stk_qty, #Bom26CBFlagsCodes.MatPricGrp, #Bom26CBFlagsCodes.LeadTime, #Bom26CBFlagsCodes.BookCost, #Bom26CBFlagsCodes.Map, #Bom26CBFlagsCodes.BestReplCost$, #Bom26CBFlagsCodes.LaborCost, #Bom26CBFlagsCodes.CanBuild, #Bom26CBFlagsCodes.grp) AS subquery27
GO
DROP TABLE #Bom1DailyInventory 
DROP TABLE #Bom26CBFlagsCodes


--MAKE BOM CAN BUILD TABLE 4000_07
--0 seconds
TRUNCATE TABLE centraldbs.dbo.BomCanBuild
GO
INSERT INTO centraldbs.dbo.BomCanBuild 
SELECT #Bom27CBQas.PrcStgy, #Bom27CBQas.MfgPartNbr, #Bom27CBQas.MatNbrTla, #Bom27CBQas.Bom, #Bom27CBQas.Qty, #Bom27CBQas.StkProfile, #Bom27CBQas.abc, #Bom27CBQas.MatPricGrp, #Bom27CBQas.LeadTime, #Bom27CBQas.BookCost, #Bom27CBQas.Map, #Bom27CBQas.BestReplCost$, #Bom27CBQas.LaborCost, #Bom27CBQas.CanBuild, #Bom27CBQas.grp
FROM #Bom27CBQas;
GO
DROP TABLE #Bom27CBQas


--MAKE WEBI TABLE 6000_01
--34 seconds
DROP TABLE centraldbs.dbo.BomCanBuildWebI
GO
SELECT * INTO centraldbs.dbo.BomCanBuildWebI 
FROM (SELECT Format(Cast(centraldbs.dbo.BomCanBuild.MatNbrTla as BigInt), '000000000000000000#') AS MATERIAL_NO, centraldbs.dbo.BomCanBuild.Qty AS QUANTITY, sap.dbo.MARC.InhProdTime AS LEAD_TIME 
FROM centraldbs.dbo.BomCanBuild LEFT JOIN sap.dbo.MARC ON centraldbs.dbo.BomCanBuild.MatNbrTla = sap.dbo.MARC.MatNbr
WHERE (((sap.dbo.MARC.Plnt)=1360))) AS tabl2
GO 