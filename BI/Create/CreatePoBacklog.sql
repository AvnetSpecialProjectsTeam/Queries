USE BI
GO
--ALTER TABLE bi.dbo.BIPoBacklog SET (SYSTEM_VERSIONING = OFF)

----(HISTORY_TABLE= dbo.BiPoBacklogHistory));

--DROP TABLE BIPoBacklog
--DROP TABLE BiPoBacklogHistory

CREATE TABLE Bi.dbo.BIPoBacklog 
(
    PoNbr BIGINT NOT NULL
    ,PoLine INT NOT NULL
    ,PoSchedLine INT NOT NULL
    ,MaterialNbr BIGINT NOT NULL
    ,Plant INT
    ,StorLoc VARCHAR(4)
    ,PurchOrg VARCHAR(4)
	,Mfg CHAR(3)
    ,ProdHrchy VARCHAR(15)
    ,RefDocNbr VARCHAR(50)
    ,PoSchedConfCd VARCHAR(4)
    ,PoItemCd VARCHAR(4)
    ,OrderDt DATE
    ,SchedLineDeliveryDt DATE
    ,ConfDlvryDt DATE
    ,SchedQty BIGINT
	,SchedLineValue MONEY
	,PoOpenQty BIGINT
    ,PoRemainingValue MONEY
	,DocType VARCHAR(5)
	,PoTypeDesc VARCHAR(15)
	,GenericPoType VARCHAR(15)
	,Age INT
	,AgeBucket VARCHAR(11)
	,SqlStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
    ,SqlEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
	,PERIOD FOR SYSTEM_TIME (SqlStartTime, SqlEndTime),
	CONSTRAINT PkBiPoBacklog PRIMARY KEY(PoNbr,PoLine,PoSchedLine)
)

WITH
	(
		SYSTEM_VERSIONING = ON (HISTORY_TABLE= dbo.BiPoBacklogHistory)
	)
;

