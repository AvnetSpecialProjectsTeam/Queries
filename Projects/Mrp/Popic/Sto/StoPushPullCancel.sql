


DECLARE @CurrentDate AS DATE=GETDATE()
DECLARE @PoBlStartDate AS DATE=GETDATE()-200



SELECT Ml.MrpDt, Ml.MaterialNbr, Ml.Plant, Ml.Mfg, ml.PrcStgy, Ml.CC, Ml.Grp, Ml.MrpInd, Ml.ReqDt, Ml.MrpNbr, Ml.MrpItem, Ml.SchedItem, Ml.ExceptnNbr, Ml.ExceptnKey, Ml.ReschedDt, Ml.ConfDlvryDt, Ml.SchDlvryDt, Ml.PoschedVal, Ml.CostCond, Ml.StkHigh, Ml.MrpCtrlr, Ml.PurchGrp, Ml.AutoBuy, Ml.AvnetAbc, Ml.SplrCancelWdw, Ml.MfgPartNbr,  Ml.MatlStatus, Ml.NcnrFl, Ml.StkFl, Ml.MrpElemntDesc, Ml.SqlStartTime, Ml.SqlEndTime, NULL AS CancelWindow, NULL AS QtrDay, NULL AS InTransit, NULL AS ZorQty, NULL AS ZfcQty, NULL AS ZsbQty, Ml.PoAction, Ml.SrDir, Ml.Pld, Ml.MatlSpclst,'EDI' AS [TransmitType], NULL AS PoChgCount
--, PoblCount.PoChgCount
INTO #PopicSto
FROM
--==========================================STO PUSH===========================================================
	(
	SELECT Ml.*, 'StoPush' AS PoAction, Ma.SrDir, Ma.Pld, Ma.MatlSpclst, Ma.PrcStgy, Pobl.CostCond, Pobl.PoSchedVal
	FROM SAP.dbo.MrpList AS Ml
		INNER JOIN 
			(SELECT *
			FROM CentralDbs.dbo.SapPartsList AS Spl
			WHERE Spl.MatHubState<>-1 AND Spl.SendToSapFl='Y' AND (Spl.pbg='0ST' OR Spl.Pbg='0IT')) AS Spl
			ON Ml.MaterialNbr=Spl.MaterialNbr
		INNER JOIN
			(SELECT Ml.MrpNbr, Ml.MrpItem, Ml.SchedItem
			FROM SAP.dbo.MrpList AS Ml
			WHERE Ml.MrpNbr LIKE '31%' AND Ml.Plant=1301 AND Ml.ReschedDt<>Ml.SchDlvryDt AND Ml.ExceptnNbr=15
			GROUP BY Ml.MrpNbr, Ml.MrpItem, Ml.SchedItem
			HAVING COUNT(SchedItem)=1) AS FiltMl
			ON Ml.MrpNbr=FiltMl.MrpNbr AND Ml.MrpItem=FiltMl.MrpItem AND Ml.SchedItem=FiltMl.SchedItem
		INNER JOIN SAP.dbo.MatAor AS Ma
			ON Ml.MaterialNbr=Ma.MatNbr
		INNER JOIN	
			(SELECT Pobl.PoNbr, Pobl.PoLine, Pobl.PoSchedLine, Pobl.SchedQty *PoCc.CostCondVal/1000 AS PoSchedVal, PoCc.CostCond, Pobl.SchedLineValue
			FROM Bi.dbo.BIPoBacklog AS Pobl
				INNER JOIN 
					(SELECT *
						FROM
							(SELECT *, RANK() OVER(PARTITION BY Pocc.PoNbr, PoCc.PoLineNbr ORDER BY Pocc.PoNbr, PoCc.PoLineNbr, PoCc.CostCond ASC) AS Rank2
							FROM
								(SELECT *, RANK() OVER(PARTITION BY Pocc.PoNbr, PoCc.PoLineNbr ORDER BY Pocc.PoNbr, PoCc.PoLineNbr, PoCc.CostCondVal ASC) AS Rank1
								FROM Bi.dbo.BiPoCostConditions AS PoCc
								WHERE PoCC.CostCond='P101') AS PoCc
							WHERE PoCc.Rank1=1) AS Pocc
						WHERE PoCc.Rank2=1) AS Pocc
						ON Pobl.PoNbr=Pocc.PONbr AND Pobl.PoLine=Pocc.PoLineNbr) AS Pobl
			ON Ml.MrpNbr=Pobl.PoNbr AND Ml.MrpItem=Pobl.PoLine
	WHERE Pobl.PoSchedVal<50000
	UNION ALL
	
--==========================================STO Cancel===========================================================
	SELECT Ml.*, 'StoCancel' AS PoAction, Ma.SrDir, Ma.Pld, Ma.MatlSpclst, Ma.PrcStgy, Pobl.CostCond, Pobl.PoSchedVal
	FROM SAP.dbo.MrpList AS Ml
		INNER JOIN 
			(SELECT *
			FROM CentralDbs.dbo.SapPartsList AS Spl
			WHERE Spl.MatHubState<>-1 AND Spl.SendToSapFl='Y' AND (Spl.pbg='0ST' OR Spl.Pbg='0IT')) AS Spl
			ON Ml.MaterialNbr=Spl.MaterialNbr
		INNER JOIN
			(SELECT Ml.MrpNbr, Ml.MrpItem, Ml.SchedItem
			FROM SAP.dbo.MrpList AS Ml
			WHERE Ml.MrpNbr LIKE '31%' AND Ml.Plant=1301 AND Ml.ReschedDt<>Ml.SchDlvryDt AND Ml.ExceptnNbr=20
			GROUP BY Ml.MrpNbr, Ml.MrpItem, Ml.SchedItem
			HAVING COUNT(SchedItem)=1) AS FiltMl
			ON Ml.MrpNbr=FiltMl.MrpNbr AND Ml.MrpItem=FiltMl.MrpItem AND Ml.SchedItem=FiltMl.SchedItem
		INNER JOIN SAP.dbo.MatAor AS Ma
			ON Ml.MaterialNbr=Ma.MatNbr
		INNER JOIN	
			(SELECT Pobl.PoNbr, Pobl.PoLine, Pobl.PoSchedLine, Pobl.SchedQty *PoCc.CostCondVal/1000 AS PoSchedVal, PoCc.CostCond, Pobl.SchedLineValue
			FROM Bi.dbo.BIPoBacklog AS Pobl
				INNER JOIN 
					(SELECT *
					FROM
						(SELECT *, RANK() OVER(PARTITION BY Pocc.PoNbr, PoCc.PoLineNbr ORDER BY Pocc.PoNbr, PoCc.PoLineNbr, PoCc.CostCond ASC) AS Rank2
						FROM
							(SELECT *, RANK() OVER(PARTITION BY Pocc.PoNbr, PoCc.PoLineNbr ORDER BY Pocc.PoNbr, PoCc.PoLineNbr, PoCc.CostCondVal ASC) AS Rank1
							FROM Bi.dbo.BiPoCostConditions AS PoCc
							WHERE PoCC.CostCond='P101') AS PoCc
						WHERE PoCc.Rank1=1) AS Pocc
					WHERE PoCc.Rank2=1) AS Pocc
					ON Pobl.PoNbr=Pocc.PONbr AND Pobl.PoLine=Pocc.PoLineNbr) AS Pobl
			ON Ml.MrpNbr=Pobl.PoNbr AND Ml.MrpItem=Pobl.PoLine
	WHERE Ml.NetValue<50000
	UNION ALL
--==========================================STO Pull===========================================================
		SELECT Ml.*, 'StoPull' AS PoAction, Ma.SrDir, Ma.Pld, Ma.MatlSpclst, Ma.PrcStgy, Pobl.CostCond, Pobl.PoSchedVal
		FROM SAP.dbo.MrpList AS Ml
			INNER JOIN 
				(SELECT *
				FROM CentralDbs.dbo.SapPartsList AS Spl
				WHERE Spl.MatHubState<>-1 AND Spl.SendToSapFl='Y' AND (Spl.pbg='0ST' OR Spl.Pbg='0IT')) AS Spl
				ON Ml.MaterialNbr=Spl.MaterialNbr
			INNER JOIN
				(SELECT Ml.MrpNbr, Ml.MrpItem, Ml.SchedItem
				FROM SAP.dbo.MrpList AS Ml
				WHERE Ml.MrpNbr LIKE '31%' AND Ml.Plant=1301 AND Ml.ReschedDt<>Ml.SchDlvryDt AND Ml.ExceptnNbr=10
				GROUP BY Ml.MrpNbr, Ml.MrpItem, Ml.SchedItem
				HAVING COUNT(SchedItem)=1) AS FiltMl
				ON Ml.MrpNbr=FiltMl.MrpNbr AND Ml.MrpItem=FiltMl.MrpItem AND Ml.SchedItem=FiltMl.SchedItem
			INNER JOIN SAP.dbo.MatAor AS Ma
				ON Ml.MaterialNbr=Ma.MatNbr
			INNER JOIN
			(SELECT Pobl.PoNbr, Pobl.PoLine, Pobl.PoSchedLine, Pobl.SchedQty *PoCc.CostCondVal/1000 AS PoSchedVal, PoCc.CostCond, Pobl.SchedLineValue
			FROM Bi.dbo.BIPoBacklog AS Pobl
				INNER JOIN 
					(SELECT *
					FROM
						(SELECT *, RANK() OVER(PARTITION BY Pocc.PoNbr, PoCc.PoLineNbr ORDER BY Pocc.PoNbr, PoCc.PoLineNbr, PoCc.CostCond ASC) AS Rank2
						FROM
							(SELECT *, RANK() OVER(PARTITION BY Pocc.PoNbr, PoCc.PoLineNbr ORDER BY Pocc.PoNbr, PoCc.PoLineNbr, PoCc.CostCondVal ASC) AS Rank1
							FROM Bi.dbo.BiPoCostConditions AS PoCc
							WHERE PoCC.CostCond='P101') AS PoCc
						WHERE PoCc.Rank1=1) AS Pocc
					WHERE PoCc.Rank2=1) AS Pocc
					ON Pobl.PoNbr=Pocc.PONbr AND Pobl.PoLine=Pocc.PoLineNbr) AS Pobl
			ON Ml.MrpNbr=Pobl.PoNbr AND Ml.MrpItem=Pobl.PoLine
	--INNER JOIN #PoBlCount AS PoblCount
	--	ON Ml.MrpNbr=PoblCount.PoNbr AND Ml.MrpItem=PoblCount.PoLine AND Ml.SchedItem=PoblCount.PoSchedLine
	WHERE Ml.NetValue<50000) AS Ml



