USE SAP 
GO

TRUNCATE TABLE Sap.dbo.ZfcCustMatSplit

INSERT INTO Sap.dbo.ZfcCustMatSplit
(
Client,
FcstParty,
SalesOrg,
DistrChannel,
CustMat,
Material,
ValidTo,
ValidFrom,
AnnualFcstQty,
DlvryUnit,
BaseUnit,
SplitPercent,
RiskScore,
XPlantStatus,
AssetApproval,
Abc,
Plant,
ProdHier,
Mfg,
MfgPartNbr,
MrpCntrlr,
MatGrp,
PSMatStatus,
PlanDlvryTime,
[Value],
DocCurr,
LiabilityWeeks,
Liability,
PoNbr,
CreatedBy,
CreatedOn,
CreatedAt,
ChangedBy,
ChangedOn,
ChangedAt
) 

SELECT 
[Column 0]
      ,[Column 1]
      ,[Column 2]
      ,[Column 3]
      ,[Column 4]
      ,[Column 5]
      ,Case When Try_Cast(STUFF(STUFF(Replace([Column 6],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 6],' ',''),5,0,'/'),8,0,'/') End
      ,Case When Try_Cast(STUFF(STUFF(Replace([Column 7],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 7],' ',''),5,0,'/'),8,0,'/') End
      ,[Column 8]
      ,[Column 9]
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
      ,[Column 23]= Replace([Column 23], '.', '')
      ,[Column 24]
      ,[Column 25]
      ,[Column 26]
      ,[Column 27]
      ,[Column 28]
      ,[Column 29]
      ,Case When Try_Cast(STUFF(STUFF(Replace([Column 30],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 30],' ',''),5,0,'/'),8,0,'/') End
      ,Case When Try_Cast(STUFF(STUFF(Replace([COLUMN 31],' ',''), 5,0,':'),3,0,':') AS Time) Is null then null Else STUFF(STUFF(Replace([COLUMN 31],' ',''),5,0,':'),3,0,':') End
      ,[Column 32]
      ,Case When Try_Cast(STUFF(STUFF(Replace([Column 33],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 33],' ',''),5,0,'/'),8,0,'/') End
      ,Case When Try_Cast(STUFF(STUFF(Replace([COLUMN 34],' ',''), 5,0,':'),3,0,':') AS Time) Is null then null Else STUFF(STUFF(Replace([COLUMN 34],' ',''),5,0,':'),3,0,':') End
  FROM [NonHaImportTesting].[dbo].[ImportZfcCustMatSplit] WHERE [Column 0] Is not null And [Column 0] Not Like '% %'

--TRUNCATE TABLE ImportZfcCustMatSplit




