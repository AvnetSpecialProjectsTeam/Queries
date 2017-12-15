DROP TABLE sap.dbo.Mard


CREATE TABLE sap.dbo.Mard
(
Client varchar (5),
Material decimal (18),
Plant int,
StorLoc varchar (6),
MaintStatus varchar (17),
ValuationTyp varchar (3),
YearCurrentPeriod varchar (6),
CurrentPeriod int,
PostingBlock varchar (3),
Unrestricted decimal (13, 3),
StkTransLocToLoc decimal (13, 3),
InQualInsp decimal (13, 3),
TtlStkRestrictedBatches decimal (13, 3),
Blocked decimal (13, 3),
[Returns] decimal (13, 3),
UnrestrUsePP decimal (13, 3),
InTransferPP decimal (13, 3),
QualInspPP decimal (13, 3),
RestrUsePP decimal (13, 3),
BlockedStockPP decimal (13, 3),
BlockedReturnsPP decimal (13, 3),
WarehouseStkCurrYr varchar (6),
QualInspStkCurrYr varchar (5),
RestrictedUseCurrYr varchar (5),
BlockedStkCurrYr varchar (5),
WarehouseStkPrevYr varchar (5),
QualInspStkPrevYr varchar (5),
RestrictedUsePrevYr varchar (5),
BlockedStkPrevYr varchar (5),
StorageLocateMRPId varchar (3),
SpecProcStorLoc varchar (4),
ReOrderPoint decimal (13, 3),
ReplenishQty decimal (13, 3),
CtryOfOrigin varchar (5),
PrefId varchar (3),
ExportId varchar (4),
StorBin varchar (12),
UnrestricConsignStk decimal (13, 3),
ConsignQtyInspec decimal (13, 3),
RestrictConsignStk decimal (13, 3),
BlockedConsignStk decimal (13, 3),
UnrestrictLastCountDt varchar (10),
ProfitCenter varchar (12),
CreatedOn datetime2,
SpStkVal money,
StkTransferSvLocToLoc money,
PickingArea varchar (5),
InvCorrectFact decimal (8),
MardhRecAlreadyExists varchar (3),
FYCurrPhsyInv varchar (6),


PRIMARY KEY (Client, Material, Plant, StorLoc)
)