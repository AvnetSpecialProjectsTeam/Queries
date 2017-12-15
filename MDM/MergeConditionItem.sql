SELECT *
INTO #AvrCiTemp
FROM OPENQUERY(AVR80,'SELECT *
FROM GOLDEN.C_BO_CONDITION_ITEM
WHERE (((LAST_UPDATE_DATE) > SYSDATE-30))')


CREATE NONCLUSTERED INDEX AvrCi
ON #AvrCiTemp (ROWID_OBJECT)  
GO

USE MDM
GO

MERGE ConditionItem AS TargetTbl
USING #AvrCiTemp AS SourceTbl
ON (TargetTbl.RowIdObject=SourceTbl.ROWID_OBJECT)
WHEN MATCHED 
	AND TargetTbl.LastUpdateDate <> SourceTbl.LAST_UPDATE_DATE

THEN
	UPDATE SET
	TargetTbl.UpdatedBy = SourceTbl.UPDATED_BY
	,TargetTbl.LastUpdateDate = SourceTbl.LAST_UPDATE_DATE
	,TargetTbl.ConditionIdn = SourceTbl.CONSOLIDATION_IND
	,TargetTbl.DeletedInd = SourceTbl.DELETED_IND
	,TargetTbl.DeletedBy = SourceTbl.DELETED_BY
	,TargetTbl.DeletedDate = SourceTbl.DELETED_DATE
	,TargetTbl.LastRowIdSystem = SourceTbl.LAST_ROWID_SYSTEM
	,TargetTbl.DirtyInd = SourceTbl.DIRTY_IND
	,TargetTbl.InteractionId = SourceTbl.INTERACTION_ID
	,TargetTbl.HubStateInd = SourceTbl.HUB_STATE_IND
	,TargetTbl.CMDirtyInd = SourceTbl.CM_DIRTY_IND
	,TargetTbl.ConditionAM = SourceTbl.CONDITION_AM
	,TargetTbl.ConditionSqNo = SourceTbl.CONDITION_SQ_NO
	,TargetTbl.MinConditionQt = SourceTbl.MIN_CONDITION_QT
	,TargetTbl.MaxConditionQt = SourceTbl.MAX_CONDITION_QT
	,TargetTbl.SAPCurrencyCode = SourceTbl.SAP_CURRENCY_CODE
	,TargetTbl.MDMConditionHeaderId = SourceTbl.MDM_CONDITION_HEADER_ID
	,TargetTbl.ConditionPricingUnitQt = SourceTbl.CONDITION_PRICING_UNIT_QT
	,TargetTbl.SAPConditionScaleUomCD = SourceTbl.SAP_CONDITION_SCALE_UOM_CD
	,TargetTbl.SAPConditionTypeCD = SourceTbl.SAP_CONDITION_TYPE_CD


WHEN NOT MATCHED BY TARGET THEN
INSERT(
	RowIdObject , Creator , CreateDate , UpdatedBy , LastUpdateDate , ConditionIdn , DeletedInd , DeletedBy , DeletedDate , LastRowIdSystem , DirtyInd , InteractionId , HubStateInd , CMDirtyInd , ConditionAM , ConditionSqNo , MinConditionQt , MaxConditionQt , SAPCurrencyCode , MDMConditionHeaderId , ConditionPricingUnitQt , SAPConditionScaleUomCD , SAPConditionTypeCD
)
VALUES(ROWID_OBJECT, CREATOR, CREATE_DATE, UPDATED_BY, LAST_UPDATE_DATE, CONSOLIDATION_IND, DELETED_IND, DELETED_BY, DELETED_DATE, LAST_ROWID_SYSTEM, DIRTY_IND, INTERACTION_ID, HUB_STATE_IND, CM_DIRTY_IND, CONDITION_AM, CONDITION_SQ_NO, MIN_CONDITION_QT, MAX_CONDITION_QT, SAP_CURRENCY_CODE, MDM_CONDITION_HEADER_ID, CONDITION_PRICING_UNIT_QT, SAP_CONDITION_SCALE_UOM_CD, SAP_CONDITION_TYPE_CD
);

DROP TABLE #AvrCiTemp