--=========================================Merge Statement===========================================================================


MERGE Popic.dbo.CdbPopic AS TargetTbl
USING #PopicSto AS SourceTbl
ON (TargetTbl.MrpNbr=SourceTbl.MrpNbr AND TargetTbl.MrpItem=SourceTbl.MrpItem AND TargetTbl.SchedItem=SourceTbl.SchedItem)
WHEN MATCHED 
	AND TargetTbl.MrpDt <> SourceTbl.MrpDt
	OR TargetTbl.MaterialNbr <> SourceTbl.MaterialNbr
	OR TargetTbl.MfgPartNbr <> SourceTbl.MfgPartNbr
	OR TargetTbl.Plant <> SourceTbl.Plant
	OR TargetTbl.Mfg <> SourceTbl.Mfg
	OR TargetTbl.PrcStgy <> SourceTbl.PrcStgy
	OR TargetTbl.CC <> SourceTbl.CC
	OR TargetTbl.Grp <> SourceTbl.Grp
	OR TargetTbl.MrpInd <> SourceTbl.MrpInd
	OR TargetTbl.ReqDt <> SourceTbl.ReqDt
	OR TargetTbl.ExceptnNbr <> SourceTbl.ExceptnNbr
	OR TargetTbl.ExceptnKey <> SourceTbl.ExceptnKey
	OR TargetTbl.ReschedDt <> SourceTbl.ReschedDt
	OR TargetTbl.ConfDlvryDt <> SourceTbl.ConfDlvryDt
	OR TargetTbl.SchDlvryDt <> SourceTbl.SchDlvryDt
	OR TargetTbl.PoschedVal <> SourceTbl.PoschedVal
	OR TargetTbl.StkHigh <> SourceTbl.StkHigh
	OR TargetTbl.MrpCtrlr <> SourceTbl.MrpCtrlr
	OR TargetTbl.PurchGrp <> SourceTbl.PurchGrp
	OR TargetTbl.AutoBuy <> SourceTbl.AutoBuy
	OR TargetTbl.AvnetAbc <> SourceTbl.AvnetAbc
	OR TargetTbl.SplrCancelWdw <> SourceTbl.SplrCancelWdw
	OR TargetTbl.MatlStatus <> SourceTbl.MatlStatus
	OR TargetTbl.NcnrFl <> SourceTbl.NcnrFl
	OR TargetTbl.StkFl <> SourceTbl.StkFl
	OR TargetTbl.MrpElemntDesc <> SourceTbl.MrpElemntDesc
	OR TargetTbl.CancelWindow <> SourceTbl.CancelWindow
	OR TargetTbl.QtrDay <> SourceTbl.QtrDay
	OR TargetTbl.InTransit <> SourceTbl.InTransit
	OR TargetTbl.ZorQty <> SourceTbl.ZorQty
	OR TargetTbl.ZfcQty <> SourceTbl.ZfcQty
	OR TargetTbl.ZsbQty <> SourceTbl.ZsbQty
	OR TargetTbl.PoAction <> SourceTbl.PoAction
	OR TargetTbl.SrDir <> SourceTbl.SrDir
	OR TargetTbl.Pld <> SourceTbl.Pld
	OR TargetTbl.MatlSpclst <> SourceTbl.MatlSpclst
	OR TargetTbl.PoChgCount <> SourceTbl.PoChgCount
	OR TargetTbl.TransmitType <> SourceTbl.TransmitType
	OR TargetTbl.CostCond <> SourceTbl.CostCond

