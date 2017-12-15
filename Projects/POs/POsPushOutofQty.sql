DECLARE @Date AS DATETIME2='2017-10-02'
;

DROP TABLE #temp
SELECT *
INTO #temp
FROM
	(SELECT B.PoNbr, B.PoLine, B.PoSchedLine, B.SqlStartTime, MAX(B.rank1) AS RMax
	FROM
		(SELECT DISTINCT *, DENSE_RANK() OVER(PARTITION BY Pobl.PoNbr, Pobl.PoLine, pobl.poschedline ORDER BY Pobl.SqlStartTime) AS Rank1
		FROM Bi.dbo.BIPoBacklog 
		FOR SYSTEM_TIME BETWEEN '2017-7-01' AND '2017-12-30' AS Pobl
		WHERE (Pobl.DocType='ZSB' OR Pobl.DocType='NB') AND Pobl.SchedLineDeliveryDt>'2017-12-30') AS B
	GROUP BY B.PoNbr, B.PoLine, B.PoSchedLine,B.SqlStartTime) AS B;

DROP TABLE #temp2

SELECT *
INTO #temp2
FROM
	(SELECT B.PoNbr, B.PoLine, B.PoSchedLine, MIN(B.Rank1) AS Rmin, MAX(B.rank1) AS RMax
	FROM
		(SELECT DISTINCT *, DENSE_RANK() OVER(PARTITION BY Pobl.PoNbr, Pobl.PoLine, pobl.poschedline ORDER BY Pobl.SqlStartTime) AS Rank1
		FROM Bi.dbo.BIPoBacklog 
		FOR SYSTEM_TIME BETWEEN '2017-7-01' AND '2017-12-30' AS Pobl
		WHERE (Pobl.DocType='ZSB' OR Pobl.DocType='NB') AND Pobl.SchedLineDeliveryDt>'2017-12-30') AS B
	GROUP BY B.PoNbr, B.PoLine, B.PoSchedLine) AS B;



WITH CTE
AS(
	(SELECT DISTINCT A.PoNbr, A.PoLine, A.PoSchedLine, A.Plant, A.MaterialNbr, A.Mfg, A.ProdHrchy, A.SchedLineDeliveryDt, B.SchedLineDeliveryDt AS NewReqDt, A.ConfDlvryDt, A.PoOpenQty, B.Rank1, A.SqlStartTime, A.SqlEndTime
	--, B.SqlStartTime AS NewSqlStartTime
	FROM
		(SELECT *
		FROM
			(SELECT DISTINCT *, DENSE_RANK() OVER(PARTITION BY Pobl.PoNbr, Pobl.PoLine, pobl.poschedline ORDER BY Pobl.SqlStartTime) AS Rank1
			FROM Bi.dbo.BIPoBacklog 
			FOR SYSTEM_TIME BETWEEN '2017-7-01' AND '2017-12-30' AS Pobl
			WHERE (Pobl.DocType='ZSB' OR Pobl.DocType='NB') AND Pobl.SchedLineDeliveryDt BETWEEN '2017-10-02' AND '2017-12-30') AS A
		WHERE A.Rank1=1) AS A
	INNER JOIN
		(SELECT DISTINCT Pobl.PoNbr, Pobl.PoLine, Pobl.PoSchedLine, Pobl.SchedLineDeliveryDt, Pobl.SqlStartTime, DENSE_RANK() OVER(PARTITION BY Pobl.PoNbr, Pobl.PoLine, pobl.poschedline ORDER BY Pobl.SqlStartTime) AS Rank1
		FROM Bi.dbo.BIPoBacklog 
		FOR SYSTEM_TIME BETWEEN '2017-7-01' AND '2017-12-30' AS Pobl
		WHERE (Pobl.DocType='ZSB' OR Pobl.DocType='NB') AND Pobl.SchedLineDeliveryDt>'2017-12-30') AS B
		ON A.PoNbr=B.PoNbr AND A.PoLine=B.PoLine AND A.PoSchedLine=B.PoSchedLine)	
)
SELECT DISTINCT CTE.*, (D.CostCondVal/1000)*CTE.PoOpenQty AS EstimatedPoValue, E.SqlStartTime AS LastUpdateDt, Ma.PrcStgy, Ma.Cc, Ma.Grp, Ma.SrDir, Ma.Pld, Ma.MatlSpclst
FROM CTE
	INNER JOIN 
		(SELECT B.PoNbr, B.PoLine, B.PoSchedLine, Rmin, RMax
			FROM #temp2 AS B) AS C
		ON CTE.PoNbr=C.PoNbr AND CTE.PoLine=C.PoLine AND CTE.PoSchedLine=C.PoSchedLine AND (CTE.Rank1=C.Rmin OR CTE.Rank1=C.RMax)
	LEFT JOIN
		(SELECT B.PoNbr, B.PoLine, B.PoSchedLine, B.SqlStartTime, RMax
			FROM #temp AS B) AS E
		ON CTE.PoNbr=E.PoNbr AND CTE.PoLine=E.PoLine AND CTE.PoSchedLine=E.PoSchedLine AND Rank1=E.RMax
	INNER JOIN Sap.dbo.MatAor AS Ma
		ON CTE.MaterialNbr=Ma.MatNbr
	INNER JOIN 
		(SELECT *
		FROM
			(SELECT *, RANK() OVER(PARTITION BY PoNbr, PoLineNbr ORDER BY CostCondVal) AS Rank1
			FROM Bi.dbo.BiPoCostConditions
			WHERE (CostCond='ZDC' OR CostCond='ZSBP' OR CostCond='ZSRP')) AS C
		WHERE Rank1=1) AS D
		ON CTE.PoNbr=D.PONbr AND CTE.PoLine=D.PoLineNbr
	--INNER JOIN CentralDbs.dbo.CostResale AS Cr
	--	ON CTE.MaterialNbr=Cr.MaterialNbr
WHERE CTE.Rank1=1 AND E.SqlStartTime>@Date
ORDER BY CTE.PoNbr, CTE.PoLine, CTE.Rank1


--SELECT *
--FROM Bi.dbo.BiPoCostConditions
--WHERE PONbr=3400258261

--SELECT *
--FROM Bi.dbo.BIPoBacklog
--WHERE CAST(SqlStartTime AS DATE) > '2017-10-02'





