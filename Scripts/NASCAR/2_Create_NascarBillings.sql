USE [NascarProd]
GO

/****** Object:  Table [dbo].[NascarOpenShipDebit]    Script Date: 11/2/2017 2:37:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NascarBillings](
	[MaterialNbr] [varchar](20) NOT NULL,
	[SoldToParty] [varchar](15) NOT NULL,
	[SalesDoc] [varchar](35) NOT NULL,
	[Qty] [bigint] NULL,
	[OrderValue] [real] NULL,
	[ExtResale] [real] NULL,
	[ExtCost] [real] NULL,
	EndCust [varchar](15) Null,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PkNascarBillings] PRIMARY KEY CLUSTERED 
(
	[SoldToParty] ASC,
	[SalesDoc] ASC,
	[MaterialNbr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[NascarBillingsHistory] )
)

GO