THEN UPDATE
	SET
		TargetTbl.MrpDt = SourceTbl.MrpDt
		,TargetTbl.MaterialNbr = SourceTbl.MaterialNbr
		,TargetTbl.MfgPartNbr = SourceTbl.MfgPartNbr
		,TargetTbl.Plant = SourceTbl.Plant
		,TargetTbl.Mfg = SourceTbl.Mfg
		,TargetTbl.PrcStgy = SourceTbl.PrcStgy
		,TargetTbl.CC = SourceTbl.CC
		,TargetTbl.Grp = SourceTbl.Grp
		,TargetTbl.MrpInd = SourceTbl.MrpInd
		,TargetTbl.ReqDt = SourceTbl.ReqDt
		,TargetTbl.ExceptnNbr = SourceTbl.ExceptnNbr
		,TargetTbl.ExceptnKey = SourceTbl.ExceptnKey
		,TargetTbl.ReschedDt = SourceTbl.ReschedDt
		,TargetTbl.ConfDlvryDt = SourceTbl.ConfDlvryDt
		,TargetTbl.SchDlvryDt = SourceTbl.SchDlvryDt
		,TargetTbl.PoschedVal = SourceTbl.PoschedVal
		,TargetTbl.StkHigh = SourceTbl.StkHigh
		,TargetTbl.MrpCtrlr = SourceTbl.MrpCtrlr
		,TargetTbl.PurchGrp = SourceTbl.PurchGrp
		,TargetTbl.AutoBuy = SourceTbl.AutoBuy
		,TargetTbl.AvnetAbc = SourceTbl.AvnetAbc
		,TargetTbl.SplrCancelWdw = SourceTbl.SplrCancelWdw
		,TargetTbl.MatlStatus = SourceTbl.MatlStatus
		,TargetTbl.NcnrFl = SourceTbl.NcnrFl
		,TargetTbl.StkFl = SourceTbl.StkFl
		,TargetTbl.MrpElemntDesc = SourceTbl.MrpElemntDesc
		,TargetTbl.CancelWindow = SourceTbl.CancelWindow
		,TargetTbl.QtrDay = SourceTbl.QtrDay
		,TargetTbl.InTransit = SourceTbl.InTransit
		,TargetTbl.ZorQty = SourceTbl.ZorQty
		,TargetTbl.ZfcQty = SourceTbl.ZfcQty
		,TargetTbl.ZsbQty = SourceTbl.ZsbQty
		,TargetTbl.PoAction = SourceTbl.PoAction
		,TargetTbl.SrDir = SourceTbl.SrDir
		,TargetTbl.Pld = SourceTbl.Pld
		,TargetTbl.MatlSpclst = SourceTbl.MatlSpclst
		,TargetTbl.PoChgCount = SourceTbl.PoChgCount
		,TargetTbl.TransmitType = SourceTbl.TransmitType
		,TargetTbl.CostCond = SourceTbl.CostCond
