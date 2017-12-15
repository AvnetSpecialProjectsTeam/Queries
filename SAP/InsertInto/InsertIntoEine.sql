Use NonHaImportTesting
Go

Truncate Table Sap.dbo.Eine

Insert Into Sap.dbo.Eine(
Client,
NbrPurcInfoRec,
PurcOrg,
PurcInfoRecCat,
Plant,
PurcInfoFlagDel,
CreateDt,
PersonCreate,
PurcGrp,
CurrKey,
VolBaseRebate,
QtyBaseVolRebate,
MinPoQty,
StanPoQty,
PlanDlvryTimeDay,
OverDlvryTol,
UnlimitOverDlvry,
UnderOverDlvry,
QuotNbr,
QuotValidDt,
RFQNbr,
ItmNbrRFQ,
RejId,
AmrtPerFrom,
AmrtPerTo,
AmrtPlanQty,
AmrtPlanVal,
AmrtActQty,
AmrtActVal,
AmrtRes,
PurcDocCat,
PurcDocNbr,
PurcDocItmNbr,
DateLastPOSched,
NetPricPurcInfoRec,
PricUnt,
OrdPricUntPurc,
VaildTo,
NumQtyConversion,
DenQtyConversion,
NoMatTxt,
GRBasedIV,
EffectPrice,
CondGrpVend,
NoCashDisc,
OrdAckReq,
TaxPurchCd,
ValTyp,
SetGrp1Purc,
ShipInst,
[Procedure],
ConfControl,
PricDetPricDateCont,
Incoterms,
Incoterms2,
NoERS,
SetGrp2,
SetGrp3,
NoSubSett,
RemShelfLife,
ProdVers,
MaxPurcOrdQty,
RoundProf,
UntMeasGrp,
NCMCode,
PeriodId,
TransportationChain,
StagingTime,
CreateRefDoc,
PpEligible,
PoWaitPeriod,
PoUpdate,
SoUpdate,
StkRotation,
InvAge,
OffsetReq,
DollarPercent,
QualPeriod,
Frequency,
TolPercent,
RTConsumption,
RmaReq,
DiffInvoicing,
MRPind,
StockSegRelId,
MinPackQty,
MinOrderLine,
PoChangesAllowed,
AsnInTransitTime,
PoSchedLine
)
Select
[Column 0]
,[Column 1]
,[Column 2]
,[Column 3]
,[Column 4]
,[Column 5]
,Case When TRY_CAST(STUFF(STUFF(Replace(Replace([Column 6],' ',''),'/',''),5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN Null Else STUFF(STUFF(Replace(Replace([Column 6],' ',''),'/',''),5,0,'/'),8,0,'/') End
,[Column 7]
,[Column 8]
,[Column 9]
,[Column 10]
,[Column 11]
,[Column 12]
,[Column 13]
,Replace([Column 14],'.','')
,[Column 15]
,[Column 16]
,[Column 17]
,Case When [Column 18] = ' ' Then Null Else [Column 18] End
,Case When TRY_CAST(STUFF(STUFF(Replace(Replace([Column 19],' ',''),'/',''),5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN Null Else STUFF(STUFF(Replace(Replace([Column 19],' ',''),'/',''),5,0,'/'),8,0,'/') End
,Case When [Column 20] = ' ' Then Null Else [Column 20] End
,[Column 21]
,[Column 22]
,Case When TRY_CAST(STUFF(STUFF(Replace(Replace([Column 23],' ',''),'/',''),5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN Null Else STUFF(STUFF(Replace(Replace([Column 23],' ',''),'/',''),5,0,'/'),8,0,'/') End
,Case When TRY_CAST(STUFF(STUFF(Replace(Replace([Column 24],' ',''),'/',''),5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN Null Else STUFF(STUFF(Replace(Replace([Column 24],' ',''),'/',''),5,0,'/'),8,0,'/') End
,[Column 25]
,[Column 26]
,[Column 27]
,[Column 28]
,[Column 29]
,[Column 30]
,Case When [Column 31] = ' ' Then Null Else [Column 31] End
,[Column 32]
,Case When TRY_CAST(STUFF(STUFF(Replace(Replace([Column 33],' ',''),'/',''),5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN Null Else STUFF(STUFF(Replace(Replace([Column 33],' ',''),'/',''),5,0,'/'),8,0,'/') End
,[Column 34]
,Replace([Column 35],'.','')
,[Column 36]
,Case When TRY_CAST(STUFF(STUFF(Replace(Replace([Column 37],' ',''),'/',''),5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN Null Else STUFF(STUFF(Replace(Replace([Column 37],' ',''),'/',''),5,0,'/'),8,0,'/') End
,Replace([Column 38],'.','')
,Replace([Column 39],'.','')
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
,Replace([Column 59],'.','')
,[Column 60]
,[Column 61]
,[Column 62]
,[Column 63]
,[Column 64]
,[Column 65]
,[Column 66]
,Replace([Column 67],'.','')
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
,Replace([Column 85],'.','')
,[Column 86]
,[Column 87]
,[Column 88]
,[Column 89]
From NonHaImportTesting.dbo.ImportEine Where [Column 0] Is Not Null And [Column 0] <>' '

Truncate Table NonHaImportTesting.dbo.ImportEine

