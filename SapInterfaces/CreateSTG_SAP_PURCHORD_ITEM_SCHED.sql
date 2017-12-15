USE SAP
GO
--ALTER TABLE PurchOrdItemSched SET (SYSTEM_VERSIONING = OFF)
-- --(HISTORY_TABLE= dbo.PurchOrdItemSchedHistory));


--DROP TABLE PurchOrdItemSched
--DROP TABLE PurchOrdItemSchedHistory

CREATE TABLE PurchOrdItemSched
	( 
PoNbr Bigint
,PoLine Int
,PoSchedLine Int
,DeliveryDt Datetime2
,ScheduleDt Datetime2
,ScheduleQt Decimal(15,3)
,ApplCreateDt Datetime2
,ApplUpdateDt Datetime2
,ApplActiveFromDt Datetime2
,ApplActiveThruDt Datetime2
,GoodsReceiptProcessDayQt Int
,ItemQt Decimal(15,3)
,GrQt Decimal(15,3)
,GiQt Decimal(15,3)
,OpenQt Decimal(15,3)
	,SqlStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
    ,SqlEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
	,PERIOD FOR SYSTEM_TIME (SqlStartTime, SqlEndTime)
	,CONSTRAINT PkPurchOrdItemSched PRIMARY KEY(PoNbr, PoLine, PoSchedLine)
)

WITH
	(
		SYSTEM_VERSIONING = ON (HISTORY_TABLE= dbo.PurchOrdItemSchedHistory)
	)
;