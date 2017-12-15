USE [SAP]
GO

DROP TABLE Msku

CREATE TABLE Msku(
Client varchar (5),
Material decimal (18),
Plant varchar (6),
BatchNbr varchar (11),
SpecialStk varchar (3),
SoldToPartyId decimal (10),
YearCurrentPeriod int,
CurrentPeriod int,
PhysInvBlk varchar (3),
Unrestricted decimal (13, 3),
InvQualInsp decimal (13, 3),
UnrestrUse decimal (13, 3),
StkQualInsp decimal (13, 3),
WarehouseStkCurrYr varchar (5),
QualInspStkCurr varchar (5),
WarehouseStkPrevYr varchar (5),
QualinspStkPrevPeri varchar (5),
WarehouseStkFolYr varchar (5),
QualInspStkFolYr varchar (5),
LastCountDt datetime2,
RestrictedUse decimal (13, 3),
RestrUsePp decimal (13, 3),
CreatedOn datetime2,
FiscalYearCurrInv int,
MxxxhRecExists varchar (3),
StkInTrans decimal (13, 3),
StkSegment varchar (18),



) ON [PRIMARY]

GO


