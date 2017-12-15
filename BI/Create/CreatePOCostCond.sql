USE BI
GO

--ALTER TABLE PoCostConditions SET (SYSTEM_VERSIONING = OFF);


DROP TABLE BiPoCostConditions
--DROP TABLE BiPoCostConditionHistory

CREATE TABLE BiPoCostConditions
	(
	PONbr BIGINT,
	PoLineNbr INT,
	CostCond VARCHAR(4),
	CostCondVal MONEY,
	Curr VARCHAR (3)
	,SqlStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
    ,SqlEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
	,PERIOD FOR SYSTEM_TIME (SqlStartTime, SqlEndTime),
	CONSTRAINT PkBiPoCostCondition PRIMARY KEY(PONbr, PoLineNbr, CostCond)
)

WITH
	(
		SYSTEM_VERSIONING = ON (HISTORY_TABLE= dbo.BiPoCostConditionHistory)
	)
;
