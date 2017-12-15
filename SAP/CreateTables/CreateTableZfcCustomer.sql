USE SAP
GO

DROP TABLE ZfcCustomer

CREATE TABLE ZfcCustomer (
Client varchar (5),
FcstParty bigint,
SalesOrg varchar (6),
DistrChannel int,
ReservingFcst varchar (3),
[Status] int,
Plant int,
RespUser varchar (14),
FcstPeriod varchar (3),
FcstReloadPeriod varchar (3),
LoadTo int,
FcstHoldPerson int,
Idicator01 varchar (3),
Idicator02 varchar (3),
NetQtyTrans varchar (3),
NetQtyTransDays int,
ConsignFlag varchar (3),
VMIFlag varchar (3),
PackSizeRound varchar (3),
ConsumptionTyp varchar (3),
[Route] varchar (8),
SalesDocTyp varchar (6),
PeriodsValidate int,
SafetyScs int,
TargetBufferQty int,
CreatedBy varchar (14),
CreatedOn datetime2,
CreatedAt time ,
ChangedBy varchar (14),
ChangedOn datetime2,
ChangedAt time ,
PoNbr varchar (36),

)

SELECT * FROM ZfcCustomer