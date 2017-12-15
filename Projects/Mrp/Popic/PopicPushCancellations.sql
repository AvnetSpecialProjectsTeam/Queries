/*														Popic

Versions:					Date:							Comments

1.0							10-27-2017						Created the majority of the framework for Popic.  Created Po Push, cancellation,																and pull in processes. 
															Created process to determine PO Change Count.
1.1							10-30-2017						Created process to look at In Transit Windows and move PO's out of them.
															Created process to look at ZOR, ZFC, and ZSB Demand Types
1.2							11-08-2017
1.3							11-15-2017						Edited to use need rules in PopicRules which allows rules to be defined at the																	PoAction Type level.


USES:
PoCostCond
PoBacklog
SoBacklog
MrpList
[RefDateAvnet]
PopicRules
MatAor
*/


/* 
Need to add in PO change counts.  COMPLETE*******************
Need to factor in In Transit Windows.  COMPLETE*******************
Need to add in ability to look at demand types  COMPLETE*******************
Need to check on cancellation window override   COMPLETE*******************
Need to check on Popic excemption				COMPLETE*************************
Need to check that PO's are only being moved if resched date is >14 days	COMPLETE*************************
Need to grab Quote Number
Need to check on dollar thresholds  COMPLETE*******************
*/






DECLARE @CurrentDate AS DATE=GETDATE()
DECLARE @PoBlStartDate AS DATE=GETDATE()-200


IF OBJECT_ID('tempdb..#PoBlCount') is not null
	BEGIN
	DROP TABLE #PoBlCount
	END

IF OBJECT_ID('tempdb..#popic') is not null
	BEGIN
	DROP TABLE #popic
	END


--====================================================PO Change Count=============================================================
--CREATE Temp table to calculate PO change count and filter down to PO's that meet the rule

SELECT *
INTO #PoBlCount
FROM
	(SELECT PoBlCount.*
	FROM
		(SELECT PoBl.PoNbr, Pobl.PoLine, PoBl.PoSchedLine, COUNT(Pobl.SqlStartTime) AS PoChgCount, 'Push' AS PoType
		FROM Bi.dbo.BIPoBacklog
		FOR SYSTEM_TIME BETWEEN @PoBlStartDate AND @CurrentDate  AS PoBl
		GROUP BY PoBl.PoNbr, Pobl.PoLine, PoBl.PoSchedLine) AS PoBlCount
			INNER JOIN Bi.dbo.BIPoBacklog AS Pobl
				ON PoBlCount.PoNbr=Pobl.PoNbr AND PoBlCount.PoLine=Pobl.PoLine AND PoBlCount.PoSchedLine=Pobl.PoSchedLine 
				INNER JOIN Popic.dbo.PopicRules AS Pr
					ON Pobl.Mfg=pr.Mfg AND SUBSTRING(Pobl.ProdHrchy,4,3)=Pr.PrcStgy AND SUBSTRING(Pobl.ProdHrchy,10,3)=Pr.Cc AND SUBSTRING(Pobl.ProdHrchy,13,3)=Pr.Grp
		WHERE Pr.EdiPushMaxPoChangeCount>PoBlCount.PoChgCount OR Pr.EdiPushMaxPoChangeCount IS NULL

	UNION ALL
	SELECT PoBlCount.*
	FROM
		(SELECT PoBl.PoNbr, Pobl.PoLine, PoBl.PoSchedLine, COUNT(Pobl.SqlStartTime) AS PoChgCount, 'Cancel' AS PoType
		FROM Bi.dbo.BIPoBacklog
		FOR SYSTEM_TIME BETWEEN @PoBlStartDate AND @CurrentDate  AS PoBl
		GROUP BY PoBl.PoNbr, Pobl.PoLine, PoBl.PoSchedLine) AS PoBlCount
			INNER JOIN Bi.dbo.BIPoBacklog AS Pobl
				ON PoBlCount.PoNbr=Pobl.PoNbr AND PoBlCount.PoLine=Pobl.PoLine AND PoBlCount.PoSchedLine=Pobl.PoSchedLine 
				INNER JOIN Popic.dbo.PopicRules AS Pr
					ON Pobl.Mfg=pr.Mfg AND SUBSTRING(Pobl.ProdHrchy,4,3)=Pr.PrcStgy AND SUBSTRING(Pobl.ProdHrchy,10,3)=Pr.Cc AND SUBSTRING(Pobl.ProdHrchy,13,3)=Pr.Grp
		WHERE Pr.EdiCancelMaxPoChangeCount>PoBlCount.PoChgCount OR Pr.EdiCancelMaxPoChangeCount IS NULL

	UNION ALL
	SELECT PoBlCount.*
	FROM
		(SELECT PoBl.PoNbr, Pobl.PoLine, PoBl.PoSchedLine, COUNT(Pobl.SqlStartTime) AS PoChgCount, 'Pull' AS PoType
		FROM Bi.dbo.BIPoBacklog
		FOR SYSTEM_TIME BETWEEN @PoBlStartDate AND @CurrentDate  AS PoBl
		GROUP BY PoBl.PoNbr, Pobl.PoLine, PoBl.PoSchedLine) AS PoBlCount
			INNER JOIN Bi.dbo.BIPoBacklog AS Pobl
				ON PoBlCount.PoNbr=Pobl.PoNbr AND PoBlCount.PoLine=Pobl.PoLine AND PoBlCount.PoSchedLine=Pobl.PoSchedLine 
				INNER JOIN Popic.dbo.PopicRules AS Pr
					ON Pobl.Mfg=pr.Mfg AND SUBSTRING(Pobl.ProdHrchy,4,3)=Pr.PrcStgy AND SUBSTRING(Pobl.ProdHrchy,10,3)=Pr.Cc AND SUBSTRING(Pobl.ProdHrchy,13,3)=Pr.Grp
		WHERE Pr.EdiPullMaxPoChangeCount>PoBlCount.PoChgCount OR Pr.EdiPullMaxPoChangeCount IS NULL) AS PoblCount



