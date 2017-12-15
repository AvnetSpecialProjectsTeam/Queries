

Insert Into Sap.dbo.Mkpf(
Client  --0
,MatDocNbr --1
,MatDocYr --2
,TransactEventTyp1 --3
,DocTyp --4
,DocTypRev --5
,DocDt --6
,DocPostingDt --7
,EnteredOnDt --8
,EnteredAtTime --9
,ChangeDt --10
,UserName --11
,NotMoreCloselyDefined --12
,RefDocNbr --13
,DocHeaderText --14
,UnplDlvryCosts --15
,BillOfLadingNbr --16
,PrintVersion --17
,GrSlipNbr --18
,LogicalSystem --19
,DocTypAd --20
,TransactionCd --21
,ExtWmsControl --22
,ForeignTradeDataNbr --23
,GoodsIssueTime --24
,TimeZone --25
,Delivery --26
,LogicalSystemEwm --27
,MaterialDocEwm --28
,CustRefNbrScrap --29
,DocCond --30
,StoreReturnInOut --31
,AdvReturns --32
)
Select 
[Column 0]
,CASE WHEN [Column 1] NOT LIKE '%[^0-9]%' THEN CAST([Column 1] AS BIGINT) ELSE 0 END
,[Column 2]
,[Column 3]
,[Column 4]
,[Column 5]
,Case When Try_cast(STUFF(STUFF(Replace(Replace([Column 6],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else Try_cast(STUFF(STUFF(Replace(Replace([Column 6],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) End
,Case When Try_cast(STUFF(STUFF(Replace(Replace([Column 7],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else Try_cast(STUFF(STUFF(Replace(Replace([Column 7],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) End
,Case When Try_cast(STUFF(STUFF(Replace(Replace([Column 8],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else Try_cast(STUFF(STUFF(Replace(Replace([Column 8],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) End
,Case When Try_cast(STUFF(STUFF(Replace(Replace([Column 9],' ',''),':',''),3,0,':'),6,0,':') as time) is null then null else Try_cast(STUFF(STUFF(Replace(Replace([Column 9],' ',''),':',''),3,0,':'),6,0,':') as time) End
,Case When Try_cast(STUFF(STUFF(Replace(Replace([Column 10],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else Try_cast(STUFF(STUFF(Replace(Replace([Column 10],' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) End
,[Column 11]
,[Column 12]
,CASE WHEN [Column 13] NOT LIKE '%[^0-9]%' THEN CAST(Replace([Column 13], ' ','') AS BIGINT) ELSE 0 END
,[Column 14]
,Cast([Column 15] as decimal(15,0))
,[Column 16]
,[Column 17]
,[Column 18]
,[Column 19]
,[Column 20]
,[Column 21]
,[Column 22]
,[Column 23]
,Case When Try_cast(STUFF(STUFF(Replace(Replace([Column 24],' ',''),':',''),3,0,':'),6,0,':') as time) is null then null else Try_cast(STUFF(STUFF(Replace(Replace([Column 24],' ',''),':',''),3,0,':'),6,0,':') as time) End
,[Column 25]
,CASE WHEN [Column 26] NOT LIKE '%[^0-9]%' THEN CAST([Column 26] AS BIGINT) ELSE 0 END
,[Column 27]
,[Column 28]
,[Column 29]
,[Column 30]
,[Column 31]
,[Column 32]
From NonHaImportTesting.dbo.ImportMkpf
Where [Column 0] Is Not Null And [Column 0] <> ''
AND (ISNUMERIC([Column 26])=1 OR [Column 26] IS Null Or [Column 26] = '')