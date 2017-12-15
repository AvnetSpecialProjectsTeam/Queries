USE 
NonHaImportTesting
GO 

Update ImportVbep Set [Column 6] = Case When Try_Cast(STUFF(STUFF(Replace([Column 6],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 6],' ',''),5,0,'/'),8,0,'/') End,
[Column 13] = Case When Try_Cast(STUFF(STUFF(Replace([Column 13],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 13],' ',''),5,0,'/'),8,0,'/') End,
[Column 58] = Case When Try_Cast(STUFF(STUFF(Replace([Column 58],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 58],' ',''),5,0,'/'),8,0,'/') End,
[Column 59] = Case When Try_Cast(STUFF(STUFF(Replace([Column 59],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 59],' ',''),5,0,'/'),8,0,'/') End,
[Column 60] = Case When Try_Cast(STUFF(STUFF(Replace([Column 60],' ',''),3,0,':'),6,0,':') As Time) Is null then null Else STUFF(STUFF(Replace([Column 60],' ',''),3,0,':'),6,0,':') End,
[Column 65] = Case When Try_Cast(STUFF(STUFF(Replace([Column 65],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 65],' ',''),5,0,'/'),8,0,'/') End,
[Column 42] = Replace([Column 42],'.',''),
[Column 43] = Replace([Column 43],'.',''),
[Column 16] = Case When [Column 16] = ' ' Then Null Else [Column 16] End,
[Column 21] = Case When [Column 21] = ' ' Then Null Else [Column 21] End,
[Column 48] = Case When [Column 48] = ' ' Then Null Else [Column 48] End,
[Column 49] = Case When [Column 49] = ' ' Then Null Else [Column 49] End,
[Column 50] = Case When [Column 50] = ' ' Then Null Else [Column 50] End,
[Column 52] = Case When [Column 52] = ' ' Then Null When [Column 52] = ' 0.1E+01' Then '1.0' When [Column 42] = ' 0.0E+00' Then '0.0' Else [Column 52] End,
[Column 61] = Case When [Column 61] = ' ' Then Null Else [Column 61] End,
[Column 62] = Case When [Column 62] = ' ' Then Null Else [Column 62] End,
[Column 64] = Case When [Column 64] = ' ' Then Null Else [Column 64] End,
[Column 36] = Case When [Column 36] = ' ' Then Null Else [Column 36] End,
[Column 37] = Case When [Column 37] = ' ' Then Null Else [Column 37] End,
[Column 38] = Case When [Column 38] = ' ' Then Null Else [Column 38] End,
[Column 39] = Case When [Column 39] = ' ' Then Null Else [Column 39] End

Truncate Table Sap.dbo.Vbep

Insert Into Sap.dbo.Vbep
Select * From ImportVbep Where [Column 0] Is Not Null And [Column 0] <>' '

Truncate Table ImportVbep