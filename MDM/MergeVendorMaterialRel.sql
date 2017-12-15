SELECT *
INTO #AvrVmrTemp
FROM OPENQUERY(AVR80,'SELECT *
FROM GOLDEN.C_VENDOR_MATERIAL_REL
WHERE (((LAST_UPDATE_DATE) > SYSDATE-10))')

USE MDM
GO

MERGE [VendorMaterialRel] AS TargetTbl
USING #AvrVmrTemp AS SourceTbl
ON (TargetTbl.RowIdObject=SourceTbl.ROWID_OBJECT)
WHEN MATCHED 
	AND TargetTbl.LastUpdateDate <> SourceTbl.LAST_UPDATE_DATE

THEN
	UPDATE SET
	TargetTbl. UpdateBy  = SourceTbl. UPDATED_BY
	,TargetTbl. LastUpdateDate  = SourceTbl. LAST_UPDATE_DATE
	,TargetTbl. ConsolidationInd  = SourceTbl. CONSOLIDATION_IND
	,TargetTbl. DeleteInd  = SourceTbl. DELETED_IND
	,TargetTbl. DeleteBy  = SourceTbl. DELETED_BY
	,TargetTbl. DeleteDate  = SourceTbl. DELETED_DATE
	,TargetTbl. LastRowIdSystem  = SourceTbl. LAST_ROWID_SYSTEM
	,TargetTbl. DirtyInd  = SourceTbl. DIRTY_IND
	,TargetTbl. InteractionId  = SourceTbl. INTERACTION_ID
	,TargetTbl. HubStateInd  = SourceTbl. HUB_STATE_IND
	,TargetTbl. CMDirtyInd  = SourceTbl. CM_DIRTY_IND
	,TargetTbl. MDMMaterialID  = SourceTbl. MDM_MATERIAL_ID
	,TargetTbl. MDMVendorPartyId  = SourceTbl. MDM_VENDOR_PARTY_ID
	,TargetTbl. VendorPartNo = SourceTbl. VENDOR_PART_NO


WHEN NOT MATCHED BY TARGET THEN
INSERT (RowIdObject , Creator , CreateDate , UpdateBy , LastUpdateDate , ConsolidationInd , DeleteInd , DeleteBy , DeleteDate , LastRowIdSystem , DirtyInd , InteractionId , HubStateInd , CMDirtyInd , MDMMaterialID , MDMVendorPartyId , VendorPartNo)

VALUES(ROWID_OBJECT, CREATOR, CREATE_DATE, UPDATED_BY, LAST_UPDATE_DATE, CONSOLIDATION_IND, DELETED_IND, DELETED_BY, DELETED_DATE, LAST_ROWID_SYSTEM, DIRTY_IND, INTERACTION_ID, HUB_STATE_IND, CM_DIRTY_IND, MDM_MATERIAL_ID, MDM_VENDOR_PARTY_ID, VENDOR_PART_NO
);

DROP TABLE #AvrVmrTemp