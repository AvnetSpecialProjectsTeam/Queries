USE NonHaImportTesting
GO

SELECT *
INTO #AVRTemp
FROM OPENQUERY(AVR80, 'SELECT *
FROM GOLDEN.C_BT_MRP_CONTROLLER
WHERE (((CREATE_DATE) > SYSDATE-5))')

INSERT INTO MRP_CONTROLLER
SELECT *
FROM #AVRTemp
WHERE NOT EXISTS(
SELECT *
FROM MRP_CONTROLLER
WHERE MRP_CONTROLLER.RowidObject = #AVRTemp.ROWID_OBJECT)

DROP TABLE #AVRTemp