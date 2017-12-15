USE [CentralDbs]
GO

/****** Object:  Table [dbo].[MapMaterial]    Script Date: 12/5/2017 11:42:53 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
Drop Table CentralDbs.dbo.MapMaterial
CREATE TABLE [dbo].[MapMaterial](
	[Material] [bigint] NOT NULL,
	[Map] [decimal](38, 15) NULL,
	[PriceUnitItm] [int] NULL,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL, 
	CONSTRAINT [PkMapMaterial] PRIMARY KEY CLUSTERED 
(
	[Material] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[MapMaterialHistory] )
)


