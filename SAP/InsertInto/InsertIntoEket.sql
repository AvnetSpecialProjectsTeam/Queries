--Use NonHaImportTesting

--Update ImportEket
--Set [Column 4] = Case When TRY_CAST(STUFF(STUFF([Column 4],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null 
--Else STUFF(STUFF([Column 4],5,0,'/'),8,0,'/') End,
--[Column 5] = Case When TRY_CAST(STUFF(STUFF([Column 5],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null 
--Else STUFF(STUFF([Column 5],5,0,'/'),8,0,'/') End,
--[Column 18] = Case When TRY_CAST(STUFF(STUFF([Column 18],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null 
--Else STUFF(STUFF([Column 18],5,0,'/'),8,0,'/') End,
--[Column 30] = Case When TRY_CAST(STUFF(STUFF([Column 30],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null 
--Else STUFF(STUFF([Column 30],5,0,'/'),8,0,'/') End,
--[Column 31] = Case When TRY_CAST(STUFF(STUFF([Column 31],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null 
--Else STUFF(STUFF([Column 31],5,0,'/'),8,0,'/') End,
--[Column 33] = Case When TRY_CAST(STUFF(STUFF([Column 33],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null 
--Else STUFF(STUFF([Column 33],5,0,'/'),8,0,'/') End,
--[Column 35] = Case When TRY_CAST(STUFF(STUFF([Column 35],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null 
--Else STUFF(STUFF([Column 35],5,0,'/'),8,0,'/') End,
--[Column 37] = Case When TRY_CAST(STUFF(STUFF([Column 37],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null 
--Else STUFF(STUFF([Column 37],5,0,'/'),8,0,'/') End,
--[Column 39] = Case When TRY_CAST(STUFF(STUFF([Column 39],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null 
--Else STUFF(STUFF([Column 39],5,0,'/'),8,0,'/') End,
--[Column 41] = Case When TRY_CAST(STUFF(STUFF([Column 41],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null 
--Else STUFF(STUFF([Column 41],5,0,'/'),8,0,'/') End,
--[Column 54] = Case When TRY_CAST(STUFF(STUFF([Column 54],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null 
--Else STUFF(STUFF([Column 54],5,0,'/'),8,0,'/') End,
--[Column 56] = Case When TRY_CAST(STUFF(STUFF([Column 56],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null 
--Else STUFF(STUFF([Column 56],5,0,'/'),8,0,'/') End,
--[Column 68] = Case When TRY_CAST(STUFF(STUFF([Column 68],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null 
--Else STUFF(STUFF([Column 68],5,0,'/'),8,0,'/') End,
--[Column 59] = Replace([Column 59],'.',''),
--[Column 17] = Replace([Column 17],'.',''),
--[Column 24] = Case When Try_cast([Column 24] As Int) Is null then null else [Column 24] end,
--[Column 25] = Case When Try_cast([Column 25] As Int) Is null then null else [Column 25] end,
--[Column 12] = Case When Try_Cast([Column 12] As Decimal(13,0)) is null then null else [Column 12] End,
--[Column 15]  = Case When Try_Cast([Column 15] As Decimal(10,0)) is null then null else [Column 15] End,
--[Column 20]  = Case When Try_Cast([Column 20] As Decimal(10,0)) is null then null else [Column 20] End,
--[Column 66]  = Case When Try_Cast([Column 66] As Decimal(10,0)) is null then null else [Column 66] End


--SELECT [Column 1], TRY_CAST([Column 12] AS bigint), [Column 12]
--FROM NonHaImportTesting.dbo.ImportEket
--WHERE TRY_CAST([Column 12] AS bigint) IS NULL

MERGE Sap.dbo.Eket AS TargetTbl
USING NonHaImportTesting.dbo.ImportEket AS SourceTbl
ON (TargetTbl.PoNbr=SourceTbl.[Column 1] AND TargetTbl.PoItmNbr=SourceTbl.[Column 2] AND TargetTbl.PoSchedLine=SourceTbl.[Column 3])
WHEN MATCHED AND SourceTbl.[Column 0] <>  ' ' AND SourceTbl.[Column 0] Is Not Null
	AND TargetTbl.[ItmDlvryDt]<>Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 4],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 4],5,0,'/'),8,0,'/') End
	OR TargetTbl.[StatRelDlvryDt]<>Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 5],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 5],5,0,'/'),8,0,'/') End
	OR TargetTbl.[CatDlvryDt]<>SourceTbl.[Column 6]
	OR TargetTbl.[PoSchedQty]<>SourceTbl.[Column 7]
	OR TargetTbl.[PrevQty]<>SourceTbl.[Column 8]
	OR TargetTbl.[QtyGoodRec]<>SourceTbl.[Column 9]
	OR TargetTbl.[IssuedQty]<>SourceTbl.[Column 10]
	OR TargetTbl.[DlvryDtTime]<>SourceTbl.[Column 11]
	OR TargetTbl.[PurchReqNbr]<>Case When Try_Cast(SourceTbl.[Column 12] As BIGINT) is null then null else [Column 12] End
	OR TargetTbl.[RequisitionItmNbr]<>SourceTbl.[Column 13]
	OR TargetTbl.[CreateId]<>SourceTbl.[Column 14]
	OR TargetTbl.[QuotaArrNbr]<>Case When Try_Cast(SourceTbl.[Column 15] As Decimal(10,0)) is null then null else [Column 15] End
	OR TargetTbl.[QuotaArrItm]<>SourceTbl.[Column 16]
	OR TargetTbl.[NbrRemExpSchedLine]<>Replace(SourceTbl.[Column 17],'.','')
	OR TargetTbl.[OrderDtSchedLine]<>Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 18],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 18],5,0,'/'),8,0,'/') End
	OR TargetTbl.[ReservationNbr]<>SourceTbl.[Column 19]
	OR TargetTbl.[BomExplNbr]<>Case When Try_Cast(SourceTbl.[Column 20] As Decimal(10,0)) is null then null else [Column 20] End
	OR TargetTbl.[SchedLineFix]<>SourceTbl.[Column 21]
	OR TargetTbl.[QtyDlvryd]<>SourceTbl.[Column 22]
	OR TargetTbl.[QtyReducedMRP]<>SourceTbl.[Column 23]
	OR TargetTbl.[BatchNbr]<>Case When Try_cast(SourceTbl.[Column 24] As Int) Is null then null else [Column 24] end
	OR TargetTbl.[VenBatchNbr]<>Case When Try_cast(SourceTbl.[Column 25] As Int) Is null then null else [Column 25] end
	OR TargetTbl.[CompChange]<>SourceTbl.[Column 26]
	OR TargetTbl.[ProdVersion]<>SourceTbl.[Column 27]
	OR TargetTbl.[ReleaseTyp]<>SourceTbl.[Column 28]
	OR TargetTbl.[CommitQty]<>SourceTbl.[Column 29]
	OR TargetTbl.[CommitDt]<>Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 30],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 30],5,0,'/'),8,0,'/') End
	OR TargetTbl.[PrevDlvryDt]<>Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 31],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 31],5,0,'/'),8,0,'/') End
	OR TargetTbl.[RouteSched]<>SourceTbl.[Column 32]
	OR TargetTbl.[MatAvailDt]<>Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 33],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 33],5,0,'/'),8,0,'/') End
	OR TargetTbl.[MatStagingTime]<>SourceTbl.[Column 34]
	OR TargetTbl.[LoadDt]<>Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 35],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 35],5,0,'/'),8,0,'/') End
	OR TargetTbl.[LoadTime]<>SourceTbl.[Column 36]
	OR TargetTbl.[TranPlanDt]<>Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 37],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 37],5,0,'/'),8,0,'/') End
	OR TargetTbl.[TranPlanTime]<>SourceTbl.[Column 38]
	OR TargetTbl.[GoodIssueDt]<>Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 39],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 39],5,0,'/'),8,0,'/') End
	OR TargetTbl.[TimeGoodIssue]<>SourceTbl.[Column 40]
	OR TargetTbl.[GrEndDt]<>Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 41],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 41],5,0,'/'),8,0,'/') End
	OR TargetTbl.[GrEndTime]<>SourceTbl.[Column 42]
	OR TargetTbl.[BudgetNbr]<>SourceTbl.[Column 43]
	OR TargetTbl.[ReqBudget]<>SourceTbl.[Column 44]
	OR TargetTbl.[OTBCurr]<>SourceTbl.[Column 45]
	OR TargetTbl.[ReservedBudget]<>SourceTbl.[Column 46]
	OR TargetTbl.[SpecialRelease]<>SourceTbl.[Column 47]
	OR TargetTbl.[OTBReasonProfile]<>SourceTbl.[Column 48]
	OR TargetTbl.[BudgetTyp]<>SourceTbl.[Column 49]
	OR TargetTbl.[OTBStatus]<>SourceTbl.[Column 50]
	OR TargetTbl.[ReasonOTBStatus]<>SourceTbl.[Column 51]
	OR TargetTbl.[TypOTBCheck]<>SourceTbl.[Column 52]
	OR TargetTbl.[DtLineId]<>SourceTbl.[Column 53]
	OR TargetTbl.[TransDt]<>Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 54],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 54],5,0,'/'),8,0,'/') End
	OR TargetTbl.[PurcOrdTranSCEM]<>SourceTbl.[Column 55]
	OR TargetTbl.[ReminderDt]<>Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 56],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 56],5,0,'/'),8,0,'/') End
	OR TargetTbl.[ReminderTime]<>SourceTbl.[Column 57]
	OR TargetTbl.[CancelThreatMade]<>SourceTbl.[Column 58]
	OR TargetTbl.[NbrCurrDtShift]<>Replace(SourceTbl.[Column 59],'.','')
	OR TargetTbl.[NbrSerNbr]<>SourceTbl.[Column 60]
	OR TargetTbl.[ResPurcReqCreate]<>SourceTbl.[Column 61]
	OR TargetTbl.[Georoute]<>SourceTbl.[Column 62]
	OR TargetTbl.[GTSRouteCode]<>SourceTbl.[Column 63]
	OR TargetTbl.[GoodTrafficTyp]<>SourceTbl.[Column 64]
	OR TargetTbl.[FwdAgent]<>SourceTbl.[Column 65]
	OR TargetTbl.[APOLocNbr]<>Case When Try_Cast(SourceTbl.[Column 66] As Decimal(10,0)) is null then null else [Column 66] End
	OR TargetTbl.[APOLocTyp]<>SourceTbl.[Column 67]
	OR TargetTbl.[HanDtHanLoc]<>Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 68],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 68],5,0,'/'),8,0,'/') End
	OR TargetTbl.[HanTimeHanLoc]<>SourceTbl.[Column 69]
