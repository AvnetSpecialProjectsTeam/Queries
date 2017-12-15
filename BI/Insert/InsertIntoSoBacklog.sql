USE BI
GO


UPDATE ImportSoBacklog
	SET OrderQty=
					CASE
						WHEN OrderQty NOT LIKE '%[a-z]%'THEN LEFT(OrderQty, LEN(OrderQty)-3)
						ELSE OrderQty
					END
					,RemainingQty=LEFT(RemainingQty, LEN(RemainingQty)-3)
					,BlockedOrders=LEFT(BlockedOrders, LEN(BlockedOrders)-4)
GO

MERGE SoBacklog AS TargetTbl
USING ImportSOBacklog AS SourceTbl
ON (TargetTbl.[SalesDocNbr]=SourceTbl.[salesdocnbr] AND TargetTbl.[SalesDocItemNbr]=SourceTbl.[salesdocitemnbr] AND TargetTbl.[SoSchedLine]=SourceTbl.[schedline])
WHEN MATCHED
	AND TargetTbl.[SalesDocType]=SourceTbl.[SalesDocType]
	AND TargetTbl.[CustReqDockDt] <> SourceTbl.[CustReqDockDt]
	OR TargetTbl.[AtpDt] <> SourceTbl.[AtpDt]
	OR TargetTbl.[LastConfPromDt] <> SourceTbl.[LastConfPromDt]
	OR TargetTbl.[RemainingQty] <> SourceTbl.[RemainingQty]
	OR TargetTbl.[UnitPrice] <> CAST(SourceTbl.[UnitPrice] AS FLOAT)
	OR TargetTbl.[BlockedOrders] <> SourceTbl.[BlockedOrders]
	OR TargetTbl.[OverallDlvryStatus] <> SourceTbl.[OverallDlvryStatus]
	OR TargetTbl.[DlvryStatus] <> SourceTbl.[DlvryStatus]
	OR TargetTbl.TtlOrderValue <> SourceTbl.TtlOrderValue
	OR TargetTbl.ExtResale <> SourceTbl.ExtResale
	OR TargetTbl.ExtCost <> SourceTbl.ExtCost

THEN
	UPDATE SET
	TargetTbl.[CustReqDockDt] = SourceTbl.[CustReqDockDt]
	,TargetTbl.[AtpDt] = SourceTbl.[AtpDt]
	,TargetTbl.[LastConfPromDt] = SourceTbl.[LastConfPromDt]
	,TargetTbl.[RemainingQty] = SourceTbl.[RemainingQty]
	,TargetTbl.[UnitPrice] = CAST(SourceTbl.[UnitPrice] AS FLOAT)
	,TargetTbl.[BlockedOrders] = SourceTbl.[BlockedOrders]
	,TargetTbl.[OverallDlvryStatus] = SourceTbl.[OverallDlvryStatus]
	,TargetTbl.[DlvryStatus] = SourceTbl.[DlvryStatus]
	,TargetTbl.TtlOrderValue = SourceTbl.TtlOrderValue
	,TargetTbl.ExtResale = SourceTbl.ExtResale
	,TargetTbl.ExtCost = SourceTbl.ExtCost

WHEN NOT MATCHED BY TARGET THEN
INSERT(
	[FyMthNbr]
    ,[VersionDt]
    ,[LogDt]
    ,[LogTime]
    ,[OutsideSalesRep]
    ,[InsideSalesRep]
    ,[SoldToPartyId]
    ,[SoldToParty]
    ,[SalesDocItCreateDt]
    ,[SalesDocNbr]
    ,[SalesDocItemNbr]
    ,[SoSchedLine]
    ,[CustomerPoNbr]
    ,[CustomerPartNbr]
    ,[MaterialTxt]
    ,[Grp]
    ,[Pbg]
    ,[Cc]
    ,[Mfg]
    ,[PrcStgy]
    ,[Tech]
    ,[MaterialNbr]
    ,[MfgPartNbr]
    ,[PlantId]
    ,[BillingBlock]
    ,[PricingBlock]
    ,[ShipAndDebitBlock]
    ,[CreditBlock]
    ,[DlvryBlock]
    ,[ProgrammingBlock]
    ,[CustReqDockDt]
    ,[LastConfPromDt]
    ,[DlvryDt]
    ,[OrginPromDt]
    ,[AtpDt]
    ,[OrderQty]
    ,[RemainingQty]
    ,[UnitPrice]
    ,[ExtResale]
    ,[TtlOrderValue]
    ,[MrpCntrl]
    ,[Abc]
    ,[StockProfile]
    ,[OrderReason]
    ,[BufferType]
    ,[PlantSpecificMatl]
    ,[SalesDocType]
    ,[ResaleSource]
    ,[PurGrp]
    ,[BlockedOrders]
    ,[SalesOrg]
    ,[SalesOffice]
    ,[SalesGrp]
    ,[MatBaseUnit]
    ,[CondType]
    ,[OverallDlvryStatus]
    ,[ExtCost]
    ,[MatGpPercent]
    ,[DlvryStatus]

)
VALUES( 
	[FyMthNbr]
    ,[VersionDt]
    ,[LogDt]
    ,[LogTime]
    ,[OutsideSalesRep]
    ,[InsideSalesRep]
    ,[SoldToPartyId]
    ,[SoldToParty]
    ,[SalesDocItCreateDt]
    ,[SalesDocNbr]
    ,[SalesDocItemNbr]
    ,[SchedLine]
    ,[CustomerPoNbr]
    ,[CustomerPartNbr]
    ,[MaterialTxt]
    ,[Grp]
    ,[Pbg]
    ,[Cc]
    ,[Mfg]
    ,[PrcStgy]
    ,[Tech]
    ,[MaterialNbr]
    ,[MfgPartNbr]
    ,[PlantId]
    ,[BillingBlock]
    ,[PricingBlock]
    ,[ShipAndDebitBlock]
    ,[CreditBlock]
    ,[DlvryBlock]
    ,[ProgrammingBlock]
    ,[CustReqDockDt]
    ,[LastConfPromDt]
    ,[DlvryDt]
    ,[OrginPromDt]
    ,[AtpDt]
    ,CAST([OrderQty] AS FLOAT)
    ,[RemainingQty]
    ,CAST([UnitPrice] AS FLOAT)
    ,[ExtResale]
    ,[TtlOrderValue]
    ,[MrpCntrl]
    ,[Abc]
    ,[StockProfile]
    ,[OrderReason]
    ,[BufferType]
    ,[PlantSpecificMatl]
    ,[SalesDocType]
    ,[ResaleSource]
    ,[PurGrp]
    ,[BlockedOrders]
    ,[SalesOrg]
    ,[SalesOffice]
    ,[SalesGrp]
    ,[MatBaseUnit]
    ,[CondType]
    ,[OverallDlvryStatus]
    ,[ExtCost]
    ,[MatGpPercent]
    ,[DlvryStatus]
)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;

TRUNCATE TABLE ImportSoBacklog