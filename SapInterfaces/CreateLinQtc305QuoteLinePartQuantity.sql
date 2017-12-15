USE Interfaces
GO

/****** Object:  Table [dbo].[LinQtc305QuoteLinePartQuantity]    Script Date: 11/2/2017 2:45:24 PM ******/
ALTER TABLE [dbo].[LinQtc305QuoteLinePartQuantity] SET ( SYSTEM_VERSIONING = OFF  )
GO

/****** Object:  Table [dbo].[LinQtc305QuoteLinePartQuantity]    Script Date: 11/2/2017 2:45:24 PM ******/
DROP TABLE [dbo].[LinQtc305QuoteLinePartQuantity]
GO

/****** Object:  Table [dbo].[LinQtc305QuoteLinePartQuantityHistory]    Script Date: 11/2/2017 2:45:24 PM ******/
DROP TABLE [dbo].[LinQtc305QuoteLinePartQuantityHistory]
GO

/****** Object:  Table [dbo].[LinQtc305QuoteLinePartQuantityHistory]    Script Date: 11/2/2017 2:45:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LinQtc305QuoteLinePartQuantityHistory](
	[QuoteLinePartQtyId] [int] NOT NULL,
	[AuthCostAmt] [decimal](15, 5) NULL,
	[AuthDeliveryCompletedByUserId] [varchar](30) NULL,
	[AuthDeliveryCompletedDt] [datetime2](7) NULL,
	[AuthDeliveryFlag] [varchar](1) NULL,
	[AuthLeadTimeWeekQty] [int] NULL,
	[AuthMaterialGrossProfitPct] [decimal](15, 5) NULL,
	[AuthMinimumIncrementalQty] [int] NULL,
	[AuthMinimumOrderAmt] [int] NULL,
	[AuthMinimumOrderQty] [int] NULL,
	[AuthPriceCompletedByUserId] [varchar](30) NULL,
	[AuthPriceCompletedDt] [datetime2](7) NULL,
	[AuthPriceExpirationDt] [datetime2](7) NULL,
	[AuthPriceFlag] [varchar](1) NULL,
	[AuthPriceTypeId] [int] NULL,
	[AuthResaleAmt] [decimal](15, 5) NULL,
	[CanadianCurrencyExchangePct] [decimal](15, 5) NULL,
	[SapDeliveryPlantCd] [varchar](4) NULL,
	[SapDeliveryPlantCdUoFlag] [varchar](1) NULL,
	[LeadTimeWeekQty] [int] NULL,
	[LeadTimeWeekQtyUoFlag] [varchar](1) NULL,
	[MaterialGrossProfitPc] [decimal](15, 5) NULL,
	[MaterialGrossProfitPcUoFlag] [varchar](1) NULL,
	[PartQty] [int] NOT NULL,
	[PaAgreementAdjustedCostAmt] [decimal](15, 5) NULL,
	[PaAtpDt] [datetime2](7) NULL,
	[PaAwardResaleAmt] [decimal](15, 5) NULL,
	[PaCostAmt] [decimal](15, 5) NULL,
	[PaCostExpirationDt] [date] NULL,
	[PaCostSourceCd] [varchar](4) NULL,
	[PaQuotedCostAmt] [decimal](15, 5) NULL,
	[PaQuotedCostExpireDt] [datetime2](7) NULL,
	[PaQuoteCostSourceCd] [varchar](4) NULL,
	[PaSalesCostAmt] [decimal](15, 5) NULL,
	[PaWebResaleAmt] [decimal](15, 5) NULL,
	[PriceEffectiveDt] [date] NULL,
	[QuoteId] [int] NOT NULL,
	[QuoteLineNbr] [int] NOT NULL,
	[RequestPartQty] [int] NOT NULL,
	[ResaleAmt] [decimal](15, 5) NULL,
	[ResaleExpirationDt] [datetime2](7) NULL,
	[ResaleSourceCd] [varchar](4) NULL,
	[TargetResaleAmt] [decimal](15, 5) NULL,
	[UserSelectedFlag] [varchar](1) NOT NULL,
	[ApplCreateDt] [datetime2](7) NOT NULL,
	[ApplUpdateDt] [datetime2](7) NOT NULL,
	[ApplyActiveFromDt] [datetime2](7) NOT NULL,
	[ApplActiveThruDt] [datetime2](7) NOT NULL,
	[PaAwardNbr] [varchar](50) NULL,
	[ConfigCostAm] [decimal](15, 5) NULL,
	[PaAwardEffectiveDt] [datetime2](7) NULL,
	[PaAwardExpirationDt] [datetime2](7) NULL,
	[PaAwardQty] [int] NULL,
	[PaMapCost] [decimal](15, 5) NULL,
	[TlaActivity] [decimal](15, 5) NULL,
	[PaBestReplaceCostAm] [decimal](15, 5) NULL,
	[PaBookCostAm] [decimal](15, 5) NULL,
	[PaBookCostPrcBreakFl] [char](1) NULL,
	[PaBookCostQtyTx] [varchar](20) NULL,
	[PaBookResaleAm] [decimal](15, 5) NULL,
	[PaBookResalePrcBreakFl] [varchar](1) NULL,
	[PaBookResaleQtyTx] [varchar](20) NULL,
	[PaMppCostAm] [decimal](15, 5) NULL,
	[PaMppCostPrcBreakFl] [varchar](1) NULL,
	[PaMppCostQtyTx] [varchar](20) NULL,
	[PaSalesCostExpireDt] [datetime2](7) NULL,
	[PaSalesCostSourceCd] [varchar](4) NULL,
	[PaSystemResaleAm] [decimal](15, 5) NULL,
	[PaSystemResaleExpireDt] [datetime2](7) NULL,
	[PaSystemResaleSourceCd] [varchar](4) NULL,
	[PaWebResalePrcBreakFl] [varchar](1) NULL,
	[PaWebResaleQtyTx] [varchar](20) NULL,
	[SqlStartTime] [datetime2](7) NOT NULL,
	[SqlEndTime] [datetime2](7) NOT NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[LinQtc305QuoteLinePartQuantity]    Script Date: 11/2/2017 2:45:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LinQtc305QuoteLinePartQuantity](
	[QuoteLinePartQtyId] [int] NOT NULL,
	[AuthCostAmt] [decimal](15, 5) NULL,
	[AuthDeliveryCompletedByUserId] [varchar](30) NULL,
	[AuthDeliveryCompletedDt] [datetime2](7) NULL,
	[AuthDeliveryFlag] [varchar](1) NULL,
	[AuthLeadTimeWeekQty] [int] NULL,
	[AuthMaterialGrossProfitPct] [decimal](15, 5) NULL,
	[AuthMinimumIncrementalQty] [int] NULL,
	[AuthMinimumOrderAmt] [int] NULL,
	[AuthMinimumOrderQty] [int] NULL,
	[AuthPriceCompletedByUserId] [varchar](30) NULL,
	[AuthPriceCompletedDt] [datetime2](7) NULL,
	[AuthPriceExpirationDt] [datetime2](7) NULL,
	[AuthPriceFlag] [varchar](1) NULL,
	[AuthPriceTypeId] [int] NULL,
	[AuthResaleAmt] [decimal](15, 5) NULL,
	[CanadianCurrencyExchangePct] [decimal](15, 5) NULL,
	[SapDeliveryPlantCd] [varchar](4) NULL,
	[SapDeliveryPlantCdUoFlag] [varchar](1) NULL,
	[LeadTimeWeekQty] [int] NULL,
	[LeadTimeWeekQtyUoFlag] [varchar](1) NULL,
	[MaterialGrossProfitPc] [decimal](15, 5) NULL,
	[MaterialGrossProfitPcUoFlag] [varchar](1) NULL,
	[PartQty] [int] NOT NULL,
	[PaAgreementAdjustedCostAmt] [decimal](15, 5) NULL,
	[PaAtpDt] [datetime2](7) NULL,
	[PaAwardResaleAmt] [decimal](15, 5) NULL,
	[PaCostAmt] [decimal](15, 5) NULL,
	[PaCostExpirationDt] [date] NULL,
	[PaCostSourceCd] [varchar](4) NULL,
	[PaQuotedCostAmt] [decimal](15, 5) NULL,
	[PaQuotedCostExpireDt] [datetime2](7) NULL,
	[PaQuoteCostSourceCd] [varchar](4) NULL,
	[PaSalesCostAmt] [decimal](15, 5) NULL,
	[PaWebResaleAmt] [decimal](15, 5) NULL,
	[PriceEffectiveDt] [date] NULL,
	[QuoteId] [int] NOT NULL,
	[QuoteLineNbr] [int] NOT NULL,
	[RequestPartQty] [int] NOT NULL,
	[ResaleAmt] [decimal](15, 5) NULL,
	[ResaleExpirationDt] [datetime2](7) NULL,
	[ResaleSourceCd] [varchar](4) NULL,
	[TargetResaleAmt] [decimal](15, 5) NULL,
	[UserSelectedFlag] [varchar](1) NOT NULL,
	[ApplCreateDt] [datetime2](7) NOT NULL,
	[ApplUpdateDt] [datetime2](7) NOT NULL,
	[ApplyActiveFromDt] [datetime2](7) NOT NULL,
	[ApplActiveThruDt] [datetime2](7) NOT NULL,
	[PaAwardNbr] [varchar](50) NULL,
	[ConfigCostAm] [decimal](15, 5) NULL,
	[PaAwardEffectiveDt] [datetime2](7) NULL,
	[PaAwardExpirationDt] [datetime2](7) NULL,
	[PaAwardQty] [int] NULL,
	[PaMapCost] [decimal](15, 5) NULL,
	[TlaActivity] [decimal](15, 5) NULL,
	[PaBestReplaceCostAm] [decimal](15, 5) NULL,
	[PaBookCostAm] [decimal](15, 5) NULL,
	[PaBookCostPrcBreakFl] [char](1) NULL,
	[PaBookCostQtyTx] [varchar](20) NULL,
	[PaBookResaleAm] [decimal](15, 5) NULL,
	[PaBookResalePrcBreakFl] [varchar](1) NULL,
	[PaBookResaleQtyTx] [varchar](20) NULL,
	[PaMppCostAm] [decimal](15, 5) NULL,
	[PaMppCostPrcBreakFl] [varchar](1) NULL,
	[PaMppCostQtyTx] [varchar](20) NULL,
	[PaSalesCostExpireDt] [datetime2](7) NULL,
	[PaSalesCostSourceCd] [varchar](4) NULL,
	[PaSystemResaleAm] [decimal](15, 5) NULL,
	[PaSystemResaleExpireDt] [datetime2](7) NULL,
	[PaSystemResaleSourceCd] [varchar](4) NULL,
	[PaWebResalePrcBreakFl] [varchar](1) NULL,
	[PaWebResaleQtyTx] [varchar](20) NULL,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PkLinQtc305QuoteLinePartQuantity] PRIMARY KEY CLUSTERED 
(
	[QuoteLinePartQtyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[LinQtc305QuoteLinePartQuantityHistory] )
)

GO


