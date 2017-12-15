USE [msdb]
GO

/****** Object:  Job [MdmRowUpdates]    Script Date: 5/16/2017 10:40:24 AM ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'829519b7-0d03-4aa1-a117-52b213fbfd72', @delete_unused_schedule=1
GO

/****** Object:  Job [MdmRowUpdates]    Script Date: 5/16/2017 10:40:24 AM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Data Collector]    Script Date: 5/16/2017 10:40:24 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Data Collector' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Data Collector'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'MdmRowUpdates', 
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
/****** Object:  Step [DBAIsPrimary]    Script Date: 5/16/2017 10:40:25 AM ******/
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
/****** Object:  Step [Update MatProdHier]    Script Date: 5/16/2017 10:40:25 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update MatProdHier', 
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
FROM OPENQUERY(AVR80,''SELECT *
FROM GOLDEN.C_BO_MATL_PROD_HIERARCHY
WHERE (((LAST_UPDATE_DATE) > SYSDATE-5))'')
Go


DECLARE @MDMtbl AS NVARCHAR(MAX)

SET @MDMtbl = ''MaterialProdHier''

UPDATE MaterialProdHier
SET
MaterialProdHier.RowIdObject = #AVRTemp.ROWID_OBJECT,
MaterialProdHier.Creator = #AVRTemp.CREATOR,
MaterialProdHier.CreateDate = #AVRTemp.CREATE_DATE,
MaterialProdHier.UpdatedBy = #AVRTemp.UPDATED_BY,
MaterialProdHier.LastUpdateDate = #AVRTemp.LAST_UPDATE_DATE,
MaterialProdHier.ConsolidationInd = #AVRTemp.CONSOLIDATION_IND,
MaterialProdHier.DeletedInd = #AVRTemp.DELETED_IND,
MaterialProdHier.DeletedBy = #AVRTemp.DELETED_BY,
MaterialProdHier.DeletedDate = #AVRTemp.DELETED_DATE,
MaterialProdHier.LastRowidSystem = #AVRTemp.LAST_ROWID_SYSTEM,
MaterialProdHier.DirtyInd = #AVRTemp.DIRTY_IND,
MaterialProdHier.InteractionId = #AVRTemp.INTERACTION_ID,
MaterialProdHier.HubStateInd = #AVRTemp.HUB_STATE_IND,
MaterialProdHier.CmDirtyInd = #AVRTemp.CM_DIRTY_IND,
MaterialProdHier.ProductHierarchyCode = #AVRTemp.PRODUCT_HIERARCHY_CODE,
MaterialProdHier.SapMatlProdHierNm = #AVRTemp.SAP_MATL_PROD_HIER_NM,
MaterialProdHier.SapProductBusGroupCd = #AVRTemp.SAP_PRODUCT_BUS_GROUP_CD,
MaterialProdHier.SapProcureStrategyCd = #AVRTemp.SAP_PROCURE_STRATEGY_CD,
MaterialProdHier.SapTechnologyCd = #AVRTemp.SAP_TECHNOLOGY_CD,
MaterialProdHier.SapCommodityCd = #AVRTemp.SAP_COMMODITY_CD,
MaterialProdHier.SapProductGroupCd = #AVRTemp.SAP_PRODUCT_GROUP_CD
FROM #AVRTemp
INNER JOIN MaterialProdHier
ON #AVRTemp.ROWID_OBJECT = MaterialProdHier.RowidObject
WHERE MaterialProdHier.LastUpdateDate<>#AVRTemp.LAST_UPDATE_DATE

DROP TABLE #AVRTemp', 
		@database_name=N'MDM', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Update Material]    Script Date: 5/16/2017 10:40:25 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update Material', 
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
WHERE (((LAST_UPDATE_DATE) > SYSDATE-10))'')
Go

DECLARE @MDMtbl AS NVARCHAR(MAX)

SET @MDMtbl = ''Material''

UPDATE Material
SET
Material.AvnetLegacyPartId = #AVRTemp.AVNET_LEGACY_PART_ID,
Material.AvnetValueAddNo = #AVRTemp.AVNET_VALUE_ADD_NO,
Material.CcatsEncryptionRegNo = #AVRTemp.CCATS_ENCRYPTION_REG_NO,
Material.CmDirtyInd = #AVRTemp.CM_DIRTY_IND,
Material.ConsolidationInd = #AVRTemp.CONSOLIDATION_IND,
Material.CreateDate = #AVRTemp.CREATE_DATE,
Material.Creator = #AVRTemp.CREATOR,
Material.CustomReelableFl = #AVRTemp.CUSTOM_REELABLE_FL,
Material.DeletedBy = #AVRTemp.DELETED_BY,
Material.DeletedDate = #AVRTemp.DELETED_DATE,
Material.DeletedInd = #AVRTemp.DELETED_IND,
Material.DemoPartValueAm = #AVRTemp.DEMO_PART_VALUE_AM,
Material.DimensionHeightQt = #AVRTemp.DIMENSION_HEIGHT_QT,
Material.DimensionLengthQt = #AVRTemp.DIMENSION_LENGTH_QT,
Material.DimensionWidthQt = #AVRTemp.DIMENSION_WIDTH_QT,
Material.DirtyInd = #AVRTemp.DIRTY_IND,
Material.EconomicProductionQt = #AVRTemp.ECONOMIC_PRODUCTION_QT,
Material.ExportControlClassNo = #AVRTemp.EXPORT_CONTROL_CLASS_NO,
Material.FactoryStockAvailQt = #AVRTemp.FACTORY_STOCK_AVAIL_QT,
Material.FccFl = #AVRTemp.FCC_FL,
Material.FdaFl = #AVRTemp.FDA_FL,
Material.GrossWeightQt = #AVRTemp.GROSS_WEIGHT_QT,
Material.HubStateInd = #AVRTemp.HUB_STATE_IND,
Material.InspectionTx = #AVRTemp.INSPECTION_TX,
Material.InteractionId = #AVRTemp.INTERACTION_ID,
Material.InventoryMessageTx = #AVRTemp.INVENTORY_MESSAGE_TX,
Material.ItarFl = #AVRTemp.ITAR_FL,
Material.LastRowidSystem = #AVRTemp.LAST_ROWID_SYSTEM,
Material.LastUpdateDate = #AVRTemp.LAST_UPDATE_DATE,
Material.ManufactFamilyPartNo = #AVRTemp.MANUFACT_FAMILY_PART_NO,
Material.ManufacturerPartNo = #AVRTemp.MANUFACTURER_PART_NO,
Material.MaterialDs = #AVRTemp.MATERIAL_DS,
Material.MaterialProdHierarchyId = #AVRTemp.MATERIAL_PROD_HIERARCHY_ID,
Material.MaterialStatusDt = #AVRTemp.MATERIAL_STATUS_DT,
Material.MaterialSuppressSyndFl = #AVRTemp.MATERIAL_SUPPRESS_SYND_FL,
Material.MdmActionCd = #AVRTemp.MDM_ACTION_CD,
Material.MdmManufacturerPartyId = #AVRTemp.MDM_MANUFACTURER_PARTY_ID,
Material.MdmSmxqDeviationCd = #AVRTemp.MDM_SMXQ_DEVIATION_CD,
Material.MdmUnspscCd = #AVRTemp.MDM_UNSPSC_CD,
Material.MdmUsmlCd = #AVRTemp.MDM_USML_CD,
Material.MdmWebCd = #AVRTemp.MDM_WEB_CD,
Material.MilitarySpecPartNo = #AVRTemp.MILITARY_SPEC_PART_NO,
Material.NetWeightQt = #AVRTemp.NET_WEIGHT_QT,
Material.PartDs = #AVRTemp.PART_DS,
Material.ProcurementStrategy = #AVRTemp.PROCUREMENT_STRATEGY,
Material.ProgrammableFl = #AVRTemp.PROGRAMMABLE_FL,
Material.RenewableFl = #AVRTemp.RENEWABLE_FL,
Material.ReplacementPartNo = #AVRTemp.REPLACEMENT_PART_NO,
Material.ResyndFl = #AVRTemp.RESYND_FL,
Material.RowidObject = #AVRTemp.ROWID_OBJECT,
Material.SapBaseUnitOfMsrCd = #AVRTemp.SAP_BASE_UNIT_OF_MSR_CD,
Material.SapDimUnitOfMeasureCd = #AVRTemp.SAP_DIM_UNIT_OF_MEASURE_CD,
Material.SapEcomStockStrategyCd = #AVRTemp.SAP_ECOM_STOCK_STRATEGY_CD,
Material.SapExternalMatlGroup = #AVRTemp.SAP_EXTERNAL_MATL_GROUP,
Material.SapGreenCd = #AVRTemp.SAP_GREEN_CD,
Material.SapJitCd = #AVRTemp.SAP_JIT_CD,
Material.SapLeadFreeCd = #AVRTemp.SAP_LEAD_FREE_CD,
Material.SapMaterialGroupCd = #AVRTemp.SAP_MATERIAL_GROUP_CD,
Material.SapMaterialId = #AVRTemp.SAP_MATERIAL_ID,
Material.SapMaterialStatusCd = #AVRTemp.SAP_MATERIAL_STATUS_CD,
Material.SapMaterialTypeCd = #AVRTemp.SAP_MATERIAL_TYPE_CD,
Material.SapMatGroupPackagingCd = #AVRTemp.SAP_MAT_GROUP_PACKAGING_CD,
Material.SapMatIndstrySectorCd = #AVRTemp.SAP_MAT_INDSTRY_SECTOR_CD,
Material.SapMatItemCatgGroupCd = #AVRTemp.SAP_MAT_ITEM_CATG_GROUP_CD,
Material.SapOrderUnitOfMsureCd = #AVRTemp.SAP_ORDER_UNIT_OF_MSURE_CD,
Material.SapProductHierarchyCd = #AVRTemp.SAP_PRODUCT_HIERARCHY_CD,
Material.SapPurchasingValueCd = #AVRTemp.SAP_PURCHASING_VALUE_CD,
Material.SapRohsCd = #AVRTemp.SAP_ROHS_CD,
Material.SapScheduleBCd = #AVRTemp.SAP_SCHEDULE_B_CD,
Material.SapSerialNoLevelCd = #AVRTemp.SAP_SERIAL_NO_LEVEL_CD,
Material.SapStorageConditionCd = #AVRTemp.SAP_STORAGE_CONDITION_CD,
Material.SapTlaTypeCd = #AVRTemp.SAP_TLA_TYPE_CD,
Material.SapTransGroupCd = #AVRTemp.SAP_TRANS_GROUP_CD,
Material.SapVolUnitOfMeasureCd = #AVRTemp.SAP_VOL_UNIT_OF_MEASURE_CD,
Material.SapWstsCd = #AVRTemp.SAP_WSTS_CD,
Material.SapWtUnitOfMeasureCd = #AVRTemp.SAP_WT_UNIT_OF_MEASURE_CD,
Material.SendToSapFl = #AVRTemp.SEND_TO_SAP_FL,
Material.SentToSapDate = #AVRTemp.SENT_TO_SAP_DATE,
Material.SignedLicAgrmntReqFl = #AVRTemp.SIGNED_LIC_AGRMNT_REQ_FL,
Material.SizeDimensionsDs = #AVRTemp.SIZE_DIMENSIONS_DS,
Material.SoleSourceFl = #AVRTemp.SOLE_SOURCE_FL,
Material.SupplierLastTimeBuyDt = #AVRTemp.SUPPLIER_LAST_TIME_BUY_DT,
Material.SupplierLastTimeRetDt = #AVRTemp.SUPPLIER_LAST_TIME_RET_DT,
Material.SupplierLastTimeShipDt = #AVRTemp.SUPPLIER_LAST_TIME_SHIP_DT,
Material.TaskRequesterEmail = #AVRTemp.TASK_REQUESTER_EMAIL,
Material.TradeComplianceNoteTx = #AVRTemp.TRADE_COMPLIANCE_NOTE_TX,
Material.TransactablePartFl = #AVRTemp.TRANSACTABLE_PART_FL,
Material.UpdatedBy = #AVRTemp.UPDATED_BY,
Material.ValueAddedFl = #AVRTemp.VALUE_ADDED_FL,
Material.VolumeQt = #AVRTemp.VOLUME_QT,
Material.WarrantyDurationMonthQt = #AVRTemp.WARRANTY_DURATION_MONTH_QT,
Material.PackageQty = #AVRTemp.PACKAGE_QTY
FROM #AVRTemp
INNER JOIN Material
ON #AVRTemp.ROWID_OBJECT = Material.RowidObject
WHERE Material.LastUpdateDate<>#AVRTemp.LAST_UPDATE_DATE

DROP TABLE #AVRTemp', 
		@database_name=N'MDM', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Update Party]    Script Date: 5/16/2017 10:40:25 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update Party', 
		@step_id=4, 
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
FROM GOLDEN.C_BO_PARTY
WHERE (((LAST_UPDATE_DATE) > SYSDATE-5))'')
Go


DECLARE @MDMtbl AS NVARCHAR(MAX)

SET @MDMtbl = ''Party''

UPDATE Party
SET
Party.RowidObject = #AVRTemp.ROWID_OBJECT,
Party.Creator = #AVRTemp.CREATOR,
Party.CreateDate = #AVRTemp.CREATE_DATE,
Party.UpdatedBy = #AVRTemp.UPDATED_BY,
Party.LastUpdateDate = #AVRTemp.LAST_UPDATE_DATE,
Party.ConsolidationInd = #AVRTemp.CONSOLIDATION_IND,
Party.DeletedInd = #AVRTemp.DELETED_IND,
Party.DeletedBy = #AVRTemp.DELETED_BY,
Party.DeletedDate = #AVRTemp.DELETED_DATE,
Party.LastRowidSystem = #AVRTemp.LAST_ROWID_SYSTEM,
Party.DirtyInd = #AVRTemp.DIRTY_IND,
Party.InteractionId = #AVRTemp.INTERACTION_ID,
Party.HubStateInd = #AVRTemp.HUB_STATE_IND,
Party.CmDirtyInd = #AVRTemp.CM_DIRTY_IND,
Party.SapCustAcctGroupCd = #AVRTemp.SAP_CUST_ACCT_GROUP_CD,
Party.SearchTermTx01 = #AVRTemp.SEARCH_TERM_TX_01,
Party.SapCreateDt = #AVRTemp.SAP_CREATE_DT,
Party.SapBillBlockReasonCd = #AVRTemp.SAP_BILL_BLOCK_REASON_CD,
Party.SapDelivBlockReasonCd = #AVRTemp.SAP_DELIV_BLOCK_REASON_CD,
Party.SapTaxJurisdictionCd = #AVRTemp.SAP_TAX_JURISDICTION_CD,
Party.AnnualSalesAm = #AVRTemp.ANNUAL_SALES_AM,
Party.AnnualSalesYr = #AVRTemp.ANNUAL_SALES_YR,
Party.SapFiscalYearVariantCd = #AVRTemp.SAP_FISCAL_YEAR_VARIANT_CD,
Party.SapSalesBlockReasonCd = #AVRTemp.SAP_SALES_BLOCK_REASON_CD,
Party.DeactivationFl = #AVRTemp.DEACTIVATION_FL,
Party.SapDeactivationReasonCd = #AVRTemp.SAP_DEACTIVATION_REASON_CD,
Party.SapCustomerPartyTypeCd = #AVRTemp.SAP_CUSTOMER_PARTY_TYPE_CD,
Party.AvnetLogoPrintFl = #AVRTemp.AVNET_LOGO_PRINT_FL,
Party.InsuranceChargeFl = #AVRTemp.INSURANCE_CHARGE_FL,
Party.SapFuelSurchargeCd = #AVRTemp.SAP_FUEL_SURCHARGE_CD,
Party.SapHandlingChargeCd = #AVRTemp.SAP_HANDLING_CHARGE_CD,
Party.VertexNo = #AVRTemp.VERTEX_NO,
Party.SapAltCountryNameCd = #AVRTemp.SAP_ALT_COUNTRY_NAME_CD,
Party.SapHazmatCd = #AVRTemp.SAP_HAZMAT_CD,
Party.HpVarNo = #AVRTemp.HP_VAR_NO,
Party.IbmCustomerContractNo = #AVRTemp.IBM_CUSTOMER_CONTRACT_NO,
Party.SapDeniedPartyStatusCd = #AVRTemp.SAP_DENIED_PARTY_STATUS_CD,
Party.DeniedPartyStatusDt = #AVRTemp.DENIED_PARTY_STATUS_DT,
Party.ItarRestrictedFl = #AVRTemp.ITAR_RESTRICTED_FL,
Party.ForeignGovernmentFl = #AVRTemp.FOREIGN_GOVERNMENT_FL,
Party.SapCustGrowthTypeCd = #AVRTemp.SAP_CUST_GROWTH_TYPE_CD,
Party.CustomerSinceDt = #AVRTemp.CUSTOMER_SINCE_DT,
Party.RelatedPartyFl = #AVRTemp.RELATED_PARTY_FL,
Party.SmallDisadvantagedBusFl = #AVRTemp.SMALL_DISADVANTAGED_BUS_FL,
Party.SapCustomerUserTypeCd = #AVRTemp.SAP_CUSTOMER_USER_TYPE_CD,
Party.SapRoutedCustomerCd = #AVRTemp.SAP_ROUTED_CUSTOMER_CD,
Party.SapDutyTaxLocationCd = #AVRTemp.SAP_DUTY_TAX_LOCATION_CD,
Party.DutyTaxCarrierAcctNo = #AVRTemp.DUTY_TAX_CARRIER_ACCT_NO,
Party.PlantShutdownStartDt = #AVRTemp.PLANT_SHUTDOWN_START_DT,
Party.PlantShutdownEndDt = #AVRTemp.PLANT_SHUTDOWN_END_DT,
Party.SoldToCreateDt = #AVRTemp.SOLD_TO_CREATE_DT,
Party.SapShipTypeCd = #AVRTemp.SAP_SHIP_TYPE_CD,
Party.SapCustomerEndUseCd = #AVRTemp.SAP_CUSTOMER_END_USE_CD,
Party.SapRemoteRegionCd = #AVRTemp.SAP_REMOTE_REGION_CD,
Party.RemoteRegionSapAccNo = #AVRTemp.REMOTE_REGION_SAP_ACC_NO,
Party.SapRemoteDivisionCd = #AVRTemp.SAP_REMOTE_DIVISION_CD,
Party.StmtOfAssureOrigAttDt = #AVRTemp.STMT_OF_ASSURE_ORIG_ATT_DT,
Party.CustBusPlanExistsFl = #AVRTemp.CUST_BUS_PLAN_EXISTS_FL,
Party.SapRiskClassCd = #AVRTemp.SAP_RISK_CLASS_CD,
Party.MdmPriPartyRoleTypeCd = #AVRTemp.MDM_PRI_PARTY_ROLE_TYPE_CD,
Party.SapPartyId = #AVRTemp.SAP_PARTY_ID,
Party.SapPartyNm01 = #AVRTemp.SAP_PARTY_NM_01,
Party.SapPartyNm02 = #AVRTemp.SAP_PARTY_NM_02,
Party.SapPartyNm03 = #AVRTemp.SAP_PARTY_NM_03,
Party.SapPartyNm04 = #AVRTemp.SAP_PARTY_NM_04,
Party.SapBusPtnerFuncCd = #AVRTemp.SAP_BUS_PTNER_FUNC_CD,
Party.MdmPartyNm = #AVRTemp.MDM_PARTY_NM,
Party.BoClassCode = #AVRTemp.BO_CLASS_CODE,
Party.ShipToRowid = #AVRTemp.SHIP_TO_ROWID,
Party.CentralPurchBlockFl = #AVRTemp.CENTRAL_PURCH_BLOCK_FL,
Party.SapLanguageCd = #AVRTemp.SAP_LANGUAGE_CD,
Party.SapDmndCreatClsCd = #AVRTemp.SAP_DMND_CREAT_CLS_CD,
Party.SapCustAddrSrcCd = #AVRTemp.SAP_CUST_ADDR_SRC_CD,
Party.ImportTaxId = #AVRTemp.IMPORT_TAX_ID,
Party.ExportTaxId = #AVRTemp.EXPORT_TAX_ID,
Party.SapDndPtyDuplSuggCd = #AVRTemp.SAP__DND_PTY_DUPL_SUGG_CD,
Party.SapTitleCd = #AVRTemp.SAP_TITLE_CD,
Party.SapCommunicationTypeCd = #AVRTemp.SAP_COMMUNICATION_TYPE_CD,
Party.SearchTermTx02 = #AVRTemp.SEARCH_TERM_TX_02,
Party.VendorNoteTx = #AVRTemp.VENDOR_NOTE_TX,
Party.ContactDescription = #AVRTemp.CONTACT_DESCRIPTION,
Party.CrmContactId = #AVRTemp.CRM_CONTACT_ID,
Party.ContactFirstNm = #AVRTemp.CONTACT_FIRST_NM,
Party.ContactLastNm = #AVRTemp.CONTACT_LAST_NM,
Party.LegacyContactId = #AVRTemp.LEGACY_CONTACT_ID,
Party.ContactNickNm = #AVRTemp.CONTACT_NICK_NM,
Party.SapContactCdFk = #AVRTemp.SAP_CONTACT_CD_FK,
Party.SapContactVipCdFk = #AVRTemp.SAP_CONTACT_VIP_CD_FK,
Party.JobTitleTx = #AVRTemp.JOB_TITLE_TX,
Party.SapVendorAcctGroupCd = #AVRTemp.SAP_VENDOR_ACCT_GROUP_CD,
Party.SapBlockFuncReasonCd = #AVRTemp.SAP_BLOCK_FUNC_REASON_CD,
Party.PartySubRoleTypCd = #AVRTemp.PARTY_SUB_ROLE_TYP_CD,
Party.SapContactVipCd = #AVRTemp.SAP_CONTACT_VIP_CD,
Party.SapContactFunctionCd = #AVRTemp.SAP_CONTACT_FUNCTION_CD,
Party.InSapFl = #AVRTemp.IN_SAP_FL,
Party.ManualConsolidatinInd = #AVRTemp.MANUAL_CONSOLIDATIN_IND,
Party.SapAnnualSalesCurrCd = #AVRTemp.SAP_ANNUAL_SALES_CURR_CD,
Party.LegacySourceSystem = #AVRTemp.LEGACY_SOURCE_SYSTEM,
Party.TaxExemptionFl = #AVRTemp.TAX_EXEMPTION_FL,
Party.DeactivationDate = #AVRTemp.DEACTIVATION_DATE
FROM #AVRTemp
INNER JOIN Party
ON #AVRTemp.ROWID_OBJECT = Party.RowidObject
WHERE Party.LastUpdateDate<>#AVRTemp.LAST_UPDATE_DATE

DROP TABLE #AVRTemp', 
		@database_name=N'MDM', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Update MaterialPlant]    Script Date: 5/16/2017 10:40:25 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update MaterialPlant', 
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
FROM OPENQUERY(AVR80,''SELECT *
FROM GOLDEN.C_BO_MATERIAL_PLANT
WHERE (((LAST_UPDATE_DATE) > SYSDATE-5))'')
Go

DECLARE @MDMtbl AS NVARCHAR(MAX)
SET @MDMtbl = ''MaterialPlant''

USE MDM
GO

UPDATE MaterialPlant
SET
MaterialPlant.RowidObject = #AVRTemp.ROWID_OBJECT,
MaterialPlant.Creator = #AVRTemp.CREATOR,
MaterialPlant.CreateDate = #AVRTemp.CREATE_DATE,
MaterialPlant.UpdatedBy = #AVRTemp.UPDATED_BY,
MaterialPlant.LastUpdateDate = #AVRTemp.LAST_UPDATE_DATE,
MaterialPlant.ConsolidationInd = #AVRTemp.CONSOLIDATION_IND,
MaterialPlant.DeletedInd = #AVRTemp.DELETED_IND,
MaterialPlant.DeletedBy = #AVRTemp.DELETED_BY,
MaterialPlant.DeletedDate = #AVRTemp.DELETED_DATE,
MaterialPlant.LastRowidSystem = #AVRTemp.LAST_ROWID_SYSTEM,
MaterialPlant.DirtyInd = #AVRTemp.DIRTY_IND,
MaterialPlant.InteractionId = #AVRTemp.INTERACTION_ID,
MaterialPlant.HubStateInd = #AVRTemp.HUB_STATE_IND,
MaterialPlant.CmDirtyInd = #AVRTemp.CM_DIRTY_IND,
MaterialPlant.MdmMaterialId = #AVRTemp.MDM_MATERIAL_ID,
MaterialPlant.SapPlantCd = #AVRTemp.SAP_PLANT_CD,
MaterialPlant.SapAvailCheckGroupCd = #AVRTemp.SAP_AVAIL_CHECK_GROUP_CD,
MaterialPlant.SapMaterialStatusCd = #AVRTemp.SAP_MATERIAL_STATUS_CD,
MaterialPlant.MaterialStatusDt = #AVRTemp.MATERIAL_STATUS_DT,
MaterialPlant.MaximumLotSizeQt = #AVRTemp.MAXIMUM_LOT_SIZE_QT,
MaterialPlant.SapProcurementTypeCd = #AVRTemp.SAP_PROCUREMENT_TYPE_CD,
MaterialPlant.AbcCd = #AVRTemp.ABC_CD,
MaterialPlant.MilitaryPartFl = #AVRTemp.MILITARY_PART_FL,
MaterialPlant.PlannedDeliveryDayQt = #AVRTemp.PLANNED_DELIVERY_DAY_QT,
MaterialPlant.InventoryMessageTx = #AVRTemp.INVENTORY_MESSAGE_TX,
MaterialPlant.SapSupplierMatAbcCd = #AVRTemp.SAP_SUPPLIER_MAT_ABC_CD,
MaterialPlant.BatchManagementReqFl = #AVRTemp.BATCH_MANAGEMENT_REQ_FL,
MaterialPlant.BuildDayQt = #AVRTemp.BUILD_DAY_QT,
MaterialPlant.TotalReplenLeadDayQt = #AVRTemp.TOTAL_REPLEN_LEAD_DAY_QT,
MaterialPlant.SerialNumberProfileFl = #AVRTemp.SERIAL_NUMBER_PROFILE_FL,
MaterialPlant.BatchManagementFl = #AVRTemp.BATCH_MANAGEMENT_FL,
MaterialPlant.SapHtsCd = #AVRTemp.SAP_HTS_CD,
MaterialPlant.AutoPoAllowedFl = #AVRTemp.AUTO_PO_ALLOWED_FL,
MaterialPlant.SapPurchasingGroupCd = #AVRTemp.SAP_PURCHASING_GROUP_CD,
MaterialPlant.UnlimitedOvrDlvAllowFl = #AVRTemp.UNLIMITED_OVR_DLV_ALLOW_FL,
MaterialPlant.GoodsRecptProcessDayQt = #AVRTemp.GOODS_RECPT_PROCESS_DAY_QT,
MaterialPlant.SapMrpTypeCd = #AVRTemp.SAP_MRP_TYPE_CD,
MaterialPlant.PlanningTimeFenceDayQt = #AVRTemp.PLANNING_TIME_FENCE_DAY_QT,
MaterialPlant.SafetyStockQt = #AVRTemp.SAFETY_STOCK_QT,
MaterialPlant.MinimumLotSizeQt = #AVRTemp.MINIMUM_LOT_SIZE_QT,
MaterialPlant.FixedLotSizeQt = #AVRTemp.FIXED_LOT_SIZE_QT,
MaterialPlant.SapMrpLotSizeCd = #AVRTemp.SAP_MRP_LOT_SIZE_CD,
MaterialPlant.ManualSupplLeadDayQt = #AVRTemp.MANUAL_SUPPL_LEAD_DAY_QT,
MaterialPlant.SapPeriodCd = #AVRTemp.SAP_PERIOD_CD,
MaterialPlant.CycleCountFixedFl = #AVRTemp.CYCLE_COUNT_FIXED_FL,
MaterialPlant.SapOriginatingCountryCd = #AVRTemp.SAP_ORIGINATING_COUNTRY_CD,
MaterialPlant.VendorEdiLeadDayQt = #AVRTemp.VENDOR_EDI_LEAD_DAY_QT,
MaterialPlant.RunRateQt = #AVRTemp.RUN_RATE_QT,
MaterialPlant.SupplyDayQt = #AVRTemp.SUPPLY_DAY_QT,
MaterialPlant.SuppCancelWindowDayQt = #AVRTemp.SUPP_CANCEL_WINDOW_DAY_QT,
MaterialPlant.EncryptionPartFl = #AVRTemp.ENCRYPTION_PART_FL,
MaterialPlant.SapStockingProfile = #AVRTemp.SAP_STOCKING_PROFILE,
MaterialPlant.SapReplacementPartCd = #AVRTemp.SAP_REPLACEMENT_PART_CD,
MaterialPlant.SapLoadingGroupCd = #AVRTemp.SAP_LOADING_GROUP_CD,
MaterialPlant.SourceListRequiredFl = #AVRTemp.SOURCE_LIST_REQUIRED_FL,
MaterialPlant.SapFiscalYearVariantCd = #AVRTemp.SAP_FISCAL_YEAR_VARIANT_CD,
MaterialPlant.SapIndCollectReqdCd = #AVRTemp.SAP_IND_COLLECT_REQD_CD,
MaterialPlant.SapForecastModelCd = #AVRTemp.SAP_FORECAST_MODEL_CD,
MaterialPlant.SapValuationCategoryCd = #AVRTemp.SAP_VALUATION_CATEGORY_CD,
MaterialPlant.SapMixedMrpCd = #AVRTemp.SAP_MIXED_MRP_CD,
MaterialPlant.SapProfitCenter = #AVRTemp.SAP_PROFIT_CENTER,
MaterialPlant.RoundingValueNo = #AVRTemp.ROUNDING_VALUE_NO,
MaterialPlant.SapSpecialProcureTypCd = #AVRTemp.SAP_SPECIAL_PROCURE_TYP_CD,
MaterialPlant.SapMrpGroupCd = #AVRTemp.SAP_MRP_GROUP_CD,
MaterialPlant.SapIssuePlntStrLocCd = #AVRTemp.SAP_ISSUE_PLNT_STR_LOC_CD,
MaterialPlant.SapExtPrcPltStrLocCd = #AVRTemp.SAP_EXT_PRC_PLT_STR_LOC_CD,
MaterialPlant.SapProductionSchedCd = #AVRTemp.SAP_PRODUCTION_SCHED_CD,
MaterialPlant.SapCycleCountPhyInvCd = #AVRTemp.SAP_CYCLE_COUNT_PHY_INV_CD,
MaterialPlant.SapPlanningCycleCd = #AVRTemp.SAP_PLANNING_CYCLE_CD,
MaterialPlant.SapMrpControllerCd = #AVRTemp.SAP_MRP_CONTROLLER_CD,
MaterialPlant.SapSchedulingFloatsCd = #AVRTemp.SAP_SCHEDULING_FLOATS_CD,
MaterialPlant.LeadTimeOverrideFl = #AVRTemp.LEAD_TIME_OVERRIDE_FL,
MaterialPlant.PriceBookEdiLtDt = #AVRTemp.PRICE_BOOK_EDI_LT_DT
FROM #AVRTemp
INNER JOIN MaterialPlant
ON #AVRTemp.ROWID_OBJECT = MaterialPlant.RowidObject
WHERE MaterialPlant.LastUpdateDate<>#AVRTemp.LAST_UPDATE_DATE
GO

DROP TABLE #AVRTemp', 
		@database_name=N'MDM', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Update MatSalesOrg]    Script Date: 5/16/2017 10:40:25 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update MatSalesOrg', 
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
FROM OPENQUERY(AVR80,''SELECT *
FROM GOLDEN.C_BO_MATERIAL_SALES_ORG
WHERE (((LAST_UPDATE_DATE) > SYSDATE-4))'')
Go

DECLARE @MDMtbl AS NVARCHAR(MAX)

SET @MDMtbl = ''MaterialSalesOrg''

UPDATE MaterialSalesOrg
SET
MaterialSalesOrg.RowIdObject = #AVRTemp.ROWID_OBJECT,
MaterialSalesOrg.Creator = #AVRTemp.CREATOR,
MaterialSalesOrg.CreateDate = #AVRTemp.CREATE_DATE,
MaterialSalesOrg.UpdatedBy = #AVRTemp.UPDATED_BY,
MaterialSalesOrg.LastUpdateDate = #AVRTemp.LAST_UPDATE_DATE,
MaterialSalesOrg.ConsolidationInd = #AVRTemp.CONSOLIDATION_IND,
MaterialSalesOrg.DeletedInd = #AVRTemp.DELETED_IND,
MaterialSalesOrg.DeletedBy = #AVRTemp.DELETED_BY,
MaterialSalesOrg.DeletedDate = #AVRTemp.DELETED_DATE,
MaterialSalesOrg.LastRowIdSystem = #AVRTemp.LAST_ROWID_SYSTEM,
MaterialSalesOrg.DirtyInd = #AVRTemp.DIRTY_IND,
MaterialSalesOrg.InteractionId = #AVRTemp.INTERACTION_ID,
MaterialSalesOrg.HubStateInd = #AVRTemp.HUB_STATE_IND,
MaterialSalesOrg.CmDirtyInd = #AVRTemp.CM_DIRTY_IND,
MaterialSalesOrg.MdmMaterialId = #AVRTemp.MDM_MATERIAL_ID,
MaterialSalesOrg.SapSalesOrgCd = #AVRTemp.SAP_SALES_ORG_CD,
MaterialSalesOrg.SapCentralStockPlantCd = #AVRTemp.SAP_CENTRAL_STOCK_PLANT_CD,
MaterialSalesOrg.SalesMinimumOrderQt = #AVRTemp.SALES_MINIMUM_ORDER_QT,
MaterialSalesOrg.SapDesignWinAvailCd = #AVRTemp.SAP_DESIGN_WIN_AVAIL_CD,
MaterialSalesOrg.SapMatlItemCatGroupCd = #AVRTemp.SAP_MATL_ITEM_CAT_GROUP_CD,
MaterialSalesOrg.SapMatlSplHandlingCd = #AVRTemp.SAP_MATL_SPL_HANDLING_CD,
MaterialSalesOrg.SapSmallOrderStratCd = #AVRTemp.SAP_SMALL_ORDER_STRAT_CD,
MaterialSalesOrg.CustomProductFl = #AVRTemp.CUSTOM_PRODUCT_FL,
MaterialSalesOrg.NonCancelNonReturnFl = #AVRTemp.NON_CANCEL_NON_RETURN_FL,
MaterialSalesOrg.SoftwareLicenseReqFl = #AVRTemp.SOFTWARE_LICENSE_REQ_FL,
MaterialSalesOrg.DesignWinEffFromDt = #AVRTemp.DESIGN_WIN_EFF_FROM_DT,
MaterialSalesOrg.DesignWinEffThruDt = #AVRTemp.DESIGN_WIN_EFF_THRU_DT,
MaterialSalesOrg.SapMatlPricingGroupCd = #AVRTemp.SAP_MATL_PRICING_GROUP_CD,
MaterialSalesOrg.DesignWinGrandfatherDt = #AVRTemp.DESIGN_WIN_GRANDFATHER_DT,
MaterialSalesOrg.NonDisclosurAgrmtReqFl = #AVRTemp.NON_DISCLOSUR_AGRMT_REQ_FL,
MaterialSalesOrg.DualMarkingFl = #AVRTemp.DUAL_MARKING_FL,
MaterialSalesOrg.SalesMessageTx = #AVRTemp.SALES_MESSAGE_TX,
MaterialSalesOrg.SapStockingProfileCd = #AVRTemp.SAP_STOCKING_PROFILE_CD,
MaterialSalesOrg.WaiverRequiredFl = #AVRTemp.WAIVER_REQUIRED_FL,
MaterialSalesOrg.SapDistributionChnlCd = #AVRTemp.SAP_DISTRIBUTION_CHNL_CD,
MaterialSalesOrg.LiquidationAllowedFl = #AVRTemp.LIQUIDATION_ALLOWED_FL,
MaterialSalesOrg.SapSalesUnitOfMsrCd = #AVRTemp.SAP_SALES_UNIT_OF_MSR_CD,
MaterialSalesOrg.SapMatlSalesDistStsCd = #AVRTemp.SAP_MATL_SALES_DIST_STS_CD,
MaterialSalesOrg.MinimumDeliveryQt = #AVRTemp.MINIMUM_DELIVERY_QT,
MaterialSalesOrg.MatlSalesDistStsEffDt = #AVRTemp.MATL_SALES_DIST_STS_EFF_DT,
MaterialSalesOrg.SapElectroStaticDisCd = #AVRTemp.SAP_ELECTRO_STATIC_DIS_CD,
MaterialSalesOrg.DownloadableFl = #AVRTemp.DOWNLOADABLE_FL,
MaterialSalesOrg.GlobalInventEligibleFl = #AVRTemp.GLOBAL_INVENT_ELIGIBLE_FL,
MaterialSalesOrg.NaftaFl = #AVRTemp.NAFTA_FL,
MaterialSalesOrg.ExistsWithinSapFl = #AVRTemp.EXISTS_WITHIN_SAP_FL,
MaterialSalesOrg.MdmExportSourceCd = #AVRTemp.MDM_EXPORT_SOURCE_CD,
MaterialSalesOrg.DeliveryUnitQt = #AVRTemp.DELIVERY_UNIT_QT,
MaterialSalesOrg.SapMatlAcctAssnGrpCd = #AVRTemp.SAP_MATL_ACCT_ASSN_GRP_CD,
MaterialSalesOrg.MaterialProdHierarchyId = #AVRTemp.MATERIAL_PROD_HIERARCHY_ID,
MaterialSalesOrg.MdmPriceRefMaterialId = #AVRTemp.MDM_PRICE_REF_MATERIAL_ID,
MaterialSalesOrg.SapProductHierarchyCd = #AVRTemp.SAP_PRODUCT_HIERARCHY_CD,
MaterialSalesOrg.MdmPriceRefMatlRowId = #AVRTemp.MDM_PRICE_REF_MATL_ROWID
FROM #AVRTemp
INNER JOIN MaterialSalesOrg
ON #AVRTemp.ROWID_OBJECT = MaterialSalesOrg.RowIdObject
WHERE MaterialSalesOrg.LastUpdateDate<>#AVRTemp.LAST_UPDATE_DATE

DROP TABLE #AVRTemp
', 
		@database_name=N'MDM', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Update VenMatRel]    Script Date: 5/16/2017 10:40:25 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update VenMatRel', 
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
WHERE (((LAST_UPDATE_DATE) > SYSDATE-5))'')
Go

DECLARE @MDMtbl AS NVARCHAR(MAX)
SET @MDMtbl = ''VendorMaterialRel''

UPDATE VendorMaterialRel
SET
VendorMaterialRel.RowIdObject = #AVRTemp.ROWID_OBJECT,
VendorMaterialRel.Creator = #AVRTemp.CREATOR,
VendorMaterialRel.CreateDate = #AVRTemp.CREATE_DATE,
VendorMaterialRel.UpdateBy = #AVRTemp.UPDATED_BY,
VendorMaterialRel.LastUpdateDate = #AVRTemp.LAST_UPDATE_DATE,
VendorMaterialRel.ConsolidationInd = #AVRTemp.CONSOLIDATION_IND,
VendorMaterialRel.DeleteInd = #AVRTemp.DELETED_IND,
VendorMaterialRel.DeleteBy = #AVRTemp.DELETED_BY,
VendorMaterialRel.DeleteDate = #AVRTemp.DELETED_DATE,
VendorMaterialRel.LastRowIdSystem = #AVRTemp.LAST_ROWID_SYSTEM,
VendorMaterialRel.DirtyInd = #AVRTemp.DIRTY_IND,
VendorMaterialRel.InteractionId = #AVRTemp.INTERACTION_ID,
VendorMaterialRel.HubStateInd = #AVRTemp.HUB_STATE_IND,
VendorMaterialRel.CMDirtyInd = #AVRTemp.CM_DIRTY_IND,
VendorMaterialRel.MDMMaterialID = #AVRTemp.MDM_MATERIAL_ID,
VendorMaterialRel.MDMVendorPartyId = #AVRTemp.MDM_VENDOR_PARTY_ID,
VendorMaterialRel.VendorPartNo = #AVRTemp.VENDOR_PART_NO
FROM #AVRTemp
INNER JOIN VendorMaterialRel
ON #AVRTemp.ROWID_OBJECT = VendorMaterialRel.RowidObject
WHERE VendorMaterialRel.LastUpdateDate<>#AVRTemp.LAST_UPDATE_DATE
Go

DROP TABLE #AVRTemp', 
		@database_name=N'MDM', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Update VenMatPurOrgPlnt]    Script Date: 5/16/2017 10:40:25 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update VenMatPurOrgPlnt', 
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
WHERE (((LAST_UPDATE_DATE) > SYSDATE-7))'')
Go

DECLARE @MDMtbl AS NVARCHAR(MAX)
SET @MDMtbl = ''VendMatPurOrgPlant''

UPDATE VendMatPurOrgPlant
SET
VendMatPurOrgPlant.RowIdObject = #AVRTemp.ROWID_OBJECT,
VendMatPurOrgPlant.Creator = #AVRTemp.CREATOR,
VendMatPurOrgPlant.CreateDate = #AVRTemp.CREATE_DATE,
VendMatPurOrgPlant.UpdatedBy = #AVRTemp.UPDATED_BY,
VendMatPurOrgPlant.LastUpdateDate = #AVRTemp.LAST_UPDATE_DATE,
VendMatPurOrgPlant.CondsolidationInd = #AVRTemp.CONSOLIDATION_IND,
VendMatPurOrgPlant.DeletedInd = #AVRTemp.DELETED_IND,
VendMatPurOrgPlant.DeletedBy = #AVRTemp.DELETED_BY,
VendMatPurOrgPlant.DeletedDate = #AVRTemp.DELETED_DATE,
VendMatPurOrgPlant.LastRowIdSystem = #AVRTemp.LAST_ROWID_SYSTEM,
VendMatPurOrgPlant.DirtyInd = #AVRTemp.DIRTY_IND,
VendMatPurOrgPlant.InteractionId = #AVRTemp.INTERACTION_ID,
VendMatPurOrgPlant.HubStateInd = #AVRTemp.HUB_STATE_IND,
VendMatPurOrgPlant.CMDirtyInd = #AVRTemp.CM_DIRTY_IND,
VendMatPurOrgPlant.SAPPurchasingOrgCD = #AVRTemp.SAP_PURCHASING_ORG_CD,
VendMatPurOrgPlant.SAPPlantCD = #AVRTemp.SAP_PLANT_CD,
VendMatPurOrgPlant.PriceProtectEligibleFL = #AVRTemp.PRICE_PROTECT_ELIGIBLE_FL,
VendMatPurOrgPlant.SupplierMinPackageQt = #AVRTemp.SUPPLIER_MIN_PACKAGE_QT,
VendMatPurOrgPlant.SupplierMinOrderQt = #AVRTemp.SUPPLIER_MIN_ORDER_QT,
VendMatPurOrgPlant.MDMVendorMaterialId = #AVRTemp.MDM_VENDOR_MATERIAL_ID,
VendMatPurOrgPlant.SAPPirCategoryDc = #AVRTemp.SAP_PIR_CATEGORY_CD
FROM #AVRTemp
INNER JOIN VendMatPurOrgPlant
ON #AVRTemp.ROWID_OBJECT = VendMatPurOrgPlant.RowidObject
WHERE VendMatPurOrgPlant.LastUpdateDate<>#AVRTemp.LAST_UPDATE_DATE
GO

DROP TABLE #AVRTemp', 
		@database_name=N'MDM', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Update ConditionHeader]    Script Date: 5/16/2017 10:40:25 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update ConditionHeader', 
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
WHERE (((LAST_UPDATE_DATE) > SYSDATE-7))'')
Go

DECLARE @MDMtbl AS NVARCHAR(MAX)
SET @MDMtbl = ''ConditionHeader''

UPDATE ConditionHeader
SET
ConditionHeader.RowIdObject = #AVRTemp.ROWID_OBJECT,
ConditionHeader.Creator = #AVRTemp.CREATOR,
ConditionHeader.CreateDate = #AVRTemp.CREATE_DATE,
ConditionHeader.UpdateBy = #AVRTemp.UPDATED_BY,
ConditionHeader.LastUpdateDate = #AVRTemp.LAST_UPDATE_DATE,
ConditionHeader.ConsolidationInd = #AVRTemp.CONSOLIDATION_IND,
ConditionHeader.DeletionInd = #AVRTemp.DELETED_IND,
ConditionHeader.DeletedBy = #AVRTemp.DELETED_BY,
ConditionHeader.DeletedDate = #AVRTemp.DELETED_DATE,
ConditionHeader.LastRowIdSystem = #AVRTemp.LAST_ROWID_SYSTEM,
ConditionHeader.DirtyInd = #AVRTemp.DIRTY_IND,
ConditionHeader.InteractionId = #AVRTemp.INTERACTION_ID,
ConditionHeader.HubStateInd = #AVRTemp.HUB_STATE_IND,
ConditionHeader.CMDirtyInd = #AVRTemp.CM_DIRTY_IND,
ConditionHeader.ConditionRecordNo = #AVRTemp.CONDITION_RECORD_NO,
ConditionHeader.ValidFromDt = #AVRTemp.VALID_FROM_DT,
ConditionHeader.ValidToDt = #AVRTemp.VALID_TO_DT,
ConditionHeader.SAPConditionTypeCode = #AVRTemp.SAP_CONDITION_TYPE_CODE,
ConditionHeader.MDMVendMatlPoPlantId = #AVRTemp.MDM_VEND_MATL_PO_PLANT_ID
FROM #AVRTemp
INNER JOIN ConditionHeader
ON #AVRTemp.ROWID_OBJECT = ConditionHeader.RowidObject
WHERE ConditionHeader.LastUpdateDate<>#AVRTemp.LAST_UPDATE_DATE
GO

DROP TABLE #AVRTemp', 
		@database_name=N'MDM', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Update ConditionItem]    Script Date: 5/16/2017 10:40:25 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update ConditionItem', 
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
WHERE (((LAST_UPDATE_DATE) > SYSDATE-7))'')
Go

DECLARE @MDMtbl AS NVARCHAR(MAX)
SET @MDMtbl = ''ConditionItem''

UPDATE ConditionItem
SET
ConditionItem.RowIdObject = #AVRTemp.ROWID_OBJECT,
ConditionItem.Creator = #AVRTemp.CREATOR,
ConditionItem.CreateDate = #AVRTemp.CREATE_DATE,
ConditionItem.UpdatedBy = #AVRTemp.UPDATED_BY,
ConditionItem.LastUpdateDate = #AVRTemp.LAST_UPDATE_DATE,
ConditionItem.ConditionIdn = #AVRTemp.CONSOLIDATION_IND,
ConditionItem.DeletedInd = #AVRTemp.DELETED_IND,
ConditionItem.DeletedBy = #AVRTemp.DELETED_BY,
ConditionItem.DeletedDate = #AVRTemp.DELETED_DATE,
ConditionItem.LastRowIdSystem = #AVRTemp.LAST_ROWID_SYSTEM,
ConditionItem.DirtyInd = #AVRTemp.DIRTY_IND,
ConditionItem.InteractionId = #AVRTemp.INTERACTION_ID,
ConditionItem.HubStateInd = #AVRTemp.HUB_STATE_IND,
ConditionItem.CMDirtyInd = #AVRTemp.CM_DIRTY_IND,
ConditionItem.ConditionAM = #AVRTemp.CONDITION_AM,
ConditionItem.ConditionSqNo = #AVRTemp.CONDITION_SQ_NO,
ConditionItem.MinConditionQt = #AVRTemp.MIN_CONDITION_QT,
ConditionItem.MaxConditionQt = #AVRTemp.MAX_CONDITION_QT,
ConditionItem.SAPCurrencyCode = #AVRTemp.SAP_CURRENCY_CODE,
ConditionItem.MDMConditionHeaderId = #AVRTemp.MDM_CONDITION_HEADER_ID,
ConditionItem.ConditionPricingUnitQt = #AVRTemp.CONDITION_PRICING_UNIT_QT,
ConditionItem.SAPConditionScaleUomCD = #AVRTemp.SAP_CONDITION_SCALE_UOM_CD,
ConditionItem.SAPConditionTypeCD = #AVRTemp.SAP_CONDITION_TYPE_CD
FROM #AVRTemp
INNER JOIN ConditionItem
ON #AVRTemp.ROWID_OBJECT = ConditionItem.RowidObject
WHERE ConditionItem.LastUpdateDate<>#AVRTemp.LAST_UPDATE_DATE
GO

DROP TABLE #AVRTemp', 
		@database_name=N'MDM', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily', 
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
		@schedule_uid=N'ac9ccf73-cfd2-4d14-8cec-c7cefe92178c'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


