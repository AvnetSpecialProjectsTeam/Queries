TRUNCATE TABLE SAP.dbo.Konh


Insert Into SAP.dbo.Konh
(
 [Client]
      ,[CondRecNbr]
      ,[CreatorName]
      ,[CreateDt]
      ,[CondTblUsage]
      ,[CondTbl]
      ,[Application]
      ,[CondType]
      ,[VarKey]
      ,[ValidFrom]
      ,[ValidTo]
      ,[CondSearchTerm]
      ,[SdResponsibility]
      ,[Promo]
      ,[SalesDeal]
      ,[SalesQuote]
      ,[StandardAgree]
      ,[Promo2]
      ,[Agreement]
      ,[TaxExemptLicenseNbr]
      ,[LicenseDt]
      ,[VariableData]

)
Select
[Column 0]
      ,[Column 1]
      ,[Column 2]
      ,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 3],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) IS Null then Null Else Try_Cast(STUFF(STUFF(Replace(Replace([Column 3],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) End
      ,[Column 4]
      ,[Column 5]
      ,[Column 6]
      ,[Column 7]
      ,[Column 8]
      ,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 9],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) IS Null then Null Else Try_Cast(STUFF(STUFF(Replace(Replace([Column 9],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) End
      ,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 10],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) IS Null then Null Else Try_Cast(STUFF(STUFF(Replace(Replace([Column 10],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) End
      ,[Column 11]
      ,[Column 12]
      ,[Column 13]
      ,[Column 14]
      ,[Column 15]
      ,[Column 16]
      ,[Column 17]
      ,[Column 18]
      ,[Column 19]
      ,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 20],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) IS Null then Null Else Try_Cast(STUFF(STUFF(Replace(Replace([Column 20],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) End
      ,[Column 21]
From NonHaImportTesting.dbo.ImportKonh 
Where [Column 0] Is not Null AND [Column 0] <> ' '  AND [Column 0] <> ''AND [Column 9] <> ' ' AND [Column 10] <> ' ' and [Column 9] <> '26572440 U001613100400337540040000040TISSN74LVC1T4' AND LEN([Column 9]) < 11
GO

--Truncate Table ImportKonh