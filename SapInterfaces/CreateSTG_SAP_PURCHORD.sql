USE Interfaces
GO

/****** Object:  Table [dbo].[PurchOrd]    Script Date: 11/2/2017 2:37:10 PM ******/
ALTER TABLE [dbo].[PurchOrd] SET ( SYSTEM_VERSIONING = OFF  )
GO

/****** Object:  Table [dbo].[PurchOrd]    Script Date: 11/2/2017 2:37:10 PM ******/
DROP TABLE [dbo].[PurchOrd]
GO

/****** Object:  Table [dbo].[PurchOrdHistory]    Script Date: 11/2/2017 2:37:10 PM ******/
DROP TABLE [dbo].[PurchOrdHistory]
GO

/****** Object:  Table [dbo].[PurchOrdHistory]    Script Date: 11/2/2017 2:37:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PurchOrdHistory](
	[PoNbr] [bigint] NOT NULL,
	[EndUserNm] [varchar](20) NULL,
	[ExternalTx] [varchar](500) NULL,
	[InstallerNm] [varchar](20) NULL,
	[LegacyPoNo] [varchar](30) NULL,
	[PurchasingDocTypeNm] [varchar](20) NULL,
	[PurchasingGroupEmailAddrTx] [varchar](500) NULL,
	[PurchasingGroupNm] [varchar](20) NULL,
	[PurchaseOrderDt] [datetime2](7) NULL,
	[ResellerNm] [varchar](20) NULL,
	[SalesOrderReleaseNo] [int] NULL,
	[SapCompanyCd] [varchar](10) NULL,
	[SapPurchasingDocTypeCd] [varchar](10) NULL,
	[SapPurchasingGroupPhoneNo] [varchar](15) NULL,
	[SapPurchasingOrgCd] [varchar](10) NULL,
	[SapVendorId] [int] NULL,
	[ShippingInstructionsTx] [varchar](500) NULL,
	[VendorNm] [varchar](20) NULL,
	[ApplCreateDt] [datetime2](7) NULL,
	[ApplUpdateDt] [datetime2](7) NULL,
	[ApplActiveFromDt] [datetime2](7) NULL,
	[ApplActiveThruDt] [datetime2](7) NULL,
	[SapPurchaseOrderDescr] [varchar](20) NULL,
	[SapSupplyingPlant] [varchar](20) NULL,
	[SqlStartTime] [datetime2](7) NOT NULL,
	[SqlEndTime] [datetime2](7) NOT NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[PurchOrd]    Script Date: 11/2/2017 2:37:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PurchOrd](
	[PoNbr] [bigint] NOT NULL,
	[EndUserNm] [varchar](20) NULL,
	[ExternalTx] [varchar](500) NULL,
	[InstallerNm] [varchar](20) NULL,
	[LegacyPoNo] [varchar](30) NULL,
	[PurchasingDocTypeNm] [varchar](20) NULL,
	[PurchasingGroupEmailAddrTx] [varchar](500) NULL,
	[PurchasingGroupNm] [varchar](20) NULL,
	[PurchaseOrderDt] [datetime2](7) NULL,
	[ResellerNm] [varchar](20) NULL,
	[SalesOrderReleaseNo] [int] NULL,
	[SapCompanyCd] [varchar](10) NULL,
	[SapPurchasingDocTypeCd] [varchar](10) NULL,
	[SapPurchasingGroupPhoneNo] [varchar](15) NULL,
	[SapPurchasingOrgCd] [varchar](10) NULL,
	[SapVendorId] [int] NULL,
	[ShippingInstructionsTx] [varchar](500) NULL,
	[VendorNm] [varchar](20) NULL,
	[ApplCreateDt] [datetime2](7) NULL,
	[ApplUpdateDt] [datetime2](7) NULL,
	[ApplActiveFromDt] [datetime2](7) NULL,
	[ApplActiveThruDt] [datetime2](7) NULL,
	[SapPurchaseOrderDescr] [varchar](20) NULL,
	[SapSupplyingPlant] [varchar](20) NULL,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PkPurchOrd] PRIMARY KEY CLUSTERED 
(
	[PoNbr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[PurchOrdHistory] )
)

GO


