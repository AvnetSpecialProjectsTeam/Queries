USE [msdb]
GO

/****** Object:  Job [MdmRowInsert]    Script Date: 5/16/2017 10:20:09 AM ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'0e0f38ee-e661-442f-a4fd-44d6c5fa2d4e', @delete_unused_schedule=1
GO

/****** Object:  Job [MdmRowInsert]    Script Date: 5/16/2017 10:20:09 AM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Data Collector]    Script Date: 5/16/2017 10:20:10 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Data Collector' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Data Collector'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'MdmRowInsert', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Data Collector', 
		@owner_login_name=N'AMER\execmssqldev', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [DBAIsPrimary]    Script Date: 5/16/2017 10:20:10 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'DBAIsPrimary', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=1, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BEGIN
IF  [dbo].[fn_hadr_group_is_primary] (''DevMatAG01'') = 0
RAISERROR(N''Not Primary Replica - Ending Job'', 16, 1);
ELSE
PRINT ''Proceeding to next job step'';
END', 
		@database_name=N'msdb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Insert New MatProdHier]    Script Date: 5/16/2017 10:20:10 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Insert New MatProdHier', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SELECT *
INTO #AVRTemp
FROM OPENQUERY(AVR80, ''SELECT *
FROM GOLDEN.C_BO_MATL_PROD_HIERARCHY
WHERE (((CREATE_DATE) > SYSDATE-5))'')

INSERT INTO MaterialProdHier
(
	MaterialProdHier.RowIdObject , MaterialProdHier.Creator , MaterialProdHier.CreateDate , MaterialProdHier.UpdatedBy , MaterialProdHier.LastUpdateDate , MaterialProdHier.ConsolidationInd , MaterialProdHier.DeletedInd , MaterialProdHier.DeletedBy , MaterialProdHier.DeletedDate , MaterialProdHier.LastRowidSystem , MaterialProdHier.DirtyInd , MaterialProdHier.InteractionId , MaterialProdHier.HubStateInd , MaterialProdHier.CmDirtyInd , MaterialProdHier.ProductHierarchyCode , MaterialProdHier.SapMatlProdHierNm , MaterialProdHier.SapProductBusGroupCd , MaterialProdHier.SapProcureStrategyCd , MaterialProdHier.SapTechnologyCd , MaterialProdHier.SapCommodityCd , MaterialProdHier.SapProductGroupCd
)
SELECT  #AVRTemp.ROWID_OBJECT, #AVRTemp.CREATOR, #AVRTemp.CREATE_DATE, #AVRTemp.UPDATED_BY, #AVRTemp.LAST_UPDATE_DATE, #AVRTemp.CONSOLIDATION_IND, #AVRTemp.DELETED_IND, #AVRTemp.DELETED_BY, #AVRTemp.DELETED_DATE, #AVRTemp.LAST_ROWID_SYSTEM, #AVRTemp.DIRTY_IND, #AVRTemp.INTERACTION_ID, #AVRTemp.HUB_STATE_IND, #AVRTemp.CM_DIRTY_IND, #AVRTemp.PRODUCT_HIERARCHY_CODE, #AVRTemp.SAP_MATL_PROD_HIER_NM, #AVRTemp.SAP_PRODUCT_BUS_GROUP_CD, #AVRTemp.SAP_PROCURE_STRATEGY_CD, #AVRTemp.SAP_TECHNOLOGY_CD, #AVRTemp.SAP_COMMODITY_CD, #AVRTemp.SAP_PRODUCT_GROUP_CD
FROM #AVRTemp
WHERE NOT EXISTS(
SELECT *
FROM MaterialProdHier
WHERE MaterialProdHier.RowIdObject= #AVRTemp.ROWID_OBJECT)

DROP TABLE #AVRTemp', 
		@database_name=N'MDM', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Insert New Material Rows]    Script Date: 5/16/2017 10:20:10 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Insert New Material Rows', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SELECT *
INTO #AVRTemp
FROM OPENQUERY(AVR80,''SELECT *
FROM GOLDEN.C_BO_MATERIAL
WHERE (((CREATE_DATE) > SYSDATE-5))'')

USE MDM
GO

INSERT INTO Material
(
Material.AvnetLegacyPartId , Material.AvnetValueAddNo , Material.CcatsEncryptionRegNo , Material.CmDirtyInd , Material.ConsolidationInd , Material.CreateDate , Material.Creator , Material.CustomReelableFl , Material.DeletedBy , Material.DeletedDate , Material.DeletedInd , Material.DemoPartValueAm , Material.DimensionHeightQt , Material.DimensionLengthQt , Material.DimensionWidthQt , Material.DirtyInd , Material.EconomicProductionQt , Material.ExportControlClassNo , Material.FactoryStockAvailQt , Material.FccFl , Material.FdaFl , Material.GrossWeightQt , Material.HubStateInd , Material.InspectionTx , Material.InteractionId , Material.InventoryMessageTx , Material.ItarFl , Material.LastRowidSystem , Material.LastUpdateDate , Material.ManufactFamilyPartNo , Material.ManufacturerPartNo , Material.MaterialDs , Material.MaterialProdHierarchyId , Material.MaterialStatusDt , Material.MaterialSuppressSyndFl , Material.MdmActionCd , Material.MdmManufacturerPartyId , Material.MdmSmxqDeviationCd , Material.MdmUnspscCd , Material.MdmUsmlCd , Material.MdmWebCd , Material.MilitarySpecPartNo , Material.NetWeightQt , Material.PartDs , Material.ProcurementStrategy , Material.ProgrammableFl , Material.RenewableFl , Material.ReplacementPartNo , Material.ResyndFl , Material.RowidObject , Material.SapBaseUnitOfMsrCd , Material.SapDimUnitOfMeasureCd , Material.SapEcomStockStrategyCd , Material.SapExternalMatlGroup , Material.SapGreenCd , Material.SapJitCd , Material.SapLeadFreeCd , Material.SapMaterialGroupCd , Material.SapMaterialId , Material.SapMaterialStatusCd , Material.SapMaterialTypeCd , Material.SapMatGroupPackagingCd , Material.SapMatIndstrySectorCd , Material.SapMatItemCatgGroupCd , Material.SapOrderUnitOfMsureCd , Material.SapProductHierarchyCd , Material.SapPurchasingValueCd , Material.SapRohsCd , Material.SapScheduleBCd , Material.SapSerialNoLevelCd , Material.SapStorageConditionCd , Material.SapTlaTypeCd , Material.SapTransGroupCd , Material.SapVolUnitOfMeasureCd , Material.SapWstsCd , Material.SapWtUnitOfMeasureCd , Material.SendToSapFl , Material.SentToSapDate , Material.SignedLicAgrmntReqFl , Material.SizeDimensionsDs , Material.SoleSourceFl , Material.SupplierLastTimeBuyDt , Material.SupplierLastTimeRetDt , Material.SupplierLastTimeShipDt , Material.TaskRequesterEmail , Material.TradeComplianceNoteTx , Material.TransactablePartFl , Material.UpdatedBy , Material.ValueAddedFl , Material.VolumeQt , Material.WarrantyDurationMonthQt , Material.PackageQty
)
SELECT  #AVRTemp.AVNET_LEGACY_PART_ID, #AVRTemp.AVNET_VALUE_ADD_NO, #AVRTemp.CCATS_ENCRYPTION_REG_NO, #AVRTemp.CM_DIRTY_IND, #AVRTemp.CONSOLIDATION_IND, #AVRTemp.CREATE_DATE, #AVRTemp.CREATOR, #AVRTemp.CUSTOM_REELABLE_FL, #AVRTemp.DELETED_BY, #AVRTemp.DELETED_DATE, #AVRTemp.DELETED_IND, #AVRTemp.DEMO_PART_VALUE_AM, #AVRTemp.DIMENSION_HEIGHT_QT, #AVRTemp.DIMENSION_LENGTH_QT, #AVRTemp.DIMENSION_WIDTH_QT, #AVRTemp.DIRTY_IND, #AVRTemp.ECONOMIC_PRODUCTION_QT, #AVRTemp.EXPORT_CONTROL_CLASS_NO, #AVRTemp.FACTORY_STOCK_AVAIL_QT, #AVRTemp.FCC_FL, #AVRTemp.FDA_FL, #AVRTemp.GROSS_WEIGHT_QT, #AVRTemp.HUB_STATE_IND, #AVRTemp.INSPECTION_TX, #AVRTemp.INTERACTION_ID, #AVRTemp.INVENTORY_MESSAGE_TX, #AVRTemp.ITAR_FL, #AVRTemp.LAST_ROWID_SYSTEM, #AVRTemp.LAST_UPDATE_DATE, #AVRTemp.MANUFACT_FAMILY_PART_NO, #AVRTemp.MANUFACTURER_PART_NO, #AVRTemp.MATERIAL_DS, #AVRTemp.MATERIAL_PROD_HIERARCHY_ID, #AVRTemp.MATERIAL_STATUS_DT, #AVRTemp.MATERIAL_SUPPRESS_SYND_FL, #AVRTemp.MDM_ACTION_CD, #AVRTemp.MDM_MANUFACTURER_PARTY_ID, #AVRTemp.MDM_SMXQ_DEVIATION_CD, #AVRTemp.MDM_UNSPSC_CD, #AVRTemp.MDM_USML_CD, #AVRTemp.MDM_WEB_CD, #AVRTemp.MILITARY_SPEC_PART_NO, #AVRTemp.NET_WEIGHT_QT, #AVRTemp.PART_DS, #AVRTemp.PROCUREMENT_STRATEGY, #AVRTemp.PROGRAMMABLE_FL, #AVRTemp.RENEWABLE_FL, #AVRTemp.REPLACEMENT_PART_NO, #AVRTemp.RESYND_FL, #AVRTemp.ROWID_OBJECT, #AVRTemp.SAP_BASE_UNIT_OF_MSR_CD, #AVRTemp.SAP_DIM_UNIT_OF_MEASURE_CD, #AVRTemp.SAP_ECOM_STOCK_STRATEGY_CD, #AVRTemp.SAP_EXTERNAL_MATL_GROUP, #AVRTemp.SAP_GREEN_CD, #AVRTemp.SAP_JIT_CD, #AVRTemp.SAP_LEAD_FREE_CD, #AVRTemp.SAP_MATERIAL_GROUP_CD, #AVRTemp.SAP_MATERIAL_ID, #AVRTemp.SAP_MATERIAL_STATUS_CD, #AVRTemp.SAP_MATERIAL_TYPE_CD, #AVRTemp.SAP_MAT_GROUP_PACKAGING_CD, #AVRTemp.SAP_MAT_INDSTRY_SECTOR_CD, #AVRTemp.SAP_MAT_ITEM_CATG_GROUP_CD, #AVRTemp.SAP_ORDER_UNIT_OF_MSURE_CD, #AVRTemp.SAP_PRODUCT_HIERARCHY_CD, #AVRTemp.SAP_PURCHASING_VALUE_CD, #AVRTemp.SAP_ROHS_CD, #AVRTemp.SAP_SCHEDULE_B_CD, #AVRTemp.SAP_SERIAL_NO_LEVEL_CD, #AVRTemp.SAP_STORAGE_CONDITION_CD, #AVRTemp.SAP_TLA_TYPE_CD, #AVRTemp.SAP_TRANS_GROUP_CD, #AVRTemp.SAP_VOL_UNIT_OF_MEASURE_CD, #AVRTemp.SAP_WSTS_CD, #AVRTemp.SAP_WT_UNIT_OF_MEASURE_CD, #AVRTemp.SEND_TO_SAP_FL, #AVRTemp.SENT_TO_SAP_DATE, #AVRTemp.SIGNED_LIC_AGRMNT_REQ_FL, #AVRTemp.SIZE_DIMENSIONS_DS, #AVRTemp.SOLE_SOURCE_FL, #AVRTemp.SUPPLIER_LAST_TIME_BUY_DT, #AVRTemp.SUPPLIER_LAST_TIME_RET_DT, #AVRTemp.SUPPLIER_LAST_TIME_SHIP_DT, #AVRTemp.TASK_REQUESTER_EMAIL, #AVRTemp.TRADE_COMPLIANCE_NOTE_TX, #AVRTemp.TRANSACTABLE_PART_FL, #AVRTemp.UPDATED_BY, #AVRTemp.VALUE_ADDED_FL, #AVRTemp.VOLUME_QT, #AVRTemp.WARRANTY_DURATION_MONTH_QT, #AVRTemp.PACKAGE_QTY
FROM #AVRTemp
WHERE NOT EXISTS(
SELECT *
FROM Material
WHERE Material.RowIdObject= #AVRTemp.ROWID_OBJECT)

DROP TABLE #AVRTemp', 
		@database_name=N'MDM', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Inset New MatSalesOrg Rows]    Script Date: 5/16/2017 10:20:10 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Inset New MatSalesOrg Rows', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=1, 
		@retry_interval=1, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SELECT *
INTO #AVRTemp
FROM OPENQUERY(AVR80, ''SELECT *
FROM GOLDEN.C_BO_MATERIAL_SALES_ORG
WHERE (((CREATE_DATE) > SYSDATE-5))'')

USE MDM
GO

INSERT INTO MaterialSalesOrg
(
	MaterialSalesOrg.RowIdObject , MaterialSalesOrg.Creator , MaterialSalesOrg.CreateDate , MaterialSalesOrg.UpdatedBy , MaterialSalesOrg.LastUpdateDate , MaterialSalesOrg.ConsolidationInd , MaterialSalesOrg.DeletedInd , MaterialSalesOrg.DeletedBy , MaterialSalesOrg.DeletedDate , MaterialSalesOrg.LastRowIdSystem , MaterialSalesOrg.DirtyInd , MaterialSalesOrg.InteractionId , MaterialSalesOrg.HubStateInd , MaterialSalesOrg.CmDirtyInd , MaterialSalesOrg.MdmMaterialId , MaterialSalesOrg.SapSalesOrgCd , MaterialSalesOrg.SapCentralStockPlantCd , MaterialSalesOrg.SalesMinimumOrderQt , MaterialSalesOrg.SapDesignWinAvailCd , MaterialSalesOrg.SapMatlItemCatGroupCd , MaterialSalesOrg.SapMatlSplHandlingCd , MaterialSalesOrg.SapSmallOrderStratCd , MaterialSalesOrg.CustomProductFl , MaterialSalesOrg.NonCancelNonReturnFl , MaterialSalesOrg.SoftwareLicenseReqFl , MaterialSalesOrg.DesignWinEffFromDt , MaterialSalesOrg.DesignWinEffThruDt , MaterialSalesOrg.SapMatlPricingGroupCd , MaterialSalesOrg.DesignWinGrandfatherDt , MaterialSalesOrg.NonDisclosurAgrmtReqFl , MaterialSalesOrg.DualMarkingFl , MaterialSalesOrg.SalesMessageTx , MaterialSalesOrg.SapStockingProfileCd , MaterialSalesOrg.WaiverRequiredFl , MaterialSalesOrg.SapDistributionChnlCd , MaterialSalesOrg.LiquidationAllowedFl , MaterialSalesOrg.SapSalesUnitOfMsrCd , MaterialSalesOrg.SapMatlSalesDistStsCd , MaterialSalesOrg.MinimumDeliveryQt , MaterialSalesOrg.MatlSalesDistStsEffDt , MaterialSalesOrg.SapElectroStaticDisCd , MaterialSalesOrg.DownloadableFl , MaterialSalesOrg.GlobalInventEligibleFl , MaterialSalesOrg.NaftaFl , MaterialSalesOrg.ExistsWithinSapFl , MaterialSalesOrg.MdmExportSourceCd , MaterialSalesOrg.DeliveryUnitQt , MaterialSalesOrg.SapMatlAcctAssnGrpCd , MaterialSalesOrg.MaterialProdHierarchyId , MaterialSalesOrg.MdmPriceRefMaterialId , MaterialSalesOrg.SapProductHierarchyCd , MaterialSalesOrg.MdmPriceRefMatlRowId
)
SELECT  #AVRTemp.ROWID_OBJECT, #AVRTemp.CREATOR, #AVRTemp.CREATE_DATE, #AVRTemp.UPDATED_BY, #AVRTemp.LAST_UPDATE_DATE, #AVRTemp.CONSOLIDATION_IND, #AVRTemp.DELETED_IND, #AVRTemp.DELETED_BY, #AVRTemp.DELETED_DATE, #AVRTemp.LAST_ROWID_SYSTEM, #AVRTemp.DIRTY_IND, #AVRTemp.INTERACTION_ID, #AVRTemp.HUB_STATE_IND, #AVRTemp.CM_DIRTY_IND, #AVRTemp.MDM_MATERIAL_ID, #AVRTemp.SAP_SALES_ORG_CD, #AVRTemp.SAP_CENTRAL_STOCK_PLANT_CD, #AVRTemp.SALES_MINIMUM_ORDER_QT, #AVRTemp.SAP_DESIGN_WIN_AVAIL_CD, #AVRTemp.SAP_MATL_ITEM_CAT_GROUP_CD, #AVRTemp.SAP_MATL_SPL_HANDLING_CD, #AVRTemp.SAP_SMALL_ORDER_STRAT_CD, #AVRTemp.CUSTOM_PRODUCT_FL, #AVRTemp.NON_CANCEL_NON_RETURN_FL, #AVRTemp.SOFTWARE_LICENSE_REQ_FL, #AVRTemp.DESIGN_WIN_EFF_FROM_DT, #AVRTemp.DESIGN_WIN_EFF_THRU_DT, #AVRTemp.SAP_MATL_PRICING_GROUP_CD, #AVRTemp.DESIGN_WIN_GRANDFATHER_DT, #AVRTemp.NON_DISCLOSUR_AGRMT_REQ_FL, #AVRTemp.DUAL_MARKING_FL, #AVRTemp.SALES_MESSAGE_TX, #AVRTemp.SAP_STOCKING_PROFILE_CD, #AVRTemp.WAIVER_REQUIRED_FL, #AVRTemp.SAP_DISTRIBUTION_CHNL_CD, #AVRTemp.LIQUIDATION_ALLOWED_FL, #AVRTemp.SAP_SALES_UNIT_OF_MSR_CD, #AVRTemp.SAP_MATL_SALES_DIST_STS_CD, #AVRTemp.MINIMUM_DELIVERY_QT, #AVRTemp.MATL_SALES_DIST_STS_EFF_DT, #AVRTemp.SAP_ELECTRO_STATIC_DIS_CD, #AVRTemp.DOWNLOADABLE_FL, #AVRTemp.GLOBAL_INVENT_ELIGIBLE_FL, #AVRTemp.NAFTA_FL, #AVRTemp.EXISTS_WITHIN_SAP_FL, #AVRTemp.MDM_EXPORT_SOURCE_CD, #AVRTemp.DELIVERY_UNIT_QT, #AVRTemp.SAP_MATL_ACCT_ASSN_GRP_CD, #AVRTemp.MATERIAL_PROD_HIERARCHY_ID, #AVRTemp.MDM_PRICE_REF_MATERIAL_ID, #AVRTemp.SAP_PRODUCT_HIERARCHY_CD, #AVRTemp.MDM_PRICE_REF_MATL_ROWID
FROM #AVRTemp
WHERE NOT EXISTS(
SELECT *
FROM MaterialSalesOrg
WHERE MaterialSalesOrg.RowidObject = #AVRTemp.ROWID_OBJECT)

DROP TABLE #AVRTemp
', 
		@database_name=N'MDM', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Insert New MaterialPlant Rows]    Script Date: 5/16/2017 10:20:10 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Insert New MaterialPlant Rows', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SELECT *
INTO #AVRTemp
FROM OPENQUERY(AVR80, ''SELECT *
FROM GOLDEN.C_BO_MATERIAL_PLANT
WHERE (((CREATE_DATE) > SYSDATE-5))'')

USE MDM
GO

INSERT INTO MaterialPlant
(
	MaterialPlant.RowidObject , MaterialPlant.Creator , MaterialPlant.CreateDate , MaterialPlant.UpdatedBy , MaterialPlant.LastUpdateDate , MaterialPlant.ConsolidationInd , MaterialPlant.DeletedInd , MaterialPlant.DeletedBy , MaterialPlant.DeletedDate , MaterialPlant.LastRowidSystem , MaterialPlant.DirtyInd , MaterialPlant.InteractionId , MaterialPlant.HubStateInd , MaterialPlant.CmDirtyInd , MaterialPlant.MdmMaterialId , MaterialPlant.SapPlantCd , MaterialPlant.SapAvailCheckGroupCd , MaterialPlant.SapMaterialStatusCd , MaterialPlant.MaterialStatusDt , MaterialPlant.MaximumLotSizeQt , MaterialPlant.SapProcurementTypeCd , MaterialPlant.AbcCd , MaterialPlant.MilitaryPartFl , MaterialPlant.PlannedDeliveryDayQt , MaterialPlant.InventoryMessageTx , MaterialPlant.SapSupplierMatAbcCd , MaterialPlant.BatchManagementReqFl , MaterialPlant.BuildDayQt , MaterialPlant.TotalReplenLeadDayQt , MaterialPlant.SerialNumberProfileFl , MaterialPlant.BatchManagementFl , MaterialPlant.SapHtsCd , MaterialPlant.AutoPoAllowedFl , MaterialPlant.SapPurchasingGroupCd , MaterialPlant.UnlimitedOvrDlvAllowFl , MaterialPlant.GoodsRecptProcessDayQt , MaterialPlant.SapMrpTypeCd , MaterialPlant.PlanningTimeFenceDayQt , MaterialPlant.SafetyStockQt , MaterialPlant.MinimumLotSizeQt , MaterialPlant.FixedLotSizeQt , MaterialPlant.SapMrpLotSizeCd , MaterialPlant.ManualSupplLeadDayQt , MaterialPlant.SapPeriodCd , MaterialPlant.CycleCountFixedFl , MaterialPlant.SapOriginatingCountryCd , MaterialPlant.VendorEdiLeadDayQt , MaterialPlant.RunRateQt , MaterialPlant.SupplyDayQt , MaterialPlant.SuppCancelWindowDayQt , MaterialPlant.EncryptionPartFl , MaterialPlant.SapStockingProfile , MaterialPlant.SapReplacementPartCd , MaterialPlant.SapLoadingGroupCd , MaterialPlant.SourceListRequiredFl , MaterialPlant.SapFiscalYearVariantCd , MaterialPlant.SapIndCollectReqdCd , MaterialPlant.SapForecastModelCd , MaterialPlant.SapValuationCategoryCd , MaterialPlant.SapMixedMrpCd , MaterialPlant.SapProfitCenter , MaterialPlant.RoundingValueNo , MaterialPlant.SapSpecialProcureTypCd , MaterialPlant.SapMrpGroupCd , MaterialPlant.SapIssuePlntStrLocCd , MaterialPlant.SapExtPrcPltStrLocCd , MaterialPlant.SapProductionSchedCd , MaterialPlant.SapCycleCountPhyInvCd , MaterialPlant.SapPlanningCycleCd , MaterialPlant.SapMrpControllerCd , MaterialPlant.SapSchedulingFloatsCd , MaterialPlant.LeadTimeOverrideFl , MaterialPlant.PriceBookEdiLtDt
)
SELECT  #AVRTemp.ROWID_OBJECT, #AVRTemp.CREATOR, #AVRTemp.CREATE_DATE, #AVRTemp.UPDATED_BY, #AVRTemp.LAST_UPDATE_DATE, #AVRTemp.CONSOLIDATION_IND, #AVRTemp.DELETED_IND, #AVRTemp.DELETED_BY, #AVRTemp.DELETED_DATE, #AVRTemp.LAST_ROWID_SYSTEM, #AVRTemp.DIRTY_IND, #AVRTemp.INTERACTION_ID, #AVRTemp.HUB_STATE_IND, #AVRTemp.CM_DIRTY_IND, #AVRTemp.MDM_MATERIAL_ID, #AVRTemp.SAP_PLANT_CD, #AVRTemp.SAP_AVAIL_CHECK_GROUP_CD, #AVRTemp.SAP_MATERIAL_STATUS_CD, #AVRTemp.MATERIAL_STATUS_DT, #AVRTemp.MAXIMUM_LOT_SIZE_QT, #AVRTemp.SAP_PROCUREMENT_TYPE_CD, #AVRTemp.ABC_CD, #AVRTemp.MILITARY_PART_FL, #AVRTemp.PLANNED_DELIVERY_DAY_QT, #AVRTemp.INVENTORY_MESSAGE_TX, #AVRTemp.SAP_SUPPLIER_MAT_ABC_CD, #AVRTemp.BATCH_MANAGEMENT_REQ_FL, #AVRTemp.BUILD_DAY_QT, #AVRTemp.TOTAL_REPLEN_LEAD_DAY_QT, #AVRTemp.SERIAL_NUMBER_PROFILE_FL, #AVRTemp.BATCH_MANAGEMENT_FL, #AVRTemp.SAP_HTS_CD, #AVRTemp.AUTO_PO_ALLOWED_FL, #AVRTemp.SAP_PURCHASING_GROUP_CD, #AVRTemp.UNLIMITED_OVR_DLV_ALLOW_FL, #AVRTemp.GOODS_RECPT_PROCESS_DAY_QT, #AVRTemp.SAP_MRP_TYPE_CD, #AVRTemp.PLANNING_TIME_FENCE_DAY_QT, #AVRTemp.SAFETY_STOCK_QT, #AVRTemp.MINIMUM_LOT_SIZE_QT, #AVRTemp.FIXED_LOT_SIZE_QT, #AVRTemp.SAP_MRP_LOT_SIZE_CD, #AVRTemp.MANUAL_SUPPL_LEAD_DAY_QT, #AVRTemp.SAP_PERIOD_CD, #AVRTemp.CYCLE_COUNT_FIXED_FL, #AVRTemp.SAP_ORIGINATING_COUNTRY_CD, #AVRTemp.VENDOR_EDI_LEAD_DAY_QT, #AVRTemp.RUN_RATE_QT, #AVRTemp.SUPPLY_DAY_QT, #AVRTemp.SUPP_CANCEL_WINDOW_DAY_QT, #AVRTemp.ENCRYPTION_PART_FL, #AVRTemp.SAP_STOCKING_PROFILE, #AVRTemp.SAP_REPLACEMENT_PART_CD, #AVRTemp.SAP_LOADING_GROUP_CD, #AVRTemp.SOURCE_LIST_REQUIRED_FL, #AVRTemp.SAP_FISCAL_YEAR_VARIANT_CD, #AVRTemp.SAP_IND_COLLECT_REQD_CD, #AVRTemp.SAP_FORECAST_MODEL_CD, #AVRTemp.SAP_VALUATION_CATEGORY_CD, #AVRTemp.SAP_MIXED_MRP_CD, #AVRTemp.SAP_PROFIT_CENTER, #AVRTemp.ROUNDING_VALUE_NO, #AVRTemp.SAP_SPECIAL_PROCURE_TYP_CD, #AVRTemp.SAP_MRP_GROUP_CD, #AVRTemp.SAP_ISSUE_PLNT_STR_LOC_CD, #AVRTemp.SAP_EXT_PRC_PLT_STR_LOC_CD, #AVRTemp.SAP_PRODUCTION_SCHED_CD, #AVRTemp.SAP_CYCLE_COUNT_PHY_INV_CD, #AVRTemp.SAP_PLANNING_CYCLE_CD, #AVRTemp.SAP_MRP_CONTROLLER_CD, #AVRTemp.SAP_SCHEDULING_FLOATS_CD, #AVRTemp.LEAD_TIME_OVERRIDE_FL, #AVRTemp.PRICE_BOOK_EDI_LT_DT
FROM #AVRTemp
WHERE NOT EXISTS(
SELECT *
FROM MaterialPlant
WHERE MaterialPlant.RowidObject = #AVRTemp.ROWID_OBJECT)

DROP TABLE #AVRTemp
', 
		@database_name=N'MDM', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Insert New Party]    Script Date: 5/16/2017 10:20:10 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Insert New Party', 
		@step_id=6, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SELECT *
INTO #AVRTemp
FROM OPENQUERY(AVR80, ''SELECT *
FROM GOLDEN.C_BO_PARTY
WHERE (((CREATE_DATE) > SYSDATE-5))'')

INSERT INTO Party
(
	Party.RowidObject , Party.Creator , Party.CreateDate , Party.UpdatedBy , Party.LastUpdateDate , Party.ConsolidationInd , Party.DeletedInd , Party.DeletedBy , Party.DeletedDate , Party.LastRowidSystem , Party.DirtyInd , Party.InteractionId , Party.HubStateInd , Party.CmDirtyInd , Party.SapCustAcctGroupCd , Party.SearchTermTx01 , Party.SapCreateDt , Party.SapBillBlockReasonCd , Party.SapDelivBlockReasonCd , Party.SapTaxJurisdictionCd , Party.AnnualSalesAm , Party.AnnualSalesYr , Party.SapFiscalYearVariantCd , Party.SapSalesBlockReasonCd , Party.DeactivationFl , Party.SapDeactivationReasonCd , Party.SapCustomerPartyTypeCd , Party.AvnetLogoPrintFl , Party.InsuranceChargeFl , Party.SapFuelSurchargeCd , Party.SapHandlingChargeCd , Party.VertexNo , Party.SapAltCountryNameCd , Party.SapHazmatCd , Party.HpVarNo , Party.IbmCustomerContractNo , Party.SapDeniedPartyStatusCd , Party.DeniedPartyStatusDt , Party.ItarRestrictedFl , Party.ForeignGovernmentFl , Party.SapCustGrowthTypeCd , Party.CustomerSinceDt , Party.RelatedPartyFl , Party.SmallDisadvantagedBusFl , Party.SapCustomerUserTypeCd , Party.SapRoutedCustomerCd , Party.SapDutyTaxLocationCd , Party.DutyTaxCarrierAcctNo , Party.PlantShutdownStartDt , Party.PlantShutdownEndDt , Party.SoldToCreateDt , Party.SapShipTypeCd , Party.SapCustomerEndUseCd , Party.SapRemoteRegionCd , Party.RemoteRegionSapAccNo , Party.SapRemoteDivisionCd , Party.StmtOfAssureOrigAttDt , Party.CustBusPlanExistsFl , Party.SapRiskClassCd , Party.MdmPriPartyRoleTypeCd , Party.SapPartyId , Party.SapPartyNm01 , Party.SapPartyNm02 , Party.SapPartyNm03 , Party.SapPartyNm04 , Party.SapBusPtnerFuncCd , Party.MdmPartyNm , Party.BoClassCode , Party.ShipToRowid , Party.CentralPurchBlockFl , Party.SapLanguageCd , Party.SapDmndCreatClsCd , Party.SapCustAddrSrcCd , Party.ImportTaxId , Party.ExportTaxId , Party.SapDndPtyDuplSuggCd , Party.SapTitleCd , Party.SapCommunicationTypeCd , Party.SearchTermTx02 , Party.VendorNoteTx , Party.ContactDescription , Party.CrmContactId , Party.ContactFirstNm , Party.ContactLastNm , Party.LegacyContactId , Party.ContactNickNm , Party.SapContactCdFk , Party.SapContactVipCdFk , Party.JobTitleTx , Party.SapVendorAcctGroupCd , Party.SapBlockFuncReasonCd , Party.PartySubRoleTypCd , Party.SapContactVipCd , Party.SapContactFunctionCd , Party.InSapFl , Party.ManualConsolidatinInd , Party.SapAnnualSalesCurrCd , Party.LegacySourceSystem , Party.TaxExemptionFl , Party.DeactivationDate
)
SELECT  #AVRTemp.ROWID_OBJECT, #AVRTemp.CREATOR, #AVRTemp.CREATE_DATE, #AVRTemp.UPDATED_BY, #AVRTemp.LAST_UPDATE_DATE, #AVRTemp.CONSOLIDATION_IND, #AVRTemp.DELETED_IND, #AVRTemp.DELETED_BY, #AVRTemp.DELETED_DATE, #AVRTemp.LAST_ROWID_SYSTEM, #AVRTemp.DIRTY_IND, #AVRTemp.INTERACTION_ID, #AVRTemp.HUB_STATE_IND, #AVRTemp.CM_DIRTY_IND, #AVRTemp.SAP_CUST_ACCT_GROUP_CD, #AVRTemp.SEARCH_TERM_TX_01, #AVRTemp.SAP_CREATE_DT, #AVRTemp.SAP_BILL_BLOCK_REASON_CD, #AVRTemp.SAP_DELIV_BLOCK_REASON_CD, #AVRTemp.SAP_TAX_JURISDICTION_CD, #AVRTemp.ANNUAL_SALES_AM, #AVRTemp.ANNUAL_SALES_YR, #AVRTemp.SAP_FISCAL_YEAR_VARIANT_CD, #AVRTemp.SAP_SALES_BLOCK_REASON_CD, #AVRTemp.DEACTIVATION_FL, #AVRTemp.SAP_DEACTIVATION_REASON_CD, #AVRTemp.SAP_CUSTOMER_PARTY_TYPE_CD, #AVRTemp.AVNET_LOGO_PRINT_FL, #AVRTemp.INSURANCE_CHARGE_FL, #AVRTemp.SAP_FUEL_SURCHARGE_CD, #AVRTemp.SAP_HANDLING_CHARGE_CD, #AVRTemp.VERTEX_NO, #AVRTemp.SAP_ALT_COUNTRY_NAME_CD, #AVRTemp.SAP_HAZMAT_CD, #AVRTemp.HP_VAR_NO, #AVRTemp.IBM_CUSTOMER_CONTRACT_NO, #AVRTemp.SAP_DENIED_PARTY_STATUS_CD, #AVRTemp.DENIED_PARTY_STATUS_DT, #AVRTemp.ITAR_RESTRICTED_FL, #AVRTemp.FOREIGN_GOVERNMENT_FL, #AVRTemp.SAP_CUST_GROWTH_TYPE_CD, #AVRTemp.CUSTOMER_SINCE_DT, #AVRTemp.RELATED_PARTY_FL, #AVRTemp.SMALL_DISADVANTAGED_BUS_FL, #AVRTemp.SAP_CUSTOMER_USER_TYPE_CD, #AVRTemp.SAP_ROUTED_CUSTOMER_CD, #AVRTemp.SAP_DUTY_TAX_LOCATION_CD, #AVRTemp.DUTY_TAX_CARRIER_ACCT_NO, #AVRTemp.PLANT_SHUTDOWN_START_DT, #AVRTemp.PLANT_SHUTDOWN_END_DT, #AVRTemp.SOLD_TO_CREATE_DT, #AVRTemp.SAP_SHIP_TYPE_CD, #AVRTemp.SAP_CUSTOMER_END_USE_CD, #AVRTemp.SAP_REMOTE_REGION_CD, #AVRTemp.REMOTE_REGION_SAP_ACC_NO, #AVRTemp.SAP_REMOTE_DIVISION_CD, #AVRTemp.STMT_OF_ASSURE_ORIG_ATT_DT, #AVRTemp.CUST_BUS_PLAN_EXISTS_FL, #AVRTemp.SAP_RISK_CLASS_CD, #AVRTemp.MDM_PRI_PARTY_ROLE_TYPE_CD, #AVRTemp.SAP_PARTY_ID, #AVRTemp.SAP_PARTY_NM_01, #AVRTemp.SAP_PARTY_NM_02, #AVRTemp.SAP_PARTY_NM_03, #AVRTemp.SAP_PARTY_NM_04, #AVRTemp.SAP_BUS_PTNER_FUNC_CD, #AVRTemp.MDM_PARTY_NM, #AVRTemp.BO_CLASS_CODE, #AVRTemp.SHIP_TO_ROWID, #AVRTemp.CENTRAL_PURCH_BLOCK_FL, #AVRTemp.SAP_LANGUAGE_CD, #AVRTemp.SAP_DMND_CREAT_CLS_CD, #AVRTemp.SAP_CUST_ADDR_SRC_CD, #AVRTemp.IMPORT_TAX_ID, #AVRTemp.EXPORT_TAX_ID, #AVRTemp.SAP__DND_PTY_DUPL_SUGG_CD, #AVRTemp.SAP_TITLE_CD, #AVRTemp.SAP_COMMUNICATION_TYPE_CD, #AVRTemp.SEARCH_TERM_TX_02, #AVRTemp.VENDOR_NOTE_TX, #AVRTemp.CONTACT_DESCRIPTION, #AVRTemp.CRM_CONTACT_ID, #AVRTemp.CONTACT_FIRST_NM, #AVRTemp.CONTACT_LAST_NM, #AVRTemp.LEGACY_CONTACT_ID, #AVRTemp.CONTACT_NICK_NM, #AVRTemp.SAP_CONTACT_CD_FK, #AVRTemp.SAP_CONTACT_VIP_CD_FK, #AVRTemp.JOB_TITLE_TX, #AVRTemp.SAP_VENDOR_ACCT_GROUP_CD, #AVRTemp.SAP_BLOCK_FUNC_REASON_CD, #AVRTemp.PARTY_SUB_ROLE_TYP_CD, #AVRTemp.SAP_CONTACT_VIP_CD, #AVRTemp.SAP_CONTACT_FUNCTION_CD, #AVRTemp.IN_SAP_FL, #AVRTemp.MANUAL_CONSOLIDATIN_IND, #AVRTemp.SAP_ANNUAL_SALES_CURR_CD, #AVRTemp.LEGACY_SOURCE_SYSTEM, #AVRTemp.TAX_EXEMPTION_FL, #AVRTemp.DEACTIVATION_DATE
FROM #AVRTemp
WHERE NOT EXISTS(
SELECT *
FROM Party
WHERE Party.RowidObject = #AVRTemp.ROWID_OBJECT)

DROP TABLE #AVRTemp', 
		@database_name=N'MDM', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Insert New Rows VenMatRel]    Script Date: 5/16/2017 10:20:10 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Insert New Rows VenMatRel', 
		@step_id=7, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SELECT *
INTO #AVRTemp
FROM OPENQUERY(AVR80,''SELECT *
FROM GOLDEN.C_VENDOR_MATERIAL_REL
WHERE (((CREATE_DATE) > SYSDATE-5))'')

INSERT INTO VendorMaterialRel (VendorMaterialRel.RowIdObject , VendorMaterialRel.Creator , VendorMaterialRel.CreateDate , VendorMaterialRel.UpdateBy , VendorMaterialRel.LastUpdateDate , VendorMaterialRel.ConsolidationInd , VendorMaterialRel.DeleteInd , VendorMaterialRel.DeleteBy , VendorMaterialRel.DeleteDate , VendorMaterialRel.LastRowIdSystem , VendorMaterialRel.DirtyInd , VendorMaterialRel.InteractionId , VendorMaterialRel.HubStateInd , VendorMaterialRel.CMDirtyInd , VendorMaterialRel.MDMMaterialID , VendorMaterialRel.MDMVendorPartyId , VendorMaterialRel.VendorPartNo)

SELECT   #AVRTemp.ROWID_OBJECT, #AVRTemp.CREATOR, #AVRTemp.CREATE_DATE, #AVRTemp.UPDATED_BY, #AVRTemp.LAST_UPDATE_DATE, #AVRTemp.CONSOLIDATION_IND, #AVRTemp.DELETED_IND, #AVRTemp.DELETED_BY, #AVRTemp.DELETED_DATE, #AVRTemp.LAST_ROWID_SYSTEM, #AVRTemp.DIRTY_IND, #AVRTemp.INTERACTION_ID, #AVRTemp.HUB_STATE_IND, #AVRTemp.CM_DIRTY_IND, #AVRTemp.MDM_MATERIAL_ID, #AVRTemp.MDM_VENDOR_PARTY_ID, #AVRTemp.VENDOR_PART_NO
FROM #AVRTemp
WHERE NOT EXISTS(
SELECT *
FROM VendorMaterialRel
WHERE VendorMaterialRel.RowIdObject= #AVRTemp.ROWID_OBJECT)

DROP TABLE #AVRTemp


', 
		@database_name=N'MDM', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Insert New Rows VenMatPurOrgPlant]    Script Date: 5/16/2017 10:20:10 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Insert New Rows VenMatPurOrgPlant', 
		@step_id=8, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SELECT *
INTO #AVRTemp
FROM OPENQUERY(AVR80,''SELECT *
FROM GOLDEN.C_BO_VND_MT_PUR_ORG_PLNT
WHERE (((CREATE_DATE) > SYSDATE-5))'')

INSERT INTO VendMatPurOrgPlant (VendMatPurOrgPlant.RowIdObject , VendMatPurOrgPlant.Creator , VendMatPurOrgPlant.CreateDate , VendMatPurOrgPlant.UpdatedBy , VendMatPurOrgPlant.LastUpdateDate , VendMatPurOrgPlant.CondsolidationInd , VendMatPurOrgPlant.DeletedInd , VendMatPurOrgPlant.DeletedBy , VendMatPurOrgPlant.DeletedDate , VendMatPurOrgPlant.LastRowIdSystem , VendMatPurOrgPlant.DirtyInd , VendMatPurOrgPlant.InteractionId , VendMatPurOrgPlant.HubStateInd , VendMatPurOrgPlant.CMDirtyInd , VendMatPurOrgPlant.SAPPurchasingOrgCD , VendMatPurOrgPlant.SAPPlantCD , VendMatPurOrgPlant.PriceProtectEligibleFL , VendMatPurOrgPlant.SupplierMinPackageQt , VendMatPurOrgPlant.SupplierMinOrderQt , VendMatPurOrgPlant.MDMVendorMaterialId , VendMatPurOrgPlant.SAPPirCategoryDc)
SELECT  #AVRTemp.ROWID_OBJECT, #AVRTemp.CREATOR, #AVRTemp.CREATE_DATE, #AVRTemp.UPDATED_BY, #AVRTemp.LAST_UPDATE_DATE, #AVRTemp.CONSOLIDATION_IND, #AVRTemp.DELETED_IND, #AVRTemp.DELETED_BY, #AVRTemp.DELETED_DATE, #AVRTemp.LAST_ROWID_SYSTEM, #AVRTemp.DIRTY_IND, #AVRTemp.INTERACTION_ID, #AVRTemp.HUB_STATE_IND, #AVRTemp.CM_DIRTY_IND, #AVRTemp.SAP_PURCHASING_ORG_CD, #AVRTemp.SAP_PLANT_CD, #AVRTemp.PRICE_PROTECT_ELIGIBLE_FL, #AVRTemp.SUPPLIER_MIN_PACKAGE_QT, #AVRTemp.SUPPLIER_MIN_ORDER_QT, #AVRTemp.MDM_VENDOR_MATERIAL_ID, #AVRTemp.SAP_PIR_CATEGORY_CD
FROM #AVRTemp
WHERE NOT EXISTS(
SELECT *
FROM VendMatPurOrgPlant
WHERE VendMatPurOrgPlant.RowIdObject= #AVRTemp.ROWID_OBJECT)

DROP TABLE #AVRTemp', 
		@database_name=N'MDM', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Insert New Rows Condition Header]    Script Date: 5/16/2017 10:20:10 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Insert New Rows Condition Header', 
		@step_id=9, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SELECT *
INTO #AVRTemp
FROM OPENQUERY(AVR80,''SELECT *
FROM GOLDEN.C_BO_CONDITION_HEADER
WHERE (((CREATE_DATE) > SYSDATE-5))'')

INSERT INTO ConditionHeader 
(
	ConditionHeader.RowIdObject , ConditionHeader.Creator , ConditionHeader.CreateDate , ConditionHeader.UpdateBy , ConditionHeader.LastUpdateDate , ConditionHeader.ConsolidationInd , ConditionHeader.DeletionInd , ConditionHeader.DeletedBy , ConditionHeader.DeletedDate , ConditionHeader.LastRowIdSystem , ConditionHeader.DirtyInd , ConditionHeader.InteractionId , ConditionHeader.HubStateInd , ConditionHeader.CMDirtyInd , ConditionHeader.ConditionRecordNo , ConditionHeader.ValidFromDt , ConditionHeader.ValidToDt , ConditionHeader.SAPConditionTypeCode , ConditionHeader.MDMVendMatlPoPlantId
)
SELECT  #AVRTemp.ROWID_OBJECT, #AVRTemp.CREATOR, #AVRTemp.CREATE_DATE, #AVRTemp.UPDATED_BY, #AVRTemp.LAST_UPDATE_DATE, #AVRTemp.CONSOLIDATION_IND, #AVRTemp.DELETED_IND, #AVRTemp.DELETED_BY, #AVRTemp.DELETED_DATE, #AVRTemp.LAST_ROWID_SYSTEM, #AVRTemp.DIRTY_IND, #AVRTemp.INTERACTION_ID, #AVRTemp.HUB_STATE_IND, #AVRTemp.CM_DIRTY_IND, #AVRTemp.CONDITION_RECORD_NO, #AVRTemp.VALID_FROM_DT, #AVRTemp.VALID_TO_DT, #AVRTemp.SAP_CONDITION_TYPE_CODE, #AVRTemp.MDM_VEND_MATL_PO_PLANT_ID
FROM #AVRTemp
WHERE NOT EXISTS(
SELECT *
FROM ConditionHeader
WHERE ConditionHeader.RowIdObject= #AVRTemp.ROWID_OBJECT)

DROP TABLE #AVRTemp', 
		@database_name=N'MDM', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Insert New Rows Condition Item]    Script Date: 5/16/2017 10:20:10 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Insert New Rows Condition Item', 
		@step_id=10, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SELECT *
INTO #AVRTemp
FROM OPENQUERY(AVR80,''SELECT *
FROM GOLDEN.C_BO_CONDITION_ITEM
WHERE (((CREATE_DATE) > SYSDATE-5))'')

INSERT INTO ConditionItem 
(
	ConditionItem.RowIdObject , ConditionItem.Creator , ConditionItem.CreateDate , ConditionItem.UpdatedBy , ConditionItem.LastUpdateDate , ConditionItem.ConditionIdn , ConditionItem.DeletedInd , ConditionItem.DeletedBy , ConditionItem.DeletedDate , ConditionItem.LastRowIdSystem , ConditionItem.DirtyInd , ConditionItem.InteractionId , ConditionItem.HubStateInd , ConditionItem.CMDirtyInd , ConditionItem.ConditionAM , ConditionItem.ConditionSqNo , ConditionItem.MinConditionQt , ConditionItem.MaxConditionQt , ConditionItem.SAPCurrencyCode , ConditionItem.MDMConditionHeaderId , ConditionItem.ConditionPricingUnitQt , ConditionItem.SAPConditionScaleUomCD , ConditionItem.SAPConditionTypeCD
)
SELECT  #AVRTemp.ROWID_OBJECT, #AVRTemp.CREATOR, #AVRTemp.CREATE_DATE, #AVRTemp.UPDATED_BY, #AVRTemp.LAST_UPDATE_DATE, #AVRTemp.CONSOLIDATION_IND, #AVRTemp.DELETED_IND, #AVRTemp.DELETED_BY, #AVRTemp.DELETED_DATE, #AVRTemp.LAST_ROWID_SYSTEM, #AVRTemp.DIRTY_IND, #AVRTemp.INTERACTION_ID, #AVRTemp.HUB_STATE_IND, #AVRTemp.CM_DIRTY_IND, #AVRTemp.CONDITION_AM, #AVRTemp.CONDITION_SQ_NO, #AVRTemp.MIN_CONDITION_QT, #AVRTemp.MAX_CONDITION_QT, #AVRTemp.SAP_CURRENCY_CODE, #AVRTemp.MDM_CONDITION_HEADER_ID, #AVRTemp.CONDITION_PRICING_UNIT_QT, #AVRTemp.SAP_CONDITION_SCALE_UOM_CD, #AVRTemp.SAP_CONDITION_TYPE_CD
FROM #AVRTemp
WHERE NOT EXISTS(
SELECT *
FROM ConditionItem
WHERE ConditionItem.RowIdObject= #AVRTemp.ROWID_OBJECT)

DROP TABLE #AVRTemp', 
		@database_name=N'MDM', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'MDM Insert', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20170220, 
		@active_end_date=99991231, 
		@active_start_time=30000, 
		@active_end_time=235959, 
		@schedule_uid=N'd38877ad-0f8c-4121-b9f5-fc3df329b16f'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


