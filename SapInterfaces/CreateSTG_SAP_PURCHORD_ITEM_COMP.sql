USE SAP
GO
--ALTER TABLE PurchOrdItemComp SET (SYSTEM_VERSIONING = OFF)
----(HISTORY_TABLE= dbo.PurchOrdItemCompHistory));


--DROP TABLE PurchOrdItemComp
--DROP TABLE PurchOrdItemCompHistory

CREATE TABLE PurchOrdItemComp
	( 
	PoNbr Bigint
,PoLine Int
,PoCmpIdLine BIGINT
,ComponentQt Int
,ApplCreateDt Datetime2
,ApplUpdateDt Datetime2
,ApplActiveFromDt Datetime2
,ApplActiveThruDt Datetime2
	,SqlStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
    ,SqlEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
	,PERIOD FOR SYSTEM_TIME (SqlStartTime, SqlEndTime)
	,CONSTRAINT PkPurchOrdItemComp PRIMARY KEY(PoNbr,PoLine,PoCmpIdLine)
)

WITH
	(
		SYSTEM_VERSIONING = ON (HISTORY_TABLE= dbo.PurchOrdItemCompHistory)
	)
;