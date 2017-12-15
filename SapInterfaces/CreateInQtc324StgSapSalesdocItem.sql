USE Interfaces
GO

/****** Object:  Table [dbo].[InQtc324StgSapSalesDocItem]    Script Date: 11/2/2017 2:33:07 PM ******/
ALTER TABLE [dbo].[InQtc324StgSapSalesDocItem] SET ( SYSTEM_VERSIONING = OFF  )
GO

/****** Object:  Table [dbo].[InQtc324StgSapSalesDocItem]    Script Date: 11/2/2017 2:33:07 PM ******/
DROP TABLE [dbo].[InQtc324StgSapSalesDocItem]
GO

/****** Object:  Table [dbo].[InQtc324StgSapSalesDocItemHistory]    Script Date: 11/2/2017 2:33:07 PM ******/
DROP TABLE [dbo].[InQtc324StgSapSalesDocItemHistory]
GO

/****** Object:  Table [dbo].[InQtc324StgSapSalesDocItemHistory]    Script Date: 11/2/2017 2:33:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[InQtc324StgSapSalesDocItemHistory](
	[SalesDoc] [bigint] NOT NULL,
	[SalesDocLineNbr] [int] NOT NULL,
	[SalesDocItemCategory] [varchar](4) NULL,
	[HigherLevelItemInBomStructures] [int] NULL,
	[Plant] [int] NULL,
	[ShipToEndCustPoNbr] [varchar](35) NULL,
	[CustPo] [varchar](35) NULL,
	[ItemNbrOfUnderlyingPo] [varchar](6) NULL,
	[CustPartNbr] [varchar](35) NULL,
	[MaterialNbr] [bigint] NULL,
	[CumulativeOrderQty] [decimal](15, 2) NULL,
	[TargetQtyUnitOfMeasure] [varchar](3) NULL,
	[OverallStatus] [varchar](25) NULL,
	[RejectionStatus] [varchar](25) NULL,
	[MaterialDescription] [varchar](40) NULL,
	[MaraMfrnr] [varchar](10) NULL,
	[Price] [decimal](15, 2) NULL,
	[ZzDatwsta] [datetime2](6) NULL,
	[DeliveryNbr] [bigint] NULL,
	[DeliveryItem] [int] NULL,
	[CarrierName] [varchar](40) NULL,
	[ShipDt] [datetime2](7) NULL,
	[ShipQty] [decimal](13, 2) NULL,
	[CreditBlock] [varchar](1) NULL,
	[Fkart] [varchar](4) NULL,
	[VbapZzRemqty] [decimal](15, 2) NULL,
	[VbapVmeng] [decimal](15, 2) NULL,
	[SqlStartTime] [datetime2](7) NOT NULL,
	[SqlEndTime] [datetime2](7) NOT NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[InQtc324StgSapSalesDocItem]    Script Date: 11/2/2017 2:33:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[InQtc324StgSapSalesDocItem](
	[SalesDoc] [bigint] NOT NULL,
	[SalesDocLineNbr] [int] NOT NULL,
	[SalesDocItemCategory] [varchar](4) NULL,
	[HigherLevelItemInBomStructures] [int] NULL,
	[Plant] [int] NULL,
	[ShipToEndCustPoNbr] [varchar](35) NULL,
	[CustPo] [varchar](35) NULL,
	[ItemNbrOfUnderlyingPo] [varchar](6) NULL,
	[CustPartNbr] [varchar](35) NULL,
	[MaterialNbr] [bigint] NULL,
	[CumulativeOrderQty] [decimal](15, 2) NULL,
	[TargetQtyUnitOfMeasure] [varchar](3) NULL,
	[OverallStatus] [varchar](25) NULL,
	[RejectionStatus] [varchar](25) NULL,
	[MaterialDescription] [varchar](40) NULL,
	[MaraMfrnr] [varchar](10) NULL,
	[Price] [decimal](15, 2) NULL,
	[ZzDatwsta] [datetime2](6) NULL,
	[DeliveryNbr] [bigint] NULL,
	[DeliveryItem] [int] NULL,
	[CarrierName] [varchar](40) NULL,
	[ShipDt] [datetime2](7) NULL,
	[ShipQty] [decimal](13, 2) NULL,
	[CreditBlock] [varchar](1) NULL,
	[Fkart] [varchar](4) NULL,
	[VbapZzRemqty] [decimal](15, 2) NULL,
	[VbapVmeng] [decimal](15, 2) NULL,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PkInQtc324StgSapSalesDocItem] PRIMARY KEY CLUSTERED 
(
	[SalesDoc] ASC,
	[SalesDocLineNbr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[InQtc324StgSapSalesDocItemHistory] )
)

GO


