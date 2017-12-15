
TRUNCATE TABLE Sap.dbo.EBEW
GO

INSERT INTO sap.dbo.EBEW
	([Client]
      ,[Material]
      ,[ValArea]
      ,[ValTyp]
      ,[SpecialStk]
      ,[SalesDocNbr]
      ,[SalesDocItmNbr]
      ,[TtlValStk]
      ,[ValTtlValStk]
      ,[PriceControl]
      ,[Map]
      ,[StandardPrice]
      ,[PriceUnitItm]
      ,[ValClass]
      ,[ValMap]
      ,[TtlStkValPP]
      ,[TtlValPP]
      ,[PriceCtrlPP]
      ,[MapPP]
      ,[StdPricePP]
      ,[PriceUnitItmPP]
      ,[ValClassPP]
      ,[MapValPP]
      ,[TtlStkPrevYr]
      ,[TtlValPrevYr]
      ,[PriceCtrlPrevYr]
      ,[MapPrevYr]
      ,[StdPricePrevYr]
      ,[PriceUnItmPrevYr]
      ,[ValClassPrevYr]
      ,[ValPrevYear]
      ,[YearCurrPeriod]
      ,[CurrPeriod]
      ,[ValCat]
      ,[PrevPrice]
      ,[LastPriceChange]
      ,[FutPrice]
      ,[ValidFrom]
      ,[TimeStamp]
      ,[FutPlandPrice]
      ,[FutCostEst]
      ,[CurrCostEst]
      ,[PrevCostEst]
      ,[ProdCostEstNbr]
      ,[ValVarCostEstFut]
      ,[ValVarCostEstStandard]
      ,[ValVarCostEstPrev]
      ,[CostingVersionFut]
      ,[CostingVersionCurr]
      ,[CostingVersionPrev]
      ,[OriginGrp]
      ,[OverheadGrp]
      ,[PostingPeriod]
      ,[CurrPeriodStandCostEst]
      ,[PrevPeriod]
      ,[FutFY]
      ,[CurrFY]
      ,[PrevFY]
      ,[CostEstWQs]
      ,[PrevPlndPrice]
      ,[MatLedgerActive]
      ,[PriceDetermine]
      ,[CurrPlanPrice]
      ,[TtlSpVal]
      ,[MatOrigin]
      ,[ValMargin]
      ,[FxdCurrPlanPrice]
      ,[PrevPlndPriceFixed]
      ,[FixedPortionFuturePlanPrice]
      ,[CurrValStgy]
      ,[PrevValStrat]
      ,[FutValStrat]
      ,[MbewRecAlreadyExists]
      ,[VcVendor])

