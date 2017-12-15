USE [SAP]
GO

DROP TABLE Enia

CREATE TABLE [dbo].[Eina](
Client varchar (4),
InfoRecOrderNbr decimal (10),
Material decimal (18),
MatGrp varchar (10),
Vendor varchar (10),
PurOrgData varchar (2),
CreateDt datetime2,
CreatePerson varchar (13),
PurchaseInfoRec varchar (41),
SortTerm varchar (11),
UnitOfMeasure varchar (4),
NumOrderToBase int,
DenomOrderToBase int,
VendMatNbr varchar (50),
SalesRepResp varchar (31),
EndTeleNbr varchar (16),
[1stRemExped] int,
[2ndRemExped] int,
[3rdRemExped] int,
CertNbr decimal (10),
OriginValidTo datetime2,
CtryOfOrigin varchar (8),
CertCat varchar (2),
Nbr varchar (16),
BaseUnit varchar (4),
Region varchar (4),
VarOrderUnitItm varchar (2),
VendorSubrange varchar (7),
VsrSortNbr varchar (10),
VendorMatGrp varchar (19),
ReturnAgmt varchar (3),
AvailFrom datetime2,
AvailTo datetime2,
PriorVendor varchar (11),
NbrPoints decimal (13, 3),
PointsUnItm int,
RegularVendor varchar (2),
Mfg varchar (11)
) 

GO


