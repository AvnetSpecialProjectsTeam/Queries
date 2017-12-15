USE SAP 
GO


Drop Table Eord



CREATE TABLE Eord 
(
Client varchar (4),
Material bigint,
Plant int,
NbrSrcList int,
CreateDt datetime2,
CreatedBy varchar (13),
ValidFrom datetime2,
ValidTo datetime2,
Vendor varchar (10),
FixedVendorId varchar (2),
PurchDocNbr bigint,
PurchDocItmNbr int,
FixOutlinePurchAgreeItm varchar (2),
MatPlant int,
IssuingPlant int,
MfgPartNbr bigint,
Blocked varchar (2),
PurchOrg varchar (5),
PurchDocCat varchar (2),
SourceListRecCat varchar (2),
SourceListMatPlan varchar (2),
UnitOfMeasure varchar (4),
LogicalSys varchar (11),
SpecialStk varchar (2),
CentralContract varchar (11),
CentralContractItm bigint

);