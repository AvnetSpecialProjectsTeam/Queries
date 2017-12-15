USE SAP
GO

DROP TABLE Knvh


CREATE TABLE Knvh 
(
Client varchar (4),
HierTyp varchar (2),
SoldToPartyId bigint,
SalesOrg varchar (5),
DistrChannel varchar (3),
Division varchar (3),
ValidFrom datetime2,
ValidTo datetime2,
HighLvlCust varchar (11),
HighLvlSalesOrg varchar (5),
HighLvlDistrib varchar (3),
HighLvlDivis varchar (3),
RoutineNbr int,
Rebate varchar (2),
PriceDetermin varchar (2),
HierAssign int,
);