THEN
	UPDATE SET
		TargetTbl.[ItmDlvryDt]=Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 4],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 4],5,0,'/'),8,0,'/') End
		,TargetTbl.[StatRelDlvryDt]=Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 5],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 5],5,0,'/'),8,0,'/') End
		,TargetTbl.[CatDlvryDt]=SourceTbl.[Column 6]
		,TargetTbl.[PoSchedQty]=SourceTbl.[Column 7]
		,TargetTbl.[PrevQty]=SourceTbl.[Column 8]
		,TargetTbl.[QtyGoodRec]=SourceTbl.[Column 9]
		,TargetTbl.[IssuedQty]=SourceTbl.[Column 10]
		,TargetTbl.[DlvryDtTime]=SourceTbl.[Column 11]
		,TargetTbl.[PurchReqNbr]=Case When Try_Cast(SourceTbl.[Column 12] As BIGINT) is null then null else [Column 12] End
		,TargetTbl.[RequisitionItmNbr]=SourceTbl.[Column 13]
		,TargetTbl.[CreateId]=SourceTbl.[Column 14]
		,TargetTbl.[QuotaArrNbr]=Case When Try_Cast(SourceTbl.[Column 15] As Decimal(10,0)) is null then null else [Column 15] End
		,TargetTbl.[QuotaArrItm]=SourceTbl.[Column 16]
		,TargetTbl.[NbrRemExpSchedLine]=Replace(SourceTbl.[Column 17],'.','')
		,TargetTbl.[OrderDtSchedLine]=Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 18],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 18],5,0,'/'),8,0,'/') End
		,TargetTbl.[ReservationNbr]=SourceTbl.[Column 19]
		,TargetTbl.[BomExplNbr]=Case When Try_Cast(SourceTbl.[Column 20] As Decimal(10,0)) is null then null else [Column 20] End
		,TargetTbl.[SchedLineFix]=SourceTbl.[Column 21]
		,TargetTbl.[QtyDlvryd]=SourceTbl.[Column 22]
		,TargetTbl.[QtyReducedMRP]=SourceTbl.[Column 23]
		,TargetTbl.[BatchNbr]=Case When Try_cast(SourceTbl.[Column 24] As Int) Is null then null else [Column 24] end
		,TargetTbl.[VenBatchNbr]=Case When Try_cast(SourceTbl.[Column 25] As Int) Is null then null else [Column 25] end
		,TargetTbl.[CompChange]=SourceTbl.[Column 26]
		,TargetTbl.[ProdVersion]=SourceTbl.[Column 27]
		,TargetTbl.[ReleaseTyp]=SourceTbl.[Column 28]
		,TargetTbl.[CommitQty]=SourceTbl.[Column 29]
		,TargetTbl.[CommitDt]=Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 30],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 30],5,0,'/'),8,0,'/') End
		,TargetTbl.[PrevDlvryDt]=Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 31],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 31],5,0,'/'),8,0,'/') End
		,TargetTbl.[RouteSched]=SourceTbl.[Column 32]
		,TargetTbl.[MatAvailDt]=Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 33],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 33],5,0,'/'),8,0,'/') End
		,TargetTbl.[MatStagingTime]=SourceTbl.[Column 34]
		,TargetTbl.[LoadDt]=Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 35],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 35],5,0,'/'),8,0,'/') End
		,TargetTbl.[LoadTime]=SourceTbl.[Column 36]
		,TargetTbl.[TranPlanDt]=Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 37],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 37],5,0,'/'),8,0,'/') End
		,TargetTbl.[TranPlanTime]=SourceTbl.[Column 38]
		,TargetTbl.[GoodIssueDt]=Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 39],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 39],5,0,'/'),8,0,'/') End
		,TargetTbl.[TimeGoodIssue]=SourceTbl.[Column 40]
		,TargetTbl.[GrEndDt]=Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 41],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 41],5,0,'/'),8,0,'/') End
		,TargetTbl.[GrEndTime]=SourceTbl.[Column 42]
		,TargetTbl.[BudgetNbr]=SourceTbl.[Column 43]
		,TargetTbl.[ReqBudget]=SourceTbl.[Column 44]
		,TargetTbl.[OTBCurr]=SourceTbl.[Column 45]
		,TargetTbl.[ReservedBudget]=SourceTbl.[Column 46]
		,TargetTbl.[SpecialRelease]=SourceTbl.[Column 47]
		,TargetTbl.[OTBReasonProfile]=SourceTbl.[Column 48]
		,TargetTbl.[BudgetTyp]=SourceTbl.[Column 49]
		,TargetTbl.[OTBStatus]=SourceTbl.[Column 50]
		,TargetTbl.[ReasonOTBStatus]=SourceTbl.[Column 51]
		,TargetTbl.[TypOTBCheck]=SourceTbl.[Column 52]
		,TargetTbl.[DtLineId]=SourceTbl.[Column 53]
		,TargetTbl.[TransDt]=Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 54],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 54],5,0,'/'),8,0,'/') End
		,TargetTbl.[PurcOrdTranSCEM]=SourceTbl.[Column 55]
		,TargetTbl.[ReminderDt]=Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 56],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 56],5,0,'/'),8,0,'/') End
		,TargetTbl.[ReminderTime]=SourceTbl.[Column 57]
		,TargetTbl.[CancelThreatMade]=SourceTbl.[Column 58]
		,TargetTbl.[NbrCurrDtShift]=Replace(SourceTbl.[Column 59],'.','')
		,TargetTbl.[NbrSerNbr]=SourceTbl.[Column 60]
		,TargetTbl.[ResPurcReqCreate]=SourceTbl.[Column 61]
		,TargetTbl.[Georoute]=SourceTbl.[Column 62]
		,TargetTbl.[GTSRouteCode]=SourceTbl.[Column 63]
		,TargetTbl.[GoodTrafficTyp]=SourceTbl.[Column 64]
		,TargetTbl.[FwdAgent]=SourceTbl.[Column 65]
		,TargetTbl.[APOLocNbr]=Case When Try_Cast(SourceTbl.[Column 66] As Decimal(10,0)) is null then null else [Column 66] End
		,TargetTbl.[APOLocTyp]=SourceTbl.[Column 67]
		,TargetTbl.[HanDtHanLoc]=Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 68],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 68],5,0,'/'),8,0,'/') End
		,TargetTbl.[HanTimeHanLoc]=SourceTbl.[Column 69]

