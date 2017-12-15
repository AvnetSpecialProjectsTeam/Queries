USE BI
GO
--ALTER TABLE SoBacklog SET (SYSTEM_VERSIONING = OFF)

--(HISTORY_TABLE= dbo.DailyInvHistory));

--DROP TABLE DailyInv

CREATE TABLE DailyInv(
	LogDt DATETIME2
	,LogTime TIME
	,VersionDt DATETIME2
	,MaterialNbr BIGINT
	,Mfg VARCHAR(3)
	,MfgPartNbr VARCHAR(50)
	,MaterialType VARCHAR(5)
	,Pbg VARCHAR(3)
	,PrcStgy VARCHAR(3)
	,TechCd VARCHAR(3)
	,Cc VARCHAR(3)
	,Grp VARCHAR(3)
	,StkPrflPlnt VARCHAR(3)
	,StkPrflSls VARCHAR(5)
	,Abc VARCHAR(3)
	,Plant INT
	,StorageLoc VARCHAR(4)
	,MrpCntrlr VARCHAR(3)
	,DemandMgmtFl Varchar(4)
	,NcnrFl VARCHAR(1)
	,SpecialStk VARCHAR(2)
	,CustAcct INT
	,CustName VARCHAR(50)
	,BatchNbr VARCHAR(3)
	,PurchDocNbr BIGINT
	,CreatedOnDt DATETIME2
	,OrigGoodsRcptDt DATETIME2
	,LastGoodsRcptDt DATETIME2
	,BlockedStk BIGINT
	,AvlStkQty BIGINT
	,TtlStkQty BIGINT
	,TtlStkValue MONEY
	,QitStkQty BIGINT
	,MovingAvgPriceCalc MONEY
	,AgedDays INT
	,ProfitCtr INT
	,ProfitCtrDesc VARCHAR(20)
	,StockType VARCHAR(3)
	,TotalStockValue MONEY
	,SqlStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
    ,SqlEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
	,PERIOD FOR SYSTEM_TIME (SqlStartTime, SqlEndTime));