USE Interfaces
GO

/****** Object:  Table [dbo].[InQtc324StgSapSalesdocHdr]    Script Date: 11/2/2017 2:31:33 PM ******/
ALTER TABLE [dbo].[InQtc324StgSapSalesdocHdr] SET ( SYSTEM_VERSIONING = OFF  )
GO

/****** Object:  Table [dbo].[InQtc324StgSapSalesdocHdr]    Script Date: 11/2/2017 2:31:33 PM ******/
DROP TABLE [dbo].[InQtc324StgSapSalesdocHdr]
GO

/****** Object:  Table [dbo].[InQtc324StgSapSalesdocHdrHistory]    Script Date: 11/2/2017 2:31:33 PM ******/
DROP TABLE [dbo].[InQtc324StgSapSalesdocHdrHistory]
GO

/****** Object:  Table [dbo].[InQtc324StgSapSalesdocHdrHistory]    Script Date: 11/2/2017 2:31:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[InQtc324StgSapSalesdocHdrHistory](
	[SalesDoc] [bigint] NOT NULL,
	[SoldTo] [bigint] NULL,
	[ShipTo] [bigint] NULL,
	[BillTo] [bigint] NULL,
	[Payer] [bigint] NULL,
	[SalesDocType] [varchar](4) NULL,
	[CustomerPo] [varchar](35) NULL,
	[ShipToEndCustPoNbr] [varchar](35) NULL,
	[CustomerPoDt] [datetime2](7) NULL,
	[ColumnOrderType] [varchar](4) NULL,
	[Status] [varchar](25) NULL,
	[SqlStartTime] [datetime2](7) NOT NULL,
	[SqlEndTime] [datetime2](7) NOT NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[InQtc324StgSapSalesdocHdr]    Script Date: 11/2/2017 2:31:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[InQtc324StgSapSalesdocHdr](
	[SalesDoc] [bigint] NOT NULL,
	[SoldTo] [bigint] NULL,
	[ShipTo] [bigint] NULL,
	[BillTo] [bigint] NULL,
	[Payer] [bigint] NULL,
	[SalesDocType] [varchar](4) NULL,
	[CustomerPo] [varchar](35) NULL,
	[ShipToEndCustPoNbr] [varchar](35) NULL,
	[CustomerPoDt] [datetime2](7) NULL,
	[ColumnOrderType] [varchar](4) NULL,
	[Status] [varchar](25) NULL,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PkInQtc324StgSapSalesdocHdr] PRIMARY KEY CLUSTERED 
(
	[SalesDoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[InQtc324StgSapSalesdocHdrHistory] )
)

GO


