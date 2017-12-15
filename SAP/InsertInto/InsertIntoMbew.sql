TRUNCATE TABLE Sap.dbo.MBEW

INSERT INTO Sap.dbo.Mbew 
(Client
,Material
,ValArea
,ValTyp
,ValTypDelFlag
,TtlValStk
,ValTtlValStk
,PriceControl
,Map
,StandardPrice
,PriceUnitItm
,ValClass
,ValMap
,TtlStkValPP
,TtlValPP
,PriceCtrlPP
,MapPP
,StdPricePP
,PriceUnitItmPP
,ValClassPP
,MapValPP
,TtlStkPrevYr
,TtlValPrevYr
,PriceCtrlPrevYr
,MapPrevYr
,StdPricePrevYr
,PriceUnItmPrevYr
,ValClassPrevYr
,ValPrevYr
,FYCurrPeriod
,CurrPeriod
,ValCat
,PrevPrice
,LastPriceChange
,FutPrice
,ValidFrom
,[TimeStamp]
,TaxPrice1
,ComPrice1
,TaxLawPrice3
,ComLawPrice3
,TtlValStkYrBefLast
,TtlStkYrBefLast
,TtlStkPbl
,StkValuePeriodBefLast
,FutPlndPrice1
,FutPlndPrice2
,FutPlndPrice3
,FutPlndPrice4
,PlndPriceDt1
,PlndPriceDt2
,PlndPriceDt3
,FutStandCostEstPeriod
,CurrStandCostEstPeriod
,PrevStandCostEstPeriod
,FutStandCostEstPeriodId
,CurrentCostEst
,PrevCostEstId
,OverheadKey
,LifoFifoRel
,LifoPool
,CommPrice2
,TaxPrice2
,DevaluationId
,MaintStatus
,ProdCostEstNbr
,CostEstNbr
,ValVarCostEstFut
,ValVarCostEstStand
,ValVarCostEstPrev
,CostingVersionFuture
,CostingVersionCurrent
,CostingVersionPrev
,OriginGrp
,OverheadGrp
,PostPeriodStandCostEst
,CurrPeriodStandCostEst
,PrevPeriodStandCostEst
,FutFYStandCostEst
,CurrFYStandCostEst
,PrevFYStandCostEst
,CostEstWQs
,PrevPlndPrice
,MatLedgerActive
,PriceDetermine
,CurrPlanPrice
,TtlSpVal
,MatRelOrigin
,PhysInvBlk
,PhsyInvValOnlyMat
,LastCountDt
,CycleCountPhysInvId1
,ValMargin
,FxdCurrPlanPrice
,PrevPlndPriceFixed
,FixedPortionFuturePlanPrice
,CurrValStgy
,PrevValStgy
,FutureValStgy
,ValClassSalesOrderStk
,ProjectStkVal
,MatUsage
,MatOrigin
,ProdInHouse
,ValuationUnit
,PriceUnitValPriceTaxComLaw
,MbewhRecAlreadyExists
,VcVendor
,PrepaidInv
)
SELECT [Column 0]
, [Column 1]
, [Column 2]
, [Column 3]
, [Column 4]
, [Column 5]
, [Column 6]
, [Column 7]
, [Column 8]
, [Column 9]
, Replace([Column 10],'.','')
, [Column 11]
, [Column 12]
, [Column 13]
, [Column 14]
, [Column 15]
, [Column 16]
, [Column 17]
, Replace([Column 18],'.','')
, [Column 19]
, [Column 20]
, [Column 21]
, [Column 22]
, [Column 23]
, [Column 24]
, [Column 25]
, Replace([Column 26],'.','')
, [Column 27]
, [Column 28]
, [Column 29]
, [Column 30]
, [Column 31]
, [Column 32]
, [Column 33]
, [Column 34]
, [Column 35]
, STUFF(STUFF(STUFF(STUFF(STUFF(Replace([Column 36], '.', ''),13,0,':'),11,0,':'),9,0,' '),7,0,'/'),5,0,'/')
, [Column 37]
, [Column 38]
, [Column 39]
, [Column 40]
, [Column 41]
, [Column 42]
, [Column 43]
, [Column 44]
, [Column 45]
, [Column 46]
, [Column 47]
, [Column 48]
, [Column 49]
, [Column 50]
, [Column 51]
, [Column 52]
, [Column 53]
, [Column 54]
, [Column 55]
, [Column 56]
, [Column 57]
, [Column 58]
, [Column 59]
, [Column 60]
, [Column 61]
, [Column 62]
, [Column 63]
, [Column 64]
, [Column 65]
, [Column 66]
, [Column 67]
, [Column 68]
, [Column 69]
, [Column 70]
, [Column 71]
, [Column 72]
, [Column 73]
, [Column 74]
, [Column 75]
, [Column 76]
, [Column 77]
, [Column 78]
, [Column 79]
, [Column 80]
, [Column 81]
, [Column 82]
, [Column 83]
, [Column 84]
, [Column 85]
, [Column 86]
, [Column 87]
, [Column 88]
, [Column 89]
, [Column 90]
, [Column 91]
, [Column 92]
, [Column 93]
, [Column 94]
, [Column 95]
, [Column 96]
, [Column 97]
, [Column 98]
, [Column 99]
, [Column 100]
, [Column 101]
, [Column 102]
, [Column 103]
, [Column 104]
, Replace([Column 105],'.','')
, [Column 106]
, [Column 107]
, [Column 108]
FROM NonHaImportTesting.dbo.ImportMBEW
WHERE [Column 0] Is Not Null AND [Column 0]<>''
AND (IsNumeric([Column 5])=1 Or [Column 5] IS Null OR  [Column 5] = '')
AND (IsNumeric([Column 6])=1 Or [Column 6] IS Null OR  [Column 6] = '')
AND (IsNumeric([Column 8])=1 Or [Column 8] IS Null OR  [Column 8] = '')
AND (IsNumeric([Column 9])=1 Or [Column 9] IS Null OR  [Column 9] = '')
AND (IsNumeric([Column 10])=1 Or [Column 10] IS Null OR  [Column 10] = '')
AND (IsNumeric([Column 12])=1 Or [Column 12] IS Null OR  [Column 12] = '')
AND (IsNumeric([Column 13])=1 Or [Column 13] IS Null OR  [Column 13] = '')
AND (IsNumeric([Column 14])=1 Or [Column 14] IS Null OR  [Column 14] = '')
AND (IsNumeric([Column 16])=1 Or [Column 16] IS Null OR  [Column 16] = '')
AND (IsNumeric([Column 17])=1 Or [Column 17] IS Null OR  [Column 17] = '')
AND (IsNumeric([Column 18])=1 Or [Column 18] IS Null OR  [Column 18] = '')
AND (IsNumeric([Column 20])=1 Or [Column 20] IS Null OR  [Column 20] = '')
AND (IsNumeric([Column 21])=1 Or [Column 21] IS Null OR  [Column 21] = '')
AND (IsNumeric([Column 22])=1 Or [Column 22] IS Null OR  [Column 22] = '')
AND (IsNumeric([Column 24])=1 Or [Column 24] IS Null OR  [Column 24] = '')
AND (IsNumeric([Column 25])=1 Or [Column 25] IS Null OR  [Column 25] = '')
AND (IsNumeric([Column 26])=1 Or [Column 26] IS Null OR  [Column 26] = '')
AND (IsNumeric([Column 28])=1 Or [Column 28] IS Null OR  [Column 28] = '')
AND (IsNumeric([Column 29])=1 Or [Column 29] IS Null OR  [Column 29] = '')
AND (IsNumeric([Column 30])=1 Or [Column 30] IS Null OR  [Column 30] = '')
AND (IsNumeric([Column 32])=1 Or [Column 32] IS Null OR  [Column 32] = '')
AND (IsNumeric([Column 34])=1 Or [Column 34] IS Null OR  [Column 34] = '')
AND (IsNumeric([Column 37])=1 Or [Column 37] IS Null OR  [Column 37] = '')
AND (IsNumeric([Column 38])=1 Or [Column 38] IS Null OR  [Column 38] = '')
AND (IsNumeric([Column 39])=1 Or [Column 39] IS Null OR  [Column 39] = '')
AND (IsNumeric([Column 40])=1 Or [Column 40] IS Null OR  [Column 40] = '')
AND (IsNumeric([Column 41])=1 Or [Column 41] IS Null OR  [Column 41] = '')
AND (IsNumeric([Column 42])=1 Or [Column 42] IS Null OR  [Column 42] = '')
AND (IsNumeric([Column 43])=1 Or [Column 43] IS Null OR  [Column 43] = '')
AND (IsNumeric([Column 44])=1 Or [Column 44] IS Null OR  [Column 44] = '')
AND (IsNumeric([Column 45])=1 Or [Column 45] IS Null OR  [Column 45] = '')
AND (IsNumeric([Column 46])=1 Or [Column 46] IS Null OR  [Column 46] = '')
AND (IsNumeric([Column 47])=1 Or [Column 47] IS Null OR  [Column 47] = '')
AND (IsNumeric([Column 48])=1 Or [Column 48] IS Null OR  [Column 48] = '')
AND (IsNumeric([Column 61])=1 Or [Column 61] IS Null OR  [Column 61] = '')
AND (IsNumeric([Column 62])=1 Or [Column 62] IS Null OR  [Column 62] = '')
AND (IsNumeric([Column 63])=1 Or [Column 63] IS Null OR  [Column 63] = '')
AND (IsNumeric([Column 65])=1 Or [Column 65] IS Null OR  [Column 65] = '')
AND (IsNumeric([Column 66])=1 Or [Column 66] IS Null OR  [Column 66] = '')
AND (IsNumeric([Column 70])=1 Or [Column 70] IS Null OR  [Column 70] = '')
AND (IsNumeric([Column 71])=1 Or [Column 71] IS Null OR  [Column 71] = '')
AND (IsNumeric([Column 72])=1 Or [Column 72] IS Null OR  [Column 72] = '')
AND (IsNumeric([Column 75])=1 Or [Column 75] IS Null OR  [Column 75] = '')
AND (IsNumeric([Column 76])=1 Or [Column 76] IS Null OR  [Column 76] = '')
AND (IsNumeric([Column 77])=1 Or [Column 77] IS Null OR  [Column 77] = '')
AND (IsNumeric([Column 78])=1 Or [Column 78] IS Null OR  [Column 78] = '')
AND (IsNumeric([Column 79])=1 Or [Column 79] IS Null OR  [Column 79] = '')
AND (IsNumeric([Column 80])=1 Or [Column 80] IS Null OR  [Column 80] = '')
AND (IsNumeric([Column 82])=1 Or [Column 82] IS Null OR  [Column 82] = '')
AND (IsNumeric([Column 85])=1 Or [Column 85] IS Null OR  [Column 85] = '')
AND (IsNumeric([Column 86])=1 Or [Column 86] IS Null OR  [Column 86] = '')
AND (IsNumeric([Column 92])=1 Or [Column 92] IS Null OR  [Column 92] = '')
AND (IsNumeric([Column 93])=1 Or [Column 93] IS Null OR  [Column 93] = '')
AND (IsNumeric([Column 94])=1 Or [Column 94] IS Null OR  [Column 94] = '')
AND (IsNumeric([Column 95])=1 Or [Column 95] IS Null OR  [Column 95] = '')
AND (IsNumeric([Column 105])=1 Or [Column 105] IS Null OR  [Column 105] = '')
AND LEN([Column 0]) < 6
AND LEN([Column 2]) < 7
AND LEN([Column 3]) < 13
AND LEN([Column 4]) < 4
AND LEN([Column 7]) < 4
AND LEN([Column 11]) < 7
AND LEN([Column 15]) < 4
AND LEN([Column 19]) < 7
AND LEN([Column 23]) < 4
AND LEN([Column 27]) < 7
AND LEN([Column 31]) < 4
AND LEN([Column 33]) < 11
AND LEN([Column 35]) < 11
AND LEN([Column 36]) < 22
AND LEN([Column 49]) < 11
AND LEN([Column 50]) < 11
AND LEN([Column 51]) < 11
AND LEN([Column 52]) < 9
AND LEN([Column 53]) < 9
AND LEN([Column 54]) < 9
AND LEN([Column 55]) < 4
AND LEN([Column 56]) < 4
AND LEN([Column 57]) < 4
AND LEN([Column 58]) < 9
AND LEN([Column 59]) < 4
AND LEN([Column 60]) < 7
AND LEN([Column 64]) < 18
AND LEN([Column 67]) < 6
AND LEN([Column 68]) < 6
AND LEN([Column 69]) < 6
AND LEN([Column 73]) < 7
AND LEN([Column 74]) < 13
AND LEN([Column 81]) < 4
AND LEN([Column 83]) < 4
AND LEN([Column 84]) < 4
AND LEN([Column 87]) < 4
AND LEN([Column 88]) < 4
AND LEN([Column 89]) < 6
AND LEN([Column 90]) < 11
AND LEN([Column 91]) < 4
AND LEN([Column 96]) < 4
AND LEN([Column 97]) < 4
AND LEN([Column 98]) < 4
AND LEN([Column 99]) < 7
AND LEN([Column 100]) < 7
AND LEN([Column 101]) < 4
AND LEN([Column 102]) < 4
AND LEN([Column 103]) < 4
AND LEN([Column 104]) < 4
AND LEN([Column 106]) < 4
AND LEN([Column 107]) < 7
AND LEN([Column 108]) < 4

TRUNCATE TABLE NonHaImportTesting.dbo.ImportMBEW 
