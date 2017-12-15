USE BI
GO
--ALTER TABLE BiImportPoReciepts SET (SYSTEM_VERSIONING = OFF (HISTORY_TABLE= BiImportPoRecieptsHistory));
GO
DROP TABLE BiImportPoReciepts
DROP TABLE BiImportPoRecieptsHistory

CREATE TABLE BiImportPoReciepts 
(
    PoNbr BIGINT NOT NULL
    ,PoLine INT NOT NULL
    ,PoSchedLine INT NOT NULL
    ,MaterialNbr BIGINT NOT NULL
    ,Plant INT
	,StocLoc VARCHAR(4)
    ,PurchOrg VARCHAR(4)
	,Mfg CHAR(3)
    ,ProdHrchy VARCHAR(15)
	,ShipInstructions VARCHAR(3)
	,GrPostDt DATE
	,RcvNbrContainers INT
	,ReqDlvryDt DATE
	,PoRcvCost MONEY
	,RecievedQty BIGINT
	,OpenQty BIGINT
	,SO BIGINT
	,PoType VARCHAR(4)
	,PoConfDt DATE
	,Batch VARCHAR(15)
	,GrQty BIGINT
	,GrInd CHAR(1)
	,DlvryInd CHAR(1)
	,SqlStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
    ,SqlEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
	,PERIOD FOR SYSTEM_TIME (SqlStartTime, SqlEndTime),
	CONSTRAINT PkBiPoReciepts PRIMARY KEY(PoNbr,PoLine,PoSchedLine)
)

WITH
	(
		SYSTEM_VERSIONING = ON (HISTORY_TABLE= dbo.BiImportPoRecieptsHistory)
	)
;
