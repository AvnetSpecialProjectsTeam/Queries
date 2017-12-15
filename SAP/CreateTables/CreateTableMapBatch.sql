USE [CentralDbs]
GO

/****** Object:  Table [dbo].[MapBatch]    Script Date: 12/5/2017 11:46:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
Drop table MapBatch
CREATE TABLE [dbo].[MapBatch](
	[Material] [bigint] NOT NULL,
	[ValArea] [int] NOT NULL,
	[ValTyp] [varchar](12) NOT NULL,
	[Map] [money] NULL,
	[PriceUnitItm] [decimal](10, 0) NULL,
	[MapPerUnit]  AS ([Map]/[PriceUnitItm]),
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL, 
	CONSTRAINT [PkMapBatch] PRIMARY KEY CLUSTERED 
(
	[Material] ASC,
	[ValArea] ASC,
	ValTyp
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[MapBatchHistory] )
)

GO