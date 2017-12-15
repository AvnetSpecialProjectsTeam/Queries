USE SAP 
GO 



DROP TABLE ZfcCustMatSplit

CREATE TABLE ZfcCustMatSplit(
Client varchar (5),
FcstParty bigint,
SalesOrg varchar (10),
DistrChannel int,
CustMat varchar (51),
Material bigint,
ValidTo datetime2,
ValidFrom datetime2,
AnnualFcstQty decimal (20),
DlvryUnit decimal (20),
BaseUnit varchar (10),
SplitPercent decimal (10),
RiskScore varchar (20),
XPlantStatus varchar (15),
AssetApproval varchar (41),
Abc varchar (5),
Plant int,
ProdHier varchar (20),
Mfg varchar (11),
MfgPartNbr varchar (41),
MrpCntrlr varchar (11),
MatGrp varchar (5),
PSMatStatus varchar (36),
PlanDlvryTime int,
[Value] money,
DocCurr varchar (15),
LiabilityWeeks int,
Liability varchar (5),
PoNbr bigint,
CreatedBy varchar (15),
CreatedOn datetime2,
CreatedAt time,
ChangedBy varchar (15),
ChangedOn datetime2,
ChangedAt time,

)

