SELECT *
INTO #AvrMsoTemp
FROM OPENQUERY(AVR80, 'SELECT *
FROM GOLDEN.C_BO_MATERIAL_SALES_ORG
WHERE (((LAST_UPDATE_DATE) > SYSDATE-7))')

USE MDM
GO


MERGE MaterialSalesOrg AS TargetTbl
USING #AvrMsoTemp AS SourceTbl
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
	,TargetTbl.LastRowIdSystem = SourceTbl.LAST_ROWID_SYSTEM
	,TargetTbl.DirtyInd = SourceTbl.DIRTY_IND
	,TargetTbl.InteractionId = SourceTbl.INTERACTION_ID
	,TargetTbl.HubStateInd = SourceTbl.HUB_STATE_IND
	,TargetTbl.CmDirtyInd = SourceTbl.CM_DIRTY_IND
	,TargetTbl.MdmMaterialId = SourceTbl.MDM_MATERIAL_ID
	,TargetTbl.SapSalesOrgCd = SourceTbl.SAP_SALES_ORG_CD
	,TargetTbl.SapCentralStockPlantCd = SourceTbl.SAP_CENTRAL_STOCK_PLANT_CD
	,TargetTbl.SalesMinimumOrderQt = SourceTbl.SALES_MINIMUM_ORDER_QT
	,TargetTbl.SapDesignWinAvailCd = SourceTbl.SAP_DESIGN_WIN_AVAIL_CD
	,TargetTbl.SapMatlItemCatGroupCd = SourceTbl.SAP_MATL_ITEM_CAT_GROUP_CD
	,TargetTbl.SapMatlSplHandlingCd = SourceTbl.SAP_MATL_SPL_HANDLING_CD
	,TargetTbl.SapSmallOrderStratCd = SourceTbl.SAP_SMALL_ORDER_STRAT_CD
	,TargetTbl.CustomProductFl = SourceTbl.CUSTOM_PRODUCT_FL
	,TargetTbl.NonCancelNonReturnFl = SourceTbl.NON_CANCEL_NON_RETURN_FL
	,TargetTbl.SoftwareLicenseReqFl = SourceTbl.SOFTWARE_LICENSE_REQ_FL
	,TargetTbl.DesignWinEffFromDt = SourceTbl.DESIGN_WIN_EFF_FROM_DT
	,TargetTbl.DesignWinEffThruDt = SourceTbl.DESIGN_WIN_EFF_THRU_DT
	,TargetTbl.SapMatlPricingGroupCd = SourceTbl.SAP_MATL_PRICING_GROUP_CD
	,TargetTbl.DesignWinGrandfatherDt = SourceTbl.DESIGN_WIN_GRANDFATHER_DT
	,TargetTbl.NonDisclosurAgrmtReqFl = SourceTbl.NON_DISCLOSUR_AGRMT_REQ_FL
	,TargetTbl.DualMarkingFl = SourceTbl.DUAL_MARKING_FL
	,TargetTbl.SalesMessageTx = SourceTbl.SALES_MESSAGE_TX
	,TargetTbl.SapStockingProfileCd = SourceTbl.SAP_STOCKING_PROFILE_CD
	,TargetTbl.WaiverRequiredFl = SourceTbl.WAIVER_REQUIRED_FL
	,TargetTbl.SapDistributionChnlCd = SourceTbl.SAP_DISTRIBUTION_CHNL_CD
	,TargetTbl.LiquidationAllowedFl = SourceTbl.LIQUIDATION_ALLOWED_FL
	,TargetTbl.SapSalesUnitOfMsrCd = SourceTbl.SAP_SALES_UNIT_OF_MSR_CD
	,TargetTbl.SapMatlSalesDistStsCd = SourceTbl.SAP_MATL_SALES_DIST_STS_CD
	,TargetTbl.MinimumDeliveryQt = SourceTbl.MINIMUM_DELIVERY_QT
	,TargetTbl.MatlSalesDistStsEffDt = SourceTbl.MATL_SALES_DIST_STS_EFF_DT
	,TargetTbl.SapElectroStaticDisCd = SourceTbl.SAP_ELECTRO_STATIC_DIS_CD
	,TargetTbl.DownloadableFl = SourceTbl.DOWNLOADABLE_FL
	,TargetTbl.GlobalInventEligibleFl = SourceTbl.GLOBAL_INVENT_ELIGIBLE_FL
	,TargetTbl.NaftaFl = SourceTbl.NAFTA_FL
	,TargetTbl.ExistsWithinSapFl = SourceTbl.EXISTS_WITHIN_SAP_FL
	,TargetTbl.MdmExportSourceCd = SourceTbl.MDM_EXPORT_SOURCE_CD
	,TargetTbl.DeliveryUnitQt = SourceTbl.DELIVERY_UNIT_QT
	,TargetTbl.SapMatlAcctAssnGrpCd = SourceTbl.SAP_MATL_ACCT_ASSN_GRP_CD
	,TargetTbl.MaterialProdHierarchyId = SourceTbl.MATERIAL_PROD_HIERARCHY_ID
	,TargetTbl.MdmPriceRefMaterialId = SourceTbl.MDM_PRICE_REF_MATERIAL_ID
	,TargetTbl.SapProductHierarchyCd = SourceTbl.SAP_PRODUCT_HIERARCHY_CD
	,TargetTbl.MdmPriceRefMatlRowId = SourceTbl.MDM_PRICE_REF_MATL_ROWID

WHEN NOT MATCHED BY TARGET THEN
INSERT
(
	RowIdObject , Creator , CreateDate , UpdatedBy , LastUpdateDate , ConsolidationInd , DeletedInd , DeletedBy , DeletedDate , LastRowIdSystem , DirtyInd , InteractionId , HubStateInd , CmDirtyInd , MdmMaterialId , SapSalesOrgCd , SapCentralStockPlantCd , SalesMinimumOrderQt , SapDesignWinAvailCd , SapMatlItemCatGroupCd , SapMatlSplHandlingCd , SapSmallOrderStratCd , CustomProductFl , NonCancelNonReturnFl , SoftwareLicenseReqFl , DesignWinEffFromDt , DesignWinEffThruDt , SapMatlPricingGroupCd , DesignWinGrandfatherDt , NonDisclosurAgrmtReqFl , DualMarkingFl , SalesMessageTx , SapStockingProfileCd , WaiverRequiredFl , SapDistributionChnlCd , LiquidationAllowedFl , SapSalesUnitOfMsrCd , SapMatlSalesDistStsCd , MinimumDeliveryQt , MatlSalesDistStsEffDt , SapElectroStaticDisCd , DownloadableFl , GlobalInventEligibleFl , NaftaFl , ExistsWithinSapFl , MdmExportSourceCd , DeliveryUnitQt , SapMatlAcctAssnGrpCd , MaterialProdHierarchyId , MdmPriceRefMaterialId , SapProductHierarchyCd , MdmPriceRefMatlRowId
)
VALUES (ROWID_OBJECT, CREATOR, CREATE_DATE, UPDATED_BY, LAST_UPDATE_DATE, CONSOLIDATION_IND, DELETED_IND, DELETED_BY, DELETED_DATE, LAST_ROWID_SYSTEM, DIRTY_IND, INTERACTION_ID, HUB_STATE_IND, CM_DIRTY_IND, MDM_MATERIAL_ID, SAP_SALES_ORG_CD, SAP_CENTRAL_STOCK_PLANT_CD, SALES_MINIMUM_ORDER_QT, SAP_DESIGN_WIN_AVAIL_CD, SAP_MATL_ITEM_CAT_GROUP_CD, SAP_MATL_SPL_HANDLING_CD, SAP_SMALL_ORDER_STRAT_CD, CUSTOM_PRODUCT_FL, NON_CANCEL_NON_RETURN_FL, SOFTWARE_LICENSE_REQ_FL, DESIGN_WIN_EFF_FROM_DT, DESIGN_WIN_EFF_THRU_DT, SAP_MATL_PRICING_GROUP_CD, DESIGN_WIN_GRANDFATHER_DT, NON_DISCLOSUR_AGRMT_REQ_FL, DUAL_MARKING_FL, SALES_MESSAGE_TX, SAP_STOCKING_PROFILE_CD, WAIVER_REQUIRED_FL, SAP_DISTRIBUTION_CHNL_CD, LIQUIDATION_ALLOWED_FL, SAP_SALES_UNIT_OF_MSR_CD, SAP_MATL_SALES_DIST_STS_CD, MINIMUM_DELIVERY_QT, MATL_SALES_DIST_STS_EFF_DT, SAP_ELECTRO_STATIC_DIS_CD, DOWNLOADABLE_FL, GLOBAL_INVENT_ELIGIBLE_FL, NAFTA_FL, EXISTS_WITHIN_SAP_FL, MDM_EXPORT_SOURCE_CD, DELIVERY_UNIT_QT, SAP_MATL_ACCT_ASSN_GRP_CD, MATERIAL_PROD_HIERARCHY_ID, MDM_PRICE_REF_MATERIAL_ID, SAP_PRODUCT_HIERARCHY_CD, MDM_PRICE_REF_MATL_ROWID);

DROP TABLE #AvrMsoTemp

