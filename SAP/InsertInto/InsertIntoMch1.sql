TRUNCATE TABLE Sap.dbo.Mch1

Insert Into Sap.dbo.Mch1(
Client,
Material,
BatchNbr,
ValTyp,
CreatedOn,
EnteredBy,
ChangedBy,
LastChange,
AvailableDt,
ShelfLifeExp,
BatchStatusKey,
BatchRestr,
LastChangeDt,
Vendor,
VendorBatch,
OriginBatch,
Plant,
OriginMat,
BatchIssueUnit,
LastGoodsRec,
DtUnrUse1,
DtUnrUse2,
DtUnrUse3,
DtUnrUse4,
DtUnrUse5,
DtUnrUse6,
CtryOfOrigin,
RegOfOrigin,
ExpImportGrp,
NextInspect,
MfgDt,
IntObjNbrBatchClass1,
BatchDeactivated,
BatchTyp,
StkSegment
)
Select 
[Column 0]
,[Column 1]
,[Column 2]
,[Column 3]
,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 4],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else STUFF(STUFF(Replace(Replace([Column 4],' ',''),'/',''),5,0,'/'),8,0,'/') End
,[Column 5]
,[Column 6]
,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 7],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else STUFF(STUFF(Replace(Replace([Column 7],' ',''),'/',''),5,0,'/'),8,0,'/') End
,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 8],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else STUFF(STUFF(Replace(Replace([Column 8],' ',''),'/',''),5,0,'/'),8,0,'/') End
,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 9],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else STUFF(STUFF(Replace(Replace([Column 9],' ',''),'/',''),5,0,'/'),8,0,'/') End
,[Column 10]
,[Column 11]
,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 12],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else STUFF(STUFF(Replace(Replace([Column 12],' ',''),'/',''),5,0,'/'),8,0,'/') End
,Replace([Column 13],' ','')
,Replace([Column 14],' ','')
,Replace([Column 15],' ','')
,[Column 16]
,[Column 17]
,[Column 18]
,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 19],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else STUFF(STUFF(Replace(Replace([Column 19],' ',''),'/',''),5,0,'/'),8,0,'/') End
,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 20],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else STUFF(STUFF(Replace(Replace([Column 20],' ',''),'/',''),5,0,'/'),8,0,'/') End
,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 21],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else STUFF(STUFF(Replace(Replace([Column 21],' ',''),'/',''),5,0,'/'),8,0,'/') End
,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 22],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else STUFF(STUFF(Replace(Replace([Column 22],' ',''),'/',''),5,0,'/'),8,0,'/') End
,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 23],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else STUFF(STUFF(Replace(Replace([Column 23],' ',''),'/',''),5,0,'/'),8,0,'/') End
,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 24],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else STUFF(STUFF(Replace(Replace([Column 24],' ',''),'/',''),5,0,'/'),8,0,'/') End
,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 25],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else STUFF(STUFF(Replace(Replace([Column 25],' ',''),'/',''),5,0,'/'),8,0,'/') End
,[Column 26]
,[Column 27]
,[Column 28]
,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 29],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else STUFF(STUFF(Replace(Replace([Column 29],' ',''),'/',''),5,0,'/'),8,0,'/') End
,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 30],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else STUFF(STUFF(Replace(Replace([Column 30],' ',''),'/',''),5,0,'/'),8,0,'/') End
,[Column 31]
,[Column 32]
,[Column 33]
,[Column 34]
 From NonHaImportTesting.dbo.ImportMch1 Where [Column 0] Is Not Null And [Column 0] <> ' ' 
 
TRUNCATE TABLE NonHaImportTesting.dbo.ImportMch1