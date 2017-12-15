--CREATE SALES ORDER EOM 


USE [BI]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
DROP TABLE [dbo].[SalesOrderBacklogEom]
GO
CREATE TABLE [dbo].[SalesOrderBacklogEom](
	[EOM] [varchar](50) NULL,
	[key] [varchar](50) NULL,
	[FyMthNbr] [int] NULL,
	[LogDt] [datetime2] NULL,
	[SoldToPartyId] [BigInt] NULL,
	[SalesDocItCreateDt] [datetime2] NULL,
	[SalesDocNbr] [BigInt] NULL,
	[SalesDocItemNbr] [varchar](50) NULL,
	[SchedLine] [varchar](50) NULL,
	[Material] [BigInt] NULL,
	[Pbg] [varchar](50) NULL,
	[Mfg] [varchar](50) NULL,
	[PrcStgy] [varchar](50) NULL,
	[Cc] [varchar](50) NULL,
	[Grp] [varchar](50) NULL,
	[Tech] [varchar](50) NULL,
	[SalesGrp] [varchar](50) NULL,
	[SalesOffice] [varchar](50) NULL,
	[PlantId] [varchar](50) NULL,
	[CustReqDockDt] [datetime2] NULL,
	[LastConfPromDt] [datetime2] NULL,
	[DlvryDt] [datetime2] NULL,
	[AtpDt] [datetime2] NULL,
	[OrderQty] [int] NULL,
	[RemainingQty] [int] NULL,
	[TtlStkValue] [money] NULL,
	[TtlRrderValue] [money] NULL,
	[ExtResale] [money] NULL,
	[UnitPrice] [money] NULL,
	[MrpCntrl] [varchar](50) NULL,
	[Abc] [varchar](50) NULL,
	[StockProfile] [varchar](50) NULL,
	[SalesDocType] [varchar](50) NULL,
	[PricingBlock] [varchar](50) NULL,
	[BlockedOrders] [varchar](50) NULL,
	[CondType] [varchar](50) NULL,
	[ExtCost] [money] NULL,
	[MatGp%] [decimal] NULL,
	[DlvryStatus] [varchar](50) NULL
) ON [PRIMARY]

GO

Insert into [dbo].[SalesOrderBacklogEom](
[EOM]
      ,[key]
      ,[FyMthNbr]
      ,[LogDt]
      ,[SoldToPartyId]
      ,[SalesDocItCreateDt]
      ,[SalesDocNbr]
      ,[SalesDocItemNbr]
      ,[SchedLine]
      ,[Material]
      ,[Pbg]
      ,[Mfg]
      ,[PrcStgy]
      ,[Cc]
      ,[Grp]
      ,[Tech]
      ,[SalesGrp]
      ,[SalesOffice]
      ,[PlantId]
      ,[CustReqDockDt]
      ,[LastConfPromDt]
      ,[DlvryDt]
      ,[AtpDt]
      ,[OrderQty]
      ,[RemainingQty]
      ,[TtlStkValue]
      ,[TtlRrderValue]
      ,[ExtResale]
      ,[UnitPrice]
      ,[MrpCntrl]
      ,[Abc]
      ,[StockProfile]
      ,[SalesDocType]
	  ,[PricingBlock]
      ,[BlockedOrders]
      ,[CondType]
      ,[ExtCost]
      ,[MatGp%]
      ,[DlvryStatus])





SELECT DISTINCT 
[EOM]
      ,[key]
      ,[fy_mth_nbr]
      ,[log_dt]
      ,[sold_to_party_id]
      ,[sales_doc_it_create_dt]
      ,[sales_doc_nbr]
      ,[sales_doc_item_nbr]
      ,[sched_line]
      ,[material_nbr]
      ,[pbg]
      ,[mfg]
      ,[prc_stgy]
      ,[cc]
      ,[grp]
      ,[tech]
      ,[sales_grp]
      ,[sales_office]
      ,[plant_id]
      ,[cust_req_dock_dt]
      ,[last_conf_prom_dt]
      ,[dlvry_dt]
      ,[atp_dt]
      ,[order_qty]
      ,[remaining_qty]
      ,[ttl_stk_value]
      ,[ttl_order_value]
      ,[ext_resale]
      ,[unit_price]
      ,[mrp_cntrl]
      ,[abc]
      ,[stock_profile]
      ,[sales_doc_type]
      ,[pricing_block]
      ,[blocked_orders]
      ,[cond_type]
      ,[ext_cost]
      ,[mat_gp%]
      ,[dlvry_status]
  FROM [NonHaImportTesting].[dbo].[eom_sales_order_backlog_snapshot]