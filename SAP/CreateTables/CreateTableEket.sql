--ALTER TABLE SAP.dbo.Eket SET (SYSTEM_VERSIONING = OFF)
---- --(HISTORY_TABLE= dbo.EketHistory));

--DROP TABLE SAP.dbo.Eket
--DROP TABLE SAP.dbo.EketHistory


CREATE TABLE sap.dbo.Eket
	(
	Client varchar (4),
	PoNbr bigint,
	PoItmNbr int,
	PoSchedLine int,
	ItmDlvryDt datetime2,
	StatRelDlvryDt datetime2,
	CatDlvryDt varchar (2),
	PoSchedQty decimal (13, 3),
	PrevQty decimal (13, 3),
	QtyGoodRec decimal (13, 3),
	IssuedQty decimal (13, 3),
	DlvryDtTime varchar (7),
	PurchReqNbr BIGINT,
	RequisitionItmNbr int,
	CreateId varchar (2),
	QuotaArrNbr decimal (10),
	QuotaArrItm int,
	NbrRemExpSchedLine int,
	OrderDtSchedLine datetime2,
	ReservationNbr decimal (10),
	BomExplNbr int,
	SchedLineFix varchar (2),
	QtyDlvryd decimal (13, 3),
	QtyReducedMRP decimal (13, 3),
	BatchNbr varchar (10),
	VenBatchNbr varchar (15),
	CompChange varchar (2),
	ProdVersion varchar (5),
	ReleaseTyp varchar (2),
	CommitQty decimal (13, 3),
	CommitDt datetime2,
	PrevDlvryDt datetime2,
	RouteSched varchar (11),
	MatAvailDt datetime2,
	MatStagingTime varchar (7),
	LoadDt datetime2,
	LoadTime varchar (7),
	TranPlanDt datetime2,
	TranPlanTime varchar (7),
	GoodIssueDt datetime2,
	TimeGoodIssue varchar (7),
	GrEndDt datetime2,
	GrEndTime varchar (7),
	BudgetNbr decimal (16),
	ReqBudget money,
	OTBCurr varchar (6),
	ReservedBudget money,
	SpecialRelease money,
	OTBReasonProfile varchar (5),
	BudgetTyp varchar (3),
	OTBStatus varchar (2),
	ReasonOTBStatus varchar (4),
	TypOTBCheck varchar (2),
	DtLineId varchar (23),
	TransDt datetime2,
	PurcOrdTranSCEM varchar (2),
	ReminderDt datetime2,
	ReminderTime varchar (7),
	CancelThreatMade varchar (2),
	NbrCurrDtShift int,
	NbrSerNbr int,
	ResPurcReqCreate varchar (2),
	Georoute varchar (11),
	GTSRouteCode varchar (11),
	GoodTrafficTyp varchar (3),
	FwdAgent varchar (11),
	APOLocNbr decimal (20),
	APOLocTyp varchar (5),
	HanDtHanLoc datetime2,
	HanTimeHanLoc varchar (7)
	,SqlStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
    ,SqlEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
	,PERIOD FOR SYSTEM_TIME (SqlStartTime, SqlEndTime),
	CONSTRAINT PkEket PRIMARY KEY(PoNbr, PoItmNbr ,PoSchedLine)
)

WITH
	(
		SYSTEM_VERSIONING = ON (HISTORY_TABLE= dbo.EketHistory)
	)
;