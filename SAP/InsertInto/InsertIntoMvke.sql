Use NonHaImportTesting
Go
Truncate Table Sap.dbo.MVKE


Update ImportMVKE Set [Column 10] = Case When Try_Cast(STUFF(STUFF(Replace([Column 10],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 10],' ',''),5,0,'/'),8,0,'/') End,
[Column 33] = Case When Try_Cast(STUFF(STUFF(Replace([Column 33],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 33],' ',''),5,0,'/'),8,0,'/') End,
[Column 34] = Case When Try_Cast(STUFF(STUFF(Replace([Column 34],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 34],' ',''),5,0,'/'),8,0,'/') End,
[Column 35] = Case When Try_Cast(STUFF(STUFF(Replace([Column 35],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 35],' ',''),5,0,'/'),8,0,'/') End,
[Column 36] = Case When Try_Cast(STUFF(STUFF(Replace([Column 36],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 36],' ',''),5,0,'/'),8,0,'/') End,
[Column 37] = Case When Try_Cast(STUFF(STUFF(Replace([Column 37],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 37],' ',''),5,0,'/'),8,0,'/') End,
[Column 38] = Case When Try_Cast(STUFF(STUFF(Replace([Column 38],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF
(Replace([Column 38],' ',''),5,0,'/'),8,0,'/') End,
[Column 39] = Case When Try_Cast(STUFF(STUFF(Replace([Column 39],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 39],' ',''),5,0,'/'),8,0,'/') End,
[Column 40] = Case When Try_Cast(STUFF(STUFF(Replace([Column 40],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 40],' ',''),5,0,'/'),8,0,'/') End,
[Column 69] = Case When Try_Cast(STUFF(STUFF(Replace([Column 69],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 69],' ',''),5,0,'/'),8,0,'/') End,
[Column 70] = Case When Try_Cast(STUFF(STUFF(Replace([Column 70],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 70],' ',''),5,0,'/'),8,0,'/') End,
[Column 74] = Case When Try_Cast(STUFF(STUFF(Replace([Column 74],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 74],' ',''),5,0,'/'),8,0,'/') End,
[Column 75] = Case When Try_Cast(STUFF(STUFF(Replace([Column 75],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 75],' ',''),5,0,'/'),8,0,'/') End,
[Column 76] = Case When Try_Cast(STUFF(STUFF(Replace([Column 76],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 76],' ',''),5,0,'/'),8,0,'/') End



Insert Into Sap.dbo.MVKE Select * From ImportMVKE Where [Column 0] <>  ' ' AND [Column 0] Is Not Null

--Truncate Table ImportMVKE
