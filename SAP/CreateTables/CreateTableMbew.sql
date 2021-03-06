DROP TABLE Mbew

CREATE TABLE Mbew
(Client varchar (5),
Material bigint,
ValArea varchar (6),
ValTyp varchar (12),
ValTypDelFlag varchar (3),
TtlValStk decimal (13, 3),
ValTtlValStk money,
PriceControl varchar (3),
Map money,
StandardPrice money,
PriceUnitItm decimal (5),
ValClass varchar (6),
ValMap money,
TtlStkValPP decimal (13, 3),
TtlValPP money,
PriceCtrlPP varchar (3),
MapPP money,
StdPricePP money,
PriceUnitItmPP decimal (5),
ValClassPP varchar (6),
MapValPP money,
TtlStkPrevYr decimal (13, 3),
TtlValPrevYr money,
PriceCtrlPrevYr varchar (3),
MapPrevYr money,
StdPricePrevYr money,
PriceUnItmPrevYr decimal (5),
ValClassPrevYr varchar (6),
ValPrevYr money,
FYCurrPeriod int,
CurrPeriod int,
ValCat varchar (3),
PrevPrice money,
LastPriceChange varchar (10),
FutPrice money,
ValidFrom varchar (10),
[TimeStamp] varchar (21),
TaxPrice1 money,
ComPrice1 money,
TaxLawPrice3 money,
ComLawPrice3 money,
TtlValStkYrBefLast money,
TtlStkYrBefLast decimal (13, 3),
TtlStkPbl decimal (13, 3),
StkValuePeriodBefLast money,
FutPlndPrice1 money,
FutPlndPrice2 money,
FutPlndPrice3 money,
FutPlndPrice4 money,
PlndPriceDt1 varchar (10),
PlndPriceDt2 varchar (10),
PlndPriceDt3 varchar (10),
FutStandCostEstPeriod varchar (8),
CurrStandCostEstPeriod varchar (8),
PrevStandCostEstPeriod varchar (8),
FutStandCostEstPeriodId varchar (3),
CurrentCostEst varchar (3),
PrevCostEstId varchar (3),
OverheadKey varchar (8),
LifoFifoRel varchar (3),
LifoPool varchar (6),
CommPrice2 money,
TaxPrice2 money,
DevaluationId int,
MaintStatus varchar (17),
ProdCostEstNbr int,
CostEstNbr int,
ValVarCostEstFut varchar (5),
ValVarCostEstStand varchar (5),
ValVarCostEstPrev varchar (5),
CostingVersionFuture int,
CostingVersionCurrent int,
CostingVersionPrev int,
OriginGrp varchar (6),
OverheadGrp varchar (12),
PostPeriodStandCostEst int,
CurrPeriodStandCostEst int,
PrevPeriodStandCostEst int,
FutFYStandCostEst int,
CurrFYStandCostEst int,
PrevFYStandCostEst int,
CostEstWQs varchar (3),
PrevPlndPrice money,
MatLedgerActive varchar (3),
PriceDetermine varchar (3),
CurrPlanPrice money,
TtlSpVal money,
MatRelOrigin varchar (3),
PhysInvBlk varchar (3),
PhsyInvValOnlyMat varchar (5),
LastCountDt varchar (10),
CycleCountPhysInvId1 varchar (3),
ValMargin decimal (6, 2),
FxdCurrPlanPrice money,
PrevPlndPriceFixed money,
FixedPortionFuturePlanPrice money,
CurrValStgy varchar (3),
PrevValStgy varchar (3),
FutureValStgy varchar (3),
ValClassSalesOrderStk varchar (6),
ProjectStkVal varchar (6),
MatUsage varchar (3),
MatOrigin varchar (3),
ProdInHouse varchar (3),
ValuationUnit varchar (3),
PriceUnitValPriceTaxComLaw decimal (5),
MbewhRecAlreadyExists varchar (3),
VcVendor varchar (6),
PrepaidInv varchar (3),


);