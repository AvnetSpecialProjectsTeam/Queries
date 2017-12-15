SELECT *
INTO #AvrChTemp
FROM OPENQUERY(AVR80,'SELECT *
FROM GOLDEN.C_BO_CONDITION_HEADER')


CREATE NONCLUSTERED INDEX AvrCh
ON #AvrChTemp (ROWID_OBJECT)  

USE MDM
GO

MERGE ConditionHeader AS TargetTbl
USING #AvrChTemp AS SourceTbl
ON (TargetTbl.RowIdObject=SourceTbl.ROWID_OBJECT)
WHEN MATCHED 
	AND TargetTbl.LastUpdateDate <> SourceTbl.LAST_UPDATE_DATE

THEN
	UPDATE SET
	TargetTbl.UpdateBy = SourceTbl.UPDATED_BY
	,TargetTbl.LastUpdateDate = SourceTbl.LAST_UPDATE_DATE
	,TargetTbl.ConsolidationInd = SourceTbl.CONSOLIDATION_IND
	,TargetTbl.[DeletionInd] = SourceTbl.DELETED_IND
	,TargetTbl.DeletedBy = SourceTbl.DELETED_BY
	,TargetTbl.DeletedDate = SourceTbl.DELETED_DATE
	,TargetTbl.LastRowIdSystem = SourceTbl.LAST_ROWID_SYSTEM
	,TargetTbl.DirtyInd = SourceTbl.DIRTY_IND
	,TargetTbl.InteractionId = SourceTbl.INTERACTION_ID
	,TargetTbl.HubStateInd = SourceTbl.HUB_STATE_IND
	,TargetTbl.CMDirtyInd = SourceTbl.CM_DIRTY_IND
	,TargetTbl.ConditionRecordNo = SourceTbl.CONDITION_RECORD_NO
	,TargetTbl.ValidFromDt = SourceTbl.VALID_FROM_DT
	,TargetTbl.ValidToDt = SourceTbl.VALID_TO_DT
	,TargetTbl.SAPConditionTypeCode = SourceTbl.SAP_CONDITION_TYPE_CODE
	,TargetTbl.[MDMVendMatlPoPlantId] = SourceTbl.MDM_VEND_MATL_PO_PLANT_ID

WHEN NOT MATCHED BY TARGET THEN
INSERT(
	RowIdObject , Creator , CreateDate , UpdateBy , LastUpdateDate , ConsolidationInd , DeletionInd , DeletedBy , DeletedDate , LastRowIdSystem , DirtyInd , InteractionId , HubStateInd , CMDirtyInd , ConditionRecordNo , ValidFromDt , ValidToDt , SAPConditionTypeCode , [MDMVendMatlPoPlantId]
)
VALUES(  ROWID_OBJECT, CREATOR, CREATE_DATE, UPDATED_BY, LAST_UPDATE_DATE, CONSOLIDATION_IND, DELETED_IND, DELETED_BY, DELETED_DATE, LAST_ROWID_SYSTEM, DIRTY_IND, INTERACTION_ID, HUB_STATE_IND, CM_DIRTY_IND, CONDITION_RECORD_NO, VALID_FROM_DT, VALID_TO_DT, SAP_CONDITION_TYPE_CODE, MDM_VEND_MATL_PO_PLANT_ID
)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;

DROP TABLE #AvrChTemp