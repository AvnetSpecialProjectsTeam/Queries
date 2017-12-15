USE NonHaImportTesting
GO

TRUNCATE TABLE Sap.dbo.Mska

Insert Into Sap.dbo.Mska
(
Client,
Material,
Plant,
StorLoc,
BatchNbr,
SpecialStk,
SalesDocNbr,
SalesDocItmNbr,
YearCurrPeriod,
CurrPeriod,
PhysInvBlocked,
ValUnrestrictedStk,
StkInQualInsp,
BlockStk,
UnrestrUseStkPrevPeriod,
QualityInspectStkPrevPeriod,
BlockStkPrevPeriod,
PhyInvIdWarehouseStk,
PhyInvIdQualCurrYear,
PhyInvIdBlockedStkCurrFY,
PhyInvIdStockPrevYear,
PhyInvIdQualinspStkPrevPeriod,
PhyInvIdBlockedStkPreviousPeriod,
PhyInvIdStkFollowingYear,
PhyInvIdQualityInspStock,
PhyInvIdBlockedStkFollow,
LastCountDt,
RestrictedUseTtlStk,
RestrUsePrevPeriod,
CreatedOn,
FYCurrPhyInv,
MxxxhRecAlreadyExists,
StkSegment
)
Select 
[Column 0]
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
      ,[Column 27]
      ,[Column 28]
      ,[Column 29]
      ,[Column 30]
      ,[Column 31]
      ,[Column 32]
From ImportMSKA
WHERE [Column 0] IS NOT NULL AND [Column 0]<>'' AND ltrim(rtrim(replace(replace(replace([Column 0],char(9),''),char(10),''),char(13),''))) <> ''
GO

TRUNCATE TABLE ImportMska