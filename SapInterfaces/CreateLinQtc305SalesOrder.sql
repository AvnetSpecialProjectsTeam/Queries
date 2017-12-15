USE Interfaces
GO

/****** Object:  Table [dbo].[LinQtc305SalesOrder]    Script Date: 11/2/2017 2:45:59 PM ******/
ALTER TABLE [dbo].[LinQtc305SalesOrder] SET ( SYSTEM_VERSIONING = OFF  )
GO

/****** Object:  Table [dbo].[LinQtc305SalesOrder]    Script Date: 11/2/2017 2:45:59 PM ******/
DROP TABLE [dbo].[LinQtc305SalesOrder]
GO

/****** Object:  Table [dbo].[LinQtc305SalesOrderHistory]    Script Date: 11/2/2017 2:45:59 PM ******/
DROP TABLE [dbo].[LinQtc305SalesOrderHistory]
GO

/****** Object:  Table [dbo].[LinQtc305SalesOrderHistory]    Script Date: 11/2/2017 2:45:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LinQtc305SalesOrderHistory](
	[SalesOrderId] [bigint] NOT NULL,
	[CreateDt] [datetime2](7) NOT NULL,
	[CreateUserId] [varchar](30) NOT NULL,
	[DocInstanceId] [varchar](60) NULL,
	[JvmThreadId] [varchar](40) NULL,
	[PurchaseOrderRefNbr] [varchar](50) NULL,
	[SalesOrderErrorDs] [varchar](50) NULL,
	[SalesOrderErrorId] [int] NULL,
	[SapSalesOrderNbr] [bigint] NULL,
	[SapSalesOrderStatusCd] [varchar](1) NULL,
	[ApplCreateDt] [datetime2](7) NOT NULL,
	[ApplUpdateDt] [datetime2](7) NOT NULL,
	[ApplyActiveFromDt] [datetime2](7) NOT NULL,
	[ApplActiveThruDt] [datetime2](7) NOT NULL,
	[SapSalesDocTypeCd] [varchar](4) NULL,
	[SqlStartTime] [datetime2](7) NOT NULL,
	[SqlEndTime] [datetime2](7) NOT NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[LinQtc305SalesOrder]    Script Date: 11/2/2017 2:45:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LinQtc305SalesOrder](
	[SalesOrderId] [bigint] NOT NULL,
	[CreateDt] [datetime2](7) NOT NULL,
	[CreateUserId] [varchar](30) NOT NULL,
	[DocInstanceId] [varchar](60) NULL,
	[JvmThreadId] [varchar](40) NULL,
	[PurchaseOrderRefNbr] [varchar](50) NULL,
	[SalesOrderErrorDs] [varchar](50) NULL,
	[SalesOrderErrorId] [int] NULL,
	[SapSalesOrderNbr] [bigint] NULL,
	[SapSalesOrderStatusCd] [varchar](1) NULL,
	[ApplCreateDt] [datetime2](7) NOT NULL,
	[ApplUpdateDt] [datetime2](7) NOT NULL,
	[ApplyActiveFromDt] [datetime2](7) NOT NULL,
	[ApplActiveThruDt] [datetime2](7) NOT NULL,
	[SapSalesDocTypeCd] [varchar](4) NULL,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PkLinQtc305SalesOrder] PRIMARY KEY CLUSTERED 
(
	[SalesOrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[LinQtc305SalesOrderHistory] )
)

GO


