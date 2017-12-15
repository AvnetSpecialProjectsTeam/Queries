USE SAP
GO
--ALTER TABLE PurchOrdItem SET (SYSTEM_VERSIONING = OFF) 
----(HISTORY_TABLE= dbo.PurchOrdItemHistory));


--DROP TABLE PurchOrdItem
--DROP TABLE PurchOrdItemHistory

CREATE TABLE PurchOrdItem
	( 
	PoNbr Bigint
,PoLine Int
,AvnetResalePriceAm Int
,ClosureTx Varchar(500)
,CostAm Decimal(15,3)
,DateCd Varchar(10)
,DeliveryTx Varchar(500)
,ExternalNoteTx Varchar(500)
,ExternalTx Varchar(500)
,GoodsReceiptProcessDayQt Int
,GovernmentContractNo VARCHAR(30)
,GovernmentPriorityRatingCd Varchar(10)
,ItemQt Decimal(15,3)
,LotCd Varchar(10)
,ManufacturerPartNo Varchar(50)
,PriceUnitQt Int
,RegistrationId Varchar(20)
,RequestedDeliveryDt Datetime2
,SalesOrderItemNo Int
,SalesOrderNo Int
,SapCarrierServiceLevelCd Varchar(10)
,SapMaterialId BIGINT
,SapPlantCd Varchar(10)
,SapPlantStorageLocCd Varchar(10)
,SapPurchDocItemCatgCd Varchar(10)
,ShipToNm Varchar(20)
,SpecialBuyCustomerNm Varchar(20)
,UnitCostAm Int
,VendorPartNo VARCHAR(35)
,VendorPriceAuthCd Varchar
,ApplCreateDt Datetime2
,ApplUpdateDt Datetime2
,ApplActiveFromDt Datetime2
,ApplActiveThruDt Datetime2
,GrQt Decimal(15,3)
,GiQt Decimal(15,3)
,OpenQt Decimal(15,3)
,CommittedDt Datetime2
,CommittedQt Decimal(15,3)
	,SqlStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
    ,SqlEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
	,PERIOD FOR SYSTEM_TIME (SqlStartTime, SqlEndTime)
	,CONSTRAINT PkPurchOrdItem PRIMARY KEY(PoNbr,PoLine)
)

WITH
	(
		SYSTEM_VERSIONING = ON (HISTORY_TABLE= dbo.PurchOrdItemHistory)
	)
;