USE [NascarProd]
GO

/****** Object:  Table [dbo].[NascarOpenShipDebit]    Script Date: 11/2/2017 2:37:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NascarOpenShipDebit](
	[SapAgreement] [varchar](20) NULL,
	[AuthorizationNbr] [varchar](20) NULL,
	[ValidFrom] [date] NULL,
	[ValidTo] [date] NULL,
	[SoldToParty] [varchar](15) NOT NULL,
	[ShipToParty] [varchar](15) NOT NULL,
	[MaterialNbr] [varchar](20) NOT NULL,
	[Rate] [real] NULL,
	[RemainingQtyVistex] [bigint] NULL,
	[AvnetResale] [real] NULL,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PkNascarOpenShipDebit] PRIMARY KEY CLUSTERED 
(
	[SoldToParty] ASC,
	[ShipToParty] ASC,
	[MaterialNbr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[NascarOpenShipDebitHistory] )
)

GO