--===============================================================================================================================






				



--==============================================================================================================================





SELECT [MrpDt]
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
      ,PoSchedVal
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
      ,'EDI' AS [TransmitType]
	  ,CostCond
INTO #Popic
FROM
(
--=========================================================Push outs===============================================================

	SELECT Ml.*, PoblCount.PoChgCount		--Adds in PoBlCount and filters down on Inner Join

	FROM
		(SELECT Ml.MrpDt, Ml.MaterialNbr, Ml.MfgPartNbr , Ml.Plant, Ml.Mfg, Ml.PrcStgy, Ml.CC, Ml.Grp, Ml.MrpInd, Ml.ReqDt, Ml.MrpNbr, Ml.MrpItem, Ml.SchedItem, Ml.ExceptnNbr, Ml.ExceptnKey, Ml.ReschedDt1 AS ReschedDt, Ml.ConfDlvryDt, Ml.SchDlvryDt, Ml.PoSchedVal, Ml.CostCond, Ml.StkHigh, Ml.MrpCtrlr, Ml.PurchGrp, Ml.AutoBuy, Ml.AvnetAbc, Ml.SplrCancelWdw, Ml.MatlStatus, Ml.NcnrFl, Ml.StkFl, Ml.MrpElemntDesc, Ml.SqlStartTime, Ml.SqlEndTime, Ml.CancelWindow, Ml.QtrDay, Ml.InTransit, Ml.ZorQty, Ml.ZfcQty, Ml.ZsbQty, 'Push' AS PoAction, Ma.SrDir, Ma.Pld, Ma.MatlSpclst		--Select adds MatAor
			--,RANK() OVER(PARTITION BY Ml.MrpNbr, Ml.MrpItem, Ml.SchedItem ORDER BY Ml.MrpNbr, Ml.MrpItem, Ml.SchedItem, Ml.ZorQty DESC) AS Rank1
		FROM
			(SELECT Ml.*, Pobl.CostCond, Pobl.PoSchedVal,
				CASE 
					WHEN Ml.InTransit ='X' AND ZorQty >0 AND DATEDIFF(DAY,Ml.ConfDlvryDt,Ml.InTransitReschedDtIn)>=14 THEN Ml.InTransitReschedDtIn
					WHEN Ml.InTransit ='X' AND ZorQty >0 AND DATEDIFF(DAY,Ml.ConfDlvryDt,Ml.InTransitReschedDtIn)<14 THEN '9999-12-31'
					WHEN Ml.Intransit ='X' AND ZorQty IS NULL AND DATEDIFF(DAY,Ml.ConfDlvryDt,Ml.InTransitReschedDtIn)>=14 THEN Ml.InTransitReschedDtOut
					WHEN Ml.Intransit ='X' AND ZorQty IS NULL AND DATEDIFF(DAY,Ml.ConfDlvryDt,Ml.InTransitReschedDtIn)<14 THEN '9999-12-31'
					ELSE Ml.ReschedDt END AS ReschedDt1						--Select adds ConfDlvryDt filter and InTransitWindow
			FROM
				(SELECT Ml.*, Ma.prcStgy, CASE WHEN Pr.EdiPushCancelWindowIsLeadTime>REPLACE(Mc.SupplierCancelWId,'.','') THEN Pr.EdiPushCancelWindowIsLeadTime WHEN REPLACE(Mc.SupplierCancelWId,'.','')=0 THEN 30 ELSE REPLACE(Mc.SupplierCancelWId,'.','') END AS CancelWindow, Rda.QtrDay, Rda.InTransitReschedDtIn, Rda.InTransitReschedDtOut, CASE WHEN Rda.QtrDay<11 OR Rda.QtrDay>83 THEN 'X' END AS InTransit, Pr.EdiPushZorDemand, Pr.EdiPushZfcDemand, Pr.EdiPushZsbDemand, Sobl.ZorQty, Sobl.ZfcQty, Sobl.ZsbQty, Pr.NonEdiPushMinVal, Pr.NonEdiPushMaxVal
				FROM 
					(SELECT *
					FROM SAP.dbo.MrpList AS Ml
					WHERE Ml.ExceptnNbr=15
						AND CASE WHEN Ml.ConfDlvryDt IS NULL THEN DATEDIFF(DAY,Ml.SchDlvryDt, Ml.ReschedDt)ELSE DATEDIFF(DAY,Ml.ConfDlvryDt, Ml.ReschedDt) END >14
						AND Ml.NcnrFl<>'X'
						AND Ml.MrpNbr LIKE '34%' --Filter to only normal external POs
						) AS Ml
					INNER JOIN 
						(SELECT *
						FROM SAP.dbo.MatAor AS Ma
						WHERE (MA.Pbg='0ST' OR Ma.Pbg='0IT')) AS Ma
						ON Ml.MaterialNbr=Ma.MatNbr
						INNER JOIN Popic.dbo.PopicRules AS Pr
							ON Ma.Mfg=Pr.Mfg AND ma.PrcStgy=Pr.PrcStgy AND Ma.cc=Pr.Cc AND Ma.Grp=Pr.Grp
					LEFT JOIN
					--Get Sales order backlog data
						(SELECT Sobl.materialNbr, SoBl.PlantId, SUM(ZorQty) AS ZorQty, SUM(ZfcQty) AS ZfcQty, SUM(ZsbQty) AS ZsbQty
						FROM 
							(SELECT Sobl.materialNbr
								, Sobl.plantid
								,CASE WHEN Sobl.SalesDocType='ZOR' THEN SUM(Sobl.RemainingQty) END AS ZorQty
								,CASE WHEN Sobl.SalesDocType='ZFC' THEN SUM(Sobl.RemainingQty) END AS ZfcQty
								,CASE WHEN Sobl.SalesDocType='ZSB' THEN SUM(Sobl.RemainingQty) END AS ZsbQty
							FROM Bi.dbo.SoBacklog AS SoBl
							GROUP BY sobl.materialNbr, Sobl.plantid, SalesDocType) AS Sobl
						GROUP BY Sobl.MaterialNbr, Sobl.PlantId) AS Sobl
						ON Ml.MaterialNbr=Sobl.materialNbr AND Ml.Plant=Sobl.PlantId
					LEFT JOIN SAP.dbo.Marc AS Mc
						ON Ml.MaterialNbr=Mc.Material AND Ml.Plant=Mc.Plant
					LEFT JOIN 
						(SELECT 
							Rda.DateDt
							, Rda.DateTxt
							,Rda.QtrDay
							, CASE 
								WHEN QtrDay<11 OR QtrDay>83 THEN CAST(CONCAT(LEFT(CAST(DATEADD(day, -14, DateDt) AS VARCHAR(30)),8),'15') AS DATE) END AS InTransitReschedDtIn
							, CASE 
								WHEN QtrDay<11 OR QtrDay>83 THEN CAST(CONCAT(LEFT(CAST(DATEADD(day, 14, DateDt) AS VARCHAR(30)),8),'15') AS DATE) END AS InTransitReschedDtOut
						FROM
							(SELECT 
								*
								,RANK() OVER(PARTITION BY FyYyyyQtr ORDER BY DateDt) AS QtrDay
							FROM [CentralDbs].[dbo].[RefDateAvnet] AS Rda) AS Rda) AS Rda		--Used to calculate Intransit Window
						ON Ml.ReschedDt=Rda.DateDt
				WHERE Pr.EdiPushOut=1 AND Pr.NonEdiPushOut=0	--Filter to Edi Push Outs
					AND (Ml.SchDlvryDt BETWEEN DATEADD(DAY, Pr.EdiPushActionWindowStart, @CurrentDate) AND DATEADD(DAY, Pr.EdiPushActionWindowEnd, @CurrentDate))	--Filter on SchedDt
					AND Pr.[860PoChg]=1 and Pr.[865PoChgAck]=1						--EdiSupplier
					AND Pr.RemoveFromPopic=0) AS Ml			--Not Removed from Popic
				INNER JOIN 
					(SELECT Pobl.*, Pobl.SchedQty *PoCc.CostCondVal/1000 AS PoSchedVal, PoCc.CostCond
					FROM Bi.dbo.BIPoBacklog AS Pobl
					INNER JOIN 
						(SELECT *
							FROM
								(SELECT *, RANK() OVER(PARTITION BY Pocc.PoNbr, PoCc.PoLineNbr ORDER BY Pocc.PoNbr, PoCc.PoLineNbr, PoCc.CostCond ASC) AS Rank2
								FROM
									(SELECT *, RANK() OVER(PARTITION BY Pocc.PoNbr, PoCc.PoLineNbr ORDER BY Pocc.PoNbr, PoCc.PoLineNbr, PoCc.CostCondVal ASC) AS Rank1
									FROM Bi.dbo.BiPoCostConditions AS PoCc
									WHERE PoCC.CostCond='ZMPP' OR PoCc.CostCond='ZDC' OR PoCc.CostCond='ZSBP' OR PoCc.CostCond='PBXX') AS PoCc
								WHERE PoCc.Rank1=1) AS Pocc
							WHERE PoCc.Rank2=1) AS Pocc
						ON Pobl.PoNbr=Pocc.PONbr AND Pobl.PoLine=Pocc.PoLineNbr) AS Pobl
					ON Ml.MrpNbr=Pobl.PoNbr AND Ml.MrpItem=Pobl.PoLine AND Ml.SchedItem=Pobl.PoSchedLine
			WHERE Pobl.PoSchedVal BETWEEN Ml.NonEdiPushMinVal AND Ml.NonEdiPushMaxVal	--Dollar Threshold
				AND (Pobl.ConfDlvryDt>DATEADD(DAY, Ml.CancelWindow+7, @CurrentDate) OR Pobl.ConfDlvryDt IS NULL)
				AND ((EdiPushZorDemand=1 AND EdiPushZfcDemand=1 AND Ml.EdiPushZsbDemand=1 AND (Ml.ZorQty>0 OR Ml.ZfcQty>0 OR Ml.ZsbQty>0)) 
				OR (EdiPushZorDemand=1 AND EdiPushZfcDemand=1 AND Ml.EdiPushZsbDemand=0 AND (Ml.ZorQty>0 OR Ml.ZfcQty>0) AND Ml.ZsbQty=0)
				OR (EdiPushZorDemand=1 AND EdiPushZfcDemand=0 AND Ml.EdiPushZsbDemand=0 AND Ml.ZorQty>0 AND Ml.ZfcQty=0 AND Ml.ZsbQty=0)
				OR (EdiPushZorDemand=0 AND EdiPushZfcDemand=1 AND Ml.EdiPushZsbDemand=1 AND Ml.ZorQty=0 AND (Ml.ZfcQty>0 OR Ml.ZsbQty>0))
				OR (EdiPushZorDemand=0 AND EdiPushZfcDemand=1 AND Ml.EdiPushZsbDemand=0 AND Ml.ZorQty=0 AND Ml.ZsbQty=0 AND Ml.ZfcQty>0)
				OR (EdiPushZorDemand=0 AND EdiPushZfcDemand=0 AND Ml.EdiPushZsbDemand=1 AND Ml.ZorQty=0 AND Ml.ZfcQty=0 AND Ml.ZsbQty>0)
				)) AS Ml
			INNER JOIN SAP.dbo.MatAor AS Ma
				ON Ml.MaterialNbr=Ma.MatNbr
			INNER JOIN														---Filter out Eol & Obsolete parts
				(SELECT *
				FROM CentralDbs.dbo.SapFlagsCodes AS Sfc
				WHERE Sfc.Xstatus IS NULL) AS Sfc
				ON Ml.MaterialNbr=sfc.MaterialNbr AND Ml.Plant=Sfc.SapPlantCd) AS Ml
		INNER JOIN #PoBlCount AS PoblCount
			ON Ml.MrpNbr=PoblCount.PoNbr AND Ml.MrpItem=PoblCount.PoLine AND Ml.SchedItem=PoblCount.PoSchedLine AND PoblCount.PoType=Ml.PoAction
		WHERE Ml.ReschedDt!='9999-12-31'

--============================================================================================================================================


	UNION ALL



--========================================================Cancellations====================================================================

	SELECT Ml.*, PoblCount.PoChgCount		--Adds in PoBlCount and filters down on Inner Join
	FROM
		(SELECT Ml.MrpDt, Ml.MaterialNbr, Ml.MfgPartNbr, Ml.Plant, Ml.Mfg, Ml.PrcStgy, Ml.CC, Ml.Grp, Ml.MrpInd, Ml.ReqDt, Ml.MrpNbr, Ml.MrpItem, Ml.SchedItem, Ml.ExceptnNbr, Ml.ExceptnKey, Ml.ReschedDt1 AS ReschedDt, Ml.ConfDlvryDt, Ml.SchDlvryDt, Ml.PoSchedVal, Ml.CostCond, Ml.StkHigh, Ml.MrpCtrlr, Ml.PurchGrp, Ml.AutoBuy, Ml.AvnetAbc, Ml.SplrCancelWdw, Ml.MatlStatus, Ml.NcnrFl, Ml.StkFl, Ml.MrpElemntDesc, Ml.SqlStartTime, Ml.SqlEndTime, Ml.CancelWindow, Ml.QtrDay, Ml.InTransit, Ml.ZorQty, Ml.ZfcQty, Ml.ZsbQty, 'Cancel' AS PoAction, Ma.SrDir, Ma.Pld, Ma.MatlSpclst		--Select adds MatAor
			--,RANK() OVER(PARTITION BY Ml.MrpNbr, Ml.MrpItem, Ml.SchedItem ORDER BY Ml.MrpNbr, Ml.MrpItem, Ml.SchedItem, Ml.ZorQty DESC) AS Rank1
		FROM(
			SELECT Ml.*, Pobl.CostCond, Pobl.PoSchedVal, NULL AS ReschedDt1   --Select adds ConfDlvryDt filter
			FROM
				(SELECT Ml.*, Ma.PrcStgy, CASE WHEN Pr.EdiCancelCancelWindowIsLeadTime>REPLACE(Mc.SupplierCancelWId,'.','') THEN Pr.EdiCancelCancelWindowIsLeadTime WHEN REPLACE(Mc.SupplierCancelWId,'.','')=0  THEN 30 ELSE REPLACE(Mc.SupplierCancelWId,'.','') END AS CancelWindow, Pr.EdiCancelZorDemand, Pr.EdiCancelZfcDemand, Pr.EdiCancelZsbDemand, Pr.NonEdiPushMinVal, Pr.NonEdiPushMaxVal
				,NULL AS QtrDay					--Field used in Push and pull
				,NULL AS InTransit				--Field used in Push and pull
				--,CASE WHEN Rda.BusDay<11 THEN 'X' END AS InTransit		--Not needed for cancellations
				, Sobl.ZorQty, Sobl.ZfcQty, Sobl.ZsbQty
				FROM 
					(SELECT *
					FROM SAP.dbo.MrpList AS Ml
					WHERE Ml.ExceptnNbr=20			--Filter To Push Outs
						AND Ml.NcnrFl<>'X'
						AND Ml.MrpNbr LIKE '34%' --Filter to only normal external POs
						) AS Ml
					INNER JOIN 
						(SELECT *
						FROM SAP.dbo.MatAor AS Ma
						WHERE (MA.Pbg='0ST' OR Ma.Pbg='0IT')) AS Ma
						ON Ml.MaterialNbr=Ma.MatNbr
						INNER JOIN Popic.dbo.PopicRules AS Pr
							ON Ma.Mfg=Pr.Mfg AND ma.PrcStgy=Pr.PrcStgy AND Ma.cc=Pr.Cc AND Ma.Grp=Pr.Grp
					LEFT JOIN
					--Get Sales order backlog data
						(SELECT Sobl.materialNbr, SoBl.PlantId, SUM(ZorQty) AS ZorQty, SUM(ZfcQty) AS ZfcQty, SUM(ZsbQty) AS ZsbQty
						FROM 
							(SELECT Sobl.materialNbr
								, Sobl.plantid
								,CASE WHEN Sobl.SalesDocType='ZOR' THEN SUM(Sobl.RemainingQty) END AS ZorQty
								,CASE WHEN Sobl.SalesDocType='ZFC' THEN SUM(Sobl.RemainingQty) END AS ZfcQty
								,CASE WHEN Sobl.SalesDocType='ZSB' THEN SUM(Sobl.RemainingQty) END AS ZsbQty
							FROM Bi.dbo.SoBacklog AS SoBl
							GROUP BY sobl.materialNbr, Sobl.plantid, SalesDocType) AS Sobl
						GROUP BY Sobl.MaterialNbr, Sobl.PlantId) AS Sobl
						ON Ml.MaterialNbr=Sobl.materialNbr AND Ml.Plant=Sobl.PlantId
					LEFT JOIN SAP.dbo.Marc AS Mc
						ON Ml.MaterialNbr=Mc.Material AND Ml.Plant=Mc.Plant
					--LEFT JOIN CentralDbs.dbo.RefDateAvnet AS Rda		--Used to calculate Intransit Window not needed for cancellations
					--	ON Ml.ReschedDt=Rda.DateDt
				WHERE Pr.EdiCancel=1 AND Pr.NonEdiCancel=0						--Filter to Edi Push Outs
					AND (Ml.SchDlvryDt BETWEEN DATEADD(DAY, Pr.EdiCancelActionWindowStart, @CurrentDate) AND DATEADD(DAY, Pr.EdiCancelActionWindowEnd, @CurrentDate))	--Filter on SchedDt
					AND Pr.[860PoChg]=1 and Pr.[865PoChgAck]=1			--EdiSupplier
					AND Pr.RemoveFromPopic=0) AS Ml			--Not removed from popic
				INNER JOIN
					(SELECT Pobl.*, Pobl.SchedQty *PoCc.CostCondVal/1000 AS PoSchedVal, PoCc.CostCond
					FROM Bi.dbo.BIPoBacklog AS Pobl
						INNER JOIN 
							(SELECT *
							FROM
								(SELECT *, RANK() OVER(PARTITION BY Pocc.PoNbr, PoCc.PoLineNbr ORDER BY Pocc.PoNbr, PoCc.PoLineNbr, PoCc.CostCond ASC) AS Rank2
								FROM
									(SELECT *, RANK() OVER(PARTITION BY Pocc.PoNbr, PoCc.PoLineNbr ORDER BY Pocc.PoNbr, PoCc.PoLineNbr, PoCc.CostCondVal ASC) AS Rank1
									FROM Bi.dbo.BiPoCostConditions AS PoCc
									WHERE PoCC.CostCond='ZMPP' OR PoCc.CostCond='ZDC' OR PoCc.CostCond='ZSBP' OR PoCc.CostCond='PBXX') AS PoCc
								WHERE PoCc.Rank1=1) AS Pocc
							WHERE PoCc.Rank2=1) AS Pocc
							ON Pobl.PoNbr=Pocc.PONbr AND Pobl.PoLine=Pocc.PoLineNbr) AS Pobl
					ON Ml.MrpNbr=Pobl.PoNbr AND Ml.MrpItem=Pobl.PoLine AND Ml.SchedItem=Pobl.PoSchedLine
			WHERE Pobl.PoSchedVal BETWEEN Ml.NonEdiPushMinVal AND Ml.NonEdiPushMaxVal	--Dollar Threshold
				AND (Pobl.ConfDlvryDt>DATEADD(DAY, Ml.CancelWindow+7, @CurrentDate) OR Pobl.ConfDlvryDt IS NULL)
				AND ((EdiCancelZorDemand=1 AND EdiCancelZfcDemand=1 AND Ml.EdiCancelZsbDemand=1 AND (Ml.ZorQty>0 OR Ml.ZfcQty>0 OR Ml.ZsbQty>0)) 
				OR (EdiCancelZorDemand=1 AND EdiCancelZfcDemand=1 AND Ml.EdiCancelZsbDemand=0 AND (Ml.ZorQty>0 OR Ml.ZfcQty>0) AND Ml.ZsbQty=0)
				OR (EdiCancelZorDemand=1 AND EdiCancelZfcDemand=0 AND Ml.EdiCancelZsbDemand=0 AND Ml.ZorQty>0 AND Ml.ZfcQty=0 AND Ml.ZsbQty=0)
				OR (EdiCancelZorDemand=0 AND EdiCancelZfcDemand=1 AND Ml.EdiCancelZsbDemand=1 AND Ml.ZorQty=0 AND (Ml.ZfcQty>0 OR Ml.ZsbQty>0))
				OR (EdiCancelZorDemand=0 AND EdiCancelZfcDemand=1 AND Ml.EdiCancelZsbDemand=0 AND Ml.ZorQty=0 AND Ml.ZsbQty=0 AND Ml.ZfcQty>0)
				OR (EdiCancelZorDemand=0 AND EdiCancelZfcDemand=0 AND Ml.EdiCancelZsbDemand=1 AND Ml.ZorQty=0 AND Ml.ZfcQty=0 AND Ml.ZsbQty>0)
				)) AS Ml
			INNER JOIN SAP.dbo.MatAor AS Ma
				ON Ml.MaterialNbr=Ma.MatNbr
			INNER JOIN														---Filter out Eol & Obsolete parts
				(SELECT *
				FROM CentralDbs.dbo.SapFlagsCodes AS Sfc
				WHERE Sfc.Xstatus IS NULL) AS Sfc
				ON Ml.MaterialNbr=sfc.MaterialNbr AND Ml.Plant=Sfc.SapPlantCd) AS Ml
		INNER JOIN #PoBlCount AS PoblCount
			ON Ml.MrpNbr=PoblCount.PoNbr AND Ml.MrpItem=PoblCount.PoLine AND Ml.SchedItem=PoblCount.PoSchedLine AND PoblCount.PoType=Ml.PoAction

--=========================================================================================================================================

	UNION ALL


--=========================================================Pull ins==================================================================
	SELECT Ml.*, PoblCount.PoChgCount		--Adds in PoBlCount and filters down on Inner Join
	FROM
		(SELECT Ml.MrpDt, Ml.MaterialNbr, Ml.MfgPartNbr, Ml.Plant, Ml.Mfg, Ml.PrcStgy, Ml.CC, Ml.Grp, Ml.MrpInd, Ml.ReqDt, Ml.MrpNbr, Ml.MrpItem, Ml.SchedItem, Ml.ExceptnNbr, Ml.ExceptnKey, Ml.ReschedDt1 AS ReschedDt, Ml.ConfDlvryDt, Ml.SchDlvryDt, Ml.PoSchedVal, Ml.CostCond, Ml.StkHigh, Ml.MrpCtrlr, Ml.PurchGrp, Ml.AutoBuy, Ml.AvnetAbc, Ml.SplrCancelWdw, Ml.MatlStatus, Ml.NcnrFl, Ml.StkFl, Ml.MrpElemntDesc, Ml.SqlStartTime, Ml.SqlEndTime, Ml.CancelWindow, Ml.QtrDay, Ml.InTransit, Ml.ZorQty, Ml.ZfcQty, Ml.ZsbQty, 'Pull' AS PoAction, Ma.SrDir, Ma.Pld, Ma.MatlSpclst		--Select adds MatAor
			--,RANK() OVER(PARTITION BY Ml.MrpNbr, Ml.MrpItem, Ml.SchedItem ORDER BY Ml.MrpNbr, Ml.MrpItem, Ml.SchedItem, Ml.ZorQty DESC) AS Rank1
		FROM
			(SELECT Ml.*, Pobl.CostCond, Pobl.PoSchedVal,
				 CASE 
					WHEN Ml.InTransit ='X' AND ZorQty >0 AND DATEDIFF(DAY,Ml.InTransitReschedDtIn, Ml.ConfDlvryDt)>=14 THEN Ml.InTransitReschedDtIn
					WHEN Ml.InTransit ='X' AND ZorQty >0 AND DATEDIFF(DAY,Ml.InTransitReschedDtIn, Ml.ConfDlvryDt)<14 THEN '9999-12-31'
					WHEN Ml.Intransit ='X' AND ZorQty IS NULL AND DATEDIFF(DAY,Ml.InTransitReschedDtIn, Ml.ConfDlvryDt)>=14 THEN Ml.InTransitReschedDtOut
					WHEN Ml.Intransit ='X' AND ZorQty IS NULL AND DATEDIFF(DAY,Ml.InTransitReschedDtIn, Ml.ConfDlvryDt)<14 THEN '9999-12-31'
					ELSE Ml.ReschedDt END AS ReschedDt1										--Select adds ConfDlvryDt filter and InTransitWindow
			FROM
				(SELECT Ml.*, Ma.prcStgy, CASE WHEN Pr.EdiPullCancelWindowIsLeadTime>REPLACE(Mc.SupplierCancelWId,'.','') THEN Pr.EdiPullCancelWindowIsLeadTime WHEN REPLACE(Mc.SupplierCancelWId,'.','')=0 THEN 30 ELSE REPLACE(Mc.SupplierCancelWId,'.','') END AS CancelWindow, Rda.QtrDay, Rda.InTransitReschedDtIn, Rda.InTransitReschedDtOut, CASE WHEN Rda.QtrDay<11 OR Rda.QtrDay>83 THEN 'X' END AS InTransit, Pr.EdiPullZorDemand, Pr.EdiPullZfcDemand, Pr.EdiPullZsbDemand, Sobl.ZorQty, Sobl.ZfcQty, Sobl.ZsbQty, Pr.NonEdiPushMinVal, Pr.NonEdiPushMaxVal
				FROM 
					(SELECT *
					FROM SAP.dbo.MrpList AS Ml
					WHERE Ml.ExceptnNbr=10			--Filter To Pull Ins
						AND CASE WHEN Ml.ConfDlvryDt IS NULL THEN DATEDIFF(DAY,Ml.ReschedDt, Ml.SchDlvryDt) ELSE DATEDIFF(DAY, Ml.ReschedDt, Ml.ConfDlvryDt) END <-14			--Filter to only actions that would move more than 2 weeks
						AND Ml.NcnrFl<>'X'
						AND Ml.MrpNbr LIKE '34%' --Filter to only normal external POs
						) AS Ml
					INNER JOIN 
						(SELECT *
						FROM SAP.dbo.MatAor AS Ma
						WHERE (MA.Pbg='0ST' OR Ma.Pbg='0IT')) AS Ma
						ON Ml.MaterialNbr=Ma.MatNbr
						INNER JOIN Popic.dbo.PopicRules AS Pr
							ON Ma.Mfg=Pr.Mfg AND ma.PrcStgy=Pr.PrcStgy AND Ma.cc=Pr.Cc AND Ma.Grp=Pr.Grp
					LEFT JOIN
					--Get Sales order backlog data
						(SELECT Sobl.materialNbr, SoBl.PlantId, SUM(ZorQty) AS ZorQty, SUM(ZfcQty) AS ZfcQty, SUM(ZsbQty) AS ZsbQty
						FROM 
							(SELECT Sobl.materialNbr
								, Sobl.plantid
								,CASE WHEN Sobl.SalesDocType='ZOR' THEN SUM(Sobl.RemainingQty) END AS ZorQty
								,CASE WHEN Sobl.SalesDocType='ZFC' THEN SUM(Sobl.RemainingQty) END AS ZfcQty
								,CASE WHEN Sobl.SalesDocType='ZSB' THEN SUM(Sobl.RemainingQty) END AS ZsbQty
							FROM Bi.dbo.SoBacklog AS SoBl
							GROUP BY sobl.materialNbr, Sobl.plantid, SalesDocType) AS Sobl
						GROUP BY Sobl.MaterialNbr, Sobl.PlantId) AS Sobl
						ON Ml.MaterialNbr=Sobl.materialNbr AND Ml.Plant=Sobl.PlantId
					LEFT JOIN SAP.dbo.Marc AS Mc
						ON Ml.MaterialNbr=Mc.Material AND Ml.Plant=Mc.Plant
					LEFT JOIN 
						(SELECT 
							Rda.DateDt
							, Rda.DateTxt
							,Rda.QtrDay
							, CASE 
								WHEN QtrDay<11 OR QtrDay>83 THEN CAST(CONCAT(LEFT(CAST(DATEADD(day, -14, DateDt) AS VARCHAR(30)),8),'15') AS DATE) END AS InTransitReschedDtIn
							, CASE 
								WHEN QtrDay<11 OR QtrDay>83 THEN CAST(CONCAT(LEFT(CAST(DATEADD(day, 14, DateDt) AS VARCHAR(30)),8),'15') AS DATE) END AS InTransitReschedDtOut
						FROM
							(SELECT Rda.*
								,RANK() OVER(PARTITION BY FyYyyyQtr ORDER BY DateDt) AS QtrDay
							FROM [CentralDbs].[dbo].[RefDateAvnet] AS Rda) AS Rda) AS Rda		--Used to calculate Intransit Window
						ON Ml.ReschedDt=Rda.DateDt
				WHERE Pr.EdiPullIn=1 AND Pr.NonEdiPullIn=0  	--Filter to Edi Push Outs
					AND (Ml.SchDlvryDt BETWEEN DATEADD(DAY, Pr.EdiPullActionWindowStart, @CurrentDate) AND DATEADD(DAY, Pr.EdiPullActionWindowEnd, @CurrentDate))	--Filter on SchedDt
					AND (Ml.ReschedDt<Ml.SchDlvryDt AND Ml.ReschedDt>@CurrentDate)
					AND Pr.[860PoChg]=1 and Pr.[865PoChgAck]=1				--EdiSupplier
					AND Pr.RemoveFromPopic=0) AS Ml			--Not Removed from Popic
				INNER JOIN 
					(SELECT Pobl.*, Pobl.SchedQty *PoCc.CostCondVal/1000 AS PoSchedVal, PoCc.CostCond
					FROM Bi.dbo.BIPoBacklog AS Pobl
						INNER JOIN 
							(SELECT *
							FROM
								(SELECT *, RANK() OVER(PARTITION BY Pocc.PoNbr, PoCc.PoLineNbr ORDER BY Pocc.PoNbr, PoCc.PoLineNbr, PoCc.CostCond ASC) AS Rank2
								FROM
									(SELECT *, RANK() OVER(PARTITION BY Pocc.PoNbr, PoCc.PoLineNbr ORDER BY Pocc.PoNbr, PoCc.PoLineNbr, PoCc.CostCondVal ASC) AS Rank1
									FROM Bi.dbo.BiPoCostConditions AS PoCc
									WHERE PoCC.CostCond='ZMPP' OR PoCc.CostCond='ZDC' OR PoCc.CostCond='ZSBP' OR PoCc.CostCond='PBXX') AS PoCc
								WHERE PoCc.Rank1=1) AS Pocc
							WHERE PoCc.Rank2=1) AS Pocc
							ON Pobl.PoNbr=Pocc.PONbr AND Pobl.PoLine=Pocc.PoLineNbr) AS Pobl
					ON Ml.MrpNbr=Pobl.PoNbr AND Ml.MrpItem=Pobl.PoLine AND Ml.SchedItem=Pobl.PoSchedLine
			WHERE Pobl.PoSchedVal BETWEEN Ml.NonEdiPushMinVal AND Ml.NonEdiPushMaxVal	--Dollar Threshold
				AND (Pobl.ConfDlvryDt>DATEADD(DAY, Ml.CancelWindow+7, @CurrentDate) OR Pobl.ConfDlvryDt IS NULL)
				AND ((EdiPullZorDemand=1 AND EdiPullZfcDemand=1 AND Ml.EdiPullZsbDemand=1 AND (Ml.ZorQty>0 OR Ml.ZfcQty>0 OR Ml.ZsbQty>0)) 
				OR (EdiPullZorDemand=1 AND EdiPullZfcDemand=1 AND Ml.EdiPullZsbDemand=0 AND (Ml.ZorQty>0 OR Ml.ZfcQty>0) AND Ml.ZsbQty=0)
				OR (EdiPullZorDemand=1 AND EdiPullZfcDemand=0 AND Ml.EdiPullZsbDemand=0 AND Ml.ZorQty>0 AND Ml.ZfcQty=0 AND Ml.ZsbQty=0)
				OR (EdiPullZorDemand=0 AND EdiPullZfcDemand=1 AND Ml.EdiPullZsbDemand=1 AND Ml.ZorQty=0 AND (Ml.ZfcQty>0 OR Ml.ZsbQty>0))
				OR (EdiPullZorDemand=0 AND EdiPullZfcDemand=1 AND Ml.EdiPullZsbDemand=0 AND Ml.ZorQty=0 AND Ml.ZsbQty=0 AND Ml.ZfcQty>0)
				OR (EdiPullZorDemand=0 AND EdiPullZfcDemand=0 AND Ml.EdiPullZsbDemand=1 AND Ml.ZorQty=0 AND Ml.ZfcQty=0 AND Ml.ZsbQty>0)
				)) AS Ml
			INNER JOIN SAP.dbo.MatAor AS Ma
				ON Ml.MaterialNbr=Ma.MatNbr
			INNER JOIN														---Filter out Eol & Obsolete parts
				(SELECT *
				FROM CentralDbs.dbo.SapFlagsCodes AS Sfc
				WHERE Sfc.Xstatus IS NULL) AS Sfc
				ON Ml.MaterialNbr=sfc.MaterialNbr AND Ml.Plant=Sfc.SapPlantCd) AS Ml
		INNER JOIN #PoBlCount AS PoblCount
			ON Ml.MrpNbr=PoblCount.PoNbr AND Ml.MrpItem=PoblCount.PoLine AND Ml.SchedItem=PoblCount.PoSchedLine AND PoblCount.PoType=Ml.PoAction
		WHERE Ml.ReschedDt!='9999-12-31') AS EDI




--=========================================Merge Statement====================================================================




MERGE Popic.dbo.CdbPopic AS TargetTbl
USING #Popic AS SourceTbl
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
	OR (TargetTbl.ConfDlvryDt <> SourceTbl.ConfDlvryDt OR (TargetTbl.ConfDlvryDt IS NULL AND SourceTbl.ConfDlvryDt IS NOT NULL))
	OR TargetTbl.SchDlvryDt <> SourceTbl.SchDlvryDt
	OR TargetTbl.PoSchedVal <> SourceTbl.PoSchedVal
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
		,TargetTbl.PoSchedVal = SourceTbl.PoSchedVal
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
		,PoSchedVal
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
		,[TransmitType]
		,CostCond)
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
		,PoSchedVal
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
		,[TransmitType]
		,CostCond)
WHEN NOT MATCHED BY SOURCE AND TargetTbl.TransmitType='EDI' AND (TargetTbl.[PoAction]='PUSH' OR TargetTbl.[PoAction]='Cancel' OR TargetTbl.[PoAction]='Pull') THEN
DELETE;