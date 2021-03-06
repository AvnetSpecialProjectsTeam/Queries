USE [SAP]
GO

/****** Object:  Table [dbo].[Vbak]    Script Datetime2: 10/19/2017 2:09:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Drop Table VBAK
CREATE TABLE sap.[dbo].[Vbak](
Client varchar (5),
SalesDocNbr bigint,
CreatedOn Datetime2,
EntryTime time (0),
EnteredBy varchar (14),
BidSubmissionDeadline Datetime2,
BIdPeriodQuote Datetime2,
DocDt Datetime2,
SalesDocCat varchar (3),
TransactGrp varchar (3),
SalesDocTyp varchar (6),
OrderReason varchar (5),
WarrantyStartDt Datetime2,
CollectiveNbr varchar (16),
DlvryBlock varchar (4),
BillBlckSalesDoc varchar (4),
NetVal money,
SalesDocCurr varchar (7),
SalesOrg varchar (6),
DistrChannel varchar (4),
Division varchar (4),
SalesGrp varchar (5),
SalesOffice varchar (6),
BusArea varchar (6),
BusAreaCostCenter varchar (6),
ValidFromDt Datetime2,
ValidToDt Datetime2,
DocCondNbr bigint,
ValidFrom Datetime2,
PropDtTyp varchar (3),
CompleteDlvry varchar (3),
OriginalSystem varchar (11),
SalesDocId varchar (3),
CostingSheet varchar (8),
ShipCond varchar (4),
OrderRelBillTyp varchar (6),
SalesProb int,
[Description] varchar (42),
CustPoNbr1 varchar (46),
CustPoTyp varchar (36),
CustPoDt Datetime2,
PONbrSupp int,
YourRef varchar (14),
OrderName varchar (37),
PhoneNbr varchar (21),
NbrOfContacts decimal (12, 1),
LastContactDt Datetime2,
SoldToPartyId varchar (16),
CostCenter varchar (12),
UpDtGrp int,
StatsCurr varchar (7),
ChangeDtOrderMaster Datetime2,
CustGrp1 varchar (11),
CustGrp2 varchar (11),
CustGrp3 varchar (11),
CustGrp4 varchar (11),
CustGrp5 varchar (11),
Agreement varchar (12),
CoArea int,
WbsElement int,
ExchRateTyp varchar (11),
CreditCntrllArea varchar (11),
CreditAcct varchar (12),
CustCreditGrp varchar (6),
CreditRepGrp varchar (5),
RiskCat varchar (5),
CurrKeyCreditCtrlArea varchar (7),
DocReleaseDt Datetime2,
NextCheckDt Datetime2,
NextDt Datetime2,
CreditValOfDoc money,
HierTypPricing varchar (3),
UsageId varchar (5),
MrpOrderDlvrySchedTyp varchar (3),
RefDoc bigint,
ObjNbrItm varchar (24),
CoCd2BBilled varchar (6),
TaxClass1Cust varchar (3),
TaxClass2Cust varchar (3),
TaxClass3Cust varchar (3),
TaxClass4Cust varchar (3),
TaxClass5Cust varchar (3),
TaxClass6Cust varchar (3),
TaxClass7Cust varchar (3),
TaxClass8Cust varchar (3),
TaxClass9Cust varchar (3),
RefDocNbr varchar (51),
AssignmentNbr bigint,
PrecedSalesDocCat varchar (3),
SearchProced varchar (8),
AccrualPeriod int,
OrderNbr bigint,
NotificationNbr bigint,
MasterCntrctNbr bigint,
RefProcedure varchar (6),
CheckPartnerAuth varchar (3),
PickUpDt Datetime2,
PickUpTime2 time (0),
PickUpTime1 time (0),
PaymCardPlanNbr bigint,
ProposedSchedTime time (0),
TaxDestCntry varchar (5),
TaxDepartCity varchar (5),
EuTriangDealId varchar (3),
BlockMasterContr varchar (3),
CmlDlvryOrQtyDt Datetime2,
MatAvailDt Datetime2,
SalesDocVers varchar (17),
LIKPVBLENkey varchar (24),
DgMgmtProfile varchar (5),
ContainsDanGoods varchar (3),
Char70 varchar (72),
BusEntity int,
SalesUnit int,
SalPhase varchar (13),
TargetIncome varchar (3),
ConstructionStage int,
Contingency varchar (4),
ExpirationDt Datetime2,
ResolutionDt Datetime2,
LogicalSystem varchar (12),
ProcCampDet varchar (8),
MultiplePromotions varchar (3),
[TimeStamp] time,
NxtOrderRevDt Datetime2,
GovtContractNbr varchar (51),
PriorityCd varchar (6),
ShcCiiInstruct varchar (7),
R2ONbr varchar (12),
HdrPriceAppBlock varchar (4),
TransmissionId varchar (27),
CarrierAcctNbr varchar (17),
SuppContractNbr varchar (51),
SuppQuoteRef varchar (22),
ProcessIdNbr bigint,
ControlKey varchar (6),
PostingDt Datetime2,
ApplicationId varchar (4),
TreasuryAcctSym varchar (32),
BusEvtTypCd varchar (12),
ModsAllowed varchar (3),
CancelAllow varchar (3),
PmtMethods varchar (12),
BusPartnerNbr int,
ReportingFrequency varchar (5),
PaymtMethod varchar (4),
ClaimHeader varchar (18),
OpportunityNbr varchar (12),
DealRegistrationNbr varchar (21),
HandoverLoc varchar (12),
FreightCdUnderCutoff varchar (3),
DtCd varchar (3),
EarlyShipWindow varchar (4),
LateShippingWindow varchar (4),
CustDraw varchar (52),
CustDrawRevision varchar (7),
ReturnDt Datetime2,
NbrOfDaysWeek int,
HandlingCharges varchar (3),
BillSpecialHandCharge varchar (3),
FuelSurcharge2 varchar (3),
EndUserPoNbr varchar (13),
InvFlag varchar (5),
StkRefNbr varchar (13),
TopDownBottomUpPrice1 varchar (4),
FreightConsolidatio varchar (3),
WebOrderNbr1 bigint,
LateCd varchar (5),
LateCdFreeText varchar (52),

) ON [PRIMARY]

GO


