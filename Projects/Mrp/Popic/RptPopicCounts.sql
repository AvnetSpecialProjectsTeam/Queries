--Failure/Wait history	
SELECT *
FROM	
(SELECT Ml.MrpNbr ,Ml.MrpItem ,Ml.SchedItem , Ml.SqlStartTime ,Ml.SqlEndTime ,CASE WHEN Cp.MrpNbr IS NULL THEN 'X' END AS Exempt ,cp.[MrpDt]
      ,cp.[MaterialNbr]
      ,cp.[MfgPartNbr]
      ,cp.[Plant]
      ,cp.[Mfg]
      ,cp.[PrcStgy]
      ,cp.[CC]
      ,cp.[Grp]
      ,cp.[MrpInd]
      ,cp.[ReqDt]
      ,cp.[ExceptnNbr]
      ,cp.[ExceptnKey]
      ,cp.[ReschedDt]
      ,cp.[ConfDlvryDt]
      ,cp.[SchDlvryDt]
      ,cp.[PoSchedVal]
      ,cp.[StkHigh]
      ,cp.[MrpCtrlr]
      ,cp.[PurchGrp]
      ,cp.[AutoBuy]
      ,cp.[AvnetAbc]
      ,cp.[SplrCancelWdw]
      ,cp.[MatlStatus]
      ,cp.[NcnrFl]
      ,cp.[StkFl]
      ,cp.[MrpElemntDesc]
      ,cp.[CancelWindow]
      ,cp.[QtrDay]
      ,cp.[InTransit]
      ,cp.[ZorQty]
      ,cp.[ZfcQty]
      ,cp.[ZsbQty]
      ,cp.[PoAction]
      ,cp.[SrDir]
      ,cp.[Pld]
      ,cp.[MatlSpclst]
      ,cp.[PoChgCount]
      ,cp.[TransmitType]
      ,cp.SqlStartTime AS PopicStartTime
      ,cp.SqlEndTime AS PopicEndTime
      ,cp.[CostCond]
	  ,cp.[Status]
FROM SAP.dbo.MrpList 
FOR SYSTEM_TIME ALL AS Ml
	LEFT JOIN
		(SELECT Cp.*
			--,CASE WHEN Zp.[Status] IS NULL AND TransmitType='EDI' THEN 'Failure' 
			--	WHEN Zp.[Status] IS NULL AND TransmitType='NEDI' THEN 'Wait' 
			--	ELSE Zp.[Status] 
			--END AS [Status]
		FROM Popic.dbo.CdbPopic
			FOR SYSTEM_TIME ALL AS Cp
		LEFT JOIN Popic.dbo.ZmassPo
			FOR SYSTEM_TIME ALL AS Zp
			ON Cp.MrpNbr=Zp.PoNbr AND cp.MrpItem=zp.PoItem AND cp.SchedItem=zp.SchedLineNbr AND CAST(Cp.SqlStartTime AS DATE)=CAST(Zp.SqlStartTime AS DATE)) AS Cp
		ON Ml.MrpNbr=cp.MrpNbr AND Ml.MrpItem=cp.MrpItem AND Ml.SchedItem=cp.SchedItem AND CAST(Ml.SqlStartTime AS DATE)=CAST(cp.SqlStartTime AS DATE)
		INNER JOIN SAP.dbo.MatAor AS Ma
			ON Ml.MaterialNbr=Ma.MatNbr
			INNER JOIN Popic.dbo.PopicRules AS Pr
				ON Ma.Mfg=Pr.Mfg AND Ma.PrcStgy=Pr.PrcStgy AND Ma.Cc=Pr.Cc AND Ma.Grp=Pr.Grp
WHERE (Ml.MrpNbr LIKE '34%' OR ml.MrpNbr LIKE '31%')
			AND	(Ml.ExceptnNbr=20 AND (CAST(Ml.SchDlvryDt AS DATE) BETWEEN DATEADD(day, Pr.EdiCancelActionWindowStart ,Ml.SqlStartTime) AND DATEADD(day, Pr.EdiCancelActionWindowEnd, Ml.SqlStartTime) OR CAST(Ml.SchDlvryDt AS DATE) BETWEEN DATEADD(day, Pr.NonEdiCancelActionWindowStart, Ml.SqlStartTime) AND DATEADD(day, Pr.NonEdiCancelActionWindowEnd, Ml.SqlStartTime))) 
			OR (Ml.ExceptnNbr=15 AND (CAST(Ml.SchDlvryDt AS DATE) BETWEEN DATEADD(day, Pr.EdiPushActionWindowStart , Ml.SqlStartTime) AND DATEADD(day, Pr.EdiPushActionWindowEnd, Ml.SqlStartTime) OR CAST(Ml.SchDlvryDt AS DATE) BETWEEN DATEADD(day, Pr.NonEdiPushActionWindowStart, Ml.SqlStartTime) AND DATEADD(day, Pr.NonEdiPushActionWindowEnd, Ml.SqlStartTime))) 
			OR (Ml.ExceptnNbr=10 AND (CAST(Ml.SchDlvryDt AS DATE) BETWEEN DATEADD(day, Pr.EdiCancelActionWindowStart , Ml.SqlStartTime) AND DATEADD(day, Pr.EdiCancelActionWindowEnd, Ml.SqlStartTime) OR CAST(Ml.SchDlvryDt AS DATE) BETWEEN DATEADD(day, Pr.NonEdiCancelActionWindowStart, Ml.SqlStartTime) AND DATEADD(day, Pr.NonEdiCancelActionWindowEnd, Ml.SqlStartTime)))) AS A
			WHERE Exempt is not null

