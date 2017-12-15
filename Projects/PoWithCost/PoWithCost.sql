SELECT *
FROM
	(SELECT A.MaterialNbr, Spl.VendorPartNbr, A.PoNbr, A.PoLine, A.PoSchedLine, Ma.mfg, Ma.PrcStgy, Ma.cc, Ma.grp, A.SchedQty , A.SchedQty*CAST(PoCost.CostCondVal/1000.0 AS [decimal](15,5)) AS SchedLineValue, CAST(PoCost.CostCondVal/1000.0 AS [decimal](15,5)) AS PricePer1, A.UnitBookCost, A.UnitSpecialCost, A.MinCost, A.ValueAtMin, (CAST(PoCost.CostCondVal/1000.0 AS [decimal](15,3))*A.SchedQty)-A.[ValueAtMin] AS Delta, CASE WHEN PoCost.CostCond IS NULL THEN 'K' ELSE PoCost.CostCond END AS CostCond, Ma.SrDir, Ma.pld, Ma.MatlMgr, Ma.MatlSpclst
	FROM 
		(SELECT PoBl.MaterialNbr, PoBl.PoNbr, PoBl.PoLine, PoBl.PoSchedLine, PoBl.SchedQty, Format(PoBl.[SchedLineValue]/PoBl.[SchedQty],'0.00000') AS CostPer1, Cr.UnitBookCost, Cr.UnitSpecialCost, Cr.MinCost
		, Cr.[MinCost] * Pobl.SchedQty AS ValueAtMin
		FROM CentralDbs.dbo.CostResale AS Cr
		RIGHT JOIN Bi.dbo.BIPoBacklog AS PoBl
			ON Cr.MaterialNbr = PoBl.MaterialNbr
		WHERE (((PoBl.PoNbr) Not Like '31%'))) AS A

		INNER JOIN SAP.dbo.MatAor AS Ma
			ON A.MaterialNbr = Ma.MatNbr
		INNER JOIN Centraldbs.dbo.SapPartsList AS Spl
				ON A.MaterialNbr=Spl.MaterialNbr

		LEFT JOIN 
			(SELECT PONbr, PoLineNbr,CostCondVal,CostCond
			FROM(
				SELECT PONbr, PoLineNbr, MIN(CostCondVal) AS CostCondVal, CostCond AS CostCond, DENSE_Rank() over(Partition By PONbr, PoLineNbr ORDER BY PONbr ASC, PoLineNbr ASC, CostCondVal ASC, CostCond ASC)As RowOrder
				FROM BI.dbo.BiPoCostConditions
				WHERE CostCond='PBXX' AND CostCondVal >0 OR CostCond='ZMPP' AND CostCondVal >0 OR CostCond='ZDC' AND CostCondVal >0 OR CostCond='ZSBP' AND CostCondVal >0 OR CostCond='ZBMP' AND CostCondVal >0 OR CostCond='ZCBM' AND CostCondVal >0 OR CostCond='ZCSB' AND CostCondVal >0
				GROUP BY PONbr, PoLineNbr, CostCondVal, CostCond) TEMP
			WHERE Roworder=1 AND PONbr=3401038612) AS PoCost
			ON A.PoNbr=PoCost.PONbr AND A.PoLine=PoCost.PoLineNbr

		WHERE Spl.MatHubState<>-1 AND Spl.SendToSapFl='Y' AND A.PONbr=3401038612) AS A
ORDER BY A.SchedLineValue-A.[ValueAtMin] DESC