WHEN NOT MATCHED BY TARGET 
AND SourceTbl.[Column 0] <>  ' ' AND SourceTbl.[Column 0] Is Not Null THEN
Insert
	(
	[Client]
    ,[PoNbr]
    ,[PoItmNbr]
    ,[PoSchedLine]
    ,[ItmDlvryDt]
    ,[StatRelDlvryDt]
    ,[CatDlvryDt]
    ,[PoSchedQty]
    ,[PrevQty]
    ,[QtyGoodRec]
    ,[IssuedQty]
    ,[DlvryDtTime]
    ,[PurchReqNbr]
    ,[RequisitionItmNbr]
    ,[CreateId]
    ,[QuotaArrNbr]
    ,[QuotaArrItm]
    ,[NbrRemExpSchedLine]
    ,[OrderDtSchedLine]
    ,[ReservationNbr]
    ,[BomExplNbr]
    ,[SchedLineFix]
    ,[QtyDlvryd]
    ,[QtyReducedMRP]
    ,[BatchNbr]
    ,[VenBatchNbr]
    ,[CompChange]
    ,[ProdVersion]
    ,[ReleaseTyp]
    ,[CommitQty]
    ,[CommitDt]
    ,[PrevDlvryDt]
    ,[RouteSched]
    ,[MatAvailDt]
    ,[MatStagingTime]
    ,[LoadDt]
    ,[LoadTime]
    ,[TranPlanDt]
    ,[TranPlanTime]
    ,[GoodIssueDt]
    ,[TimeGoodIssue]
    ,[GrEndDt]
    ,[GrEndTime]
    ,[BudgetNbr]
    ,[ReqBudget]
    ,[OTBCurr]
    ,[ReservedBudget]
    ,[SpecialRelease]
    ,[OTBReasonProfile]
    ,[BudgetTyp]
    ,[OTBStatus]
    ,[ReasonOTBStatus]
    ,[TypOTBCheck]
    ,[DtLineId]
    ,[TransDt]
    ,[PurcOrdTranSCEM]
    ,[ReminderDt]
    ,[ReminderTime]
    ,[CancelThreatMade]
    ,[NbrCurrDtShift]
    ,[NbrSerNbr]
    ,[ResPurcReqCreate]
    ,[Georoute]
    ,[GTSRouteCode]
    ,[GoodTrafficTyp]
    ,[FwdAgent]
    ,[APOLocNbr]
    ,[APOLocTyp]
    ,[HanDtHanLoc]
    ,[HanTimeHanLoc]
	)
