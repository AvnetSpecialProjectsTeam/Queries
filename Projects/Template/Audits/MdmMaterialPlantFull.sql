SELECT *
INTO #AvrMpTemp
FROM OPENQUERY(AVR80, 'SELECT *
FROM GOLDEN.C_BO_MATERIAL_PLANT')

USE MDM
GO

MERGE MaterialPlant AS TargetTbl
USING #AvrMpTemp AS SourceTbl
ON (TargetTbl.RowIdObject=SourceTbl.ROWID_OBJECT)
WHEN MATCHED
	AND TargetTbl.LastUpdateDate <> SourceTbl.LAST_UPDATE_DATE

THEN
	UPDATE SET
	TargetTbl.UpdatedBy = SourceTbl.UPDATED_BY
	,TargetTbl.LastUpdateDate = SourceTbl.LAST_UPDATE_DATE
	,TargetTbl.ConsolidationInd = SourceTbl.CONSOLIDATION_IND
	,TargetTbl.DeletedInd = SourceTbl.DELETED_IND
	,TargetTbl.DeletedBy = SourceTbl.DELETED_BY
	,TargetTbl.DeletedDate = SourceTbl.DELETED_DATE
	,TargetTbl.LastRowidSystem = SourceTbl.LAST_ROWID_SYSTEM
	,TargetTbl.DirtyInd = SourceTbl.DIRTY_IND
	,TargetTbl.InteractionId = SourceTbl.INTERACTION_ID
	,TargetTbl.HubStateInd = SourceTbl.HUB_STATE_IND
	,TargetTbl.CmDirtyInd = SourceTbl.CM_DIRTY_IND
	,TargetTbl.MdmMaterialId = SourceTbl.MDM_MATERIAL_ID
	,TargetTbl.SapPlantCd = SourceTbl.SAP_PLANT_CD
	,TargetTbl.SapAvailCheckGroupCd = SourceTbl.SAP_AVAIL_CHECK_GROUP_CD
	,TargetTbl.SapMaterialStatusCd = SourceTbl.SAP_MATERIAL_STATUS_CD
	,TargetTbl.MaterialStatusDt = SourceTbl.MATERIAL_STATUS_DT
	,TargetTbl.MaximumLotSizeQt = SourceTbl.MAXIMUM_LOT_SIZE_QT
	,TargetTbl.SapProcurementTypeCd = SourceTbl.SAP_PROCUREMENT_TYPE_CD
	,TargetTbl.AbcCd = SourceTbl.ABC_CD
	,TargetTbl.MilitaryPartFl = SourceTbl.MILITARY_PART_FL
	,TargetTbl.PlannedDeliveryDayQt = SourceTbl.PLANNED_DELIVERY_DAY_QT
	,TargetTbl.InventoryMessageTx = SourceTbl.INVENTORY_MESSAGE_TX
	,TargetTbl.SapSupplierMatAbcCd = SourceTbl.SAP_SUPPLIER_MAT_ABC_CD
	,TargetTbl.BatchManagementReqFl = SourceTbl.BATCH_MANAGEMENT_REQ_FL
	,TargetTbl.BuildDayQt = SourceTbl.BUILD_DAY_QT
	,TargetTbl.TotalReplenLeadDayQt = SourceTbl.TOTAL_REPLEN_LEAD_DAY_QT
	,TargetTbl.SerialNumberProfileFl = SourceTbl.SERIAL_NUMBER_PROFILE_FL
	,TargetTbl.BatchManagementFl = SourceTbl.BATCH_MANAGEMENT_FL
	,TargetTbl.SapHtsCd = SourceTbl.SAP_HTS_CD
	,TargetTbl.AutoPoAllowedFl = SourceTbl.AUTO_PO_ALLOWED_FL
	,TargetTbl.SapPurchasingGroupCd = SourceTbl.SAP_PURCHASING_GROUP_CD
	,TargetTbl.UnlimitedOvrDlvAllowFl = SourceTbl.UNLIMITED_OVR_DLV_ALLOW_FL
	,TargetTbl.GoodsRecptProcessDayQt = SourceTbl.GOODS_RECPT_PROCESS_DAY_QT
	,TargetTbl.SapMrpTypeCd = SourceTbl.SAP_MRP_TYPE_CD
	,TargetTbl.PlanningTimeFenceDayQt = SourceTbl.PLANNING_TIME_FENCE_DAY_QT
	,TargetTbl.SafetyStockQt = SourceTbl.SAFETY_STOCK_QT
	,TargetTbl.MinimumLotSizeQt = SourceTbl.MINIMUM_LOT_SIZE_QT
	,TargetTbl.FixedLotSizeQt = SourceTbl.FIXED_LOT_SIZE_QT
	,TargetTbl.SapMrpLotSizeCd = SourceTbl.SAP_MRP_LOT_SIZE_CD
	,TargetTbl.ManualSupplLeadDayQt = SourceTbl.MANUAL_SUPPL_LEAD_DAY_QT
	,TargetTbl.SapPeriodCd = SourceTbl.SAP_PERIOD_CD
	,TargetTbl.CycleCountFixedFl = SourceTbl.CYCLE_COUNT_FIXED_FL
	,TargetTbl.SapOriginatingCountryCd = SourceTbl.SAP_ORIGINATING_COUNTRY_CD
	,TargetTbl.VendorEdiLeadDayQt = SourceTbl.VENDOR_EDI_LEAD_DAY_QT
	,TargetTbl.RunRateQt = SourceTbl.RUN_RATE_QT
	,TargetTbl.SupplyDayQt = SourceTbl.SUPPLY_DAY_QT
	,TargetTbl.SuppCancelWindowDayQt = SourceTbl.SUPP_CANCEL_WINDOW_DAY_QT
	,TargetTbl.EncryptionPartFl = SourceTbl.ENCRYPTION_PART_FL
	,TargetTbl.SapStockingProfile = SourceTbl.SAP_STOCKING_PROFILE
	,TargetTbl.SapReplacementPartCd = SourceTbl.SAP_REPLACEMENT_PART_CD
	,TargetTbl.SapLoadingGroupCd = SourceTbl.SAP_LOADING_GROUP_CD
	,TargetTbl.SourceListRequiredFl = SourceTbl.SOURCE_LIST_REQUIRED_FL
	,TargetTbl.SapFiscalYearVariantCd = SourceTbl.SAP_FISCAL_YEAR_VARIANT_CD
	,TargetTbl.SapIndCollectReqdCd = SourceTbl.SAP_IND_COLLECT_REQD_CD
	,TargetTbl.SapForecastModelCd = SourceTbl.SAP_FORECAST_MODEL_CD
	,TargetTbl.SapValuationCategoryCd = SourceTbl.SAP_VALUATION_CATEGORY_CD
	,TargetTbl.SapMixedMrpCd = SourceTbl.SAP_MIXED_MRP_CD
	,TargetTbl.SapProfitCenter = SourceTbl.SAP_PROFIT_CENTER
	,TargetTbl.RoundingValueNo = SourceTbl.ROUNDING_VALUE_NO
	,TargetTbl.SapSpecialProcureTypCd = SourceTbl.SAP_SPECIAL_PROCURE_TYP_CD
	,TargetTbl.SapMrpGroupCd = SourceTbl.SAP_MRP_GROUP_CD
	,TargetTbl.SapIssuePlntStrLocCd = SourceTbl.SAP_ISSUE_PLNT_STR_LOC_CD
	,TargetTbl.SapExtPrcPltStrLocCd = SourceTbl.SAP_EXT_PRC_PLT_STR_LOC_CD
	,TargetTbl.SapProductionSchedCd = SourceTbl.SAP_PRODUCTION_SCHED_CD
	,TargetTbl.SapCycleCountPhyInvCd = SourceTbl.SAP_CYCLE_COUNT_PHY_INV_CD
	,TargetTbl.SapPlanningCycleCd = SourceTbl.SAP_PLANNING_CYCLE_CD
	,TargetTbl.SapMrpControllerCd = SourceTbl.SAP_MRP_CONTROLLER_CD
	,TargetTbl.SapSchedulingFloatsCd = SourceTbl.SAP_SCHEDULING_FLOATS_CD
	,TargetTbl.LeadTimeOverrideFl = SourceTbl.LEAD_TIME_OVERRIDE_FL
	,TargetTbl.PriceBookEdiLtDt = SourceTbl.PRICE_BOOK_EDI_LT_DT

WHEN NOT MATCHED BY TARGET THEN
INSERT
(
	RowidObject , Creator , CreateDate , UpdatedBy , LastUpdateDate , ConsolidationInd , DeletedInd , DeletedBy , DeletedDate , LastRowidSystem , DirtyInd , InteractionId , HubStateInd , CmDirtyInd , MdmMaterialId , SapPlantCd , SapAvailCheckGroupCd , SapMaterialStatusCd , MaterialStatusDt , MaximumLotSizeQt , SapProcurementTypeCd , AbcCd , MilitaryPartFl , PlannedDeliveryDayQt , InventoryMessageTx , SapSupplierMatAbcCd , BatchManagementReqFl , BuildDayQt , TotalReplenLeadDayQt , SerialNumberProfileFl , BatchManagementFl , SapHtsCd , AutoPoAllowedFl , SapPurchasingGroupCd , UnlimitedOvrDlvAllowFl , GoodsRecptProcessDayQt , SapMrpTypeCd , PlanningTimeFenceDayQt , SafetyStockQt , MinimumLotSizeQt , FixedLotSizeQt , SapMrpLotSizeCd , ManualSupplLeadDayQt , SapPeriodCd , CycleCountFixedFl , SapOriginatingCountryCd , VendorEdiLeadDayQt , RunRateQt , SupplyDayQt , SuppCancelWindowDayQt , EncryptionPartFl , SapStockingProfile , SapReplacementPartCd , SapLoadingGroupCd , SourceListRequiredFl , SapFiscalYearVariantCd , SapIndCollectReqdCd , SapForecastModelCd , SapValuationCategoryCd , SapMixedMrpCd , SapProfitCenter , RoundingValueNo , SapSpecialProcureTypCd , SapMrpGroupCd , SapIssuePlntStrLocCd , SapExtPrcPltStrLocCd , SapProductionSchedCd , SapCycleCountPhyInvCd , SapPlanningCycleCd , SapMrpControllerCd , SapSchedulingFloatsCd , LeadTimeOverrideFl , PriceBookEdiLtDt
)
VALUES(  ROWID_OBJECT, CREATOR, CREATE_DATE, UPDATED_BY, LAST_UPDATE_DATE, CONSOLIDATION_IND, DELETED_IND, DELETED_BY, DELETED_DATE, LAST_ROWID_SYSTEM, DIRTY_IND, INTERACTION_ID, HUB_STATE_IND, CM_DIRTY_IND, MDM_MATERIAL_ID, SAP_PLANT_CD, SAP_AVAIL_CHECK_GROUP_CD, SAP_MATERIAL_STATUS_CD, MATERIAL_STATUS_DT, MAXIMUM_LOT_SIZE_QT, SAP_PROCUREMENT_TYPE_CD, ABC_CD, MILITARY_PART_FL, PLANNED_DELIVERY_DAY_QT, INVENTORY_MESSAGE_TX, SAP_SUPPLIER_MAT_ABC_CD, BATCH_MANAGEMENT_REQ_FL, BUILD_DAY_QT, TOTAL_REPLEN_LEAD_DAY_QT, SERIAL_NUMBER_PROFILE_FL, BATCH_MANAGEMENT_FL, SAP_HTS_CD, AUTO_PO_ALLOWED_FL, SAP_PURCHASING_GROUP_CD, UNLIMITED_OVR_DLV_ALLOW_FL, GOODS_RECPT_PROCESS_DAY_QT, SAP_MRP_TYPE_CD, PLANNING_TIME_FENCE_DAY_QT, SAFETY_STOCK_QT, MINIMUM_LOT_SIZE_QT, FIXED_LOT_SIZE_QT, SAP_MRP_LOT_SIZE_CD, MANUAL_SUPPL_LEAD_DAY_QT, SAP_PERIOD_CD, CYCLE_COUNT_FIXED_FL, SAP_ORIGINATING_COUNTRY_CD, VENDOR_EDI_LEAD_DAY_QT, RUN_RATE_QT, SUPPLY_DAY_QT, SUPP_CANCEL_WINDOW_DAY_QT, ENCRYPTION_PART_FL, SAP_STOCKING_PROFILE, SAP_REPLACEMENT_PART_CD, SAP_LOADING_GROUP_CD, SOURCE_LIST_REQUIRED_FL, SAP_FISCAL_YEAR_VARIANT_CD, SAP_IND_COLLECT_REQD_CD, SAP_FORECAST_MODEL_CD, SAP_VALUATION_CATEGORY_CD, SAP_MIXED_MRP_CD, SAP_PROFIT_CENTER, ROUNDING_VALUE_NO, SAP_SPECIAL_PROCURE_TYP_CD, SAP_MRP_GROUP_CD, SAP_ISSUE_PLNT_STR_LOC_CD, SAP_EXT_PRC_PLT_STR_LOC_CD, SAP_PRODUCTION_SCHED_CD, SAP_CYCLE_COUNT_PHY_INV_CD, SAP_PLANNING_CYCLE_CD, SAP_MRP_CONTROLLER_CD, SAP_SCHEDULING_FLOATS_CD, LEAD_TIME_OVERRIDE_FL, PRICE_BOOK_EDI_LT_DT
)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;

DROP TABLE #AvrMpTemp
