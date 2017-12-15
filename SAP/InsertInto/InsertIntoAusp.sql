USE NonHaImportTesting
GO 

				
TRUNCATE TABLE SAP.dbo.Ausp
GO

INSERT INTO SAP.dbo.Ausp
(
[Client]
      ,[Object]
      ,[InternalChar]
      ,[CharValCounter]
      ,[ObjectClass]
      ,[ClassTyp]
      ,[IntCounterArchiveObj]
      ,[CharVal]
      ,[FloatingPtValFrom]
      ,[IntMeasUnItmE]
      ,[FloatingPtValTo]
      ,[IntMeasUnItm1]
      ,[CdValDependency]
      ,[TolFrom]
      ,[TolTo]
      ,[TolAsPercent]
      ,[IncrementWithinInterval]
      ,[Author]
      ,[ChangeNbr]
      ,[ValidFromDt]
      ,[DeletionId]
      ,[CharNbrDataTyp]
      ,[InstanceCntr]
      ,[SortFieldAUSP]
      ,[CompTyp]

)
SELECT 
[Column 0]
,[Column 1]
,[Column 2]
,[Column 3]
,[Column 4]
,[Column 5]
,[Column 6]
,[Column 7]
,[Column 8]=LTRIM(RTRIM(CASE WHEN [Column 8] like '%E-%' THEN CAST(CAST([Column 8] AS FLOAT) AS DECIMAL(18,18)) WHEN [Column 8] like '%E+%' THEN CAST(CAST([Column 8] AS FLOAT) AS DECIMAL) ELSE [Column 8] END))
,[Column 9]
,[Column 10]=LTRIM(RTRIM(CASE WHEN [Column 10] like '%E-%' THEN CAST(CAST([Column 10] AS FLOAT) AS DECIMAL(18,18)) WHEN [Column 10] like '%E+%' THEN CAST(CAST([Column 10] AS FLOAT) AS DECIMAL) ELSE [Column 10] END)) 
,[Column 11]
,[Column 12]
,[Column 13]=LTRIM(RTRIM(CASE WHEN [Column 13] like '%E-%' THEN CAST(CAST([Column 13] AS FLOAT) AS DECIMAL(18,18)) WHEN [Column 13] like '%E+%' THEN CAST(CAST([Column 13] AS FLOAT) AS DECIMAL) ELSE [Column 13] END))
,[Column 14]=LTRIM(RTRIM(CASE WHEN [Column 14] like '%E-%' THEN CAST(CAST([Column 14] AS FLOAT) AS DECIMAL(18,18)) WHEN [Column 14] like '%E+%' THEN CAST(CAST([Column 14] AS FLOAT) AS DECIMAL) ELSE [Column 14] END)) 
,[Column 15]
,[Column 16]=LTRIM(RTRIM(CASE WHEN [Column 16] like '%E-%' THEN CAST(CAST([Column 16] AS FLOAT) AS DECIMAL(18,18)) WHEN [Column 16] like '%E+%' THEN CAST(CAST([Column 16] AS FLOAT) AS DECIMAL) ELSE [Column 16] END))
,[Column 17]
,[Column 18]
,[Column 19]= CASE WHEN len([Column 19])<6 Or [Column 19] NOT LIKE '%[1-9]%'THEN NULL ELSE [Column 19] END
,[Column 20]
,[Column 21]
,[Column 22]
,[Column 23]
,[Column 24]= CASE When [Column 24] NOT LIKE '%[a-z0-9]%' THEN NULL	ELSE [Column 24] END

FROM ImportAusp
WHERE [Column 0] Is Not Null AND [Column 0]<>''

--TRUNCATE TABLE ImportAusp;

