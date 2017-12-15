USE Interfaces
GO

/****** Object:  Table [dbo].[PurchOrdItemConf]    Script Date: 11/2/2017 2:42:07 PM ******/
ALTER TABLE [dbo].[PurchOrdItemConf] SET ( SYSTEM_VERSIONING = OFF  )
GO

/****** Object:  Table [dbo].[PurchOrdItemConf]    Script Date: 11/2/2017 2:42:07 PM ******/
DROP TABLE [dbo].[PurchOrdItemConf]
GO

/****** Object:  Table [dbo].[PurchOrdItemConfHistory]    Script Date: 11/2/2017 2:42:07 PM ******/
DROP TABLE [dbo].[PurchOrdItemConfHistory]
GO

/****** Object:  Table [dbo].[PurchOrdItemConfHistory]    Script Date: 11/2/2017 2:42:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PurchOrdItemConfHistory](
	[PoNbr] [bigint] NOT NULL,
	[PoLine] [int] NOT NULL,
	[PoCnfLine] [int] NOT NULL,
	[ConfirmationQt] [decimal](15, 3) NULL,
	[DeliveryDt] [datetime2](7) NULL,
	[ReducedQt] [decimal](15, 3) NULL,
	[SapConfirmationCategoryCd] [varchar](10) NULL,
	[ApplCreateDt] [datetime2](7) NULL,
	[ApplUpdateDt] [datetime2](7) NULL,
	[ApplActiveFromDt] [datetime2](7) NULL,
	[ApplActiveThruDt] [datetime2](7) NULL,
	[NetConfirmedQt] [decimal](15, 3) NULL,
	[SqlStartTime] [datetime2](7) NOT NULL,
	[SqlEndTime] [datetime2](7) NOT NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[PurchOrdItemConf]    Script Date: 11/2/2017 2:42:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PurchOrdItemConf](
	[PoNbr] [bigint] NOT NULL,
	[PoLine] [int] NOT NULL,
	[PoCnfLine] [int] NOT NULL,
	[ConfirmationQt] [decimal](15, 3) NULL,
	[DeliveryDt] [datetime2](7) NULL,
	[ReducedQt] [decimal](15, 3) NULL,
	[SapConfirmationCategoryCd] [varchar](10) NULL,
	[ApplCreateDt] [datetime2](7) NULL,
	[ApplUpdateDt] [datetime2](7) NULL,
	[ApplActiveFromDt] [datetime2](7) NULL,
	[ApplActiveThruDt] [datetime2](7) NULL,
	[NetConfirmedQt] [decimal](15, 3) NULL,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PkPurchOrdItemConf] PRIMARY KEY CLUSTERED 
(
	[PoNbr] ASC,
	[PoLine] ASC,
	[PoCnfLine] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[PurchOrdItemConfHistory] )
)

GO


