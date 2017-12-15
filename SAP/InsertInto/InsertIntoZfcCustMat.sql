truncate table sap.dbo.ZFCCUSTMAT
go

Insert into Sap.dbo.ZfcCustMat
(
Client,
FcstPartyZZFPA,
CustMat,
SalesOrg,
DistrChannel,
ReservingFcst,
FcstStatus,
AnnualFcstQty,
BaseUnitMeasure,
ValidFrom,
ValidTo,
PackSizeRounding,
ConsumptionTyp,
FlexibleZone,
AutoDlvry,
FcstPartyRELATED_OEM,
ConsignFlag,
LiabilityWeeks,
Liability,
Id,
FcsttOverwrite,
MoveFcst,
FcstLoadDt,
PeriodValidate,
SafetySCS,
TargetBufferQty,
EnteredBy,
CreatedOn,
CreatedAt,
ChangedBy,
ChangeDtOrderMaster,
ChangedAt,
CustPoNbr,
LiabilityQty,
ApprovedQty,
BlockedQty,
StartDt,
ChangedOn
 )

SELECT Distinct 
[Column 0]
      ,[Column 1]
      ,[Column 2]
      ,[Column 3]
      ,[Column 4]
      ,[Column 5]
      ,[Column 6]
      ,[Column 7]
      ,[Column 8]
      ,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 9],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) Is null then null else Stuff(Stuff(Replace(Replace([Column 9],'/',''),' ',''),5,0,'/'),8,0,'/') End
      ,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 10],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) Is null then null else Stuff(Stuff(Replace(Replace([Column 10],'/',''),' ',''),5,0,'/'),8,0,'/') End
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
      ,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 22],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) Is null then null else Stuff(Stuff(Replace(Replace([Column 22],'/',''),' ',''),5,0,'/'),8,0,'/') End
      ,[Column 23]
      ,[Column 24]
      ,[Column 25]
      ,[Column 26]
      ,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 27],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) Is null then null else Stuff(Stuff(Replace(Replace([Column 27],'/',''),' ',''),5,0,'/'),8,0,'/') End
      ,[Column 28]
      ,[Column 29]
      ,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 30],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) Is null then null else Stuff(Stuff(Replace(Replace([Column 30],'/',''),' ',''),5,0,'/'),8,0,'/') End
      ,[Column 31]
      ,[Column 32]
	  ,[Column 33]
	  ,[Column 34]
	  ,[Column 35]
	  ,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 36],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) Is null then null else Stuff(Stuff(Replace(Replace([Column 36],'/',''),' ',''),5,0,'/'),8,0,'/') End
	  ,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 37],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) Is null then null else Stuff(Stuff(Replace(Replace([Column 37],'/',''),' ',''),5,0,'/'),8,0,'/') End
  FROM NonHaImportTesting.[dbo].[ImportZFCCUSTMAT]
  where [column 0] <> ''

Truncate Table ImportZfcCustMat

