USE Interfaces
GO

/****** Object:  Table [dbo].[InQtc324StgSapSalesdocSchedLn]    Script Date: 11/2/2017 2:35:54 PM ******/
ALTER TABLE [dbo].[InQtc324StgSapSalesdocSchedLn] SET ( SYSTEM_VERSIONING = OFF  )
GO

/****** Object:  Table [dbo].[InQtc324StgSapSalesdocSchedLn]    Script Date: 11/2/2017 2:35:54 PM ******/
DROP TABLE [dbo].[InQtc324StgSapSalesdocSchedLn]
GO

/****** Object:  Table [dbo].[InQtc324StgSapSalesdocSchedLnHistory]    Script Date: 11/2/2017 2:35:54 PM ******/
DROP TABLE [dbo].[InQtc324StgSapSalesdocSchedLnHistory]
GO

/****** Object:  Table [dbo].[InQtc324StgSapSalesdocSchedLnHistory]    Script Date: 11/2/2017 2:35:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[InQtc324StgSapSalesdocSchedLnHistory](
	[SalesDoc] [bigint] NOT NULL,
	[SalesDocLine] [int] NOT NULL,
	[ScheduleLine] [int] NOT NULL,
	[RequiredDt] [datetime2](7) NULL,
	[ScheduledDt] [datetime2](7) NULL,
	[OrderQty] [decimal](13, 3) NULL,
	[ComfirmedQty] [decimal](13, 3) NULL,
	[SqlStartTime] [datetime2](7) NOT NULL,
	[SqlEndTime] [datetime2](7) NOT NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[InQtc324StgSapSalesdocSchedLn]    Script Date: 11/2/2017 2:35:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[InQtc324StgSapSalesdocSchedLn](
	[SalesDoc] [bigint] NOT NULL,
	[SalesDocLine] [int] NOT NULL,
	[ScheduleLine] [int] NOT NULL,
	[RequiredDt] [datetime2](7) NULL,
	[ScheduledDt] [datetime2](7) NULL,
	[OrderQty] [decimal](13, 3) NULL,
	[ComfirmedQty] [decimal](13, 3) NULL,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PkInQtc324StgSapSalesdocSchedLn] PRIMARY KEY CLUSTERED 
(
	[SalesDoc] ASC,
	[SalesDocLine] ASC,
	[ScheduleLine] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[InQtc324StgSapSalesdocSchedLnHistory] )
)

GO


