TRUNCATE TABLE Sap.dbo.Eord

Insert into Sap.dbo.Eord
(
Client--,[Column 0]
,Material--,[Column 1]
,Plant--,[Column 2]
,NbrSrcList--,[Column 3]
,CreateDt--,[Column 4]
,PersonCreate--,[Column 5]
,ValidFrom--,[Column 6]
,ValidTo--,[Column 7]
,Vendor--,[Column 8]
,FixedVendorId--,[Column 9]
,PurchDocNbr--,[Column 10]
,PurchDocItmNbr--,[Column 11]
,FixOutlinePurchAgreeItm--,[Column 12]
,MatPlant--,[Column 13]
,IssuingPlant--,[Column 14]
,MfgPartNbr--,[Column 15]
,Blocked--,[Column 16]
,PurchOrg--,[Column 17]
,PurchDocCat--,[Column 18]
,SourceListRecCat--,[Column 19]
,SourceListMatPlan--,[Column 20]
,UnitOfMeasure--,[Column 21]
,LogicalSys--,[Column 22]
,SpecialStk--,[Column 23]
,CentralContract--,[Column 24]
,CentralContractItm--,[Column 25]
)
Select
[Column 0]
,[Column 1]
,[Column 2]
,[Column 3]
,TRY_CAST(STUFF(STUFF(Replace([Column 4],' ',''),5,0,'/'),8,0,'/') as DATETIME2)
,[Column 5]
,TRY_CAST(STUFF(STUFF(Replace([Column 6],' ',''),5,0,'/'),8,0,'/') as DATETIME2)
,TRY_CAST(STUFF(STUFF(Replace([Column 7],' ',''),5,0,'/'),8,0,'/') as DATETIME2)
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
,[Column 25]
From NonHaImportTesting.dbo.ImportEord
Where [Column 0] Is not Null and [Column 0] <> ' '

TRUNCATE TABLE NonHaImportTesting.dbo.ImportEord