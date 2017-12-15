USE [NascarProd]
GO

/****** Object:  Table [dbo].[NascarMaterialThresholdValue]    Script Date: 10/11/2017 8:45:42 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NascarMaterialThresholdValue](
	[MaterialNbr] [bigint] NOT NULL,
	[ThresholdValue] [bigint] NULL,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
	[WindowsUsername] [varchar](6) NULL,
 CONSTRAINT [PKNascarMaterialThresholdValue] PRIMARY KEY CLUSTERED 
(
	[MaterialNbr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[NascarMaterialThresholdValueHistory] )
)

GO


