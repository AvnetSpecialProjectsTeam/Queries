USE SAP
GO
--ALTER TABLE PurchOrdItemConf SET (SYSTEM_VERSIONING = OFF (HISTORY_TABLE= dbo.PurchOrdItemConfHistory));


--DROP TABLE PurchOrdItemConf
--DROP TABLE PurchOrdItemConfHistory

CREATE TABLE PurchOrdItemConf
	( 
	PoNbr Bigint
,PoLine Int
,PoCnfLine Int
,ConfirmationQt Decimal(15,3)
,DeliveryDt Datetime2
,ReducedQt Decimal(15,3)
,SapConfirmationCategoryCd Varchar(10)
,ApplCreateDt Datetime2
,ApplUpdateDt Datetime2
,ApplActiveFromDt Datetime2
,ApplActiveThruDt Datetime2
,NetConfirmedQt Decimal(15,3)
	,SqlStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
    ,SqlEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
	,PERIOD FOR SYSTEM_TIME (SqlStartTime, SqlEndTime)
	,CONSTRAINT PkPurchOrdItemConf PRIMARY KEY(PoNbr,PoLine,PoCnfLine
)
)

WITH
	(
		SYSTEM_VERSIONING = ON (HISTORY_TABLE= dbo.PurchOrdItemConfHistory)
	)
;