Use NonHaImportTesting
Go

TRUNCATE TABLE Sap.dbo.ZfcCustmatCem

Insert Into Sap.dbo.ZfcCustmatCem
Select * From ImportZfcCustmatCem
Where [Column 0] Is Not Null and [Column 0] <> ' '

TRUNCATE TABLE ImportZfcCustmatCem