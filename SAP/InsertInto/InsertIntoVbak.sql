 UPDATE NonHaImportTesting.dbo.ImportVBAK
  Set 
   [Column 2] = 
    CASE 
     WHEN len([Column 2])<6 THEN NULL
     WHEN [Column 2] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [Column 2]
    END,
   [Column 5] = 
    CASE 
     WHEN len([Column 5])<6 THEN NULL
     WHEN [Column 5] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [Column 5]
    END,
   [Column 6] = 
    CASE 
     WHEN len([Column 6])<6 THEN NULL
     WHEN [Column 6] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [Column 6]
    END,
    [Column 7] = 
    CASE 
     WHEN len([Column 7])<6 THEN NULL
     WHEN [Column 7] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [Column 7]
    END,
   [Column 12] = 
    CASE 
     WHEN len([Column 12])<6 THEN NULL
     WHEN [Column 12] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [Column 12]
    END,
   [Column 13] = 
    CASE 
     WHEN [Column 13] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [Column 13]
    END,
   [Column 25] = 
    CASE 
     WHEN len([Column 6])<6 THEN NULL
     WHEN [Column 6] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [Column 6]
    END,
   [Column 26] = 
    CASE 
     WHEN len([Column 26])<6 THEN NULL
     WHEN [Column 26] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [Column 26]
    END,
   [Column 28] = 
    CASE 
     WHEN len([COLUMN 28])<6 THEN NULL
     WHEN [COLUMN 28] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [Column 28]
    END,
   [Column 40] = 
    CASE 
     WHEN len([Column 40])<6 THEN NULL
     WHEN [Column 40] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [Column 40]
    END, 
    [Column 44] = 
   CASE 
    WHEN ([Column 44] like'%[(]%') THEN Replace([Column 44], '(', '')
    WHEN ([Column 44] like'%[)]%') THEN Replace([Column 44], ')', '')
    WHEN ([Column 44] like'%[-]%') THEN Replace([Column 44], '-', '')
    WHEN ([Column 44] like'%[+]%') THEN Replace([Column 44], '+', '')
    WHEN ([Column 44] like'%[*]%') THEN Replace([Column 44], '*', '')
    WHEN ([Column 44] like'%[/]%') THEN Replace([Column 44], '/', '')
    WHEN ([Column 44] like'%[a-z]%') THEN NULL
    WHEN ([Column 44] like'0%') THEN REPLACE(LTRIM(REPLACE([Column 44], '0', ' ')),' ', '0')
    WHEN ([Column 44] like'% %') THEN Replace([Column 44], ' ', '')
    WHEN Len([Column 44])<7 THEN NULL
    ELSE [Column 44]
   END,
   [column 46] = 
    CASE 
     WHEN len([column 46])<6 THEN NULL
     WHEN [column 46] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [column 46]
    END,
   [column 51] = 
    CASE 
     WHEN len([column 51])<6 THEN NULL
     WHEN [column 51] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [column 51]
    END,
   [column 67] = 
    CASE 
     WHEN len([column 67])<6 THEN NULL
     WHEN [column 67] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [column 67]
    END,
   [column 68] = 
    CASE 
     WHEN len([column 68])<6 THEN NULL
     WHEN [column 68] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [column 68]
    END,
   [column 69] = 
    CASE 
     WHEN len([column 69])<6 THEN NULL
     WHEN [column 69] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [column 69]
    END,
   [column 86] = 
    CASE 
     WHEN [column 86] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
     ELSE [column 86]
    END,
   [Column 96] = 
    CASE 
     WHEN len([Column 96])<6 THEN NULL
     WHEN [Column 96] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [Column 96]
    END,
   [Column 97] = 
    CASE 
     WHEN len([Column 97])<6 THEN NULL
     WHEN [Column 97] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [Column 97]
    END,
   [Column 98] = 
    CASE 
     WHEN len([Column 98])<6 THEN NULL
     WHEN [Column 98] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [Column 98]
    END,
   [Column 100] = 
    CASE 
     WHEN len([Column 100])<6 THEN NULL
     WHEN [Column 100] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [Column 100]
    END,
   [COLUMN 105] = 
    CASE 
     WHEN len([COLUMN 105])<6 THEN NULL
     WHEN [COLUMN 105] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [COLUMN 105]
    END,
   [COLUMN 106] = 
    CASE 
     WHEN len([COLUMN 106])<6 THEN NULL
     WHEN [COLUMN 106] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [COLUMN 106]
    END,
   [COLUMN 118] = 
    CASE 
     WHEN len([COLUMN 118])<6 THEN NULL
     WHEN [COLUMN 118] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [COLUMN 118]
    END,
   [COLUMN 119] = 
    CASE 
     WHEN len([COLUMN 119])<6 THEN NULL
     WHEN [COLUMN 119] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [COLUMN 119]
    END,
   [Column 123] = 
   CASE
    WHEN len([COLUMN 123])<6 THEN NULL
    WHEN [Column 123] NOT LIKE '%[1-9]%' THEN NULL
    ELSE STUFF(STUFF(STUFF(STUFF(STUFF(SUBSTRING([Column 123],0,15),5,0,'-'),8,0,'-'),11,0,' '),14,0,':'),17,0,':')
   END,
   [COLUMN 124] = 
    CASE 
     WHEN len([COLUMN 124])<6 THEN NULL
     WHEN [COLUMN 124] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [COLUMN 124]
    END,
   [COLUMN 136] =
    CASE 
     WHEN len([COLUMN 136])<6 THEN NULL
     WHEN [COLUMN 136] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [COLUMN 136]
    END,
   [COLUMN 156] = 
    CASE 
     WHEN len([COLUMN 156])<6 THEN NULL
     WHEN [COLUMN 156] NOT LIKE '%[1-9]%' THEN NULL
     ELSE [COLUMN 156]
    END



