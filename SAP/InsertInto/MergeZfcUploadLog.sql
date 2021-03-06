MERGE Sap.dbo.ZfcUploadLog ZUL
USING NonHaImportTesting.dbo.ImportZfcUploadLog IZUL
ON ZUL.ForeParty = IZUL.[Column 1] AND ZUL.SalesOrg = IZUL.[Column 2] AND ZUL.DistribChannel = IZUL.[Column 3] AND ZUL.EnterCustMat = IZUL.[Column 4] AND ZUL.MatNbr = IZUL.[Column 5] and ZUL.PeriodAnalyzeWeek = IZUL.[Column 6] AND ZUL.ForeActualRecDate = IZUL.[Column 7] AND ZUL.Time1 = IZUL.[Column 8] 
WHEN NOT MATCHED BY TARGET AND Izul.[Column 0] Is NOT NULL THEN
  INSERT (Client
  ,
ForeParty,
SalesOrg,
DistribChannel,
EnterCustMat,
MatNbr,
PeriodAnalyzeWeek,
ForeActualRecDate,
Time1,
ForeErrorInd,
ForeRecCust,
ForeOverwrite,
CumulativeOrderQtySaleUnit,
CustInventory,
QtyTransit,
QtyConsignmentStock,
PackSizeRound,
DeliveryUnit,
PlanDeliveryTimeDays,
ForeAmendFigure,
ForeReprocessStat,
UserNameChangeDoc1,
Date1,
UserNameChangeDoc2,
ForeChangeType,
DeliveryQty)
Values ([Column 0]
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
      ,[Column 25]);

	  Truncate Table Sap.dbo.ZfcUploadLog

	  Select * From NonHaImportTesting.dbo.ImportZfcUploadLog where [column 25] = ''