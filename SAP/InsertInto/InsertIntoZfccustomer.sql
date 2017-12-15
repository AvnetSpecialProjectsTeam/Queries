Truncate Table Sap.dbo.ZfcCustomer

Insert Into Sap.dbo.ZfcCustomer(
Client,
FcstParty,
SalesOrg,
DistrChannel,
ReservingFcst,
[Status],
Plant,
RespUser,
FcstPeriod,
FcstReloadPeriod,
LoadTo,
FcstHoldPerson,
Idicator01,
Idicator02,
NetQtyTrans,
NetQtyTransDays,
ConsignFlag,
VMIFlag,
PackSizeRound,
ConsumptionTyp,
[Route],
SalesDocTyp,
PeriodsValidate,
SafetyScs,
TargetBufferQty,
CreatedBy,
CreatedOn,
CreatedAt,
ChangedBy,
ChangedOn,
ChangedAt,
PoNbr
) 
Select [Column 0]
      ,[Column 1]
      ,[Column 2]
      ,[Column 3]
      ,[Column 4]
      ,[Column 5]
      ,[Column 6]
      ,[Column 7]
      ,[Column 8]
      ,[Column 9]
      ,[Column 10]
      ,[Column 11]
      ,[Column 12]
      ,[Column 13]
      ,[Column 14]
      ,Replace([Column 15],'.','')
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
      ,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 26],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) Is null then null else Stuff(Stuff(Replace(Replace([Column 26],'/',''),' ',''),5,0,'/'),8,0,'/') End
      ,Case When Try_Cast(STUFF(STUFF(Replace([COLUMN 27],' ',''), 5,0,':'),3,0,':') AS Time) Is null then null Else STUFF(STUFF(Replace([COLUMN 27],' ',''),5,0,':'),3,0,':') End
      ,[Column 28]
      ,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 29],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) Is null then null else Stuff(Stuff(Replace(Replace([Column 29],'/',''),' ',''),5,0,'/'),8,0,'/') End
      ,Case When Try_Cast(STUFF(STUFF(Replace([COLUMN 30],' ',''), 5,0,':'),3,0,':') AS Time) Is null then null Else STUFF(STUFF(Replace([COLUMN 30],' ',''),5,0,':'),3,0,':') End
      ,[Column 31]

   From NonHaImportTesting.dbo.ImportZfcCustomer
   Where [Column 0] Is Not Null and [Column 0] <> ''

--Truncate Table NonHaImportTesting.dbo.ImportZfcCustomer