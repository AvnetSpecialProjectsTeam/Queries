USE [Nascar]
GO

/****** Object:  Table [dbo].[NascarFrontEnd]    Script Date: 10/10/2017 12:47:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Drop table NascarFrontEnd
go

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
	SqlStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
    ,SqlEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
	,PERIOD FOR SYSTEM_TIME (SqlStartTime, SqlEndTime),
 CONSTRAINT [PK_MaterialNbr] PRIMARY KEY (MaterialNbrText)
 )
WITH
	(
		SYSTEM_VERSIONING = ON (HISTORY_TABLE= dbo.NascarFrontEndHistory)
	)
;

