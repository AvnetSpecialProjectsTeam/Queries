USE SAP 
GO 


Drop Table Konh

Create Table Konh 
(
Client varchar (3),
CondRecNbr varchar (10),
CreatorName varchar (12),
CreateDt datetime2,
CondTblUsage varchar (1),
CondTbl varchar (3),
[Application] varchar (10),
CondType varchar (4),
VarKey varchar (100),
ValidFrom datetime2,
ValidTo datetime2,
CondSearchTerm varchar (10),
SdResponsibility varchar (8),
Promo varchar (10),
SalesDeal varchar (10),
SalesQuote varchar (10),
StandardAgree varchar (10),
Promo2 varchar (10),
Agreement varchar (10),
TaxExemptLicenseNbr varchar (20),
LicenseDt datetime2,
VariableData varchar (100),
)