VALUES
	( 
	[Column 0]
    ,[Column 1]
    ,[Column 2]
    ,[Column 3]
    ,Case When TRY_CAST(STUFF(STUFF([Column 4],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF([Column 4],5,0,'/'),8,0,'/') End
    ,Case When TRY_CAST(STUFF(STUFF([Column 5],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF([Column 5],5,0,'/'),8,0,'/') End
    ,[Column 6]
    ,[Column 7]
    ,[Column 8]
    ,[Column 9]
    ,[Column 10]
    ,[Column 11]
    ,Case When Try_Cast([Column 12] As BIGINT) is null then null else [Column 12] End
    ,[Column 13]
    ,[Column 14]
    ,Case When Try_Cast([Column 15] As Decimal(10,0)) is null then null else [Column 15] End
    ,[Column 16]
    ,Replace([Column 17],'.','')
    ,Case When TRY_CAST(STUFF(STUFF([Column 18],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF([Column 18],5,0,'/'),8,0,'/') End
    ,[Column 19]
    ,Case When Try_Cast([Column 20] As Decimal(10,0)) is null then null else [Column 20] End
    ,[Column 21]
    ,[Column 22]
    ,[Column 23]
    ,Case When Try_cast([Column 24] As Int) Is null then null else [Column 24] end
    ,Case When Try_cast([Column 25] As Int) Is null then null else [Column 25] end
    ,[Column 26]
    ,[Column 27]
    ,[Column 28]
    ,[Column 29]
    ,Case When TRY_CAST(STUFF(STUFF([Column 30],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF([Column 30],5,0,'/'),8,0,'/') End
    ,Case When TRY_CAST(STUFF(STUFF([Column 31],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF([Column 31],5,0,'/'),8,0,'/') End
    ,[Column 32]
    ,Case When TRY_CAST(STUFF(STUFF([Column 33],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF([Column 33],5,0,'/'),8,0,'/') End
    ,[Column 34]
    ,Case When TRY_CAST(STUFF(STUFF([Column 35],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF([Column 35],5,0,'/'),8,0,'/') End
    ,[Column 36]
    ,Case When TRY_CAST(STUFF(STUFF([Column 37],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF([Column 37],5,0,'/'),8,0,'/') End
    ,[Column 38]
    ,Case When TRY_CAST(STUFF(STUFF([Column 39],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF([Column 39],5,0,'/'),8,0,'/') End
    ,[Column 40]
    ,Case When TRY_CAST(STUFF(STUFF([Column 41],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF([Column 41],5,0,'/'),8,0,'/') End
    ,[Column 42]
    ,[Column 43]
    ,[Column 44]
    ,[Column 45]
    ,[Column 46]
    ,[Column 47]
    ,[Column 48]
    ,[Column 49]
    ,[Column 50]
    ,[Column 51]
    ,[Column 52]
    ,[Column 53]
    ,Case When TRY_CAST(STUFF(STUFF([Column 54],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF([Column 54],5,0,'/'),8,0,'/') End
    ,[Column 55]
    ,Case When TRY_CAST(STUFF(STUFF([Column 56],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF([Column 56],5,0,'/'),8,0,'/') End
    ,[Column 57]
    ,[Column 58]
    ,Replace([Column 59],'.','')
    ,[Column 60]
    ,[Column 61]
    ,[Column 62]
    ,[Column 63]
    ,[Column 64]
    ,[Column 65]
    ,Case When Try_Cast([Column 66] As Decimal(10,0)) is null then null else [Column 66] End
    ,[Column 67]
    ,Case When TRY_CAST(STUFF(STUFF([Column 68],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF([Column 68],5,0,'/'),8,0,'/') End
    ,[Column 69]
	)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;

TRUNCATE TABLE ImportEket