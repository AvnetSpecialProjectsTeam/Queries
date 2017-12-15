USE SAP 
GO 

DROP TABLE Mlgn




CREATE TABLE Mlgn (
Client varchar (5),
Material bigint,
WarehouseNbr varchar (5),
DelFlagMatDataWareNbr varchar (3),
StorSectId varchar (5),
StkPlacement varchar (5),
StkRemoval varchar (5),
LoadEquipQty1 decimal (13, 3),
LoadEquipQty2 decimal (13, 3),
LoadEquipQty3 decimal (13, 3),
UntMeasLoadEquipQty1 varchar (5),
UntMeasLoadEquipQty2 varchar (5),
UntMeasLoadEquipQty3 varchar (5),
StorUntTyp1 varchar (5),
StorUntTyp2 varchar (5),
StorUntTyp3 varchar (5),
WMUntMeas varchar (5),
AddExistStk varchar (3),
BulkStorageId varchar (4),
MessageToIM varchar (3),
SpecialMvmt varchar (3),
CapUse decimal (11, 3),
CapConsUnit varchar (5),
PickStorTyp varchar (5),
ProposedUoMMat varchar (3),
[2StepPicking] varchar (3)
PRIMARY KEY (Client, Material, WarehouseNbr));