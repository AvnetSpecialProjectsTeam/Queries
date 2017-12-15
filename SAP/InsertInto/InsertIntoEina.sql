TRUNCATE TABLE Sap.dbo.Eina

Insert Into Sap.dbo.Eina(
Client--,[Column 0]
,InfoRecOrderNbr--,[Column 1]
,Material--,[Column 2]
,MatGrp--,[Column 3]
,Vendor--,[Column 4]
,PurOrgData--,[Column 5]
,CreateDt--,[Column 6]
,CreatePerson--,[Column 7]
,PurchaseInfoRec--,[Column 8]
,SortTerm--,[Column 9]
,UnitOfMeasure--,[Column 10]
,NumOrderToBase--,[Column 11]
,DenomOrderToBase--,[Column 12]
,VendMatNbr--,[Column 13]
,SalesRepResp--,[Column 14]
,endTeleNbr--,[Column 15]
,[1stRemExped]--,[Column 16]
,[2ndRemExped]--,[Column 17]
,[3rdRemExped]--,[Column 18]
,CertNbr--,[Column 19]
,OriginValidTo--,[Column 20]
,CtryOfOrigin--,[Column 21]
,CertCat--,[Column 22]
,Nbr--,[Column 23]
,BaseUnit--,[Column 24]
,Region--,[Column 25]
,VarOrderUnitItm--,[Column 26]
,VendorSubrange--,[Column 27]
,VsrSortNbr--,[Column 28]
,VendorMatGrp--,[Column 29]
,ReturnAgmt--,[Column 30]
,AvailFrom--,[Column 31]
,AvailTo--,[Column 32]
,PriorVendor--,[Column 33]
,NbrPoints--,[Column 34]
,PointsUnItm--,[Column 35]
,RegularVendor--,[Column 36]
,Mfg--,[Column 37]
)
 Select
 [Column 0]
,[Column 1]
,[Column 2]
,[Column 3]
,[Column 4]
,[Column 5]
,Case When Try_Cast(STUFF(STUFF([Column 6],5,0,'/'),8,0,'/') AS datetime2) is null then null
else STUFF(STUFF([Column 6],5,0,'/'),8,0,'/') end
,[Column 7]
,[Column 8]
,[Column 9]
,[Column 10]
,Replace([Column 11],'.','')
,Replace([Column 12],'.','')
,[Column 13]
,[Column 14]
,Case When [Column 15] = ' ' Then Null Else [Column 15] End
,Case When [Column 16] = ' ' Then Null Else Replace([Column 16],'.','') End
,Replace([Column 17],'.','')
,Replace([Column 18],'.','')
,Case When [Column 19] = ' ' Then Null Else Replace([Column 19],'.','') End
,Case When Try_Cast(STUFF(STUFF([Column 20],5,0,'/'),8,0,'/') AS datetime2) is null then null
else STUFF(STUFF([Column 20],5,0,'/'),8,0,'/') end
,[Column 21]
,[Column 22]
,Case When [Column 23] = ' ' Then Null Else [Column 23] End
,[Column 24]
,[Column 25]
,[Column 26]
,[Column 27]
,[Column 28]
,[Column 29]
,[Column 30]
,Case When Try_Cast(STUFF(STUFF([Column 31],5,0,'/'),8,0,'/') AS datetime2) is null then null
else STUFF(STUFF([Column 31],5,0,'/'),8,0,'/') end
,Case When Try_Cast(STUFF(STUFF([Column 32],5,0,'/'),8,0,'/') AS datetime2) is null then null
else STUFF(STUFF([Column 32],5,0,'/'),8,0,'/') end
,[Column 33]
,Case When [Column 34] = ' ' Then Null Else [Column 34] End
,Case When [Column 35] = ' ' Then Null When [Column 35] = 0.000 Then 0 Else [Column 35] End
,[Column 36]
,[Column 37]
From NonHaImportTesting.dbo.ImportEina 
Where [Column 0] Is not Null And [Column 0] <> ' '
AND (LEN([Column 0])<5 Or Len([Column 0]) IS Null)
AND (LEN([Column 3])<11 Or Len([Column 3]) IS Null)
AND (LEN([Column 4])<11 Or Len([Column 4]) IS Null)
AND (LEN([Column 5])<3 Or Len([Column 5]) IS Null)
AND (LEN([Column 7])<14 Or Len([Column 7]) IS Null)
AND (LEN([Column 8])<42 Or Len([Column 8]) IS Null)
AND (LEN([Column 9])<12 Or Len([Column 9]) IS Null)
AND (LEN([Column 10])<5 Or Len([Column 10]) IS Null)
AND (LEN([Column 13])<51 Or Len([Column 13]) IS Null)
AND (LEN([Column 14])<32 Or Len([Column 14]) IS Null)
AND (LEN([Column 15])<17 Or Len([Column 15]) IS Null)
AND (LEN([Column 21])<9 Or Len([Column 21]) IS Null)
AND (LEN([Column 22])<3 Or Len([Column 22]) IS Null)
AND (LEN([Column 23])<17 Or Len([Column 23]) IS Null)
AND (LEN([Column 24])<5 Or Len([Column 24]) IS Null)
AND (LEN([Column 25])<5 Or Len([Column 25]) IS Null)
AND (LEN([Column 26])<3 Or Len([Column 26]) IS Null)
AND (LEN([Column 27])<8 Or Len([Column 27]) IS Null)
AND (LEN([Column 28])<11 Or Len([Column 28]) IS Null)
AND (LEN([Column 29])<20 Or Len([Column 29]) IS Null)
AND (LEN([Column 30])<4 Or Len([Column 30]) IS Null)
AND (LEN([Column 33])<12 Or Len([Column 33]) IS Null)
AND (LEN([Column 36])<3 Or Len([Column 36]) IS Null)
AND (LEN([Column 37])<12 Or Len([Column 37]) IS Null)
AND (ISNUMERIC([Column 1])=1 or [Column 1] is null or [Column 1] = '')	
AND (ISNUMERIC([Column 2])=1 or [Column 2] is null or [Column 2] = '')
AND (ISNUMERIC([Column 11])=1 or [Column 11] is null or [Column 11] = '')
AND (ISNUMERIC([Column 12])=1 or [Column 12] is null or [Column 12] = '')
AND (ISNUMERIC([Column 16])=1 or [Column 16] is null or [Column 16] = '')
AND (ISNUMERIC([Column 17])=1 or [Column 17] is null or [Column 17] = '')
AND (ISNUMERIC([Column 18])=1 or [Column 18] is null or [Column 18] = '')
AND (ISNUMERIC([Column 19])=1 or [Column 19] is null or [Column 19] = '')
AND (ISNUMERIC([Column 34])=1 or [Column 34] is null or [Column 34] = '')
AND (ISNUMERIC([Column 35])=1 or [Column 35] is null or [Column 35] = '')

TRUNCATE TABLE NonHaImportTesting.dbo.ImportEina