USE Interfaces
GO

/****** Object:  Table [dbo].[LinQtc305CustomerUserEntry]    Script Date: 11/2/2017 2:44:09 PM ******/
ALTER TABLE [dbo].[LinQtc305CustomerUserEntry] SET ( SYSTEM_VERSIONING = OFF  )
GO

/****** Object:  Table [dbo].[LinQtc305CustomerUserEntry]    Script Date: 11/2/2017 2:44:09 PM ******/
DROP TABLE [dbo].[LinQtc305CustomerUserEntry]
GO

/****** Object:  Table [dbo].[LinQtc305CustomerUserEntryHistory]    Script Date: 11/2/2017 2:44:09 PM ******/
DROP TABLE [dbo].[LinQtc305CustomerUserEntryHistory]
GO

/****** Object:  Table [dbo].[LinQtc305CustomerUserEntryHistory]    Script Date: 11/2/2017 2:44:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LinQtc305CustomerUserEntryHistory](
	[CustomerUserEntryId] [int] NOT NULL,
	[AddessCityName] [varchar](100) NULL,
	[AddressLineTx1] [varchar](100) NULL,
	[AddressLineTx2] [varchar](100) NULL,
	[AddressLineTx3] [varchar](100) NULL,
	[AddressPostalCd] [varchar](10) NULL,
	[AttentionName] [varchar](100) NULL,
	[AttentionNameUoFlag] [varchar](1) NULL,
	[ContactName] [varchar](40) NULL,
	[CustomerUserEntryTypeCd] [varchar](6) NOT NULL,
	[EmailAddressTx] [varchar](255) NULL,
	[PartyName] [varchar](80) NULL,
	[PartyNameUoFlag] [varchar](1) NULL,
	[PhoneNbr] [varchar](35) NULL,
	[PhoneNbrUoFlag] [varchar](1) NULL,
	[PurchaseOrderId] [int] NULL,
	[PurchaseOrderLineNbr] [int] NULL,
	[QuoteId] [int] NULL,
	[QuoteLineNbr] [int] NULL,
	[SapAddressCountryCd] [varchar](3) NULL,
	[SapAddressCountryRegionCd] [varchar](3) NULL,
	[ApplCreateDt] [datetime2](7) NOT NULL,
	[ApplUpdateDt] [datetime2](7) NOT NULL,
	[ApplActiveFromDt] [datetime2](7) NOT NULL,
	[ApplActiveThruDt] [datetime2](7) NOT NULL,
	[SqlStartTime] [datetime2](7) NOT NULL,
	[SqlEndTime] [datetime2](7) NOT NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[LinQtc305CustomerUserEntry]    Script Date: 11/2/2017 2:44:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LinQtc305CustomerUserEntry](
	[CustomerUserEntryId] [int] NOT NULL,
	[AddessCityName] [varchar](100) NULL,
	[AddressLineTx1] [varchar](100) NULL,
	[AddressLineTx2] [varchar](100) NULL,
	[AddressLineTx3] [varchar](100) NULL,
	[AddressPostalCd] [varchar](10) NULL,
	[AttentionName] [varchar](100) NULL,
	[AttentionNameUoFlag] [varchar](1) NULL,
	[ContactName] [varchar](40) NULL,
	[CustomerUserEntryTypeCd] [varchar](6) NOT NULL,
	[EmailAddressTx] [varchar](255) NULL,
	[PartyName] [varchar](80) NULL,
	[PartyNameUoFlag] [varchar](1) NULL,
	[PhoneNbr] [varchar](35) NULL,
	[PhoneNbrUoFlag] [varchar](1) NULL,
	[PurchaseOrderId] [int] NULL,
	[PurchaseOrderLineNbr] [int] NULL,
	[QuoteId] [int] NULL,
	[QuoteLineNbr] [int] NULL,
	[SapAddressCountryCd] [varchar](3) NULL,
	[SapAddressCountryRegionCd] [varchar](3) NULL,
	[ApplCreateDt] [datetime2](7) NOT NULL,
	[ApplUpdateDt] [datetime2](7) NOT NULL,
	[ApplActiveFromDt] [datetime2](7) NOT NULL,
	[ApplActiveThruDt] [datetime2](7) NOT NULL,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PkLinQtc305CustomerUserEntry] PRIMARY KEY CLUSTERED 
(
	[CustomerUserEntryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[LinQtc305CustomerUserEntryHistory] )
)

GO


