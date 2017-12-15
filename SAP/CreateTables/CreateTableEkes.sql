ALTER TABLE SAP.dbo.Ekes SET (SYSTEM_VERSIONING = OFF)
-- --(HISTORY_TABLE= dbo.EkesHistory));

DROP TABLE SAP.dbo.Ekes
DROP TABLE SAP.dbo.EkesHistory

Create Table SAP.dbo.Ekes(
	Client varchar (3),
	PoNbr bigint,
	PoItmNbr int,
	VenConfSeqNbr int,
	ConfCat varchar (3),
	ItmDlvryDt datetime2,
	DlvryDtCat varchar (3),
	DtTime time,
	CreatedOn datetime2,
	VendConfCreateTime time,
	SchedQty decimal (13, 3),
	QtyReduced decimal (13, 3),
	CreationId varchar (3),
	PurOrgData varchar (3),
	MrpRelevant varchar (3),
	RefDocNbr varchar (45),
	SalesDocNbr varchar (10),
	DlvryItm1 int,
	MfgPartProfile varchar (4),
	MatNbrMfgPartNbr varchar (18),
	NbrRemExp decimal (3),
	BatchNbr varchar (10),
	HighLvlItmBatch int,
	SequentialNbr int,
	Plant varchar (3),
	Delivery varchar (10),
	DlvryItm2 int,
	HandoverDt datetime2,
	HandoverTime time
	,SqlStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
	,SqlEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
	,PERIOD FOR SYSTEM_TIME (SqlStartTime, SqlEndTime),
	CONSTRAINT PkEkes PRIMARY KEY(PoNbr, PoItmNbr, VenConfSeqNbr)
	)

WITH
	(
		SYSTEM_VERSIONING = ON (HISTORY_TABLE= dbo.EkesHistory)
	)
;