USE BI


SELECT PoNbr, PoLineNbr, CostCond, [Value] AS CostCondVal, Curr
FROM
	(SELECT PoNbr, PoLineNbr, CostCond, [Value], Curr
			,RANK() OVER(PARTITION BY PoNbr, PoLineNbr ORDER BY CostCond DESC) AS Rank2
	FROM
		(SELECT PoNbr, PoLineNbr, CostCond, CAST(CostCondVal AS MONEY) AS Value, Curr
			,RANK() OVER(PARTITION BY IBPCC.PoNbr, PoLineNbr ORDER BY IBPCC.CostCondVal) AS Rank1
		FROM BiPoCostConditions AS IBPCC
		WHERE CAST(CostCondVal AS MONEY)>0 AND CostCond='PBXX' OR CostCond='ZMPP' OR CostCond='ZDC' OR CostCond='ZSBP' OR CostCond='ZBMP' OR CostCond='ZCBM' OR CostCond='ZCSB')AS RankTbl
	WHERE Rank1=1) AS IBPCC2
WHERE Rank2=1