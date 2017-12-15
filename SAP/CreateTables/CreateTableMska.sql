USE [SAP]
GO

DROP TABLE Mska

CREATE TABLE Mska(
Client varchar (5),
Material bigint,
Plant varchar (6),
StorLoc varchar (6),
BatchNbr varchar (11),
SpecialStk varchar (3),
SalesDocNbr bigint,
SalesDocItmNbr int,
YearCurrPeriod int,
CurrPeriod int,
PhysInvBlocked varchar (3),
ValUnrestrictedStk decimal (13, 3),
StkInQualInsp decimal (13, 3),
BlockStk decimal (13, 3),
UnrestrUseStkPrevPeriod decimal (13, 3),
QualityInspectStkPrevPeriod decimal (13, 3),
BlockStkPrevPeriod decimal (13, 3),
PhyInvIdWarehouseStk varchar (5),
PhyInvIdQualCurrYear varchar (5),
PhyInvIdBlockedStkCurrFY varchar (5),
PhyInvIdStockPrevYear varchar (5),
PhyInvIdQualinspStkPrevPeriod varchar (5),
PhyInvIdBlockedStkPreviousPeriod varchar (5),
PhyInvIdStkFollowingYear varchar (5),
PhyInvIdQualityInspStock varchar (5),
PhyInvIdBlockedStkFollow varchar (5),
LastCountDt varchar (10),
RestrictedUseTtlStk decimal (13, 3),
RestrUsePrevPeriod decimal (13, 3),
CreatedOn varchar (10),
FYCurrPhyInv int,
MxxxhRecAlreadyExists varchar (3),
StkSegment varchar (18)
) ON [PRIMARY]

GO


