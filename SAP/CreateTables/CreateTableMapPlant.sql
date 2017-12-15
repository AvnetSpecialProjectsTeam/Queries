USE [CentralDbs]
GO

/****** Object:  Table [dbo].[MapPlant]    Script Date: 12/5/2017 11:40:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
Drop Table MapPlant
CREATE TABLE [dbo].[MapPlant](
	[Material] [bigint] Not NULL,
	[ValArea] [int] Not Null,
	[Map] [decimal](38, 15) NULL,
	[PriceUnitItm] [int] NULL,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL, 
	CONSTRAINT [PkMapPlant] PRIMARY KEY CLUSTERED 
(
	[Material] ASC,
	[ValArea] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[MapPlantHistory] )
)

GO