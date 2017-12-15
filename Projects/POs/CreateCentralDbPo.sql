USE [CentralDbs]
GO

--ALTER TABLE [PoBacklog] SET (SYSTEM_VERSIONING = OFF)

----(HISTORY_TABLE= dbo.PoBacklogHistory));

--DROP TABLE [PoBacklog]
--DROP TABLE PoBacklogHistory


/****** Object:  Table [dbo].[PoBacklog]    Script Date: 12/4/2017 3:17:20 PM ******/
--DROP TABLE [dbo].[PoBacklog]
GO

/****** Object:  Table [dbo].[PoBacklog]    Script Date: 12/4/2017 3:17:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PoBacklog](
	[PoNbr] [bigint] NOT NULL,
	[PoItmNbr] [int] NOT NULL,
	[PoSchedLine] [int] NOT NULL,
	[Material] [bigint] NULL,
	[Plant] [int] NULL,
	[SupplyingPlant] [int] NULL,
	[PoDt] [date] NULL,
	[ChangeDtOrderMaster] [date] NULL,
	[ChangedOn] [date] NULL,
	[PurReqDocType] [varchar](5) NULL,
	[PurchOrg] [varchar](5) NULL,
	[PurGrp] [varchar](4) NULL,
	[ValidStartDt] [date] NULL,
	[ValidEndDt] [date] NULL,
	[QuoteNbr] VARCHAR(12) NULL,
	[CompanyCd] [varchar](6) NULL,
	[StorLoc] [varchar](6) NULL,
	[NbrPurchInfoRecord] [varchar](12) NULL,
	[VendorMatNbr] [varchar](42) NULL,
	[OrderPriceUnit] [varchar](4) NULL,
	[PoItmCat] [varchar](3) NULL,
	[AcctAssignmentCat] [varchar](3) NULL,
	[GRBasedIV] [varchar](3) NULL,
	[InvoiceReceipt] [varchar](3) NULL,
	[ProfitCenter] BIGINT NULL,
	[PurchReqNbr] [bigint] NULL,
	[RequisitionItmNbr] [int] NULL,
	[MfgPartNbr] [varchar](42) NULL,
	[SupplierSalesOrderNbr] [varchar](17) NULL,
	[ReqDt] [datetime2](7) NULL,
	[EstShipDt] [date] NULL,
	[EstDockDt] [date] NULL,
	[PoQty] [decimal](14, 3) NULL,
	[PoSchedQty] [decimal](13, 3) NULL,
	[QtyGoodRec] [decimal](13, 3) NULL,
	[PoDelId] [varchar](3) NULL,
	[CreatedBy] [varchar](13) NULL,
	[Requisitioner] [varchar](14) NULL,
	[PoNetPrice] [money] NULL,
	[PriceUnit] [decimal](6, 0) NULL,
	[PoGrossOrder] [money] NULL,
	[SequentialNbr] [varchar](6) NULL,
	[StatRelDlvryDt] [date] NULL,
	[OrderDtSchedLine] [date] NULL
	,Pbg CHAR(3) NULL
	,[Mfg] CHAR(3) NULL,
	[PrcStgy] CHAR(3) NULL,
	[Tech] CHAR(3) NULL,
	[CC] CHAR(3) NULL,
	[Grp] CHAR(3) NULL
	,SqlStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
    ,SqlEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
	,PERIOD FOR SYSTEM_TIME (SqlStartTime, SqlEndTime),
	CONSTRAINT PkPobl PRIMARY KEY([PoNbr], [PoItmNbr], [PoSchedLine])
)
WITH
	(
		SYSTEM_VERSIONING = ON (HISTORY_TABLE= dbo.PoBacklogHistory)
	)
;

GO


