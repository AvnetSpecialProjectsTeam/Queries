USE BI
GO
ALTER TABLE SoBacklog SET (SYSTEM_VERSIONING = OFF)

--ALTER TABLE SoBacklogHistory
--ALTER COLUMN [OutsideSalesRep] VARCHAR(10)


--(HISTORY_TABLE= dbo.SoBacklogHistory));

--DROP TABLE SoBacklog
--DROP TABLE SoBacklogHistory

CREATE TABLE SoBacklog(
    [VersionDt] DATETIME2
    ,[LogDt] DATETIME2
    ,[LogTime] TIME
    ,[SalesDocNbr] BIGINT
    ,[SalesDocItemNbr] INT
    ,[SoSchedLine] INT
	,[PlantId] INT
	,[MaterialNbr] BIGINT
    ,[MfgPartNbr] VARCHAR(50)
	,[FyMthNbr] INT
    ,[OutsideSalesRep] INT
    ,[InsideSalesRep] VARCHAR(50)
    ,[SoldToPartyId]INT
    ,[SoldToParty] VARCHAR(50)
    ,[SalesDocItCreateDt] DATETIME2
    ,[CustomerPoNbr] VARCHAR(50)
    ,[CustomerPartNbr] VARCHAR(50)
    ,[MaterialTxt] VARCHAR(50)
    ,[Grp] VARCHAR(3)
    ,[Pbg] VARCHAR(3)
    ,[Cc] VARCHAR(3)
    ,[Mfg] VARCHAR(3)
    ,[PrcStgy] VARCHAR(3)
    ,[Tech] VARCHAR(3)
    ,[BillingBlock] VARCHAR(3)
    ,[PricingBlock] VARCHAR(3)
    ,[ShipAndDebitBlock] VARCHAR(3)
    ,[CreditBlock] VARCHAR(3)
    ,[DlvryBlock] VARCHAR(3)
    ,[ProgrammingBlock] VARCHAR(50)
    ,[CustReqDockDt] DATETIME2
    ,[LastConfPromDt] DATETIME2
    ,[DlvryDt] DATETIME2
    ,[OrginPromDt] DATETIME2
    ,[AtpDt] DATETIME2
    ,[OrderQty] BIGINT
    ,[RemainingQty] BIGINT
    ,[UnitPrice] MONEY
    ,[ExtResale] MONEY
    ,[TtlOrderValue] MONEY
    ,[MrpCntrl] VARCHAR(3)
    ,[Abc] VARCHAR(3)
    ,[StockProfile] VARCHAR(2)
    ,[OrderReason] VARCHAR(4)
    ,[BufferType] VARCHAR(50)
    ,[PlantSpecificMatl] VARCHAR(2)
    ,[SalesDocType] VARCHAR(5)
    ,[ResaleSource] VARCHAR(5)
    ,[PurGrp] VARCHAR(3)
    ,[BlockedOrders] BIGINT
    ,[SalesOrg] VARCHAR(5)
    ,[SalesOffice] INT
    ,[SalesGrp] INT
    ,[MatBaseUnit] VARCHAR(50)
    ,[CondType] VARCHAR(5)
    ,[OverallDlvryStatus] VARCHAR(1)
    ,[ExtCost] MONEY
    ,[MatGpPercent] INT
    ,[DlvryStatus] VARCHAR(1)
	,SqlStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
    ,SqlEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
	,PERIOD FOR SYSTEM_TIME (SqlStartTime, SqlEndTime),
	CONSTRAINT PkSoBacklog PRIMARY KEY([SalesDocNbr],[SalesDocItemNbr],[SoSchedLine])
)

WITH
	(
		SYSTEM_VERSIONING = ON (HISTORY_TABLE= dbo.SoBacklogHistory)
	)
;