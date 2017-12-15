USE SAP
GO

ALTER TABLE MRPLIst SET (SYSTEM_VERSIONING = OFF)
 --(HISTORY_TABLE= dbo.MRPLIstHistory));

DROP TABLE MRPLIst
DROP TABLE MRPLIstHistory


Create Table MrpList(
Client varchar (3),
MrpDt DATE,
Material BIGINT,
Plant INT,
MrpInd varchar (2),
ReqDt DATE,
MrpNbr BIGINT NOT NULL,
MrpItm int NOT NULL,
SchedItm int NOT NULL,
ExceptnNbr varchar (2),
ExceptnKey varchar (2),
ReschedDt DATE,
ConfDlvryDt DATE,
SchDlvryDt DATE,
NetValue decimal (13, 2),
PlndOrdr varchar (1),
FirmPlndOrder varchar (1),
PurchReq varchar (1),
ProdOrder varchar (1),
PullIn varchar (1),
Expedite varchar (1),
InsidePush varchar (1),
InsideCancel varchar (1),
ByndPush varchar (1),
ByndCancel varchar (1),
StkHigh varchar (1),
MrpCtrlr varchar (3),
PurchGrp varchar (3),
AutoBuy varchar (1),
AvnetAbc varchar (3),
SuppCancelWdw varchar (3),
MfgPartNbr varchar (40),
Mfg varchar (5),
MatStatus varchar (2),
Ncnr varchar (1),
CC varchar (3),
Grp varchar (3),
StkFlag varchar (3),
SpecialBuy varchar (1),
MrpElemntDesc varchar(30)
--,DateKey DATETIME2 NOT NULL
	,SqlStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
    ,SqlEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
	,PERIOD FOR SYSTEM_TIME (SqlStartTime, SqlEndTime),
	CONSTRAINT PkMRPLIst PRIMARY KEY(MrpNbr, MrpItm, SchedItm, Plant)
)

WITH
	(
		SYSTEM_VERSIONING = ON (HISTORY_TABLE= dbo.MRPLIstHistory)
	)
;