TRUNCATE TABLE Sap.dbo.Vbak


INSERT INTO Sap.dbo.Vbak(
 Client,
SalesDocNbr,
CreatedOn,
EntryTime,
EnteredBy,
BidSubmissionDeadline,
BIdPeriodQuote,
DocDt,
SalesDocCat,
TransactGrp,
SalesDocTyp,
OrderReason,
WarrantyStartDt,
CollectiveNbr,
DlvryBlock,
BillBlckSalesDoc,
NetVal,
SalesDocCurr,
SalesOrg,
DistrChannel,
Division,
SalesGrp,
SalesOffice,
BusArea,
BusAreaCostCenter,
ValidFromDt,
ValidToDt,
DocCondNbr,
ValidFrom,
PropDtTyp,
CompleteDlvry,
OriginalSystem,
SalesDocId,
CostingSheet,
ShipCond,
OrderRelBillTyp,
SalesProb,
[Description],
CustPoNbr1,
CustPoTyp,
CustPoDt,
PONbrSupp,
YourRef,
OrderName,
PhoneNbr,
NbrOfContacts,
LastContactDt,
SoldToPartyId,
CostCenter,
UpDtGrp,
StatsCurr,
ChangeDtOrderMaster,
CustGrp1,
CustGrp2,
CustGrp3,
CustGrp4,
CustGrp5,
Agreement,
CoArea,
WbsElement,
ExchRateTyp,
CreditCntrllArea,
CreditAcct,
CustCreditGrp,
CreditRepGrp,
RiskCat,
CurrKeyCreditCtrlArea,
DocReleaseDt,
NextCheckDt,
NextDt,
CreditValOfDoc,
HierTypPricing,
UsageId,
MrpOrderDlvrySchedTyp,
RefDoc,
ObjNbrItm,
CoCd2BBilled,
TaxClass1Cust,
TaxClass2Cust,
TaxClass3Cust,
TaxClass4Cust,
TaxClass5Cust,
TaxClass6Cust,
TaxClass7Cust,
TaxClass8Cust,
TaxClass9Cust,
RefDocNbr,
AssignmentNbr,
PrecedSalesDocCat,
SearchProced,
AccrualPeriod,
OrderNbr,
NotificationNbr,
MasterCntrctNbr,
RefProcedure,
CheckPartnerAuth,
PickUpDt,
PickUpTime2,
PickUpTime1,
PaymCardPlanNbr,
ProposedSchedTime,
TaxDestCntry,
TaxDepartCity,
EuTriangDealId,
BlockMasterContr,
CmlDlvryOrQtyDt,
MatAvailDt,
SalesDocVers,
LIKPVBLENkey,
DgMgmtProfile,
ContainsDanGoods,
Char70,
BusEntity,
SalesUnit,
SalPhase,
TargetIncome,
ConstructionStage,
Contingency,
ExpirationDt,
ResolutionDt,
LogicalSystem,
ProcCampDet,
MultiplePromotions,
[TimeStamp],
NxtOrderRevDt,
GovtContractNbr,
PriorityCd,
ShcCiiInstruct,
R2ONbr,
HdrPriceAppBlock,
TransmissionId,
CarrierAcctNbr,
SuppContractNbr,
SuppQuoteRef,
ProcessIdNbr,
ControlKey,
PostingDt,
ApplicationId,
TreasuryAcctSym,
BusEvtTypCd,
ModsAllowed,
CancelAllow,
PmtMethods,
BusPartnerNbr,
ReportingFrequency,
PaymtMethod,
ClaimHeader,
OpportunityNbr,
DealRegistrationNbr,
HandoverLoc,
FreightCdUnderCutoff,
DtCd,
EarlyShipWindow,
LateShippingWindow,
CustDraw,
CustDrawRevision,
ReturnDt,
NbrOfDaysWeek,
HandlingCharges,
BillSpecialHandCharge,
FuelSurcharge2,
EndUserPoNbr,
InvFlag,
StkRefNbr,
TopDownBottomUpPrice1,
FreightConsolidatio,
WebOrderNbr1,
LateCd,
LateCdFreeText
)

