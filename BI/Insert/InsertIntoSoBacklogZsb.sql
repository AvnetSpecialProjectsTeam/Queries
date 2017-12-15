USE BI
GO


UPDATE ImportZsbBacklog
	SET order_qty=
					CASE
						WHEN order_qty NOT LIKE '%[a-z]%'THEN LEFT(order_qty, LEN(order_qty)-3)
						ELSE order_qty
					END
		,[remaining_qty]=LEFT([remaining_qty], LEN([remaining_qty])-3)
		,blocked_orders=LEFT(blocked_orders, LEN(blocked_orders)-4)
GO



MERGE SoBacklog AS TargetTbl
USING ImportZsbBacklog AS SourceTbl
ON (TargetTbl.[SalesDocNbr]=SourceTbl.[sales_doc_nbr] AND TargetTbl.[SalesDocItemNbr]=SourceTbl.[sales_doc_item_nbr] AND TargetTbl.[SoSchedLine]=SourceTbl.[sched_line])
WHEN MATCHED 
	AND TargetTbl.[SalesDocType]=SourceTbl.[Sales_Doc_Type]
	AND TargetTbl.[CustReqDockDt] <> SourceTbl.[Cust_Req_Dock_Dt]
	OR TargetTbl.[AtpDt] <> SourceTbl.[Atp_Dt]
	OR TargetTbl.[LastConfPromDt] <> SourceTbl.[Last_Conf_Prom_Dt]
	OR TargetTbl.[RemainingQty] <> SourceTbl.[Remaining_Qty]
	OR TargetTbl.[UnitPrice] <> CAST(SourceTbl.[Unit_Price] AS FLOAT)
	OR TargetTbl.[BlockedOrders] <> SourceTbl.[Blocked_Orders]
	OR TargetTbl.[OverallDlvryStatus] <> SourceTbl.[Overall_Dlvry_Status]
	OR TargetTbl.[DlvryStatus] <> SourceTbl.[Dlvry_Status]
	OR TargetTbl.TtlOrderValue <> SourceTbl.Ttl_Order_Value
	OR TargetTbl.ExtResale <> SourceTbl.Ext_Resale
	OR TargetTbl.ExtCost <> SourceTbl.Ext_Cost

THEN
	UPDATE SET
	TargetTbl.[CustReqDockDt] = SourceTbl.[Cust_Req_Dock_Dt]
	,TargetTbl.[AtpDt] = SourceTbl.[Atp_Dt]
	,TargetTbl.[LastConfPromDt] = SourceTbl.[Last_Conf_Prom_Dt]
	,TargetTbl.[RemainingQty] = SourceTbl.[Remaining_Qty]
	,TargetTbl.[UnitPrice] = CAST(SourceTbl.[Unit_Price] AS FLOAT)
	,TargetTbl.[BlockedOrders] = SourceTbl.[Blocked_Orders]
	,TargetTbl.[OverallDlvryStatus] = SourceTbl.[Overall_Dlvry_Status]
	,TargetTbl.[DlvryStatus] = SourceTbl.[Dlvry_Status]
	,TargetTbl.TtlOrderValue = SourceTbl.Ttl_Order_Value
	,TargetTbl.ExtResale = SourceTbl.Ext_Resale
	,TargetTbl.ExtCost = SourceTbl.Ext_Cost

WHEN NOT MATCHED BY TARGET  AND SourceTbl.[Sales_Doc_Type]='ZSB'  THEN
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
VALUES
	(
	[fy_mth_nbr]
      ,[version_dt]
      ,[log_dt]
      ,[log_time]
      ,[outside_sales_rep]
      ,[inside_sales_rep]
      ,[sold_to_party_id]
      ,[sold_to_party]
      ,[sales_doc_it_create_dt]
      ,[sales_doc_nbr]
      ,[sales_doc_item_nbr]
      ,[sched_line]
      ,[customer_po_nbr]
      ,[customer_part_nbr]
      ,[material_txt]
      ,[grp]
      ,[PBG]
      ,[CC]
      ,[mfg]
      ,[prc_stgy]
      ,[tech]
      ,[material_nbr]
      ,[mfg_part_nbr]
      ,[plant_id]
      ,[billing_block]
      ,[pricing_block]
      ,[ship_and_debit_block]
      ,[credit_block]
      ,[dlvry_block]
      ,[programming_block]
      ,[cust_req_dock_dt]
      ,[last_conf_prom_dt]
      ,[dlvry_dt]
      ,[orgin_prom_dt]
      ,[atp_dt]
      ,CAST([order_qty] AS FLOAT)
      ,[remaining_qty]
      ,CAST([unit_price] AS FLOAT)
      ,[ext_resale]
      ,[ttl_order_value]
      ,[mrp_cntrl]
      ,[abc]
      ,[stock_profile]
      ,[order_reason]
      ,[buffer_type]
      ,[plant_specific_matl]
      ,[sales_doc_type]
      ,[resale_source]
      ,[pur_grp]
      ,[blocked_orders]
      ,[sales_org]
      ,[sales_office]
      ,[sales_grp]
      ,[mat_base_unit]
      ,[cond_type]
      ,[overall_dlvry_status]
      ,[ext_cost]
      ,[mat_gp%]
      ,[dlvry_status]
	  )
WHEN NOT MATCHED BY SOURCE AND TargetTbl.[SalesDocType]='ZSB' THEN
DELETE;

TRUNCATE TABLE ImportZsbBacklog