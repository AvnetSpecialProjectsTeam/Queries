USE [Popic]
GO

/****** Object:  Table [dbo].[PopicRules]    Script Date: 11/10/2017 10:19:11 AM ******/
ALTER TABLE [dbo].[ZmassPo] SET ( SYSTEM_VERSIONING = OFF  )
GO

/****** Object:  Table [dbo].[PopicRules]    Script Date: 11/10/2017 10:19:11 AM ******/
DROP TABLE [dbo].[ZmassPo]
GO

/****** Object:  Table [dbo].[PopicRulesHistory]    Script Date: 11/10/2017 10:19:11 AM ******/
DROP TABLE [dbo].[ZmassPoHistory]
GO


/****** Object:  Table [dbo].[ZmassPo]    Script Date: 11/20/2017 2:24:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ZmassPo](
	[PoNbr] [bigint] NOT NULL,
	[PoItem] [int] NOT NULL,
	[SchedLineNbr] [int] NOT NULL,
	[Status] [varchar](8) NOT NULL
	,[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL
	,[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL
	CONSTRAINT [PkZmassPo] PRIMARY KEY CLUSTERED 
	([PoNbr], [PoItem], [SchedLineNbr]
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[ZmassPoHistory] )
)
GO


