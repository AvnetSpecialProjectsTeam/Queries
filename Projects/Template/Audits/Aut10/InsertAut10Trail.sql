UPDATE ImportAut10Trail
SET [Column 3] = CONCAT(SUBSTRING([column 3],7,4),'-', SUBSTRING([column 3],1,2),'-',SUBSTRING([column 3],4,2))
	,[Column 18] = Replace([Column 18], ' ','')
  ,[Column 24]=Replace(Replace([Column 24],' ',''),'|','')
WHERE [Column 2]=1
GO


INSERT INTO Aut10Trail
(
		[SelectionNbr]
      ,[LogDt]
      ,[LogTime]
      ,[ChgdBy]
      ,[EmpName]
      ,[TransactionCd]
      ,[TransactionName]
      ,[SapTable]
      ,[TableDesc]
      ,[TableField]
      ,[FieldLabel]
      ,[OldVal]
      ,[NewVal]
      ,[DataRecord]
      ,[ChgDocObj]
      ,[ObjVal]
      ,[TableKey]
      ,[ChgNbr]
      ,[PlannedChgNbr]
      ,[PlannedChgDoc]
      ,[PlannedChg]
      ,[TxtChg]
      ,[Lang]
)
SELECT
	  [Column 2]
      ,[Column 3]
      ,[Column 4]
      ,[Column 5]
      ,[Column 6]
      ,[Column 7]
      ,[Column 8]
      ,[Column 9]
      ,[Column 10]
      ,[Column 11]
      ,[Column 12]
      ,[Column 13]
      ,[Column 14]
      ,[Column 15]
      ,[Column 16]
      ,[Column 17]
      ,[Column 18]
      ,[Column 19]
      ,[Column 20]
      ,[Column 21]
      ,[Column 22]
      ,[Column 23]
      ,[Column 24]
FROM ImportAut10Trail
WHERE ImportAut10Trail.[column 2]=1
GO

TRUNCATE TABLE ImportAut10Trail