USE NonHaImportTesting
GO

TRUNCATE TABLE SAP.dbo.Aufk

Insert Into SAP.dbo.Aufk
(
	[Client]
      ,[OrderNbr]
      ,[OrderTyp]
      ,[OrderCat]
      ,[Order]
      ,[EnteredBy]
      ,[CreatedOn]
      ,[ChangedBy]
      ,[ChangeDtOrderMaster]
      ,[Description]
      ,[LongTxtExists]
      ,[CoCd]
      ,[Plant]
      ,[BusArea]
      ,[CoArea]
      ,[CostCollectorKey]
      ,[RespCostCntr]
      ,[Location]
      ,[LocationPlant]
      ,[StatisticalOrderId]
      ,[OrderCurrency]
      ,[OrderStatus]
      ,[StatusChange]
      ,[ReachedStatus]
      ,[Created]
      ,[Released]
      ,[Completed]
      ,[Closed]
      ,[PlannedRelease]
      ,[Plannedcompltn]
      ,[PlannedCloDat]
      ,[ReleaseDt]
      ,[TechCompletionDt]
      ,[CloseDt]
      ,[ObjectId]
      ,[DisTranGrp]
      ,[PurOrgData]
      ,[PlanLineItmems]
      ,[Usage]
      ,[Application]
      ,[CostingSheet]
      ,[OverheadKey1]
      ,[ProcessGrp]
      ,[SettlementElement]
      ,[CostCenter]
      ,[GLAcct]
      ,[AllocationSet]
      ,[CostCtrTruePost]
      ,[ValidFrom]
      ,[SequenceNbr]
      ,[Applicant]
      ,[ApplicantPhone]
      ,[PersonResp]
      ,[PhonePersCharge]
      ,[EstimatedCosts]
      ,[ApplicDt]
      ,[Department]
      ,[WorkStart]
      ,[EndOfWork]
      ,[WorkPermitItm]
      ,[ObjNbrItm]
      ,[ProfItmCenter]
      ,[WbsElement]
      ,[VarianceKey]
      ,[ResultAnalysisKey2]
      ,[TaxJur1]
      ,[FunctionalArea]
      ,[ObjectClass]
      ,[IntegPlanning]
      ,[SalesOrderNbr]
      ,[SalesOrderItm]
      ,[ExtOrderNbr]
      ,[InvestMeasureProf]
      ,[LogicalSystem]
      ,[OrderMultiItm]
      ,[RequestingCoCd]
      ,[RequestCostCenter]
      ,[Scale]
      ,[InvestReason]
      ,[EnvirInvest]
      ,[CostCollector]
      ,[InterestProf]
      ,[PROCNRCostCollector]
      ,[RequestOrder]
      ,[ProdProcNbr]
      ,[ProcessCat]
      ,[Refurbishment]
      ,[AcctId]
      ,[AddressNbr]
      ,[TimeCreated]
      ,[ChangedAt]
      ,[CostingVariant]
      ,[CostEstimateNbr]
      ,[UserResponsible]
      ,[JointVenture]
      ,[RecoveryId]
      ,[EquityTyp]
      ,[ObjectTyp]
      ,[JibJibeClass]
      ,[JibJibeSbclassA]
      ,[OrCostObj]
      ,[CuOrderCompatibleUnitItm]
      ,[ConstructMeasureNbr]
      ,[AutoEstCosts]
      ,[CuDesignNbr]
      ,[MainWorkCtr]
      ,[WorkCntrPlant]
      ,[RegId]
      ,[ClmCreationCntrlId]
      ,[ClaimInconsistent]
      ,[ClaimUpdTrigger]
      ,[CustNbr]
      ,[MatAvailDt]
      ,[OsiFlag]
      ,[OsiNbr]
      ,[PullDt]
      ,[Segment]
      ,[Team]
      ,[SplItmIdicator]
      ,[GsfcWorkOrder]
	)
Select
	[Column 0]
	,[Column 1]
	,[Column 2]
	,[Column 3]
	,[Column 4]
	,[Column 5]
	,[Column 6]=CASE WHEN len([Column 6])<6 Or [Column 6] NOT LIKE '%[1-9]%' THEN NULL	ELSE [Column 6]	END
	,[Column 7]
	,[Column 8]=CASE WHEN len([Column 8])<6 Or [Column 8] NOT LIKE '%[1-9]%' THEN NULL	ELSE [Column 8]	END
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
	,[Column 22]=CASE WHEN len([Column 22])<6 Or [Column 22] NOT LIKE '%[1-9]%' THEN NULL	ELSE [Column 22]	END
	,[Column 23]
	,[Column 24]
	,[Column 25]
	,[Column 26]
	,[Column 27]
	,[Column 28]=CASE WHEN len([Column 28])<6 Or [Column 28] NOT LIKE '%[1-9]%' THEN NULL	ELSE [Column 28]	END
	,[Column 29]=CASE WHEN len([Column 29])<6 Or [Column 29] NOT LIKE '%[1-9]%' THEN NULL	ELSE [Column 29]	END
	,[Column 30]=CASE WHEN len([Column 30])<6 Or [Column 30] NOT LIKE '%[1-9]%' THEN NULL	ELSE [Column 30]	END
	,[Column 31]=CASE WHEN len([Column 31])<6 Or [Column 31] NOT LIKE '%[1-9]%' THEN NULL	ELSE [Column 31]	END
	,[Column 32]=CASE WHEN len([Column 32])<6 Or [Column 32] NOT LIKE '%[1-9]%' THEN NULL	ELSE [Column 32]	END
	,[Column 33]=CASE WHEN len([Column 33])<6 Or [Column 33] NOT LIKE '%[1-9]%' THEN NULL	ELSE [Column 33]	END
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
	,[Column 47]
	,[Column 48]=CASE WHEN len([Column 48])<6 Or [Column 48] NOT LIKE '%[1-9]%' THEN NULL	ELSE [Column 48] END
	,[Column 49]
	,[Column 50]
	,[Column 51]
	,[Column 52]
	,[Column 53]
	,[Column 54]
	,[Column 55]=CASE WHEN len([Column 55])<6 Or [Column 55] NOT LIKE '%[1-9]%' THEN NULL	ELSE [Column 55] END
	,[Column 56]
	,[Column 57]=CASE WHEN len([Column 57])<6 Or [Column 57] NOT LIKE '%[1-9]%' THEN NULL	ELSE [Column 57] END
	,[Column 58]=CASE WHEN len([Column 45])<6 Or [Column 58] NOT LIKE '%[1-9]%' THEN NULL	ELSE [Column 58] END
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
	,[Column 89]=STUFF(STUFF([Column 89],3,0,':'),6,0,':')
	,[Column 90]=STUFF(STUFF([Column 90],3,0,':'),6,0,':')
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
	,[Column 112]=CASE WHEN len([Column 112])<6 Or [Column 112] NOT LIKE '%[1-9]%' THEN NULL	ELSE [Column 112] END
	,[Column 113]
	,[Column 114]
	,[Column 115]=CASE WHEN len([Column 115])<6 Or [Column 115] NOT LIKE '%[1-9]%' THEN NULL	ELSE [Column 115] END
	,[Column 116]
	,[Column 117]
	,[Column 118]
	,[Column 119]

From ImportAufk
WHERE [Column 0] IS NOT NULL AND [Column 0]<>''




TRUNCATE TABLE ImportAufk