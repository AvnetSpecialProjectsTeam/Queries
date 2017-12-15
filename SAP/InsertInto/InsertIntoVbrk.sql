----Update Queries to Format Data

BEGIN
Update nonhaimporttesting.dbo.ImportVbrk 
Set [Column 27] = 
	Case 
		When Try_Cast(STUFF(STUFF(Replace([Column 27],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null 
		Else STUFF(STUFF(Replace([Column 27],' ',''),5,0,'/'),8,0,'/')
	End,
	[Column 49] = 
		Case 
			When Try_Cast(STUFF(STUFF(Replace([Column 49],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null 
			Else STUFF(STUFF(Replace([Column 49],' ',''),5,0,'/'),8,0,'/')
		End,
	[Column 57] = 
		Case 
			When Try_Cast(STUFF(STUFF(Replace([Column 57],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null 
			Else STUFF(STUFF(Replace([Column 57],' ',''),5,0,'/'),8,0,'/') 
		End,
	[Column 61] = 
		Case 
			When Try_Cast(STUFF(STUFF(Replace([Column 61],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null 
			Else STUFF(STUFF(Replace([Column 61],' ',''),5,0,'/'),8,0,'/') 
		End,
	[Column 87] = 
		Case 
			When Try_Cast(STUFF(STUFF(Replace([Column 87],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null 
			Else STUFF(STUFF(Replace([Column 87],' ',''),5,0,'/'),8,0,'/') 
		End,
	[Column 48] = 
		Case 
			When Try_Cast(STUFF(STUFF(Replace([Column 48],' ',''),3,0,':'),6,0,':')  As Time) Is null then null 
			Else STUFF(STUFF(Replace([Column 48],' ',''),3,0,':'),6,0,':')  
		End,
	[Column 89] = 
		Case 
			When [Column 89] = '' Then Null 
			Else [Column 89]
		End
END

--Truncate final table to prepare for import
Truncate Table SAP.dbo.VBRK

--Insert Into Statement
Insert Into SAP.dbo.VBRK

(
Client,
SalesDocNbr,
BillTyp,
BillingCat,
SalesDocCat,
SalesDocCurr,
SalesOrg,
DistrChannel,
CostingSheet,
DocCondNbr,
ShipCond,
BillingDtIndexPrint,
AcctDocNbr,
FY,
PostingPeriod,
PriceGrp,
TechFeeServ,
SalesDistrict,
PriceList,
IncotermsPart1,
IncotermsPart2,
ExportId,
PostingStatus,
SubsInvProcess,
ExchRateAcct,
SetExchangeRate,
AddValDays,
FixedValDt,
PaytTerms,
PymtMethod,
AcctAssignGrpCust,
DestCountry,
Region,
CountyCd,
CityCd,
CoCd,
TaxClass1Cust,
TaxClass2Cust,
TaxClass3Cust,
TaxClass4Cust,
TaxClass5Cust,
TaxClass6Cust,
TaxClass7Cust,
TaxClass8Cust,
TaxClass9Cust,
NetVal,
CombCriteriaBillDoc,
EnteredBy,
EntryTime,
CreatedOn,
UpdateGrp,
Payer,
SoldToParty,
DunningArea,
StatsCurr,
ForeignTradeDataNbr,
VatRegNbr,
ChangeDtOrderMaster,
CancelBillDoc,
Agreement,
InvListTyp,
BillingDtInvoiceList,
ExchRateTyp,
DunningKey,
DunnBlock,
Division,
CreditCntrlArea,
CreditAcct,
CurrKeyCreditCntrlArea,
ExchangeRateBillingDocRate,
HierTypPricing,
CustPoNbr
--TradingPartnerId,
--AccrualBillTyp,
--[Application],
--TaxDepartCity,
--OriginSalesTax,
--TaxDestCntry,
--RefDocNbr,
--AssignmentNbr,
--TaxAmount,
--LogicalSystem,
--BillDocCancel,
--EuTriangDealId,
--PaymCardPlanNbr,
--FinanceDocNbr,
--TaxTyp,
--TranslationDt,
--CurrKeyLetterCredit,
--ExchRateLetterCredit,
--PymtRef,
--PartBankTyp,
--NbrOfPages,
--BusPlace,
--ContractAcct,
--AddFinanStatus,
--CharacterField12,
--BillingId,
--RefSpecContract,
--SourceSystem,
--CrmBillCat,
--ReversalReason,
--SalesDocCatExt,
--DpcRelvFlag,
--ManDtRef,
--PmtTyp,
--SepaRelevantSEPON,
--SepaRelevantMNDVG,
--PaymtMethod,
--SalesOrderSpecPymt,
--SpecProcessingId,
--InvFlag
	)

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
    --,[Column 72]
    --,[Column 73]
    --,[Column 74]
    --,[Column 75]
    --,[Column 76]
    --,[Column 77]
    --,[Column 78]
    --,[Column 79]
    --,[Column 80]
    --,[Column 81]
    --,[Column 82]
    --,[Column 83]
    --,[Column 84]
    --,[Column 85]
    --,[Column 86]
    --,[Column 87]
    --,[Column 88]
    --,[Column 89]
    --,[Column 90]
    --,[Column 91]
    --,[Column 92]
    --,[Column 93]
    --,[Column 94]
    --,[Column 95]
    --,[Column 96]
    --,[Column 97]
    --,[Column 98]
    --,[Column 99]
    --,[Column 100]
    --,[Column 101]
    --,[Column 102]
    --,[Column 103]
    --,[Column 104]
    --,[Column 105]
    --,[Column 106]
    --,[Column 107]
    --,[Column 108]
    --,[Column 109]
    --,[Column 110]
    --,[Column 111]

From NonHaImportTesting.dbo.ImportVBRK
Where [Column 0] <>  ' ' AND [Column 0] Is Not Null And [Column 89] <> '20161001' And [Column 89] <> '20161116' And [Column 89] <> '20170111' And [Column 89] <> '20170211' And [Column 89] <> '20170307' And [Column 89] <> '20170706' And [Column 89] <> '20170718'

----Truncate Import Table to free up space
--Truncate Table ImportVBRK
