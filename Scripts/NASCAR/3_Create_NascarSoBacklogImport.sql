Use NascarProd 
go
CREATE TABLE [dbo].[NascarSoBacklogImport](
	[MaterialNbr] [varchar](20) NOT NULL,
	[SoldToParty] [varchar](15) NOT NULL,
	[SalesDoc] [varchar](35) NOT NULL,
	[Qty] [bigint] NULL,
	[OrderValue] [real] NULL,
	[ExtResale] [real] NULL,
	[ExtCost] [real] NULL,
	EndCust [varchar](15) Null)