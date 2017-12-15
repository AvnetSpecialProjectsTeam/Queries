USE BI
GO

UPDATE ImportBiPoCostConditions
SET  [Column 3]= 
	CASE 
		WHEN [Column 3] LIKE '%[-]' THEN CAST(REPLACE([Column 3],'-','')AS MONEY) *-1
		ELSE CAST([Column 3] AS MONEY)
	END
GO



DELETE  aliasName FROM (
SELECT  *,
        ROW_NUMBER() OVER (PARTITION BY [Column 0], [Column 1], [Column 2] ORDER BY [Column 0]) AS rowNumber
FROM    ImportBiPoCostConditions) aliasName 
WHERE   rowNumber > 1



MERGE BiPOCostConditions AS TargetTbl
USING ImportBiPoCostConditions AS SourceTbl
ON (TargetTbl.PoNbr=SourceTbl.[Column 0] AND TargetTbl.PoLineNbr=SourceTbl.[Column 1] AND TargetTbl.CostCond=SourceTbl.[Column 2])
WHEN MATCHED 
	AND TargetTbl.CostCondVal <> SourceTbl.[Column 3]
	OR TargetTbl.Curr <> SourceTbl.[Column 4]
THEN
	UPDATE SET
		TargetTbl.CostCondVal = SourceTbl.[Column 3],
		TargetTbl.Curr = SourceTbl.[Column 4]
WHEN NOT MATCHED BY TARGET THEN
INSERT(
	PoNbr
	,PoLineNbr
	,CostCond
	,CostCondVal
	,Curr
	)
VALUES(
	[Column 0]
	,[Column 1]
	,[Column 2]
	,[Column 3]
	,[Column 4]
	)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;
GO

TRUNCATE TABLE ImportBiPoCostConditions
