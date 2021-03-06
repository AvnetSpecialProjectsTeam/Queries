USE NonHaImportTesting
GO 

TRUNCATE TABLE Sap.dbo.MCHB

INSERT INTO Sap.dbo.MCHB (
[Client]
      ,[Material]
      ,[Plant]
      ,[StorLoc]
      ,[BatchNbr]
      ,[ValTyp]
      ,[CreatedOn]
      ,[EnteredBy]
      ,[LastChange]
      ,[ChangedBy]
      ,[YearCurrPeriod]
      ,[CurrPeriod]
      ,[PhysInvBlock]
      ,[ValUnrestrictUseStk]
      ,[StkInTrans]
      ,[StkQualityInspect]
      ,[TtlStkRestrictBatches]
      ,[BlockStk]
      ,[BlockStkReturns]
      ,[UnrestrUsePrevPeriod]
      ,[StkTransPrevPeriod]
      ,[StkQtyInspectPrevPeriod]
      ,[RestrUsePrevPeriod]
      ,[BlckStckPrevPeriod]
      ,[BlckStkReturnPrevPeriod]
      ,[WarehouseStkCurrYr]
      ,[QualInspStkCurrYr]
      ,[RestrictedUseCurrYr]
      ,[BlockedStkCurrYr]
      ,[WarehouseStkPrevYr]
      ,[QualInspStkPrevYr]
      ,[RestrictedUsePrevYr]
      ,[BlockedStkPrevYr]
      ,[CtryOfOrigin]
      ,[LastCountDt]
      ,[FYCurrPhysInvId]
      ,[MchbhRecAlreadyExists]
      ,[StorSegment]

)
SELECT 
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
,[Column 33]
,[Column 34]
,[Column 35]
,[Column 36]
,[Column 37]

FROM ImportMCHB
WHERE [Column 0] Is Not Null AND [Column 0]<>'';

