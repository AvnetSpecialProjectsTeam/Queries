USE SAP
GO


TRUNCATE TABLE Eban
GO

INSERT INTO Eban(
Client,
PurchReqNbr,
RequisitionItmNbr,
PurchReqDocTyp,
PurchDocCatBSTYP,
ControlId,
PurOrgData,
Status,
CreationId,
RelId,
RelStatus,
RelStgyPurchReq,
PurchGrp,
CreatedBy,
CreatedOn,
Requisitioner,
PurchInfoRec,
Material,
MatNbrMfgPartNbr,
Plant,
StorLoc,
ReqTrackNbr,
MatGrp,
SupplyPlant,
SchedQty,
UnitOfMeasure,
ShortageQty,
RequisitionDt,
DlvryDtCat,
DlvryDt,
PurchReqReleaseDt,
GrProcTime,
ValPrice,
PriceUnitItm,
ItmCat,
AcctAssignCat,
Consumption,
AcctChangeable,
DistId,
PartialInvoiceId,
GoodsReceipt,
NonValueGoodsReceipt,
InvoiceReceipt,
Vendor,
FixedVendor,
PurchOrg,
PurchDocCatVRTYP,
Agreement,
AgreeItm,
InfoRecOrderNbr,
AssignedSrceSupply,
QuotaArrange,
QuotaArngeItm,
MrpCntrlrMatPlan,
BomExplNbr,
LastResubmissDt,
ResubmissionInterval,
NbrResubmission,
PurchDocNbr,
PurchDocItmNbr,
OrderDtSchedLine,
PoQty,
EntrySheet,
ValTyp,
Commitments,
PurchReqClosed,
Reservation,
SpecialStk,
SettleReserNbr,
SettleItmNbrReservation,
FixedId,
PoUnitMeas,
RevisionLevel,
AdvanceProcure,
PackageNbr,
KanbanId,
RequisitionPricePo,
IntObjNbrConfig,
RelGrp,
RelNotEffected,
Promotion,
BatchNbr,
SpIdStckTfr,
ProdVersion,
CommitmentItm,
FundsCenter,
Fund,
OriginOfConfig,
CrossPlanConfigMat,
CommittedQty,
CommitedDt,
MatCat,
Address,
NbrDlvryAddress,
SoldToPartyId,
VendorSupplied,
ScVendor,
Valuation,
OrderCurr,
VendMatNbr,
OverallReqRel,
MfgPartProfile,
UnitMeasureUse,
Language,
StandardVariant,
MfgPartNbr,
Mfg,
ExternalMfgCd,
FrameworkOrder,
FrameworkOrderItm,
PlDlvryTime,
MrpArea,
DtTime,
FunctionalArea,
[Grant],
Incomplete,
RequisitionProcState,
TtlValRelease,
PurchRequisitionBlocked,
BlockReason,
Version,
ProcPlant,
ExtProcProfile,
ExternalProcRefDoc,
ExternalProcRefItm,
PoQtyOnHold,
ReduceComVal,
IssStorLoc,
EarmarkedFundsDocNbr,
EarmarkedFundsDocItm,
ReqmtUrgency,
ReqmtPriorItm,
AdviceCd,
StatusCd,
CsPreqNbr,
CrossSysPreqItm,
CrossSysItmCat,
PoQtySender,
NbrSerialNbr,
MinRemShelfLife,
PeriodId,
NoSlocData,
IuidRelev,
SoLineItmNbr,
ConfigId,
ConfigLine,
IncompleteCat,
ResPurcReq,
CentralContract,
CentralContractItm,
BudgetPeriod,
SubconTyp,
SpStkIdSubcontract,
WbsElement,
CustNbr,
SalesAndDistDocNbr,
ItmNbrSDDpc,
OwnerOfStk,
UsGovt,
StkSegment,
ReqmntSegment,
FlagOnSpecialBuy,
SpecFlag
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
	,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 14],'/',''),' ',''),5,0,'/'),8,0,'/') as Datetime2) is null then null else Stuff(Stuff(Replace(Replace([Column 14],'/',''),' ',''),5,0,'/'),8,0,'/') End
	,[Column 15]
	,[Column 16]
	,Try_cast([Column 17] as bigint)
	,[Column 18]
	,[Column 19]
	,[Column 20]
	,[Column 21]
	,[Column 22]
	,[Column 23]
	,Case When Try_Cast(Replace([Column 24],'.000','')as int) is null then null else Replace([Column 24],'.000','') end
	,[Column 25]
	,try_cast(Replace([Column 26],'.','')as int)
	,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 27],'/',''),' ',''),5,0,'/'),8,0,'/') as Datetime2) is null then null else Stuff(Stuff(Replace(Replace([Column 27],'/',''),' ',''),5,0,'/'),8,0,'/') End
	,[Column 28]
	,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 29],'/',''),' ',''),5,0,'/'),8,0,'/') as Datetime2) is null then null else Stuff(Stuff(Replace(Replace([Column 29],'/',''),' ',''),5,0,'/'),8,0,'/') End
	,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 30],'/',''),' ',''),5,0,'/'),8,0,'/') as Datetime2) is null then null else Stuff(Stuff(Replace(Replace([Column 30],'/',''),' ',''),5,0,'/'),8,0,'/') End
	,Replace([Column 31],'.','')
	,[Column 32]
	,Replace([Column 33],'.','')
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
	,try_cast([Column 48] as int)
	,Try_Cast([Column 49] as bigint)
	,[Column 50]
	,[Column 51]
	,[Column 52]
	,[Column 53]
	,[Column 54]
	,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 55],'/',''),' ',''),5,0,'/'),8,0,'/') as Datetime2) is null then null else Stuff(Stuff(Replace(Replace([Column 55],'/',''),' ',''),5,0,'/'),8,0,'/') End
	,Replace([Column 56],'.','')
	,Replace([Column 57],'.','')
	,try_cast([Column 58] as bigint)
	,try_cast(Replace([Column 59],'.000','') as bigint) 
	,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 60],'/',''),' ',''),5,0,'/'),8,0,'/') as Datetime2) is null then null else Stuff(Stuff(Replace(Replace([Column 60],'/',''),' ',''),5,0,'/'),8,0,'/') End
	,try_cast(Replace([Column 61],'.000','') as int) 
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
	,Replace([Column 89],'.000','')
	,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 90],'/',''),' ',''),5,0,'/'),8,0,'/') as Datetime2) is null then null else Stuff(Stuff(Replace(Replace([Column 90],'/',''),' ',''),5,0,'/'),8,0,'/') End
	,[Column 91]
	,[Column 92]
	,try_cast([Column 93] as int)
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
	,Replace([Column 110],'.','')
	,[Column 111]
	,Case When Try_Cast(Stuff(Stuff(Replace(Replace([Column 112],'/',''),' ',''),5,0,'/'),8,0,'/') as Datetime2) is null then null else Stuff(Stuff(Replace(Replace([Column 112],'/',''),' ',''),5,0,'/'),8,0,'/') End
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
	,Replace([Column 125],'.000','')
	,[Column 126]
	,[Column 127]
	,[Column 128]
	,[Column 129]
	,[Column 130]
	,[Column 131]
	,[Column 132]
	,[Column 133]
	,Replace([Column 134],'.000','')
	,[Column 135]
	,[Column 136]
	,Replace([Column 137],'.000','')
	,try_cast([Column 138] as bigint)
	,Replace(Replace([Column 139],'.000',''),'.','')
	,Replace(Replace([Column 140],'.000',''),'.','')
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
FROM NonHaImportTesting.[dbo].[ImportEban]
WHERE [Column 0] IS NOT NULL AND [Column 0]<>''

TRUNCATE TABLE NonHaImportTesting.dbo.ImportEban