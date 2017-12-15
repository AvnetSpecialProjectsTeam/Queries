USE [NascarProd]
GO

/****** Object:  Table [dbo].[NascarFrontEnd]    Script Date: 10/11/2017 8:44:39 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NascarFrontEnd](
	[MaterialNbr] [bigint] NOT NULL,
	[PrcStgy] [varchar](12) NULL,
	[Grp] [varchar](12) NULL,
	[CC] [varchar](12) NULL,
	[ThresholdValue] [int] NOT NULL,
	[OverwriteThresholdValue] [int] NOT NULL,
	[OverwriteFlag] [varchar](1) NOT NULL,
	[MaterialNbrText] [varchar](25) NOT NULL,
	[WindowsUsername] [varchar](25) NULL,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PK_MaterialNbr] PRIMARY KEY CLUSTERED 
(
	[MaterialNbrText] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[NascarFrontEndHistory] )
)

GO


