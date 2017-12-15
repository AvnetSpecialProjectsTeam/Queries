USE NonHaImportTesting
Go 


Update ImportVbfa Set [Column 13] = Case When Try_Cast(STUFF(STUFF(Replace([Column 13],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 13],' ',''),5,0,'/'),8,0,'/') End,
[Column 21] = Case When Try_Cast(STUFF(STUFF(Replace([Column 21],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 21],' ',''),5,0,'/'),8,0,'/') End,
[Column 14] = Case When Try_Cast(STUFF(STUFF(Replace([Column 14],' ',''),3,0,':'),6,0,':') As Time) Is null then null Else STUFF(STUFF(Replace([Column 14],' ',''),3,0,':'),6,0,':') End

Truncate Table Sap.dbo.Vbfa
Go

Insert Into Sap.dbo.Vbfa 
(
Client,
PrecedingDoc,
PrecedingItm,
SubsequentDoc,
SubsequentItm,
SubsDocCat,
Qty,
UnitOfMeasure,
RefVal,
OrderCurr,
PrecDocCat,
PosNegative,
ConfId,
CreateDt,
EntryTime,
Material,
MvmtTyp,
ReqTyp,
PlanningTyp,
[Level],
WarehouseNbr,
ChangedDt,
BillingCat,
GrossWeight,
WeightUnit,
Volume,
VolumeUnitItm,
BillPlanNbr,
BillPlanItm,
RefQtySalesUnit,
RefQtyBaseUnit,
SalesUnitItm,
Guaranteed,
SpecialStkId,
SpecStkNbr,
InvMgmtActive,
NetWeight,
LogSys,
GoodsMvmtStat,
ConvMethodQty,
MatDocYear,
PrecSdCatExt,
SubsSdCatExt
) Select [Column 0],[Column 1],[Column 2],[Column 3],[Column 4],[Column 5],[Column 6],[Column 7],[Column 8],[Column 9],[Column 10],[Column 11],[Column 12],[Column 13],[Column 14],[Column 15],[Column 16],[Column 17],[Column 18],[Column 19],[Column 20],[Column 21],[Column 22],[Column 23],[Column 24],[Column 25],[Column 26],[Column 27],[Column 28], LTRIM(RTRIM(CASE 
  WHEN [Column 29] like '%E-%' THEN CAST(CAST(Replace([Column 29],' ','') AS FLOAT) AS DECIMAL(18,18))
  WHEN [Column 29] like '%E+%' THEN CAST(CAST(Replace([Column 29],' ','') AS FLOAT) AS DECIMAL)
  ELSE Replace([Column 29],' ','')
 END)), LTRIM(RTRIM(CASE 
  WHEN [Column 30] like '%E-%' THEN CAST(CAST(Replace([Column 30],' ','') AS FLOAT) AS DECIMAL(18,18))
  WHEN [Column 30] like '%E+%' THEN CAST(CAST(Replace([Column 30],' ','') AS FLOAT) AS DECIMAL)
  ELSE Replace([Column 29],' ','')
 END)),  [Column 31],[Column 32],[Column 33],[Column 34],[Column 35],[Column 36],[Column 37],[Column 38],[Column 39], [Column 40],[Column 41],[Column 42] From ImportVbfa Where [Column 0] Is Not Null And [Column 0] <>' '

TRUNCATE TABLE ImportVbfa