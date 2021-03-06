/* USE NonHaImportTesting
GO */

SELECT *
INTO #AVRTemp
FROM OPENQUERY(AVR80,'SELECT *
FROM GOLDEN.C_BT_MRP_CONTROLLER
WHERE (((LAST_UPDATE_DATE) > SYSDATE-5))')
Go	

DECLARE @MDMtbl AS NVARCHAR(MAX)

SET @MDMtbl = 'MRP_CONTROLLER'

UPDATE MRP_CONTROLLER
SET
MRP_CONTROLLER.RowidObject = #AVRTemp.ROWID_OBJECT,
MRP_CONTROLLER.Creator = #AVRTemp.CREATOR,
MRP_CONTROLLER.CreateDate = #AVRTemp.CREATE_DATE,
MRP_CONTROLLER.UpdatedBy = #AVRTemp.UPDATED_BY,
MRP_CONTROLLER.LastUpdateDate = #AVRTemp.LAST_UPDATE_DATE,
MRP_CONTROLLER.ConsolidationInd = #AVRTemp.CONSOLIDATION_IND,
MRP_CONTROLLER.DeletedInd = #AVRTemp.DELETED_IND,
MRP_CONTROLLER.DeletedBy = #AVRTemp.DELETED_BY,
MRP_CONTROLLER.DeletedDate = #AVRTemp.DELETED_DATE,
MRP_CONTROLLER.LastRowidSystem = #AVRTemp.LAST_ROWID_SYSTEM,
MRP_CONTROLLER.DirtyInd = #AVRTemp.DIRTY_IND,
MRP_CONTROLLER.InteractionId = #AVRTemp.INTERACTION_ID,
MRP_CONTROLLER.HubStateInd = #AVRTemp.HUB_STATE_IND,
MRP_CONTROLLER.CmDirtyInd = #AVRTemp.CM_DIRTY_IND,
MRP_CONTROLLER.SapMrpControllerCd = #AVRTemp.SAP_MRP_CONTROLLER_CD,
MRP_CONTROLLER.SapMrpControllerNm = #AVRTemp.SAP_MRP_CONTROLLER_NM,
MRP_CONTROLLER.IddDisplayName = #AVRTemp.IDD_DISPLAY_NAME,
MRP_CONTROLLER.SapPlantCd = #AVRTemp.SAP_PLANT_CD


FROM #AVRTemp
INNER JOIN MRP_CONTROLLER
ON #AVRTemp.ROWID_OBJECT = MRP_CONTROLLER.RowidObject
WHERE MRP_CONTROLLER.LastUpdateDate<>#AVRTemp.LAST_UPDATE_DATE

DROP TABLE #AVRTemp

