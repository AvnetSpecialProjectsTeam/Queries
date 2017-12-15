MERGE Sap.dbo.ZfcUploadLog ZUL
USING NonHaImportTesting.dbo.ImportZfcUploadLog IZUL
ON ZUL.FcstParty = IZUL.[Column 1] AND ZUL.SalesOrg = IZUL.[Column 2] AND ZUL.DistrChannel = IZUL.[Column 3] AND ZUL.CustMat = IZUL.[Column 4] AND ZUL.MatNbr = IZUL.[Column 5] and ZUL.Week = IZUL.[Column 6] AND ZUL.FcastReceivedDt = IZUL.[Column 7] AND ZUL.Time = IZUL.[Column 8] 
WHEN NOT MATCHED BY TARGET AND Izul.[Column 0] Is NOT NULL THEN
  INSERT (
Client,
FcstParty,
SalesOrg,
DistrChannel,
CustMat,
MatNbr,
Week,
FcastReceivedDt,
Time,
FcastErrorId,
FcastReceived,
FcastOverwrite,
OrderQty,
CustInv,
QtyInTrans,
ConsignStk,
PackSizeRounding,
DlvryUnit,
PlDlvryTime,
FcastAmendFig,
FcastReprocessStat,
Username,
Date,
UserOrigin,
DlvryQty,
FcastChangeTyp)
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

TRUNCATE TABLE NonHaImportTesting.dbo.ImportZfcUploadLog