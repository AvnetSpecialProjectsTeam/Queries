USE SAP
GO

DROP TABLE ZfcUploadLog

CREATE TABLE ZfcUploadLog(
	Client varchar (4),
	FcstParty varchar (11),
	SalesOrg varchar (5),
	DistrChannel varchar (3),
	CustMat varchar (36),
	MatNbr varchar (19),
	Week int,
	FcastReceivedDt varchar (9),
	Time varchar (7),
	FcastErrorId varchar (2),
	FcastReceived decimal (15, 3),
	FcastOverwrite int,
	OrderQty decimal (15, 3),
	CustInv decimal (15, 3),
	QtyInTrans decimal (15, 3),
	ConsignStk decimal (15, 3),
	PackSizeRounding varchar (2),
	DlvryUnit decimal (13, 3),
	PlDlvryTime decimal (4, 1),
	FcastAmendFig decimal (15, 3),
	FcastReprocessStat varchar (2),
	Username varchar (13),
	Date varchar (9),
	UserOrigin varchar (13),
	DlvryQty varchar (2),
	FcastChangeTyp decimal (13, 3)
)