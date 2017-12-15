Use NonHaImportTesting
Go

Truncate Table sap.dbo.Bsik


Insert Into Sap.dbo.Bsik
(
[Client]
      ,[CoCd]
      ,[Vendor]
      ,[SpecialGLTransTyp]
      ,[SpecialGLId]
      ,[ClrngDt]
      ,[ClrngDoc]
      ,[AssignNbr]
      ,[FY]
      ,[AcctDocNbr]
      ,[AcctDocItmNbr]
      ,[DocPostingDt]
      ,[DocDt]
      ,[EnteredOnDt]
      ,[OrderCurr]
      ,[RefDocNbr]
      ,[DocTyp]
      ,[Period]
      ,[PostingKey]
      ,[TrgSpGLId]
      ,[Returns]
      ,[BusArea]
      ,[TaxCd]
      ,[AmtLocalCurr]
      ,[AmtDocCurr]
      ,[LcTax]
      ,[TaxAmount]
      ,[ValDiff1]
      ,[ValDiff2]
      ,[Text]
      ,[NbrNotUse]
      ,[OrderNbr]
      ,[Asset]
      ,[AssetSubNbr]
      ,[PurchDocNbr]
      ,[PurchDocItmNbr]
      ,[GLAcct]
      ,[GeneralLedgeAmt]
      ,[FinBudgetItm]
      ,[AcctNbrBranch]
      ,[BaselineDt]
      ,[PaytTerms]
      ,[DiscDays1]
      ,[DiscDays2]
      ,[PmtPeriod]
      ,[DiscPct1]
      ,[DiscPct2]
      ,[DiscBase]
      ,[DiscountAmtLocal]
      ,[DiscountAmtDoc]
      ,[PymtMethod]
      ,[PmntBlock]
      ,[FixedPmtTerms]
      ,[HouseBank]
      ,[PartBankTyp]
      ,[InvoiceRef]
      ,[InvoiceFY]
      ,[InvoiceLineItm]
      ,[CustTariffNbr]
      ,[CustomsDt]
      ,[ScbId]
      ,[SupCntry]
      ,[SvcId]
      ,[DunnBlock]
      ,[DunningKey]
      ,[LastDunned]
      ,[DunningLvl]
      ,[DunningArea]
      ,[DocPostId]
      ,[DownPaymentId]
      ,[AddressDataId]
      ,[IsrDataId]
      ,[PymtTranId]
      ,[DistTaxCd1]
      ,[AmtLocalCurrTaxDist1]
      ,[TaxBreakdownAmt1]
      ,[DistTaxCd2]
      ,[AmtLocalCurrTaxDist2]
      ,[TaxBreakdownAmt2]
      ,[DistTaxCd3]
      ,[AmtLocalCurrTaxDist3]
      ,[TaxBreakdownAmt3]
      ,[WTaxCd2]
      ,[WTaxBase]
      ,[WithholdingTax]
      ,[DocStat]
      ,[DocNbrBillExchPmt]
      ,[FYOfTheBillExch]
      ,[BillofExchPmtReqCoCd]
      ,[TradingPartnerId]
      ,[FollowOnDocTyp]
      ,[VatRegNbr]
      ,[DestCountry]
      ,[SupplyingCntry]
      ,[ExemptNbr]
      ,[WTaxExempt]
      ,[InvestId]
      ,[WbsElement]
      ,[CommitmentItm]
      ,[Network]
      ,[OperOrderRoutingNbr]
      ,[InternalCounter]
      ,[EuTriangDealId]
      ,[Amt2LocalCurr]
      ,[Amt3LocalCurr]
      ,[Amt2LocalCurrTaxBreakdown1]
      ,[Amt2LocalCurrTaxBreakdown2]
      ,[Amt2LocalCurrTaxBreakdown3]
      ,[Amt3LocalCurrTaxBreakdown1]
      ,[Amt3LocalCurrTaxBreakdown2]
      ,[Amt3LocalCurrTaxBreakdown3]
      ,[Lc2Tax]
      ,[Lc3Tax]
      ,[Lc2DscAmt]
      ,[Lc3DscAmt]
      ,[ValDiff3]
      ,[ClearingReversedId]
      ,[ReasonCd]
      ,[PmtMethSupl]
      ,[CostCenter]
      ,[SequenceNbr]
      ,[ReversalFlagId]
      ,[OrigReduction]
      ,[BizPartnerRefKey1]
      ,[BizPartnerRefKey2]
      ,[DocArchiveId]
      ,[GLCurrency]
      ,[GLAmount]
      ,[RealEstateKey]
      ,[SeqNbrAccAss]
      ,[FundsCenter]
      ,[Fund]
      ,[ReferenceDtSettle2]
      ,[NegativePstngId]
      ,[Payer]
      ,[ProfitCenter]
      ,[RefKeyLineItm]
      ,[InstructKey1]
      ,[InstructKey2]
      ,[InstructKey3]
      ,[InstructKey4]
      ,[PmtSentBlockId]
      ,[PmtRef]
      ,[AutoPymtCur]
      ,[PmntAmnt]
      ,[BusPlace]
      ,[SectionCd]
      ,[DiffRealized1]
      ,[DiffRealized2]
      ,[DiffRealized3]
      ,[PenChargeLc1]
      ,[PenChargeLc2]
      ,[PenChargeLc3]
      ,[PenChargeDocCurr]
      ,[DaysInArrears]
      ,[ReasonDelay]
      ,[ContractTyp]
      ,[ContractNbr]
      ,[FlowTyp]
      ,[EarmarkedFundsDocNbr]
      ,[EarmarkedFundsDocItm]
      ,[Grant]
      ,[ItmExecution]
      ,[AddItmReceivab]
      ,[RequestNbr]
      ,[InterestBlock]
      ,[FunctionalArea]
      ,[RealEstateMasterDataCd]
      ,[PartnerPc]
      ,[LineItmId]
      ,[ClrgFiscalYr]
      ,[AcctId]
      ,[AcctAssignCat]
      ,[AcctAssign]
      ,[TransferDateLegalDunn]
      ,[JointVenture]
      ,[EquityGrp]
      ,[PayrollTyp]
      ,[MgmtDt]
      ,[CollectInv]
      ,[BudgetPeriod]
)
Select 
[Column 0]
      ,[Column 1]
      ,[Column 2]
      ,[Column 3]
      ,[Column 4]
      ,Case When Try_Cast(STUFF(STUFF([Column 5],5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN Null 
Else STUFF(STUFF([Column 5],5,0,'/'),8,0,'/') End
      ,[Column 6]
      ,Try_cast([Column 7] as bigint)
      ,[Column 8]
      ,Try_cast([Column 9] as bigint)
      ,[Column 10]
      ,Case When Try_Cast(STUFF(STUFF([Column 11],5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN Null 
Else STUFF(STUFF([Column 11],5,0,'/'),8,0,'/') End
      ,Case When Try_Cast(STUFF(STUFF([Column 12],5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN Null 
Else STUFF(STUFF([Column 12],5,0,'/'),8,0,'/') End
      ,Case When Try_Cast(STUFF(STUFF([Column 13],5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN Null 
Else STUFF(STUFF([Column 13],5,0,'/'),8,0,'/') End
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
      ,[Column 26]
      ,[Column 27]
      ,[Column 28]
      ,[Column 29]
      ,[Column 30]
      ,Try_cast([Column 31] as bigint)
      ,[Column 32]
      ,[Column 33]
      ,Try_cast([Column 34] as bigint)
      ,[Column 35]
      ,[Column 36]
      ,[Column 37]
      ,[Column 38]
      ,[Column 39]
      ,Case When Try_Cast(STUFF(STUFF([Column 40],5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN Null 
Else STUFF(STUFF([Column 40],5,0,'/'),8,0,'/') End
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
      ,Case When Try_Cast(STUFF(STUFF([Column 59],5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN Null 
Else STUFF(STUFF([Column 59],5,0,'/'),8,0,'/') End
      ,[Column 60]
      ,[Column 61]
      ,[Column 62]
      ,[Column 63]
      ,[Column 64]
      ,Case When Try_Cast(STUFF(STUFF([Column 65],5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN Null 
Else STUFF(STUFF([Column 65],5,0,'/'),8,0,'/') End
      ,[Column 66]
      ,[Column 67]
      ,[Column 68]
      ,[Column 69]
      ,[Column 70]
      ,[Column 71]
      ,[Column 72]
      ,[Column 73]
      ,[Column 74]
      ,[Column 75]
      ,[Column 76]
      ,[Column 77]
      ,[Column 78]
      ,[Column 79]
      ,[Column 80]
      ,[Column 81]
      ,[Column 82]
      ,[Column 83]
      ,[Column 84]
      ,[Column 85]
      ,[Column 86]
      ,[Column 87]
      ,[Column 88]
      ,[Column 89]
      ,[Column 90]
      ,[Column 91]
      ,[Column 92]
      ,[Column 93]
      ,[Column 94]
      ,[Column 95]
      ,[Column 96]
      ,[Column 97]
      ,[Column 98]
      ,[Column 99]
      ,[Column 100]
      ,[Column 101]
      ,[Column 102]
      ,[Column 103]
      ,[Column 104]
      ,[Column 105]
      ,[Column 106]
      ,[Column 107]
      ,[Column 108]
      ,[Column 109]
      ,[Column 110]
      ,[Column 111]
      ,[Column 112]
      ,[Column 113]
      ,[Column 114]
      ,[Column 115]
      ,[Column 116]
      ,[Column 117]
      ,[Column 118]
      ,[Column 119]
      ,[Column 120]
      ,[Column 121]
      ,[Column 122]
      ,[Column 123]
      ,[Column 124]
      ,[Column 125]
      ,[Column 126]
      ,[Column 127]
      ,[Column 128]
      ,[Column 129]
      ,[Column 130]
      ,[Column 131]
      ,Case When Try_Cast(STUFF(STUFF([Column 132],5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN Null 
Else STUFF(STUFF([Column 132],5,0,'/'),8,0,'/') End
      ,[Column 133]
      ,[Column 134]
      ,[Column 135]
      ,[Column 136]
      ,[Column 137]
      ,[Column 138]
      ,[Column 139]
      ,[Column 140]
      ,[Column 141]
      ,[Column 142]
      ,[Column 143]
      ,[Column 144]
      ,[Column 145]
      ,[Column 146]
      ,[Column 147]
      ,[Column 148]
      ,[Column 149]
      ,[Column 150]
      ,[Column 151]
      ,[Column 152]
      ,[Column 153]
      ,[Column 154]
      ,[Column 155]
      ,[Column 156]
      ,[Column 157]
      ,[Column 158]
      ,[Column 159]
      ,[Column 160]
      ,[Column 161]
      ,[Column 162]
      ,[Column 163]
      ,[Column 164]
      ,[Column 165]
      ,[Column 166]
      ,[Column 167]
      ,[Column 168]
      ,[Column 169]
      ,[Column 170]
      ,[Column 171]
      ,[Column 172]
      ,[Column 173]
      ,Case When Try_Cast(STUFF(STUFF([Column 174],5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN Null 
Else STUFF(STUFF([Column 174],5,0,'/'),8,0,'/') End
      ,[Column 175]
      ,[Column 176]
      ,[Column 177]
      ,[Column 178]
      ,[Column 179]
      ,[Column 180]
From NonHaImportTesting.dbo.ImportBsik 
Where [Column 0] <>  ' ' AND [Column 0] Is Not Null


--Truncate Table NonHaImportTesting.dbo.ImportBsik 

