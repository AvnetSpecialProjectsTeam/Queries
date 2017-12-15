Use NonHaImportTesting
Go

--Format Date Fields

Update ImportLikp Set
[Column 4] = STUFF(STUFF([Column 4],5,0,'/'),8,0,'/') ,
[Column 11] = STUFF(STUFF([Column 11],5,0,'/'),8,0,'/') ,
[Column 12] = STUFF(STUFF([Column 12],5,0,'/'),8,0,'/') ,
[Column 13] = STUFF(STUFF([Column 13],5,0,'/'),8,0,'/') ,
[Column 14] = STUFF(STUFF([Column 14],5,0,'/'),8,0,'/') ,
[Column 15] = STUFF(STUFF([Column 15],5,0,'/'),8,0,'/') ,
[Column 46] = STUFF(STUFF([Column 46],5,0,'/'),8,0,'/') ,
[Column 62] = STUFF(STUFF([Column 62],5,0,'/'),8,0,'/') ,
[Column 70] = STUFF(STUFF([Column 70],5,0,'/'),8,0,'/') ,
[Column 83] = STUFF(STUFF([Column 83],5,0,'/'),8,0,'/') ,
[Column 84] = STUFF(STUFF([Column 84],5,0,'/'),8,0,'/') ,
[Column 86] = STUFF(STUFF([Column 86],5,0,'/'),8,0,'/') ,
[Column 87] = STUFF(STUFF([Column 87],5,0,'/'),8,0,'/') ,
[Column 130] = STUFF(STUFF([Column 130],5,0,'/'),8,0,'/') ,
[Column 169] = STUFF(STUFF([Column 169],5,0,'/'),8,0,'/')

-- Remove invalid date values

Update ImportLikp
Set
[Column 4] = Case when [Column 4] = '0000/00/00' Then Null Else [Column 4]  End,
[Column 11] = Case when [Column 11] = '0000/00/00' Then Null Else [Column 11]  End,
[Column 12] = Case when [Column 12] = '0000/00/00' Then Null Else [Column 12]  End,
[Column 13] = Case when [Column 13] = '0000/00/00' Then Null Else [Column 13]  End,
[Column 14] = Case when [Column 14] = '0000/00/00' Then Null Else [Column 14]  End,
[Column 15] = Case when [Column 15] = '0000/00/00' Then Null Else [Column 15]  End,
[Column 46] = Case when [Column 46] = '0000/00/00' Then Null Else [Column 46]  End,
[Column 62] = Case when [Column 62] = '0000/00/00' Then Null Else [Column 62]  End,
[Column 70] = Case when [Column 70] = '0000/00/00' Then Null Else [Column 70]  End,
[Column 83] = Case when [Column 83] = '0000/00/00' Then Null Else [Column 83]  End,
[Column 84] = Case when [Column 84] = '0000/00/00' Then Null Else [Column 84]  End,
[Column 86] = Case when [Column 86] = '0000/00/00' Then Null Else [Column 86]  End,
[Column 87] = Case when [Column 87] = '0000/00/00' Then Null Else [Column 87]  End,
[Column 130] = Case when [Column 130] = '0000/00/00' Then Null Else [Column 130]  End,
[Column 169] = Case when [Column 169] = '0000/00/00' Then Null Else [Column 169]  End


-- Format Time Fields

Update ImportLikp
Set
[Column 3] = STUFF(STUFF([Column 3],3,0,':'),6,0,':') ,
[Column 41] = STUFF(STUFF([Column 41],3,0,':'),6,0,':') ,
[Column 101] = STUFF(STUFF([Column 101],3,0,':'),6,0,':') ,
[Column 102] = STUFF(STUFF([Column 102],3,0,':'),6,0,':') ,
[Column 103] = STUFF(STUFF([Column 103],3,0,':'),6,0,':') ,
[Column 104] = STUFF(STUFF([Column 104],3,0,':'),6,0,':') ,
[Column 131] = STUFF(STUFF([Column 131],3,0,':'),6,0,':') ,
[Column 139] = STUFF(STUFF([Column 139],3,0,':'),6,0,':') ,
[Column 170] = STUFF(STUFF([Column 170],3,0,':'),6,0,':')


-- Remove '.' to convert varchar to Int
Update ImportLikp Set [Column 163] = Null Where [Column 163] = ' '
Update ImportLikp Set [Column 163] = Replace('.','.','')