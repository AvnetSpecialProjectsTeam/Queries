

Update NonHaImportTesting.dbo.ImportMard
Set [Column 43] = Stuff(Stuff([Column 43],5,0,'/'),8,0,'/');

Update NonHaImportTesting.dbo.ImportMard
Set [Column 43] = Null
Where [Column 43] = '0000/00/00'

Update NonHaImportTesting.dbo.ImportMard
Set [Column 47] = 0
Where [Column 47] = ' 0.0E+00'
Go

TRUNCATE TABLE SAP.dbo.Mard
Go

Insert Into SAP.dbo.Mard
Select * From NonHaImportTesting.dbo.ImportMard
Where [Column 0] Is Not Null and [Column 0] <> ' '

TRUNCATE TABLE NonHaImportTesting.dbo.ImportMard