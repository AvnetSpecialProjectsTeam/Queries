SELECT *
INTO #AvrVmpopTemp
FROM OPENQUERY(AVR80,'SELECT *
FROM GOLDEN.C_BO_VND_MT_PUR_ORG_PLNT')


CREATE NONCLUSTERED INDEX AvrVmpop
ON #AvrVmpopTemp (ROWID_OBJECT)   


USE MDM
GO

MERGE VendMatPurOrgPlant AS TargetTbl
USING #AvrVmpopTemp AS SourceTbl
ON (TargetTbl.RowIdObject=SourceTbl.ROWID_OBJECT)
WHEN MATCHED 
	AND TargetTbl.LastUpdateDate <> SourceTbl.LAST_UPDATE_DATE

THEN
	UPDATE SET
	TargetTbl.UpdatedBy = SourceTbl.UPDATED_BY
	,TargetTbl.LastUpdateDate = SourceTbl.LAST_UPDATE_DATE
	,TargetTbl.CondsolidationInd = SourceTbl.CONSOLIDATION_IND
	,TargetTbl.DeletedInd = SourceTbl.DELETED_IND
	,TargetTbl.DeletedBy = SourceTbl.DELETED_BY
	,TargetTbl.DeletedDate = SourceTbl.DELETED_DATE
	,TargetTbl.LastRowIdSystem = SourceTbl.LAST_ROWID_SYSTEM
	,TargetTbl.DirtyInd = SourceTbl.DIRTY_IND
	,TargetTbl.InteractionId = SourceTbl.INTERACTION_ID
	,TargetTbl.HubStateInd = SourceTbl.HUB_STATE_IND
	,TargetTbl.CMDirtyInd = SourceTbl.CM_DIRTY_IND
	,TargetTbl.SAPPurchasingOrgCD = SourceTbl.SAP_PURCHASING_ORG_CD
	,TargetTbl.SAPPlantCD = SourceTbl.SAP_PLANT_CD
	,TargetTbl.PriceProtectEligibleFL = SourceTbl.PRICE_PROTECT_ELIGIBLE_FL
	,TargetTbl.SupplierMinPackageQt = SourceTbl.SUPPLIER_MIN_PACKAGE_QT
	,TargetTbl.SupplierMinOrderQt = SourceTbl.SUPPLIER_MIN_ORDER_QT
	,TargetTbl.MDMVendorMaterialId = SourceTbl.MDM_VENDOR_MATERIAL_ID
	,TargetTbl.SAPPirCategoryDc = SourceTbl.SAP_PIR_CATEGORY_CD


WHEN NOT MATCHED BY TARGET THEN
INSERT(RowIdObject , Creator , CreateDate , UpdatedBy , LastUpdateDate , CondsolidationInd , DeletedInd , DeletedBy , DeletedDate , LastRowIdSystem , DirtyInd , InteractionId , HubStateInd , CMDirtyInd , SAPPurchasingOrgCD , SAPPlantCD , PriceProtectEligibleFL , SupplierMinPackageQt , SupplierMinOrderQt , MDMVendorMaterialId , SAPPirCategoryDc)
VALUES(ROWID_OBJECT, CREATOR, CREATE_DATE, UPDATED_BY, LAST_UPDATE_DATE, CONSOLIDATION_IND, DELETED_IND, DELETED_BY, DELETED_DATE, LAST_ROWID_SYSTEM, DIRTY_IND, INTERACTION_ID, HUB_STATE_IND, CM_DIRTY_IND, SAP_PURCHASING_ORG_CD, SAP_PLANT_CD, PRICE_PROTECT_ELIGIBLE_FL, SUPPLIER_MIN_PACKAGE_QT, SUPPLIER_MIN_ORDER_QT, MDM_VENDOR_MATERIAL_ID, SAP_PIR_CATEGORY_CD
)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;

DROP TABLE #AvrVmpopTemp