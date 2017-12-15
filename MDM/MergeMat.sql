SELECT *
INTO #AvrMTemp
FROM OPENQUERY(AVR80,'SELECT *
FROM GOLDEN.C_BO_MATERIAL
WHERE (((LAST_UPDATE_DATE) > SYSDATE-5))')

USE MDM
GO


MERGE Material AS TargetTbl
USING #AvrMTemp AS SourceTbl
ON (TargetTbl.RowIdObject=SourceTbl.ROWID_OBJECT)
WHEN MATCHED 
	AND TargetTbl.LastUpdateDate <> SourceTbl.LAST_UPDATE_DATE

THEN
	UPDATE SET
	TargetTbl.AvnetLegacyPartId = SourceTbl.AVNET_LEGACY_PART_ID
	,TargetTbl.AvnetValueAddNo = SourceTbl.AVNET_VALUE_ADD_NO
	,TargetTbl.CcatsEncryptionRegNo = SourceTbl.CCATS_ENCRYPTION_REG_NO
	,TargetTbl.CmDirtyInd = SourceTbl.CM_DIRTY_IND
	,TargetTbl.ConsolidationInd = SourceTbl.CONSOLIDATION_IND
	,TargetTbl.CreateDate = SourceTbl.CREATE_DATE
	,TargetTbl.Creator = SourceTbl.CREATOR
	,TargetTbl.CustomReelableFl = SourceTbl.CUSTOM_REELABLE_FL
	,TargetTbl.DeletedBy = SourceTbl.DELETED_BY
	,TargetTbl.DeletedDate = SourceTbl.DELETED_DATE
	,TargetTbl.DeletedInd = SourceTbl.DELETED_IND
	,TargetTbl.DemoPartValueAm = SourceTbl.DEMO_PART_VALUE_AM
	,TargetTbl.DimensionHeightQt = SourceTbl.DIMENSION_HEIGHT_QT
	,TargetTbl.DimensionLengthQt = SourceTbl.DIMENSION_LENGTH_QT
	,TargetTbl.DimensionWidthQt = SourceTbl.DIMENSION_WIDTH_QT
	,TargetTbl.DirtyInd = SourceTbl.DIRTY_IND
	,TargetTbl.EconomicProductionQt = SourceTbl.ECONOMIC_PRODUCTION_QT
	,TargetTbl.ExportControlClassNo = SourceTbl.EXPORT_CONTROL_CLASS_NO
	,TargetTbl.FactoryStockAvailQt = SourceTbl.FACTORY_STOCK_AVAIL_QT
	,TargetTbl.FccFl = SourceTbl.FCC_FL
	,TargetTbl.FdaFl = SourceTbl.FDA_FL
	,TargetTbl.GrossWeightQt = SourceTbl.GROSS_WEIGHT_QT
	,TargetTbl.HubStateInd = SourceTbl.HUB_STATE_IND
	,TargetTbl.InspectionTx = SourceTbl.INSPECTION_TX
	,TargetTbl.InteractionId = SourceTbl.INTERACTION_ID
	,TargetTbl.InventoryMessageTx = SourceTbl.INVENTORY_MESSAGE_TX
	,TargetTbl.ItarFl = SourceTbl.ITAR_FL
	,TargetTbl.LastRowidSystem = SourceTbl.LAST_ROWID_SYSTEM
	,TargetTbl.LastUpdateDate = SourceTbl.LAST_UPDATE_DATE
	,TargetTbl.ManufactFamilyPartNo = SourceTbl.MANUFACT_FAMILY_PART_NO
	,TargetTbl.ManufacturerPartNo = SourceTbl.MANUFACTURER_PART_NO
	,TargetTbl.MaterialDs = SourceTbl.MATERIAL_DS
	,TargetTbl.MaterialProdHierarchyId = SourceTbl.MATERIAL_PROD_HIERARCHY_ID
	,TargetTbl.MaterialStatusDt = SourceTbl.MATERIAL_STATUS_DT
	,TargetTbl.MaterialSuppressSyndFl = SourceTbl.MATERIAL_SUPPRESS_SYND_FL
	,TargetTbl.MdmActionCd = SourceTbl.MDM_ACTION_CD
	,TargetTbl.MdmManufacturerPartyId = SourceTbl.MDM_MANUFACTURER_PARTY_ID
	,TargetTbl.MdmSmxqDeviationCd = SourceTbl.MDM_SMXQ_DEVIATION_CD
	,TargetTbl.MdmUnspscCd = SourceTbl.MDM_UNSPSC_CD
	,TargetTbl.MdmUsmlCd = SourceTbl.MDM_USML_CD
	,TargetTbl.MdmWebCd = SourceTbl.MDM_WEB_CD
	,TargetTbl.MilitarySpecPartNo = SourceTbl.MILITARY_SPEC_PART_NO
	,TargetTbl.NetWeightQt = SourceTbl.NET_WEIGHT_QT
	,TargetTbl.PartDs = SourceTbl.PART_DS
	,TargetTbl.ProcurementStrategy = SourceTbl.PROCUREMENT_STRATEGY
	,TargetTbl.ProgrammableFl = SourceTbl.PROGRAMMABLE_FL
	,TargetTbl.RenewableFl = SourceTbl.RENEWABLE_FL
	,TargetTbl.ReplacementPartNo = SourceTbl.REPLACEMENT_PART_NO
	,TargetTbl.ResyndFl = SourceTbl.RESYND_FL
	,TargetTbl.SapBaseUnitOfMsrCd = SourceTbl.SAP_BASE_UNIT_OF_MSR_CD
	,TargetTbl.SapDimUnitOfMeasureCd = SourceTbl.SAP_DIM_UNIT_OF_MEASURE_CD
	,TargetTbl.SapEcomStockStrategyCd = SourceTbl.SAP_ECOM_STOCK_STRATEGY_CD
	,TargetTbl.SapExternalMatlGroup = SourceTbl.SAP_EXTERNAL_MATL_GROUP
	,TargetTbl.SapGreenCd = SourceTbl.SAP_GREEN_CD
	,TargetTbl.SapJitCd = SourceTbl.SAP_JIT_CD
	,TargetTbl.SapLeadFreeCd = SourceTbl.SAP_LEAD_FREE_CD
	,TargetTbl.SapMaterialGroupCd = SourceTbl.SAP_MATERIAL_GROUP_CD
	,TargetTbl.SapMaterialId = SourceTbl.SAP_MATERIAL_ID
	,TargetTbl.SapMaterialStatusCd = SourceTbl.SAP_MATERIAL_STATUS_CD
	,TargetTbl.SapMaterialTypeCd = SourceTbl.SAP_MATERIAL_TYPE_CD
	,TargetTbl.SapMatGroupPackagingCd = SourceTbl.SAP_MAT_GROUP_PACKAGING_CD
	,TargetTbl.SapMatIndstrySectorCd = SourceTbl.SAP_MAT_INDSTRY_SECTOR_CD
	,TargetTbl.SapMatItemCatgGroupCd = SourceTbl.SAP_MAT_ITEM_CATG_GROUP_CD
	,TargetTbl.SapOrderUnitOfMsureCd = SourceTbl.SAP_ORDER_UNIT_OF_MSURE_CD
	,TargetTbl.SapProductHierarchyCd = SourceTbl.SAP_PRODUCT_HIERARCHY_CD
	,TargetTbl.SapPurchasingValueCd = SourceTbl.SAP_PURCHASING_VALUE_CD
	,TargetTbl.SapRohsCd = SourceTbl.SAP_ROHS_CD
	,TargetTbl.SapScheduleBCd = SourceTbl.SAP_SCHEDULE_B_CD
	,TargetTbl.SapSerialNoLevelCd = SourceTbl.SAP_SERIAL_NO_LEVEL_CD
	,TargetTbl.SapStorageConditionCd = SourceTbl.SAP_STORAGE_CONDITION_CD
	,TargetTbl.SapTlaTypeCd = SourceTbl.SAP_TLA_TYPE_CD
	,TargetTbl.SapTransGroupCd = SourceTbl.SAP_TRANS_GROUP_CD
	,TargetTbl.SapVolUnitOfMeasureCd = SourceTbl.SAP_VOL_UNIT_OF_MEASURE_CD
	,TargetTbl.SapWstsCd = SourceTbl.SAP_WSTS_CD
	,TargetTbl.SapWtUnitOfMeasureCd = SourceTbl.SAP_WT_UNIT_OF_MEASURE_CD
	,TargetTbl.SendToSapFl = SourceTbl.SEND_TO_SAP_FL
	,TargetTbl.SentToSapDate = SourceTbl.SENT_TO_SAP_DATE
	,TargetTbl.SignedLicAgrmntReqFl = SourceTbl.SIGNED_LIC_AGRMNT_REQ_FL
	,TargetTbl.SizeDimensionsDs = SourceTbl.SIZE_DIMENSIONS_DS
	,TargetTbl.SoleSourceFl = SourceTbl.SOLE_SOURCE_FL
	,TargetTbl.SupplierLastTimeBuyDt = SourceTbl.SUPPLIER_LAST_TIME_BUY_DT
	,TargetTbl.SupplierLastTimeRetDt = SourceTbl.SUPPLIER_LAST_TIME_RET_DT
	,TargetTbl.SupplierLastTimeShipDt = SourceTbl.SUPPLIER_LAST_TIME_SHIP_DT
	,TargetTbl.TaskRequesterEmail = SourceTbl.TASK_REQUESTER_EMAIL
	,TargetTbl.TradeComplianceNoteTx = SourceTbl.TRADE_COMPLIANCE_NOTE_TX
	,TargetTbl.TransactablePartFl = SourceTbl.TRANSACTABLE_PART_FL
	,TargetTbl.UpdatedBy = SourceTbl.UPDATED_BY
	,TargetTbl.ValueAddedFl = SourceTbl.VALUE_ADDED_FL
	,TargetTbl.VolumeQt = SourceTbl.VOLUME_QT
	,TargetTbl.WarrantyDurationMonthQt = SourceTbl.WARRANTY_DURATION_MONTH_QT
	,TargetTbl.PackageQty = SourceTbl.PACKAGE_QTY

WHEN NOT MATCHED BY TARGET THEN
INSERT
(
AvnetLegacyPartId , AvnetValueAddNo , CcatsEncryptionRegNo , CmDirtyInd , ConsolidationInd , CreateDate , Creator , CustomReelableFl , DeletedBy , DeletedDate , DeletedInd , DemoPartValueAm , DimensionHeightQt , DimensionLengthQt , DimensionWidthQt , DirtyInd , EconomicProductionQt , ExportControlClassNo , FactoryStockAvailQt , FccFl , FdaFl , GrossWeightQt , HubStateInd , InspectionTx , InteractionId , InventoryMessageTx , ItarFl , LastRowidSystem , LastUpdateDate , ManufactFamilyPartNo , ManufacturerPartNo , MaterialDs , MaterialProdHierarchyId , MaterialStatusDt , MaterialSuppressSyndFl , MdmActionCd , MdmManufacturerPartyId , MdmSmxqDeviationCd , MdmUnspscCd , MdmUsmlCd , MdmWebCd , MilitarySpecPartNo , NetWeightQt , PartDs , ProcurementStrategy , ProgrammableFl , RenewableFl , ReplacementPartNo , ResyndFl , RowidObject , SapBaseUnitOfMsrCd , SapDimUnitOfMeasureCd , SapEcomStockStrategyCd , SapExternalMatlGroup , SapGreenCd , SapJitCd , SapLeadFreeCd , SapMaterialGroupCd , SapMaterialId , SapMaterialStatusCd , SapMaterialTypeCd , SapMatGroupPackagingCd , SapMatIndstrySectorCd , SapMatItemCatgGroupCd , SapOrderUnitOfMsureCd , SapProductHierarchyCd , SapPurchasingValueCd , SapRohsCd , SapScheduleBCd , SapSerialNoLevelCd , SapStorageConditionCd , SapTlaTypeCd , SapTransGroupCd , SapVolUnitOfMeasureCd , SapWstsCd , SapWtUnitOfMeasureCd , SendToSapFl , SentToSapDate , SignedLicAgrmntReqFl , SizeDimensionsDs , SoleSourceFl , SupplierLastTimeBuyDt , SupplierLastTimeRetDt , SupplierLastTimeShipDt , TaskRequesterEmail , TradeComplianceNoteTx , TransactablePartFl , UpdatedBy , ValueAddedFl , VolumeQt , WarrantyDurationMonthQt , PackageQty
)
VALUES (AVNET_LEGACY_PART_ID, AVNET_VALUE_ADD_NO, CCATS_ENCRYPTION_REG_NO, CM_DIRTY_IND, CONSOLIDATION_IND, CREATE_DATE, CREATOR, CUSTOM_REELABLE_FL, DELETED_BY, DELETED_DATE, DELETED_IND, DEMO_PART_VALUE_AM, DIMENSION_HEIGHT_QT, DIMENSION_LENGTH_QT, DIMENSION_WIDTH_QT, DIRTY_IND, ECONOMIC_PRODUCTION_QT, EXPORT_CONTROL_CLASS_NO, FACTORY_STOCK_AVAIL_QT, FCC_FL, FDA_FL, GROSS_WEIGHT_QT, HUB_STATE_IND, INSPECTION_TX, INTERACTION_ID, INVENTORY_MESSAGE_TX, ITAR_FL, LAST_ROWID_SYSTEM, LAST_UPDATE_DATE, MANUFACT_FAMILY_PART_NO, MANUFACTURER_PART_NO, MATERIAL_DS, MATERIAL_PROD_HIERARCHY_ID, MATERIAL_STATUS_DT, MATERIAL_SUPPRESS_SYND_FL, MDM_ACTION_CD, MDM_MANUFACTURER_PARTY_ID, MDM_SMXQ_DEVIATION_CD, MDM_UNSPSC_CD, MDM_USML_CD, MDM_WEB_CD, MILITARY_SPEC_PART_NO, NET_WEIGHT_QT, PART_DS, PROCUREMENT_STRATEGY, PROGRAMMABLE_FL, RENEWABLE_FL, REPLACEMENT_PART_NO, RESYND_FL, ROWID_OBJECT, SAP_BASE_UNIT_OF_MSR_CD, SAP_DIM_UNIT_OF_MEASURE_CD, SAP_ECOM_STOCK_STRATEGY_CD, SAP_EXTERNAL_MATL_GROUP, SAP_GREEN_CD, SAP_JIT_CD, SAP_LEAD_FREE_CD, SAP_MATERIAL_GROUP_CD, SAP_MATERIAL_ID, SAP_MATERIAL_STATUS_CD, SAP_MATERIAL_TYPE_CD, SAP_MAT_GROUP_PACKAGING_CD, SAP_MAT_INDSTRY_SECTOR_CD, SAP_MAT_ITEM_CATG_GROUP_CD, SAP_ORDER_UNIT_OF_MSURE_CD, SAP_PRODUCT_HIERARCHY_CD, SAP_PURCHASING_VALUE_CD, SAP_ROHS_CD, SAP_SCHEDULE_B_CD, SAP_SERIAL_NO_LEVEL_CD, SAP_STORAGE_CONDITION_CD, SAP_TLA_TYPE_CD, SAP_TRANS_GROUP_CD, SAP_VOL_UNIT_OF_MEASURE_CD, SAP_WSTS_CD, SAP_WT_UNIT_OF_MEASURE_CD, SEND_TO_SAP_FL, SENT_TO_SAP_DATE, SIGNED_LIC_AGRMNT_REQ_FL, SIZE_DIMENSIONS_DS, SOLE_SOURCE_FL, SUPPLIER_LAST_TIME_BUY_DT, SUPPLIER_LAST_TIME_RET_DT, SUPPLIER_LAST_TIME_SHIP_DT, TASK_REQUESTER_EMAIL, TRADE_COMPLIANCE_NOTE_TX, TRANSACTABLE_PART_FL, UPDATED_BY, VALUE_ADDED_FL, VOLUME_QT, WARRANTY_DURATION_MONTH_QT, PACKAGE_QTY)
;

DROP TABLE #AvrMTemp