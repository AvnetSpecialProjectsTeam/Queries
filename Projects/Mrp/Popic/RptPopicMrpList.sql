DECLARE @CurrentDt AS DATE=GETDATE()

SELECT SUM(SuccessVal)
FROM
	(
	SELECT Ma.SrDir, Ma.Pld, Ma.MatlMgr, Ma.MatlSpclst, Ma.Mfg, Ma.PrcStgy, Ma.Cc, Ma.Grp, Ml.MrpNbr AS PoNbr, Ml.MrpItem AS PoLineNbr, Ml.SchedItem AS PoSchedLine, Ml.MaterialNbr AS Material, Ml.MfgPartNbr,Pobl.SchedQty AS TotalQty,(CostCon.CostCondVal/1000)*Pobl.SchedQty AS TotalVal
		,CASE 
			WHEN Cp.MrpNbr IS NULL THEN Pobl.SchedQty ELSE NULL 
		END AS ExcludeQty
		,CASE 
			WHEN Cp.MrpNbr IS NULL THEN (CostCon.CostCondVal/1000)*Pobl.SchedQty ELSE NULL 
		END AS ExcludeVal
		,CASE 
			WHEN Cp.MrpNbr IS NOT NULL AND Cp.Status='Success' THEN Pobl.SchedQty ELSE NULL 
		END AS SuccessQty 
		,CASE 
			WHEN Cp.MrpNbr IS NOT NULL AND Cp.Status='Success' THEN cp.PoSchedVal ELSE NULL 
		END AS SuccessVal
		,CASE 
			WHEN Cp.MrpNbr IS NOT NULL AND Cp.Status='Failure' THEN Pobl.SchedQty ELSE NULL 
		END AS FailQty 
		,CASE 
			WHEN Cp.MrpNbr IS NOT NULL AND Cp.Status='Failure' THEN cp.PoSchedVal ELSE NULL
		END AS FailVal 
		,CASE 
			WHEN Cp.MrpNbr IS NOT NULL AND Cp.Status='Wait' THEN Pobl.SchedQty ELSE NULL 
		END AS WaitQty
		,CASE 
			WHEN Cp.MrpNbr IS NOT NULL AND Cp.Status='Wait' THEN cp.PoSchedVal ELSE NULL 
		END AS WaitVal
		,CASE WHEN Ml.ExceptnNbr=10 AND Ml.MrpNbr LIKE '34%' THEN 'Pull'
			WHEN Ml.ExceptnNbr=15 AND Ml.MrpNbr LIKE '34%' THEN 'Push'
			WHEN Ml.ExceptnNbr=20 AND Ml.MrpNbr LIKE '34%' THEN 'Cancel'
			WHEN Ml.ExceptnNbr=10 AND Ml.MrpNbr LIKE '31%' THEN 'StoPull'
			WHEN Ml.ExceptnNbr=15 AND Ml.MrpNbr LIKE '31%' THEN 'StoPush'
			WHEN Ml.ExceptnNbr=20 AND Ml.MrpNbr LIKE '31%' THEN 'StoCancel'
		END AS ActionType
		,Cp.[Status]
		,Cp.TransmitType
		,DATEDIFF(DAY,Ml.SqlStartTime, @CurrentDt) AS DaysInMrp
		,DATEDIFF(DAY,Cp.SqlStartTime, @CurrentDt) AS DaysInPopic
		, CASE WHEN DATEDIFF(DAY,Ml.SqlStartTime, @CurrentDt) <7 THEN '<1Week'
			WHEN DATEDIFF(DAY,Ml.SqlStartTime, @CurrentDt) BETWEEN 7 AND 30 Then '<1Month'
			ELSE '>1Month'
		END AS BucketDaysInWindow
		,CASE WHEN Cp.MrpNbr IS NOT NULL THEN 'X' END AS ActivePopic
	FROM SAP.dbo.MrpList AS Ml
		LEFT JOIN 
			(SELECT Cp.*
				,CASE WHEN Zp.[Status] IS NULL AND TransmitType='EDI' THEN 'Failure' 
					WHEN Zp.[Status] IS NULL AND TransmitType='NEDI' THEN 'Wait' 
					ELSE Zp.[Status] 
				END AS [Status]
			FROM Popic.dbo.CdbPopic AS Cp
				LEFT JOIN Popic.dbo.ZmassPo AS Zp
					ON Cp.MrpNbr=Zp.PoNbr AND cp.MrpItem=zp.PoItem AND cp.SchedItem=zp.SchedLineNbr) AS Cp
			ON Ml.MrpNbr=Cp.MrpNbr AND Ml.MrpItem=Cp.MrpItem AND Ml.SchedItem=Cp.SchedItem
		INNER JOIN SAP.dbo.MatAor AS Ma
			ON Ml.MaterialNbr=Ma.MatNbr
			INNER JOIN Popic.dbo.PopicRules AS Pr
				ON Ma.Mfg=Pr.Mfg AND Ma.PrcStgy=Pr.PrcStgy AND Ma.Cc=Pr.Cc AND Ma.Grp=Pr.Grp
		INNER JOIN Bi.dbo.BIPoBacklog AS Pobl
			ON Ml.MrpNbr=Pobl.PoNbr AND Ml.MrpItem=pobl.PoLine AND Ml.SchedItem=Pobl.PoSchedLine
		INNER JOIN
				(SELECT PoNbr, PoLineNbr, CostCond, [Value] AS CostCondVal, Curr
				FROM
					(SELECT PoNbr, PoLineNbr, CostCond, [Value], Curr
							,RANK() OVER(PARTITION BY PoNbr, PoLineNbr ORDER BY CostCond DESC) AS Rank2
					FROM
						(SELECT PoNbr, PoLineNbr, CostCond, CAST(CostCondVal AS MONEY) AS Value, Curr
							,RANK() OVER(PARTITION BY IBPCC.PoNbr, PoLineNbr ORDER BY IBPCC.CostCondVal) AS Rank1
						FROM Bi.dbo.BiPoCostConditions AS IBPCC
						WHERE CAST(CostCondVal AS MONEY)>0 AND (CostCond='PBXX' OR CostCond='ZMPP' OR CostCond='ZDC' OR CostCond='ZSBP' OR CostCond='ZBMP' OR CostCond='ZCBM' OR CostCond='ZCSB' OR CostCond='P101')) AS RankTbl
					WHERE Rank1=1) AS IBPCC2
				WHERE Rank2=1) AS CostCon
				ON Ml.MrpNbr=CostCon.PoNbr AND Ml.MrpItem=CostCon.PoLineNbr
	WHERE (Ml.MrpNbr LIKE '34%' OR ml.MrpNbr LIKE '31%')
			AND	(Ml.ExceptnNbr=20 AND (CAST(Ml.SchDlvryDt AS DATE) BETWEEN DATEADD(day, Pr.EdiCancelActionWindowStart , @CurrentDt) AND DATEADD(day, Pr.EdiCancelActionWindowEnd, @CurrentDt) OR CAST(Ml.SchDlvryDt AS DATE) BETWEEN DATEADD(day, Pr.NonEdiCancelActionWindowStart, @CurrentDt) AND DATEADD(day, Pr.NonEdiCancelActionWindowEnd, @CurrentDt))) 
			OR (Ml.ExceptnNbr=15 AND (CAST(Ml.SchDlvryDt AS DATE) BETWEEN DATEADD(day, Pr.EdiPushActionWindowStart , @CurrentDt) AND DATEADD(day, Pr.EdiPushActionWindowEnd, @CurrentDt) OR CAST(Ml.SchDlvryDt AS DATE) BETWEEN DATEADD(day, Pr.NonEdiPushActionWindowStart, @CurrentDt) AND DATEADD(day, Pr.NonEdiPushActionWindowEnd, @CurrentDt))) 
			OR (Ml.ExceptnNbr=10 AND (CAST(Ml.SchDlvryDt AS DATE) BETWEEN DATEADD(day, Pr.EdiCancelActionWindowStart , @CurrentDt) AND DATEADD(day, Pr.EdiCancelActionWindowEnd, @CurrentDt) OR CAST(Ml.SchDlvryDt AS DATE) BETWEEN DATEADD(day, Pr.NonEdiCancelActionWindowStart, @CurrentDt) AND DATEADD(day, Pr.NonEdiCancelActionWindowEnd, @CurrentDt)))
	)AS A