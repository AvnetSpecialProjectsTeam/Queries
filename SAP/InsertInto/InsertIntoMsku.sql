Use NonHaImportTesting
Go

Update ImportMsku
Set [Column 22] = Case When Try_Cast(STUFF(STUFF(Replace([Column 22],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 22],' ',''),5,0,'/'),8,0,'/') End,
[Column 19] = Case When Try_Cast(STUFF(STUFF(Replace([Column 19],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 19],' ',''),5,0,'/'),8,0,'/') End

Truncate Table Sap.dbo.Msku

Insert Into  Sap.dbo.Msku 
Select * From ImportMsku Where [Column 0] IS Not Null ANd [Column 0] <> ' '

Truncate Table ImportMsku

