--Use NonHaImportTesting
--Go


--Truncate Table Sap.dbo.Ekes


MERGE Sap.dbo.Ekes AS TargetTbl
USING NonHaImportTesting.dbo.ImportEkes AS SourceTbl
ON (TargetTbl.PoNbr=SourceTbl.[Column 1] AND TargetTbl.PoItmNbr=SourceTbl.[Column 2] AND TargetTbl.VenConfSeqNbr=SourceTbl.[Column 3])
WHEN MATCHED AND SourceTbl.[Column 0]<>' ' AND SourceTbl.[Column 0] Is Not Null
	AND TargetTbl.ItmDlvryDt<>Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 5],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 5],5,0,'/'),8,0,'/') End

THEN
	UPDATE SET
		TargetTbl.ConfCat=SourceTbl.[Column 4]
		,TargetTbl.ItmDlvryDt=Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 5],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 5],5,0,'/'),8,0,'/') End
		,TargetTbl.DlvryDtCat=SourceTbl.[Column 6]
		,TargetTbl.DtTime=STUFF(STUFF([Column 7],3,0,':'),6,0,':')
		,TargetTbl.CreatedOn=Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 8],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 8],5,0,'/'),8,0,'/') End
		,TargetTbl.VendConfCreateTime=STUFF(STUFF(SourceTbl.[Column 9],3,0,':'),6,0,':')
		,TargetTbl.SchedQty=SourceTbl.[Column 10]
		,TargetTbl.QtyReduced=SourceTbl.[Column 11]
		,TargetTbl.CreationId=SourceTbl.[Column 12]
		,TargetTbl.PurOrgData=SourceTbl.[Column 13]
		,TargetTbl.MrpRelevant=SourceTbl.[Column 14]
		,TargetTbl.RefDocNbr=SourceTbl.[Column 15]
		,TargetTbl.SalesDocNbr=SourceTbl.[Column 16]
		,TargetTbl.DlvryItm1=SourceTbl.[Column 17]
		,TargetTbl.MfgPartProfile=SourceTbl.[Column 18]
		,TargetTbl.MatNbrMfgPartNbr=SourceTbl.[Column 19]
		,TargetTbl.NbrRemExp=SourceTbl.[Column 20]
		,TargetTbl.BatchNbr=SourceTbl.[Column 21]
		,TargetTbl.HighLvlItmBatch=SourceTbl.[Column 22]
		,TargetTbl.SequentialNbr=SourceTbl.[Column 23]
		,TargetTbl.Plant=SourceTbl.[Column 24]
		,TargetTbl.Delivery=SourceTbl.[Column 25]
		,TargetTbl.DlvryItm2=SourceTbl.[Column 26]
		,TargetTbl.HandoverDt=Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 27],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 27],5,0,'/'),8,0,'/') End
		,TargetTbl.HandoverTime=STUFF(STUFF(SourceTbl.[Column 28],3,0,':'),6,0,':')
WHEN NOT MATCHED BY TARGET AND SourceTbl.[Column 0] Is Not Null and SourceTbl.[Column 0] <> ' ' THEN
INSERT
	(
	Client,
	PoNbr,
	PoItmNbr,
	VenConfSeqNbr,
	ConfCat,
	ItmDlvryDt,
	DlvryDtCat,
	DtTime,
	CreatedOn,
	VendConfCreateTime,
	SchedQty,
	QtyReduced,
	CreationId,
	PurOrgData,
	MrpRelevant,
	RefDocNbr,
	SalesDocNbr,
	DlvryItm1,
	MfgPartProfile,
	MatNbrMfgPartNbr,
	NbrRemExp,
	BatchNbr,
	HighLvlItmBatch,
	SequentialNbr,
	Plant,
	Delivery,
	DlvryItm2,
	HandoverDt,
	HandoverTime
	)
VALUES
	(
	[Column 0]
    ,[Column 1]
    ,[Column 2]
    ,[Column 3]
    ,[Column 4]
    ,Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 5],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 5],5,0,'/'),8,0,'/') End
    ,[Column 6]
    ,STUFF(STUFF(SourceTbl.[Column 7],3,0,':'),6,0,':')
    ,Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 8],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 8],5,0,'/'),8,0,'/') End
    ,STUFF(STUFF(SourceTbl.[Column 9],3,0,':'),6,0,':')
    ,[Column 10]
    ,[Column 11]
    ,[Column 12]
    ,[Column 13]
    ,[Column 14]
    ,[Column 15]
    ,[Column 16]
    ,[Column 17]
    ,[Column 18]
    ,[Column 19]
    ,[Column 20]
    ,[Column 21]
    ,[Column 22]
    ,[Column 23]
    ,[Column 24]
    ,[Column 25]
    ,[Column 26]
    ,Case When TRY_CAST(STUFF(STUFF(SourceTbl.[Column 27],5,0,'/'),8,0,'/') as DATETIME2) IS Null THEN Null Else STUFF(STUFF(SourceTbl.[Column 27],5,0,'/'),8,0,'/') End
    ,STUFF(STUFF(SourceTbl.[Column 28],3,0,':'),6,0,':')
	)
;


Truncate Table ImportEkes