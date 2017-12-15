Use NonHaImportTesting
GO

TRUNCATE TABLE sap.dbo.Bkpf

INSERT INTO  sap.dbo.Bkpf
(
Client--0
,CoCd--1
,AcctDocNbr--2
,FY--3
,DocTyp--4
,DocDt--5
,DocPostingDt--6
,[Period]--7
,EnteredOnDt--8
,EnteredAtTime1--9
,ChangeDtOrderMaster--10
,LastUpDt--11
,TranslationDt--12
,UserNameUSNAM--13
,TransactionCode--14
,CrossCoCdPostTransNbr--15
,RefDocNbr--16
,RecEntryDocNbr--17
,ReversedWith--18
,FYReverseDoc--19
,DocHeaderTxt--20
,OrderCurr--21
,ExchangeRate--22
,GrpCurr--23
,GroupExchRate--24
,DocStat--25
,DocPostId--26
,UnplDlvryCosts--27
,BackPostingId--28
,BusTrans--29
,BatchInputSessName--30
,DocNameArchSys--31
,ExtractIdDocHeader--32
,InternalDocTyp--33
,RefTrans--34
,RefKey--35
,FinMgmtArea--36
,LocalCurr--37
,LocalCurr2Key--38
,LocalCurr3Key--39
,ExchangeRate2--40
,ExchangeRate3--41
,SourceCurr1--42
,SourceCurr2--43
,TransDt2Curr--44
,TransDt3Curr--45
,ReversalFlagId--46
,ReversalDt--47
,CalculateTax--48
,[2LocalCurrTyp]--49
,[3LocalCurrTyp]--50
,ExchRateTyp--51
,ExchRateTyp1--52
,NetEntry--53
,SourceCoCd--54
,TaxDetailId--55
,DataTransStatus--56
,LogicalSys--57
,RateForTaxe--58
,RequestNbr--59
,BExBfDueDtId--60
,ReversalReason--61
,ParkedBy--62
,BranchNbr--63
,NbrOfPages--64
,DiscountDocId--65
,RefKeyDocHead1--66
,RefKeyDocHead2--67
,ReversalId--68
,InvRecptDt--69
,Ledger--70
,LedgerGrp--71
,MgmtDt--72
,AltRefNbr--73
,TaxReportDt--74
,RequestCat--75
,Reason--76
,Region--77
,ReversalReasonIsPSrequests--78
,FileNbr--79
,IntFormula--80
,InterestCalcDt--81
,PostingDay--82
,Actual--83
,ChangedOn--84
,ChangedAt--85
,PmtTransTyp--86
,CardTyp--87
,CardNbr--88
,SamplingBlock--89
,LotNbrDoc--90
,UserNameSNAME--91
,SampledInvoice--92
,PpaExcludeId--93
,BudgetLedgerId--94
,OffsetStatus--95
,DtReferred--96
,ReasonDelay--97
,DocCondNbr--98
,SplPostingId--99
,CashFlowRelvDoc--100
,FollowOn--101
,Reorganized--102
,SubsetFico--103
,ExchRateTyp2--104
,MdExchangeRate--105
,MdExchRate2--106
,MdExchRate3--107
,DocFromMca--108
,FIDocClass--109
,ResubmissionDt--110
,F15Belegstatus--111


) 

SELECT 
[Column 0]
      ,[Column 1]
      ,[Column 2]
      ,[Column 3]
      ,[Column 4]
      ,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 5],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) IS Null then Null Else Try_Cast(STUFF(STUFF(Replace(Replace([Column 5],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) End
      ,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 6],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) IS Null then Null Else Try_Cast(STUFF(STUFF(Replace(Replace([Column 6],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) End
      ,[Column 7]
      ,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 8],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) IS Null then Null Else Try_Cast(STUFF(STUFF(Replace(Replace([Column 8],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) End
      ,[Column 9]=STUFF(STUFF([Column 9],3,0,':'),6,0,':')
      ,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 10],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) IS Null then Null Else Try_Cast(STUFF(STUFF(Replace(Replace([Column 10],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) End
      ,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 11],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) IS Null then Null Else Try_Cast(STUFF(STUFF(Replace(Replace([Column 11],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) End
      ,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 12],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) IS Null then Null Else Try_Cast(STUFF(STUFF(Replace(Replace([Column 12],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) End
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
      ,[Column 26]
      ,[Column 27]
      ,[Column 28]
      ,[Column 29]
      ,[Column 30]
      ,[Column 31]
      ,[Column 32]
      ,[Column 33]
      ,[Column 34]
      ,[Column 35]
      ,[Column 36]
      ,[Column 37]
      ,[Column 38]
      ,[Column 39]
      ,[Column 40]
      ,[Column 41]
      ,[Column 42]
      ,[Column 43]
      ,[Column 44]
      ,[Column 45]
      ,[Column 46]
      ,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 47],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) IS Null then Null Else Try_Cast(STUFF(STUFF(Replace(Replace([Column 47],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) End
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
      ,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 69],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) IS Null then Null Else Try_Cast(STUFF(STUFF(Replace(Replace([Column 69],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) End
      ,[Column 70]
      ,[Column 71]
      ,[Column 72]
      ,[Column 73]
      ,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 74],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) IS Null then Null Else Try_Cast(STUFF(STUFF(Replace(Replace([Column 74],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) End
      ,[Column 75]
      ,[Column 76]
      ,[Column 77]
      ,[Column 78]
      ,[Column 79]
      ,[Column 80]
      ,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 81],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) IS Null then Null Else Try_Cast(STUFF(STUFF(Replace(Replace([Column 81],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) End
      ,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 82],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) IS Null then Null Else Try_Cast(STUFF(STUFF(Replace(Replace([Column 82],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) End
      ,[Column 83]
      ,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 84],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) IS Null then Null Else Try_Cast(STUFF(STUFF(Replace(Replace([Column 84],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) End
      ,[Column 85]=STUFF(STUFF([Column 85],3,0,':'),6,0,':')
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
      ,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 96],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) IS Null then Null Else Try_Cast(STUFF(STUFF(Replace(Replace([Column 96],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) End
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
      ,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 110],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime) IS Null then Null Else Try_Cast(STUFF(STUFF(Replace(Replace([Column 110],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) End
      ,[Column 111]


FROM NonHaImportTesting.dbo.ImportBkpf 
WHERE [Column 0] Is Not Null And [Column 0] <>' ' And [Column 22] < 'A' And [Column 24] < 'A' And [Column 27] < 'A'
GO


