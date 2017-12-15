USE NonHaImportTesting
GO 

Truncate Table Sap.dbo.VBKD
Go

Insert Into Sap.dbo.VBKD
( 
Client ,
SalesDocNbr,
SalesDocItmNbr,
PriceGrp,
TechFeeServ,
SalesDistrict,
PriceList,
Incoterms1,
Incoterms2,
OrderComboId,
InvoicingDts,
InvListSched,
SubsInvProcess,
ExchRateAcct,
AddValDays,
FixedValDt,
PaytTerms,
PymtMethod,
AcctAssignGrpCust,
ExchangeRate4,
PricingDt,
BillingDtIdexPrint,
ServRenderedDt,
FY,
PostingPeriod,
ExchRateStat,
DunningKey,
DunnBlock,
BillPlanNbr,
Promotion,
PaymGuarProc,
FinanceDocNbr,
TaxTyp,
Reason0Vat,
Region,
ActivityCdGIT,
DistrTypEmployeTax,
TaxRelClass,
DepartmentNbr,
RecvPoint,
BSTKD,
CustPoDt,
CustPoTyp,
YourRef,
ShipPartyPoNbr,
ShipToPartyPoDt,
ShipPartyPoTyp,
ShipPartyChar,
PoItmem,
TransDt3,
TransDt2,
ConditionGrp1,
ConditionGrp2,
ConditionGrp3,
ConditionGrp4,
ConditionGrp5,
ContractCurr,
ExchangeRate,
CurrKeyLetterCredit,
ExchRateLetterCredit,
DepreciationPercent,
InflationIdex,
IdexBaseDt,
CustPoNbrMatchCd,
AgreedDlvryTime,
DynamicItmProcessProf,
AcctId,
BillForm,
RevRecognition,
AccPeriodStart,
ShipTyp,
MeansTransTyp,
MeansTrans,
SpecProcessing,
[Catalog],
FunctionArea,
PodRelevant,
GenProjPlanGUID,
ContractAcct,
BillingPlanNbr,
BillingPlanItm,
RevenueDist,
RevenueEvent,
RevenueAcctTyp,
RefSpecContract,
PerOfPerfStart,
PerOfPerfEnd,
LstCstCd,
FormTyp1,
FormTyp2,
ControlCd,
AbbvComplaintReason,
ManDtRef,
PmtTyp,
SepaRelevant1,
SepaRelevant2,
BufferTyp
) 

Select 
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
      ,Case When Try_Cast(STUFF(STUFF(Replace([Column 15],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 15],' ',''),5,0,'/'),8,0,'/') End
      ,[Column 16]
      ,[Column 17]
      ,[Column 18]
      ,[Column 19]
      ,Case When Try_Cast(STUFF(STUFF(Replace([Column 20],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 20],' ',''),5,0,'/'),8,0,'/') End
      ,Case When Try_Cast(STUFF(STUFF(Replace([Column 21],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 21],' ',''),5,0,'/'),8,0,'/') End
      ,Case When Try_Cast(STUFF(STUFF(Replace([Column 22],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 22],' ',''),5,0,'/'),8,0,'/') End
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
      ,Case When Try_Cast(STUFF(STUFF(Replace([Column 41],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 41],' ',''),5,0,'/'),8,0,'/') End
      ,[Column 42]
      ,[Column 43]
      ,[Column 44]
      ,Case When Try_Cast(STUFF(STUFF(Replace([Column 45],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 45],' ',''),5,0,'/'),8,0,'/') End
      ,[Column 46]
      ,[Column 47]
      ,[Column 48]
      ,Case When Try_Cast(STUFF(STUFF(Replace([Column 49],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 49],' ',''),5,0,'/'),8,0,'/') End
      , Case When Try_Cast(STUFF(STUFF(Replace([Column 50],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 50],' ',''),5,0,'/'),8,0,'/') End
      ,[Column 51]
      ,[Column 52]
      ,[Column 53]
      ,[Column 54]
      ,[Column 55]
      ,[Column 56]
      ,Case When [Column 57] = ' ' Then Null Else [Column 57] End
      ,[Column 58]
      ,Case When [Column 59] = ' ' Then Null Else [Column 59] End
      ,Case When [Column 60] = ' ' Then Null Else [Column 60] End
      ,[Column 61]
      ,Case When Try_Cast(STUFF(STUFF(Replace([Column 62],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 62],' ',''),5,0,'/'),8,0,'/') End
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
      ,Case When Try_Cast(STUFF(STUFF(Replace([Column 85],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 85],' ',''),5,0,'/'),8,0,'/') End
      ,Case When Try_Cast(STUFF(STUFF(Replace([Column 86],' ',''),5,0,'/'),8,0,'/') As Datetime2) Is null then null Else STUFF(STUFF(Replace([Column 86],' ',''),5,0,'/'),8,0,'/') End
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
   From ImportVbkd Where [Column 0] Is Not Null And [Column 0] <>' ';


--Truncate Table ImportVBKD