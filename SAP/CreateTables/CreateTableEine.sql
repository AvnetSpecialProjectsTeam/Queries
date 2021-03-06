Drop Table sap.dbo.EINE
go


CREATE TABLE sap.dbo.Eine (
Client varchar (4),
NbrPurcInfoRec decimal (10),
PurcOrg varchar (5),
PurcInfoRecCat varchar (2),
Plant varchar (5),
PurcInfoFlagDel varchar (2),
CreateDt datetime2,
PersonCreate varchar (13),
PurcGrp varchar (4),
CurrKey varchar (6),
VolBaseRebate varchar (2),
QtyBaseVolRebate varchar (2),
MinPoQty decimal (13, 3),
StanPoQty decimal (13, 3),
PlanDlvryTimeDay decimal (3),
OverDlvryTol decimal (3, 1),
UnlimitOverDlvry varchar (2),
UnderOverDlvry decimal (3, 1),
QuotNbr varchar (11),
QuotValidDt datetime2,
RFQNbr varchar (11),
ItmNbrRFQ int,
RejId varchar (2),
AmrtPerFrom datetime2,
AmrtPerTo datetime2,
AmrtPlanQty decimal (15, 3),
AmrtPlanVal money,
AmrtActQty decimal (15, 3),
AmrtActVal money,
AmrtRes varchar (2),
PurcDocCat varchar (2),
PurcDocNbr decimal (10),
PurcDocItmNbr int,
DateLastPOSched datetime2,
NetPricPurcInfoRec money,
PricUnt decimal (5),
OrdPricUntPurc varchar (4),
VaildTo datetime2,
NumQtyConversion int,
DenQtyConversion int,
NoMatTxt varchar (2),
GRBasedIV varchar (2),
EffectPrice money,
CondGrpVend varchar (5),
NoCashDisc varchar (2),
OrdAckReq varchar (2),
TaxPurchCd varchar (3),
ValTyp varchar (11),
SetGrp1Purc varchar (3),
ShipInst varchar (3),
[Procedure] varchar (9),
ConfControl varchar (5),
PricDetPricDateCont varchar (2),
Incoterms varchar (4),
Incoterms2 varchar (29),
NoERS varchar (2),
SetGrp2 varchar (3),
SetGrp3 varchar (3),
NoSubSett varchar (2),
RemShelfLife int,
ProdVers varchar (5),
MaxPurcOrdQty decimal (13, 3),
RoundProf varchar (5),
UntMeasGrp varchar (5),
NCMCode varchar (17),
PeriodId varchar (2),
TransportationChain varchar (11),
StagingTime int,
CreateRefDoc varchar (2),
PpEligible varchar (2),
PoWaitPeriod int,
PoUpdate varchar (3),
SoUpdate varchar (3),
StkRotation varchar (2),
InvAge int,
OffsetReq varchar (2),
DollarPercent money,
QualPeriod int,
Frequency int,
TolPercent decimal (5, 2),
RTConsumption varchar (2),
RmaReq varchar (2),
DiffInvoicing varchar (3),
MRPind varchar (2),
StockSegRelId varchar (2),
MinPackQty int,
MinOrderLine money,
PoChangesAllowed decimal (2),
AsnInTransitTime int,
PoSchedLine varchar (2)


);