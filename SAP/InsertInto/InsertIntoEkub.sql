Use NonHaImportTesting
Go

TRUNCATE TABLE Sap.dbo.Ekub

Insert Into Sap.dbo.Ekub
Select *
From ImportEkub
WHERE [Column 0] IS NOT NULL AND [Column 0]<>'' AND ltrim(rtrim(replace(replace(replace([Column 0],char(9),''),char(10),''),char(13),''))) <> ''
GO

TRUNCATE TABLE ImportEkub