

Select * Into #ZdpsSapPartsList From(
SELECT SapPartsList.MaterialRowIdObject as material_row_id, SapPartsList.MaterialNbr as material_nbr, SapPartsList.pbg, SapPartsList.mfg, SapPartsList.PrcStgy as prc_stgy, SapPartsList.cc, SapPartsList.grp, SapPartsList.tech, SapPartsList.ProdHrchy as prod_hrchy, SapPartsList.MfgPartNbr as mfg_part_nbr, SapPartsList.MaterialType as mat_type, SapPartsList.ItemCat as item_cat
FROM Centraldbs.dbo.SapPartsList
WHERE SapPartsList.MaterialType='ZDPS') as subquery1

Select * Into #NonEolFlagsCodes From(
SELECT Distinct SapFlagsCodes.RowIdObject as material_row_id, SapFlagsCodes.MaterialNbr as material_nbr, SapFlagsCodes.SapPlantCd as sap_plant_cd, SapFlagsCodes.Xstatus as x_status, SapFlagsCodes.eComm, SapFlagsCodes.WebSellable as web_sellable, SapFlagsCodes.AbcCd, SapFlagsCodes.SapStockingProfile as stk_profile, SapFlagsCodes.ncnr
FROM CentralDbs.dbo.SapFlagsCodes
HAVING SapFlagsCodes.SapPlantCd='1300') as subquery2

Select * Into #MaterialAssignments From(
SELECT MatAor.MatNbr as material_nbr, MatAor.SrDir as sr_dir, MatAor.pld, MatAor.MatlMgr as matl_mgr, MatAor.MatlSpclst as matl_spclst
FROM sap.dbo.MatAor) as subquery3

Select * Into #1300SapQuantities From( 
SELECT Distinct ViewSapQty2570.MaterialRowIdObject as material_row_id, ViewSapQty2570.MaterialNbr as material_nbr, ViewSapQty2570.SapPlantCd as sap_plant_cd, ViewSapQty2570.LT_plan_dlvry, ViewSapQty2570.LT_manual, ViewSapQty2570.LT_override_fl
FROM mdm.dbo.ViewSapQty2570
HAVING ViewSapQty2570.SapPlantCd='1300') as subquery4

Select * Into #Aged_Inv From(
SELECT DailyInv.MaterialNbr as material_nbr, DailyInv.AgedDays, Sum(DailyInv.AvlStkQty) AS avl_stk_qty, Sum(DailyInv.TtlStkQty) AS ttl_stk_qty, Sum(DailyInv.TtlStkQty) AS ttl_stk_value
FROM bi.dbo.DailyInv
GROUP BY DailyInv.MaterialNbr, DailyInv.AgedDays
HAVING DailyInv.AgedDays>360) as subquery 5

Select * Into #InvByPart From(
SELECT DailyInv.MaterialNbr as material_nbr, Sum(DailyInv.AvlStkQty) AS avl_stk_qty, Sum(DailyInv.TtlStkQty) AS ttl_stk_qty, Sum(DailyInv.ttlStkQty) AS ttl_stk_value
FROM Bi.dbo.DailyInv
GROUP BY DailyInv.MaterialNbr) as subquery6

Select * Into #Nmi From (
SELECT NonMovingInventory.material_nbr, Sum(Cast(NonMovingInventory.[nmi-crnt_qty] as decimal(13,2))) AS bom_nmi_qty, Sum(Cast(NonMovingInventory.[nmi-crnt_$] as decimal(23,5))) AS [bom_nmi_$]
FROM CentralDbs.dbo.NonMovingInventory
GROUP BY NonMovingInventory.material_nbr) as subquery7


SELECT #1300SapQuantities.material_nbr, #1300SapQuantities.sap_plant_cd, #ZdpsSapPartsList.pbg, #ZdpsSapPartsList.mfg, #ZdpsSapPartsList.prc_stgy, #ZdpsSapPartsList.cc, #ZdpsSapPartsList.grp, #ZdpsSapPartsList.tech, #ZdpsSapPartsList.prod_hrchy, #ZdpsSapPartsList.mfg_part_nbr, #ZdpsSapPartsList.mat_type, #ZdpsSapPartsList.item_cat, #1300SapQuantities.LT_plan_dlvry, #1300SapQuantities.LT_manual, #1300SapQuantities.LT_override_fl
FROM #1300SapQuantities INNER JOIN #ZdpsSapPartsList ON #1300SapQuantities.material_nbr = #ZdpsSapPartsList.material_nbr;