SELECT 
	   [Column 0]
      ,[Column 1]
      ,[Column 2]
      ,[Column 3]
      ,[Column 4]
      ,[Column 5]
      ,[Column 6]
      ,[Column 7]
      ,[Column 8]
      ,[Column 9]
      ,[Column 10]
      ,[Column 11]
      ,Replace([Column 12], '.', '')
      ,[Column 13]
      ,[Column 14]
      ,[Column 15]
      ,[Column 16]
      ,[Column 17]
      ,[Column 18]
      ,[Column 19]
      ,Replace([Column 20], '.', '')
      ,[Column 21]
      ,[Column 22]
      ,[Column 23]
      ,[Column 24]
      ,[Column 25]
      ,[Column 26]
      ,[Column 27]
      ,Replace([Column 28], '.', '')
      ,[Column 29]
      ,[Column 30]
      ,[Column 31]
      ,[Column 32]
      ,[Column 33]
      ,[Column 34]
      ,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 35],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) IS Null then Null Else Try_Cast(STUFF(STUFF(Replace(Replace([Column 35],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) End
      ,[Column 36]
      ,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 37],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) IS Null then Null Else Try_Cast(STUFF(STUFF(Replace(Replace([Column 37],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) End
      ,STUFF(STUFF(STUFF(Replace([Column 38], '.', ''),13,0,':'),11,0,':'),9,0,' ')
      ,[Column 39]
      ,[Column 40]
      ,[Column 41]
      ,[Column 42]
      ,[Column 43]
      ,[Column 44]
      ,[Column 45]
      ,[Column 46]
      ,[Column 47]
      ,[Column 48]
      ,[Column 49]
      ,[Column 50]
      ,[Column 51]
      ,[Column 52]
      ,[Column 53]
      ,[Column 54]
      ,[Column 55]
      ,[Column 56]
      ,[Column 57]
      ,[Column 58]
      ,[Column 59]
      ,[Column 60]
      ,[Column 61]
      ,[Column 62]
      ,[Column 63]
      ,[Column 64]
      ,[Column 65]
      ,[Column 66]
      ,[Column 67]
      ,[Column 68]
      ,[Column 69]
      ,[Column 70]
      ,[Column 71]
      ,[Column 72]
      ,[Column 73]
FROM nonhaimporttesting.dbo.ImportEBEW
Where [Column 0] Is Not Null
AND [Column 0] <> ''
AND (IsNumeric([Column 2])=1 Or [Column 2] IS Null OR  [Column 2] = '')
AND (IsNumeric([Column 5])=1 Or [Column 5] IS Null OR  [Column 5] = '')
AND (IsNumeric([Column 6])=1 Or [Column 6] IS Null OR  [Column 6] = '')
AND (IsNumeric([Column 7])=1 Or [Column 7] IS Null OR  [Column 7] = '')
AND (IsNumeric([Column 8])=1 Or [Column 8] IS Null OR  [Column 8] = '')
AND (IsNumeric([Column 10])=1 Or [Column 10] IS Null OR  [Column 10] = '')
AND (IsNumeric([Column 11])=1 Or [Column 11] IS Null OR  [Column 11] = '')
AND (IsNumeric([Column 12])=1 Or [Column 12] IS Null OR  [Column 12] = '')
AND (IsNumeric([Column 13])=1 Or [Column 13] IS Null OR  [Column 13] = '')
AND (IsNumeric([Column 14])=1 Or [Column 14] IS Null OR  [Column 14] = '')
AND (IsNumeric([Column 15])=1 Or [Column 15] IS Null OR  [Column 15] = '')
AND (IsNumeric([Column 16])=1 Or [Column 16] IS Null OR  [Column 16] = '')
AND (IsNumeric([Column 18])=1 Or [Column 18] IS Null OR  [Column 18] = '')
AND (IsNumeric([Column 19])=1 Or [Column 19] IS Null OR  [Column 19] = '')
AND (IsNumeric([Column 20])=1 Or [Column 20] IS Null OR  [Column 20] = '')
AND (IsNumeric([Column 22])=1 Or [Column 22] IS Null OR  [Column 22] = '')
AND (IsNumeric([Column 23])=1 Or [Column 23] IS Null OR  [Column 23] = '')
AND (IsNumeric([Column 24])=1 Or [Column 24] IS Null OR  [Column 24] = '')
AND (IsNumeric([Column 26])=1 Or [Column 26] IS Null OR  [Column 26] = '')
AND (IsNumeric([Column 27])=1 Or [Column 27] IS Null OR  [Column 27] = '')
AND (IsNumeric([Column 28])=1 Or [Column 28] IS Null OR  [Column 28] = '')
AND (IsNumeric([Column 30])=1 Or [Column 30] IS Null OR  [Column 30] = '')
AND (IsNumeric([Column 31])=1 Or [Column 31] IS Null OR  [Column 31] = '')
AND (IsNumeric([Column 32])=1 Or [Column 32] IS Null OR  [Column 32] = '')
AND (IsNumeric([Column 34])=1 Or [Column 34] IS Null OR  [Column 34] = '')
AND (IsNumeric([Column 36])=1 Or [Column 36] IS Null OR  [Column 36] = '')
AND (IsNumeric([Column 39])=1 Or [Column 39] IS Null OR  [Column 39] = '')
AND LEN([Column 0]) < 6
AND LEN([Column 3]) < 13
AND LEN([Column 4]) < 4
AND LEN([Column 9]) < 4
AND LEN([Column 17]) < 4
AND LEN([Column 21]) < 7
AND LEN([Column 25]) < 4
AND LEN([Column 29]) < 7
AND LEN([Column 33]) < 4
AND LEN([Column 38]) < 22
AND LEN([Column 40]) < 4
AND LEN([Column 41]) < 4
AND LEN([Column 42]) < 4
AND LEN([Column 44]) < 6
AND LEN([Column 45]) < 6
AND LEN([Column 46]) < 6
AND LEN([Column 50]) < 7
AND LEN([Column 51]) < 13
AND LEN([Column 58]) < 4
AND LEN([Column 60]) < 4
AND LEN([Column 61]) < 4
AND LEN([Column 64]) < 4
AND LEN([Column 69]) < 4
AND LEN([Column 70]) < 4
AND LEN([Column 71]) < 2
AND LEN([Column 72]) < 2
AND LEN([Column 73]) < 2

--TRUNCATE TABLE  NonHaImportTesting.dbo.ImportEBEW
