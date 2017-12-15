--CREATE TABLE QUERY SalesOrderBacklogZSB



USE [CentralDbs]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE [dbo].[SalesOrderBacklogZSB]

CREATE TABLE [dbo].[SalesOrderBacklogZSB](
	[Key] [nvarchar](255) NULL,
	[FyMthNbr] [int] NULL,
	[VersionDt] [datetime2](7) NULL,
	[LogDt] [datetime2](7) NULL,
	[LogTime] [datetime2](7) NULL,
	[OutsideSalesRep] [nvarchar](255) NULL,
	[InsideSalesRep] [nvarchar](255) NULL,
	[SoldToPartyId] [nvarchar](255) NULL,
	[SoldToParty] [nvarchar](255) NULL,
	[SalesDocItCreateDt] [datetime2](7) NULL,
	[SalesDocNbr] [nvarchar](255) NULL,
	[SalesDocItemNbr] [nvarchar](255) NULL,
	[SchedLine] [nvarchar](255) NULL,
	[CustomerPoNbr] [nvarchar](255) NULL,
	[CustomerPartNbr] [nvarchar](255) NULL,
	[MaterialTxt] [nvarchar](255) NULL,
	[Grp] [nvarchar](255) NULL,
	[Pbg] [nvarchar](255) NULL,
	[CC] [nvarchar](255) NULL,
	[Mfg] [nvarchar](255) NULL,
	[PrcStgy] [nvarchar](255) NULL,
	[Tech] [nvarchar](255) NULL,
	[MaterialNbr] [nvarchar](255) NULL,
	[MfgPartNbr] [nvarchar](255) NULL,
	[PlantId] [nvarchar](255) NULL,
	[BillingBlock] [nvarchar](255) NULL,
	[PricingBlock] [nvarchar](255) NULL,
	[ShipAndDebitBlock] [nvarchar](255) NULL,
	[CreditBlock] [nvarchar](255) NULL,
	[DlvryBlock] [nvarchar](255) NULL,
	[ProgrammingBlock] [nvarchar](255) NULL,
	[CustReqDockDt] [datetime2](7) NULL,
	[ATPDt] [nvarchar](255) NULL,
	[LastConfPromDt] [nvarchar](255) NULL,
	[DlvryDt] [datetime2](7) NULL,
	[OrginPromDt] [datetime2](7) NULL,
	[OrderQty] [int] NULL,
	[RemainingQty] [int] NULL,
	[UnitPrice] [money] NULL,
	[ExtResale] [money] NULL,
	[TtlOrderValue] [int] NULL,
	[MrpCntrl] [nvarchar](255) NULL,
	[Abc] [nvarchar](255) NULL,
	[StockProfile] [nvarchar](255) NULL,
	[OrderReason] [nvarchar](255) NULL,
	[BufferType] [nvarchar](255) NULL,
	[PlantSpecificMatl] [nvarchar](255) NULL,
	[SalesDocType] [nvarchar](255) NULL,
	[ResaleSource] [nvarchar](255) NULL,
	[PurGrp] [nvarchar](255) NULL,
	[BlockedOrders] [nvarchar](255) NULL,
	[SalesOrg] [nvarchar](255) NULL,
	[SalesOffice] [nvarchar](255) NULL,
	[SalesGrp] [nvarchar](255) NULL,
	[MatBaseUnit] [nvarchar](255) NULL,
	[CondType] [nvarchar](255) NULL,
	[ExtCost] [money] NULL,
	[MatGp%] [money] NULL,
	[OverallDlvryStatus] [nvarchar](255) NULL,
	[DlvryStatus] [nvarchar](255) NULL
) ON [PRIMARY]

GO


