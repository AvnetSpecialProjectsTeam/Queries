truncate table sap.dbo.ZFCCUSTMAT
go

Insert into Sap.dbo.ZFCCUSTMAT(
	Client					--[Column 0]
	,FcstParty01			--[Column 1]
	,CustMat				--[Column 2]
	,SalesOrg				--[Column 3]
	,DistrChannel			--[Column 4]
	,ReservingFcst			--[Column 5]
	,FCStatus				--[Column 6]
	,AnnualFcstQty			--[Column 7]	
	,BaseUnitMeasure		--[Column 8]
	,ValidFrom				--[Column 9]
	,ValidTo				--[Column 10]
	,PackSizeRounding		--[Column 11]
	,ConsumptionTyp			--[Column 12]
	,FlexibleZone			--[Column 13]	
	,AutomaticDlvry			--[Column 14]
	,FcstParty02			--[Column 15]
	,ConsignFlag			--[Column 16]
	,LiabilityWeeks			--[Column 17]
	,Liability				--[Column 18]
	,Id						--[Column 19]
	,FcstOverwrite			--[Column 20]
	,MoveFcst				--[Column 21]	
	,FcastLoadDt			--[Column 22]
	,PeriodValidate			--[Column 23]
	,SafetySCS				--[Column 24]
	,TargetBufferQty		--[Column 25]
	,EnteredBy				--[Column 26]
	,CreatedOn				--[Column 27]
	,CreatedAt				--[Column 28]
	,ChangedBy				--[Column 29]
	,ChangeDtOrderMaster	--[Column 30]
	,ChangedAt2				--[Column 31]
	,CustPoNbr				--[Column 32]
	)
SELECT Distinct [Column 0]
      ,[Column 1]
      ,[Column 2]
      ,[Column 3]
      ,[Column 4]
      ,[Column 5]
      ,[Column 6]
      ,[Column 7]
      ,[Column 8]
      ,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 9],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) Is null then null else Stuff(Stuff(Replace(Replace([Column 9],'/',''),' ',''),5,0,'/'),8,0,'/') End
      ,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 10],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) Is null then null else Stuff(Stuff(Replace(Replace([Column 10],'/',''),' ',''),5,0,'/'),8,0,'/') End
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
      ,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 22],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) Is null then null else Stuff(Stuff(Replace(Replace([Column 22],'/',''),' ',''),5,0,'/'),8,0,'/') End
      ,[Column 23]
      ,[Column 24]
      ,[Column 25]
      ,[Column 26]
      ,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 27],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) Is null then null else Stuff(Stuff(Replace(Replace([Column 27],'/',''),' ',''),5,0,'/'),8,0,'/') End
      ,[Column 28]
      ,[Column 29]
      ,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 30],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) Is null then null else Stuff(Stuff(Replace(Replace([Column 30],'/',''),' ',''),5,0,'/'),8,0,'/') End
      ,[Column 31]
      ,[Column 32]
  FROM NonHaImportTesting.[dbo].[ImportZFCCUSTMAT]
  where [column 0] <> ''

Truncate Table ImportZfcCustMat