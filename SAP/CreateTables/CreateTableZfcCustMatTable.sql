USE SAP 
GO 

DROP TABLE ZfcCustMat


CREATE TABLE ZfcCustMat (
Client varchar (10),
FcstPartyZZFPA varchar (20),
CustMat varchar (100),
SalesOrg varchar (15),
DistrChannel varchar (10),
ReservingFcst varchar (10),
FcstStatus varchar (8),
AnnualFcstQty decimal (15, 3),
BaseUnitMeasure varchar (8),
ValidFrom datetime2,
ValidTo datetime2,
PackSizeRounding varchar (8),
ConsumptionTyp varchar (8),
FlexibleZone int,
AutoDlvry varchar (8),
FcstPartyRELATED_OEM varchar (15),
ConsignFlag varchar (8),
LiabilityWeeks int,
Liability varchar (8),
Id varchar (8),
FcsttOverwrite int,
MoveFcst int,
FcstLoadDt datetime2,
PeriodValidate int,
SafetySCS int,
TargetBufferQty int,
EnteredBy varchar (15),
CreatedOn datetime2,
CreatedAt varchar (15),
ChangedBy varchar (15),
ChangeDtOrderMaster datetime2,
ChangedAt varchar (10),
CustPoNbr varchar (40),
LiabilityQty varchar (8),
ApprovedQty decimal (15, 4),
BlockedQty decimal (15, 4),
StartDt datetime2,
ChangedOn datetime2,
)

--SELECT * FROM NonHaImportTesting.dbo.ImportZfcCustMat