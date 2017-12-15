USE Interfaces
GO

/****** Object:  Table [dbo].[LinQtc305SalesOrderLine]    Script Date: 11/2/2017 2:46:28 PM ******/
ALTER TABLE [dbo].[LinQtc305SalesOrderLine] SET ( SYSTEM_VERSIONING = OFF  )
GO

/****** Object:  Table [dbo].[LinQtc305SalesOrderLine]    Script Date: 11/2/2017 2:46:28 PM ******/
DROP TABLE [dbo].[LinQtc305SalesOrderLine]
GO

/****** Object:  Table [dbo].[LinQtc305SalesOrderLineHistory]    Script Date: 11/2/2017 2:46:28 PM ******/
DROP TABLE [dbo].[LinQtc305SalesOrderLineHistory]
GO

/****** Object:  Table [dbo].[LinQtc305SalesOrderLineHistory]    Script Date: 11/2/2017 2:46:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LinQtc305SalesOrderLineHistory](
	[SalesOrderId] [bigint] NOT NULL,
	[SalesOrderLineNbr] [int] NOT NULL,
	[ActiveFlag] [varchar](1) NULL,
	[CreateUserId] [varchar](30) NULL,
	[PurchaseOrderId] [int] NOT NULL,
	[PurchaseOrderLineNbr] [int] NOT NULL,
	[QuoteId] [int] NOT NULL,
	[QuoteLineNbr] [int] NOT NULL,
	[SalesOrderErrorId] [int] NULL,
	[SalesOrderLinkCd] [varchar](1) NULL,
	[SapSalesOrderLineNbr] [int] NULL,
	[SapSalesOrderNbr] [bigint] NULL,
	[SapSalesOrderStatusCd] [varchar](1) NULL,
	[ApplCreateDt] [datetime2](7) NOT NULL,
	[ApplUpdateDt] [datetime2](7) NOT NULL,
	[ApplyActiveFromDt] [datetime2](7) NOT NULL,
	[ApplActiveThruDt] [datetime2](7) NOT NULL,
	[DocumentInstanceId] [varchar](60) NULL,
	[SqlStartTime] [datetime2](7) NOT NULL,
	[SqlEndTime] [datetime2](7) NOT NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[LinQtc305SalesOrderLine]    Script Date: 11/2/2017 2:46:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LinQtc305SalesOrderLine](
	[SalesOrderId] [bigint] NOT NULL,
	[SalesOrderLineNbr] [int] NOT NULL,
	[ActiveFlag] [varchar](1) NULL,
	[CreateUserId] [varchar](30) NULL,
	[PurchaseOrderId] [int] NOT NULL,
	[PurchaseOrderLineNbr] [int] NOT NULL,
	[QuoteId] [int] NOT NULL,
	[QuoteLineNbr] [int] NOT NULL,
	[SalesOrderErrorId] [int] NULL,
	[SalesOrderLinkCd] [varchar](1) NULL,
	[SapSalesOrderLineNbr] [int] NULL,
	[SapSalesOrderNbr] [bigint] NULL,
	[SapSalesOrderStatusCd] [varchar](1) NULL,
	[ApplCreateDt] [datetime2](7) NOT NULL,
	[ApplUpdateDt] [datetime2](7) NOT NULL,
	[ApplyActiveFromDt] [datetime2](7) NOT NULL,
	[ApplActiveThruDt] [datetime2](7) NOT NULL,
	[DocumentInstanceId] [varchar](60) NULL,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PK_LinQtc305SalesOrderLine] PRIMARY KEY CLUSTERED 
(
	[SalesOrderId] ASC,
	[SalesOrderLineNbr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[LinQtc305SalesOrderLineHistory] )
)

GO


