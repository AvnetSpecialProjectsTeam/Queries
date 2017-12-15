SELECT *
INTO #AvrMphTemp
FROM OPENQUERY(AVR80, 'SELECT *
FROM GOLDEN.C_BO_MATL_PROD_HIERARCHY')

MERGE MaterialProdHier AS TargetTbl
USING #AvrMphTemp AS SourceTbl
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
		,TargetTbl.ProductHierarchyCode = SourceTbl.PRODUCT_HIERARCHY_CODE
		,TargetTbl.SapMatlProdHierNm = SourceTbl.SAP_MATL_PROD_HIER_NM
		,TargetTbl.SapProductBusGroupCd = SourceTbl.SAP_PRODUCT_BUS_GROUP_CD
		,TargetTbl.SapProcureStrategyCd = SourceTbl.SAP_PROCURE_STRATEGY_CD
		,TargetTbl.SapTechnologyCd = SourceTbl.SAP_TECHNOLOGY_CD
		,TargetTbl.SapCommodityCd = SourceTbl.SAP_COMMODITY_CD
		,TargetTbl.SapProductGroupCd = SourceTbl.SAP_PRODUCT_GROUP_CD

WHEN NOT MATCHED BY TARGET THEN
INSERT
(
	RowIdObject , Creator , CreateDate , UpdatedBy , LastUpdateDate , ConsolidationInd , DeletedInd , DeletedBy , DeletedDate , LastRowidSystem , DirtyInd , InteractionId , HubStateInd , CmDirtyInd , ProductHierarchyCode , SapMatlProdHierNm , SapProductBusGroupCd , SapProcureStrategyCd , SapTechnologyCd , SapCommodityCd , SapProductGroupCd
)
VALUES(ROWID_OBJECT, CREATOR, CREATE_DATE, UPDATED_BY, LAST_UPDATE_DATE, CONSOLIDATION_IND, DELETED_IND, DELETED_BY, DELETED_DATE, LAST_ROWID_SYSTEM, DIRTY_IND, INTERACTION_ID, HUB_STATE_IND, CM_DIRTY_IND, PRODUCT_HIERARCHY_CODE, SAP_MATL_PROD_HIER_NM, SAP_PRODUCT_BUS_GROUP_CD, SAP_PROCURE_STRATEGY_CD, SAP_TECHNOLOGY_CD, SAP_COMMODITY_CD, SAP_PRODUCT_GROUP_CD)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;

DROP TABLE #AvrMphTemp