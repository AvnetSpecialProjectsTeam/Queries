SELECT PONbr, PoLineNbr,CostCondVal,CostCond
FROM(
	SELECT PONbr,PoLineNbr, MIN(CostCondVal) AS CostCondVal, CostCond AS CostCond, Row_number() over(Partition By PONbr, PoLineNbr ORDER BY PONbr ASC, PoLineNbr ASC, CostCondVal ASC, CostCond ASC)As RowOrder
	FROM BI.dbo.BiPoCostConditions
	WHERE CostCond='PBXX' AND CostCondVal >0 OR CostCond='ZMPP' AND CostCondVal >0 OR CostCond='ZDC' AND CostCondVal >0 OR CostCond='ZSBP' AND CostCondVal >0 OR CostCond='ZBMP' AND CostCondVal >0 OR CostCond='ZCBM' AND CostCondVal >0 OR CostCond='ZCSB' AND CostCondVal >0
	GROUP BY PONbr, PoLineNbr, CostCondVal, CostCond
) TEMP
	WHERE Roworder=1
	ORDER BY PONbr ASC, PoLineNbr ASC, CostCondVal ASC, CostCond ASC
