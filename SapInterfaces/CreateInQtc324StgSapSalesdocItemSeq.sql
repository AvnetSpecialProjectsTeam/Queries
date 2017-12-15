USE Interfaces
GO

/****** Object:  Table [dbo].[InQtc324StgSapSalesdocItemSeq]    Script Date: 11/2/2017 2:35:06 PM ******/
ALTER TABLE [dbo].[InQtc324StgSapSalesdocItemSeq] SET ( SYSTEM_VERSIONING = OFF  )
GO

/****** Object:  Table [dbo].[InQtc324StgSapSalesdocItemSeq]    Script Date: 11/2/2017 2:35:06 PM ******/
DROP TABLE [dbo].[InQtc324StgSapSalesdocItemSeq]
GO

/****** Object:  Table [dbo].[InQtc324StgSapSalesdocItemSeqHistory]    Script Date: 11/2/2017 2:35:06 PM ******/
DROP TABLE [dbo].[InQtc324StgSapSalesdocItemSeqHistory]
GO

/****** Object:  Table [dbo].[InQtc324StgSapSalesdocItemSeqHistory]    Script Date: 11/2/2017 2:35:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[InQtc324StgSapSalesdocItemSeqHistory](
	[SalesDoc] [bigint] NOT NULL,
	[SalesDocLineNbr] [int] NOT NULL,
	[Zseqno] [int] NOT NULL,
	[Zdocno] [bigint] NOT NULL,
	[Zcarrname] [varchar](40) NULL,
	[Zshpdate] [datetime2](7) NULL,
	[ZtfinWblTrackZwaybill] [varchar](30) NULL,
	[Zweight] [decimal](13, 2) NULL,
	[Zfreight] [decimal](13, 2) NULL,
	[ShipDt] [datetime2](7) NULL,
	[ShipQty] [decimal](13, 2) NULL,
	[DeliveryItem] [int] NULL,
	[OrigInsertDt] [datetime2](7) NULL,
	[SqlStartTime] [datetime2](7) NOT NULL,
	[SqlEndTime] [datetime2](7) NOT NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[InQtc324StgSapSalesdocItemSeq]    Script Date: 11/2/2017 2:35:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[InQtc324StgSapSalesdocItemSeq](
	[SalesDoc] [bigint] NOT NULL,
	[SalesDocLineNbr] [int] NOT NULL,
	[Zseqno] [int] NOT NULL,
	[Zdocno] [bigint] NOT NULL,
	[Zcarrname] [varchar](40) NULL,
	[Zshpdate] [datetime2](7) NULL,
	[ZtfinWblTrackZwaybill] [varchar](30) NULL,
	[Zweight] [decimal](13, 2) NULL,
	[Zfreight] [decimal](13, 2) NULL,
	[ShipDt] [datetime2](7) NULL,
	[ShipQty] [decimal](13, 2) NULL,
	[DeliveryItem] [int] NULL,
	[OrigInsertDt] [datetime2](7) NULL,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PkInQtc324StgSapSalesdocItemSeq] PRIMARY KEY CLUSTERED 
(
	[SalesDoc] ASC,
	[SalesDocLineNbr] ASC,
	[Zdocno] ASC,
	[Zseqno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[InQtc324StgSapSalesdocItemSeqHistory] )
)

GO


