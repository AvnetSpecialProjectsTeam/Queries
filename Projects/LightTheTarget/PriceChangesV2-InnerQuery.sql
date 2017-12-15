DECLARE @Start DATETIME2 = GETDATE()-3
DECLARE @End DATETIME2=GETDATE()

SELECT Distinct B.RowidObject, B.MDMConditionHeaderId, B.MdmUpdateDate, B.SqlServerStartDate, B.SqlServerEndDate, B.ConditionAM, B.SAPConditionTypeCD
FROM
       (SELECT A.*
       FROM
             (--Grabbing all records that have a change on ConditionAm except current (current = rank 1)
			 SELECT Ci.RowIdObject, Ci.MDMConditionHeaderId, SapConditionTypeCd, CAST(Ci.LastUpdateDate AS DATE) AS MdmUpdateDate, CAST(Ci.SqlStartTime AS DATE) AS SqlServerStartDate, CAST(Ci.SqlEndTime AS DATE) AS SqlServerEndDate, Ci.ConditionAm, RANK() OVER(PARTITION BY Ci.RowIdObject ORDER BY Ci.RowIdObject,  Ci.ConditionAM) AS Rank1
             FROM MDM.dbo.ConditionItem
             FOR SYSTEM_TIME
             BETWEEN @Start AND @End AS Ci) AS A
             WHERE Rank1>1) AS A
       INNER JOIN 
             (--Grabbing everything that has changes
			 SELECT Ci.RowIdObject, Ci.MDMConditionHeaderId, SapConditionTypeCd, CAST(Ci.LastUpdateDate AS DATE) AS MdmUpdateDate, CAST(Ci.SqlStartTime AS DATE) AS SqlServerStartDate, CAST(Ci.SqlEndTime AS DATE) AS SqlServerEndDate, Ci.ConditionAm, RANK() OVER(PARTITION BY Ci.RowIdObject ORDER BY Ci.RowIdObject,  Ci.ConditionAM) AS Rank1
             FROM MDM.dbo.ConditionItem
             FOR SYSTEM_TIME
             BETWEEN @Start AND @End AS Ci) AS B
             ON A.RowIdObject=B.RowIdObject