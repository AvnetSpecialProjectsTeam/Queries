USE SAP
GO

TRUNCATE TABLE InvValAnal

Insert Into InvValAnal
Select *
From NonHaImportTesting.dbo.ImportInvValAnal
WHERE [Column 0] IS NOT NULL AND [Column 0]<>'';