WHEN NOT MATCHED BY TARGET THEN
	INSERT(
		[MrpDt]
		,[MaterialNbr]
		,[MfgPartNbr]
		,[Plant]
		,[Mfg]
		,[PrcStgy]
		,[CC]
		,[Grp]
		,[MrpInd]
		,[ReqDt]
		,[MrpNbr]
		,[MrpItem]
		,[SchedItem]
		,[ExceptnNbr]
		,[ExceptnKey]
		,[ReschedDt]
		,[ConfDlvryDt]
		,[SchDlvryDt]
		,PoschedVal
		,[StkHigh]
		,[MrpCtrlr]
		,[PurchGrp]
		,[AutoBuy]
		,[AvnetAbc]
		,[SplrCancelWdw]
		,[MatlStatus]
		,[NcnrFl]
		,[StkFl]
		,[MrpElemntDesc]
		,[CancelWindow]
		,[QtrDay]
		,[InTransit]
		,[ZorQty]
		,[ZfcQty]
		,[ZsbQty]
		,[PoAction]
		,[SrDir]
		,[Pld]
		,[MatlSpclst]
		,[PoChgCount]
		,[TransmitType])
	VALUES(
		[MrpDt]
		,[MaterialNbr]
		,[MfgPartNbr]
		,[Plant]
		,[Mfg]
		,[PrcStgy]
		,[CC]
		,[Grp]
		,[MrpInd]
		,[ReqDt]
		,[MrpNbr]
		,[MrpItem]
		,[SchedItem]
		,[ExceptnNbr]
		,[ExceptnKey]
		,[ReschedDt]
		,[ConfDlvryDt]
		,[SchDlvryDt]
		,PoschedVal
		,[StkHigh]
		,[MrpCtrlr]
		,[PurchGrp]
		,[AutoBuy]
		,[AvnetAbc]
		,[SplrCancelWdw]
		,[MatlStatus]
		,[NcnrFl]
		,[StkFl]
		,[MrpElemntDesc]
		,[CancelWindow]
		,[QtrDay]
		,[InTransit]
		,[ZorQty]
		,[ZfcQty]
		,[ZsbQty]
		,[PoAction]
		,[SrDir]
		,[Pld]
		,[MatlSpclst]
		,[PoChgCount]
		,[TransmitType])
WHEN NOT MATCHED BY SOURCE AND TargetTbl.TransmitType='EDI' AND (TargetTbl.[PoAction]='StoPush' OR TargetTbl.[PoAction]='StoCancel' OR TargetTbl.[PoAction]='StoPull') THEN
DELETE;