USE CentralDbs
GO
ALTER TABLE PoBacklog SET (SYSTEM_VERSIONING = OFF)
--(HISTORY_TABLE= dbo.PoBacklogHistory));

DROP TABLE PoBacklog
DROP TABLE PoBacklogHistory

CREATE TABLE PoBacklog 
(
    PoNbr BIGINT NOT NULL
    ,PoLine INT NOT NULL
    ,PoSchedLine INT NOT NULL
	,PoConfLine INT
    ,MaterialNbr BIGINT NOT NULL
	,MfgPartNnbr VARCHAR(50)
    ,Plant INT
    ,StorLoc VARCHAR(5)
    ,PurchOrg VARCHAR(5)
	,Mfg VARCHAR(4)
	,PrcStgy VARCHAR(4)
	,Tech VARCHAR(4)
	,CC VARCHAR(4)
	,Grp VARCHAR(4)
    ,RefDocNbr VARCHAR(50)
    ,PoSchedConfCd VARCHAR(4)
    --,PoItemCd VARCHAR(4)
    ,OrderDt DATE
    ,SchedLineDeliveryDt DATE
    ,ConfDlvryDt DATE
    ,SchedQty BIGINT
	,SchedLineValue MONEY
	,SchedOpenQty BIGINT
    ,SchedOpenValue MONEY
	,CostAm MONEY
	,PriceUnitQt BIGINT
	,DocType VARCHAR(5)
	,PoTypeDesc VARCHAR(20)
	,GenericPoType VARCHAR(15)
	,Age INT
	,AgeBucket VARCHAR(11)
	,SqlStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
    ,SqlEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
	,PERIOD FOR SYSTEM_TIME (SqlStartTime, SqlEndTime),
	CONSTRAINT PkPoBacklog PRIMARY KEY(PoNbr,PoLine,PoSchedLine, PoConfLine)
)

WITH
	(
		SYSTEM_VERSIONING = ON (HISTORY_TABLE= dbo.PoBacklogHistory)
	)
;

