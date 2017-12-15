--ALTER TABLE SAP.dbo.Ekko SET (SYSTEM_VERSIONING = OFF)
---- --(HISTORY_TABLE= dbo.EkkoHistory));

--DROP TABLE SAP.dbo.Ekko
--DROP TABLE SAP.dbo.EkkoHistory

CREATE TABLE dbo.Ekko(
	Client varchar(4)
	,PoNbr bigint
	,CoCd varchar(5)
	,PoCat varchar(2)
	,PurReqDocType varchar(5)
	,ControlId varchar(2)
	,PurOrgData varchar(2)
	,[Status] varchar(2)
	,ChangeDtOrderMaster datetime2(7)
	,CreatedBy varchar(13)
	,ItmNbrInterval int
	,LastItmNbr int
	,VenAccNbr BIGINT
	,[Language] varchar(2)
	,PaytTerms varchar(5)
	,DiscDays1 int
	,DiscDays2 int
	,DiscDays3 int
	,DiscPct1 decimal(5, 3)
	,DiscPct2 decimal(5, 3)
	,PurchOrg varchar(5)
	,PurGrp varchar(4)
	,OrderCurr varchar(6)
	,ExchangeRate decimal(9, 5)
	,ExchRateFixed varchar(2)
	,PoDt datetime2(7)
	,ValidStartDt datetime2(7)
	,ValidEndDt datetime2(7)
	,AppClosingDt datetime2(7)
	,BidSubmissionDeadline datetime2(7)
	,BIdPeriodQuote datetime2(7)
	,WarrantyStartDt datetime2(7)
	,BidInvitationNbr decimal(10, 0)
	,QuoteNbr varchar(10)
	,QuoteSubmissionDt datetime2(7)
	,YourRef varchar(13)
	,SalesPersonResp varchar(31)
	,VenTeleNbr varchar(16)
	,SuppVendor varchar(11)
	,SoldToPartyId bigint
	,Agreement varchar(11)
	,RejectionReason varchar(3)
	,CompleteDlvry varchar(2)
	,GrMessage varchar(2)
	,SupplyingPlant INT
	,ReceivedVendor varchar(11)
	,Incoterms1 varchar(4)
	,Incoterms2 varchar(30)
	,TargetVal money
	,CollectiveNbr decimal(10, 0)
	,DocCondNbr decimal(10, 0)
	,CostingSheet varchar(7)
	,UpdateGrp varchar(7)
	,InvoicingParty varchar(10)
	,ForeignTradeDataNbr decimal(10, 0)
	,OurReference varchar(13)
	,LogicalSys varchar(11)
	,SubItmNbr int
	,DocTimeDepCond varchar(2)
	,RelGrp varchar(3)
	,RelStrat varchar(3)
	,PoRelId varchar(2)
	,RelStatus varchar(9)
	,RelNotEffected varchar(2)
	,ReportingCntry varchar(4)
	,ReleaseDoc varchar(2)
	,[Address] decimal(10, 0)
	,TaxDestCntry varchar(4)
	,VatRegNbr varchar(20)
	,ReasonCancel int
	,DocNbr bigint
	,CorrMiscProvisions varchar(2)
	,Incomplete varchar(2)
	,ProcState varchar(3)
	,TtlValRelease money
	,[Version] int
	,ScmPo varchar(2)
	,GrReasonCd varchar(5)
	,IncompleteCat varchar(2)
	,RetentionId varchar(2)
	,RetentionPercent decimal(5, 2)
	,DownPmtId varchar(5)
	,DownPmtPercent decimal(5, 2)
	,DownPmtAmt money
	,DueDtDownPay datetime2(7)
	,ProcessIdNbr decimal(10, 0)
	,ContractHierarchy varchar(2)
	,ThreshValExists varchar(2)
	,LegalContractNbr decimal(38, 0)
	,ContractName varchar(41)
	,ReleasedOn datetime2(7)
	,ShipTyp varchar(3)
	,HandoverLoc varchar(11)
	,ShippingCond varchar(3)
	,InteralKeyForceElement varchar(33)
	,[Counter] int
	,RelocationId varchar(11)
	,RelocationStep varchar(5)
	,LogicalSys2 varchar(11)
	,RmaAuthVal varchar(14)
	,Utilization varchar(6)
	,ReturnsHeader varchar(2)
	,FinalInvoiceInd varchar(2)
	,ExcludeB2bPoUpdt varchar(2)
	,EDICreateNbr varchar(2)
	,EDIChangeNbr varchar(2)
	,FaxEmailCreateNbr varchar(2)
	,FaxEmailChangeNbr varchar(2)
	,InterestIdic varchar(3)
	,DocCat varchar(2)
	,SameDlvryDt datetime2(7)
	,PlantAllItmRec varchar(5)
	,FirmDealId varchar(2)
	,TakeAccOfPrchgrp varchar(2)
	,TakeAccPlant varchar(2)
	,TakeAccContract varchar(2)
	,TakeAccItmCat varchar(2)
	,FixedDtPurchases varchar(2)
	,ConsiderBudget varchar(2)
	,AllocTableRelevance varchar(2)
	,TakeAcctDlvryPeriod varchar(2)
	,TakeAccDlvyDt varchar(2)
	,IncludeVendorSub varchar(2)
	,OTBCheckLevel varchar(2)
	,OTBConditionTyp varchar(5)
	,BudgetNbr decimal(16, 0)
	,RequiredBudget money 
	,OTBCurr varchar(6)
	,ReservedBudget money 
	,SpecialRelease money 
	,OTBReasonProfile varchar(5)
	,BudgetTyp varchar(3)
	,OTBStatus varchar(2)
	,Reason varchar(4)
	,TypOTBCheck varchar(2)
	,OTBRelContract varchar(2)
	,ContractIdLvl varchar(2)
	,DistTrgtValItm varchar(2) 
	,SqlStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
    ,SqlEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
	,PERIOD FOR SYSTEM_TIME (SqlStartTime, SqlEndTime),
	CONSTRAINT PkEkko PRIMARY KEY(PoNbr)
)

WITH
	(
		SYSTEM_VERSIONING = ON (HISTORY_TABLE= dbo.EkkoHistory)
	)
;



