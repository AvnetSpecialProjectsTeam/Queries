USE [NascarProd]
GO

/****** Object:  Table [dbo].[NascarOpenShipDebitDailyUpload]    Script Date: 11/2/2017 2:37:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NascarOpenShipDebitDailyUpload](
	[LogDt] [date] NULL,
	[SapAgreement] [varchar](20) NULL,
	[AuthorizationNbr] [varchar](20) NULL,
	[ValidFrom] [date] NULL,
	[ValidTo] [date] NULL,
	[SoldToParty] [varchar](15) NULL,
	[ShipToParty] [varchar](15) NULL,
	[MaterialNbr] [varchar](20) NULL,
	[Rate] [real] NULL,
	[RemainingQtyVistex] [bigint] NULL,
	[AvnetResale] [real] NULL
) ON [PRIMARY]

GO


