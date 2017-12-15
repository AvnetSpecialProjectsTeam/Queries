DECLARE @Start DATETIME2 = GETDATE()-30
DECLARE @End DATETIME2=GETDATE()


--UPDATE ConditionItem
--SET 

SELECT B.*
FROM
	(SELECT A.*
	FROM
		(SELECT Ci.RowIdObject, CAST(Ci.LastUpdateDate AS DATE) AS Update1, CAST(Ci.SqlStartTime AS DATE) AS Start1, CAST(Ci.SqlEndTime AS DATE) AS End1, RANK() OVER(PARTITION BY Ci.RowIdObject ORDER BY Ci.RowIdObject, Ci.LastUpdateDate) AS Rank1
		FROM MDM.dbo.ConditionItem
		FOR SYSTEM_TIME
		BETWEEN @Start AND @End AS Ci) AS A
		WHERE Rank1>1) AS A
	INNER JOIN 
		(SELECT Ci.RowIdObject, CAST(Ci.LastUpdateDate AS DATE) AS Update1, CAST(Ci.SqlStartTime AS DATE) AS Start1, CAST(Ci.SqlEndTime AS DATE) AS End1, RANK() OVER(PARTITION BY Ci.RowIdObject ORDER BY Ci.RowIdObject, Ci.LastUpdateDate) AS Rank1
		FROM MDM.dbo.ConditionItem
		FOR SYSTEM_TIME
		BETWEEN @Start AND @End AS Ci) AS B
		ON A.RowIdObject=B.RowIdObject
--WHERE DATEADD(DAY,1,B.Update1)<> B.Start1 AND DATEADD(DAY,1,B.Update1)<>B.End1 AND B.Rank1>2
ORDER BY B.RowIdObject, B.Update1