SELECT 
 [column 0]
 ,[column 1]
 ,Case When Try_Cast([column 2] As Date) Is Null Then Null Else Convert(Date, [column 2]) End
 ,CONVERT(TIME,STUFF(STUFF([Column 3], 3,0,':'),6,0,':'))
 ,[Column 4]
 ,Case When Try_Cast([column 5] As Date) Is Null Then Null Else Convert(Date, [column 5]) End
 ,Case When Try_Cast([column 6] As Date) Is Null Then Null Else Convert(Date, [column 6]) End
 ,Case When Try_Cast([column 7] As Date) Is Null Then Null Else Convert(Date, [column 7]) End
 ,[column 8]
 ,[column 9]
 ,[column 10]
 ,[column 11]
 ,Case When Try_Cast([column 12] As Date) Is Null Then Null Else Convert(Date, [column 12]) End
 ,[column 13]
 ,[column 14]
 ,[column 15]
 ,[column 16]
 ,[column 17]
 ,[column 18]
 ,[column 19]
 ,[column 20]
 ,[column 21]
 ,[column 22]
 ,[column 23]
 ,[column 24]
 ,Case When Try_Cast([column 25] As Date) Is Null Then Null Else Convert(Date, [column 25]) End
 ,Case When Try_Cast([column 26] As Date) Is Null Then Null Else Convert(Date, [column 26]) End
 ,Case When Try_Cast([column 27] As Bigint) Is Null Then Null Else Convert(bigint, [Column 27]) End
 ,Case When Try_Cast([column 28] As Date) Is Null Then Null Else Convert(Date, [column 28]) End
 ,[column 29]
 ,[column 30]
 ,[column 31]
 ,[column 32]
 ,[column 33]
 ,[column 34]
 ,[column 35]
 ,case when Try_cast([column 36] As int) Is null then null else [column 36] end
 ,[column 37]
 ,[column 38]
 ,[column 39]
 ,Case When Try_Cast([column 40] As Date) Is Null Then Null Else Convert(Date, [column 40]) End
 ,case when Try_cast([column 41] As int) Is null then null else [column 41] end
 ,[column 42]
 ,[column 43]
 ,[column 44]
 ,case when try_cast([column 45] as decimal(12,1)) is null then null else convert(decimal(12,1), [column 45]) end
 ,Case When Try_Cast([column 46] As Date) Is Null Then Null Else Convert(Date, [column 46]) End
 ,[column 47]
 ,[column 48]
 ,case when Try_cast([column 49] As int) Is null then null else [column 49] end
 ,[column 50] 
 ,Case When Try_Cast([column 51] As Date) Is Null Then Null Else Convert(Date, [column 51]) End
 ,[column 52]
 ,[column 53]
 ,[column 54]
 ,[column 55]
 ,[column 56]
 ,[column 57]
 ,case when Try_cast([column 58] As int) Is null then null else [column 58] end
 ,case when Try_cast([column 59] As int) Is null then null else [column 59] end
 ,[column 60]
 ,[column 61]
 ,[column 62]
 ,[column 63]
 ,[column 64]
 ,[column 65]
 ,[column 66]
 ,Case When Try_Cast([column 67] As Date) Is Null Then Null Else Convert(Date, [column 67]) End
 ,Case When Try_Cast([column 68] As Date) Is Null Then Null Else Convert(Date, [column 68]) End
 ,Case When Try_Cast([column 69] As Date) Is Null Then Null Else Convert(Date, [column 69]) End
 ,[column 70]
 ,[column 71]
 ,[column 72]
 ,[column 73]
 ,Case When Try_Cast([column 74] As Bigint) Is Null Then Null Else Convert(bigint, [column 74]) End
 ,[column 75]
 ,[column 76]
 ,[column 77]
 ,[column 78]
 ,[column 79]
 ,[column 80]
 ,[column 81]
 ,[column 82]
 ,[column 83]
 ,[column 84]
 ,[column 85]
 ,[column 86]
 ,Case When Try_Cast([column 87] As Bigint) Is Null Then Null Else Convert(bigint, [column 87]) End
 ,[column 88]
 ,[column 89]
 ,[column 90]
 ,Case When Try_Cast([column 91] As Bigint) Is Null Then Null Else Convert(bigint, [column 91]) End
 ,Case When Try_Cast([column 92] As Bigint) Is Null Then Null Else Convert(bigint, [column 92]) End
 ,Case When Try_Cast([column 93] As Bigint) Is Null Then Null Else Convert(bigint, [column 93]) End
 ,[column 94]
 ,[column 95]
 ,Case When Try_Cast([column 96] As Date) Is Null Then Null Else Convert(Date, [column 96]) End
 ,Case When Try_Cast([column 97] As Time) Is Null Then Null Else Convert(Time, [column 97]) End
 ,Case When Try_Cast([column 98] As time) Is Null Then Null Else Convert(Time, [column 98]) End
 ,Case When Try_Cast([column 99] As Bigint) Is Null Then Null Else Convert(bigint, [column 99]) End
 ,Case When Try_Cast([column 100] As Time) Is Null Then Null Else Convert(Time, [column 100]) End 
 ,[column 101]
 ,[column 102]
 ,[column 103]
 ,[column 104]
 ,Case When Try_Cast([column 105] As Date) Is Null Then Null Else Convert(Date, [column 105]) End
 ,Case When Try_Cast([column 106] As Date) Is Null Then Null Else Convert(Date, [column 106]) End
 ,[column 107]
 ,[column 108]
 ,[column 109]
 ,[column 110]
 ,[column 111]
 ,[column 112]
 ,[column 113]
 ,[column 114]
 ,[column 115]
 ,[column 116]
 ,[column 117]
 ,Case When Try_Cast([column 118] As Date) Is Null Then Null Else Convert(Date, [column 118]) End
 ,Case When Try_Cast([column 119] As Date) Is Null Then Null Else Convert(Date, [column 119]) End
 ,[column 120]
 ,[column 121]
 ,[column 122]
 ,Case When Try_Cast([column 123] As DateTime2) Is Null Then Null Else Convert(DateTime2, [column 123]) End
 ,Case When Try_Cast([column 124] As Date) Is Null Then Null Else Convert(Date, [column 124]) End
 ,[column 125]
 ,[column 126]
 ,[column 127]
 ,[column 128]
 ,[column 129]
 ,[column 130]
 ,[column 131]
 ,[column 132]
 ,[column 133]
 ,Case When Try_Cast([column 134] As Bigint) Is Null Then Null Else Convert(bigint, [column 134]) End
 ,[column 135]
 ,Case When Try_Cast([column 136] As Date) Is Null Then Null Else Convert(Date, [column 136]) End
 ,[column 137]
 ,[column 138]
 ,[column 139]
 ,[column 140] 
 ,[column 141]
 ,[column 142]
 ,[column 143]
 ,[column 144]
 ,[column 145]
 ,[column 146]
 ,[column 147]
 ,[column 148]
 ,[column 149]
 ,[column 150]
 ,[column 151]
 ,[column 152]
 ,[column 153]
 ,[column 154]
 ,[column 155]
 ,Case When Try_Cast([column 156] As Date) Is Null Then Null Else Convert(Date, [column 156]) End
 ,[column 157]
 ,[column 158]
 ,[column 159]
 ,[column 160]
 ,[column 161]
 ,[column 162]
 ,[column 163]
 ,[column 164]
 ,[column 165]
 ,Case When Try_Cast([column 166] As Bigint) Is Null Then Null Else Convert(bigint, [column 166]) End
 ,[column 167]
 ,[column 168] 
 
FROM NonHaImportTesting.dbo.ImportVBAK
WHERE [Column 0] Is Not Null AND [Column 0]<>'' and len([Column 52]) <= 4 and len([Column 53]) <=4  and len([Column 54]) <=4  and len([Column 55]) <=4;
