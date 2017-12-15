USE Interfaces
GO

/****** Object:  Table [dbo].[PurchOrdItem]    Script Date: 11/2/2017 2:40:16 PM ******/
ALTER TABLE [dbo].[PurchOrdItem] SET ( SYSTEM_VERSIONING = OFF  )
GO

/****** Object:  Table [dbo].[PurchOrdItem]    Script Date: 11/2/2017 2:40:16 PM ******/
DROP TABLE [dbo].[PurchOrdItem]
GO

/****** Object:  Table [dbo].[PurchOrdItemHistory]    Script Date: 11/2/2017 2:40:16 PM ******/
DROP TABLE [dbo].[PurchOrdItemHistory]
GO

/****** Object:  Table [dbo].[PurchOrdItemHistory]    Script Date: 11/2/2017 2:40:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PurchOrdItemHistory](
	[PoNbr] [bigint] NOT NULL,
	[PoLine] [int] NOT NULL,
	[AvnetResalePriceAm] [int] NULL,
	[ClosureTx] [varchar](500) NULL,
	[CostAm] [decimal](15, 3) NULL,
	[DateCd] [varchar](10) NULL,
	[DeliveryTx] [varchar](500) NULL,
	[ExternalNoteTx] [varchar](500) NULL,
	[ExternalTx] [varchar](500) NULL,
	[GoodsReceiptProcessDayQt] [int] NULL,
	[GovernmentContractNo] [varchar](30) NULL,
	[GovernmentPriorityRatingCd] [varchar](10) NULL,
	[ItemQt] [decimal](15, 3) NULL,
	[LotCd] [varchar](10) NULL,
	[ManufacturerPartNo] [varchar](50) NULL,
	[PriceUnitQt] [int] NULL,
	[RegistrationId] [varchar](20) NULL,
	[RequestedDeliveryDt] [datetime2](7) NULL,
	[SalesOrderItemNo] [int] NULL,
	[SalesOrderNo] [int] NULL,
	[SapCarrierServiceLevelCd] [varchar](10) NULL,
	[SapMaterialId] [bigint] NULL,
	[SapPlantCd] [varchar](10) NULL,
	[SapPlantStorageLocCd] [varchar](10) NULL,
	[SapPurchDocItemCatgCd] [varchar](10) NULL,
	[ShipToNm] [varchar](20) NULL,
	[SpecialBuyCustomerNm] [varchar](20) NULL,
	[UnitCostAm] [int] NULL,
	[VendorPartNo] [varchar](35) NULL,
	[VendorPriceAuthCd] [varchar](1) NULL,
	[ApplCreateDt] [datetime2](7) NULL,
	[ApplUpdateDt] [datetime2](7) NULL,
	[ApplActiveFromDt] [datetime2](7) NULL,
	[ApplActiveThruDt] [datetime2](7) NULL,
	[GrQt] [decimal](15, 3) NULL,
	[GiQt] [decimal](15, 3) NULL,
	[OpenQt] [decimal](15, 3) NULL,
	[CommittedDt] [datetime2](7) NULL,
	[CommittedQt] [decimal](15, 3) NULL,
	[SqlStartTime] [datetime2](7) NOT NULL,
	[SqlEndTime] [datetime2](7) NOT NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[PurchOrdItem]    Script Date: 11/2/2017 2:40:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PurchOrdItem](
	[PoNbr] [bigint] NOT NULL,
	[PoLine] [int] NOT NULL,
	[AvnetResalePriceAm] [int] NULL,
	[ClosureTx] [varchar](500) NULL,
	[CostAm] [decimal](15, 3) NULL,
	[DateCd] [varchar](10) NULL,
	[DeliveryTx] [varchar](500) NULL,
	[ExternalNoteTx] [varchar](500) NULL,
	[ExternalTx] [varchar](500) NULL,
	[GoodsReceiptProcessDayQt] [int] NULL,
	[GovernmentContractNo] [varchar](30) NULL,
	[GovernmentPriorityRatingCd] [varchar](10) NULL,
	[ItemQt] [decimal](15, 3) NULL,
	[LotCd] [varchar](10) NULL,
	[ManufacturerPartNo] [varchar](50) NULL,
	[PriceUnitQt] [int] NULL,
	[RegistrationId] [varchar](20) NULL,
	[RequestedDeliveryDt] [datetime2](7) NULL,
	[SalesOrderItemNo] [int] NULL,
	[SalesOrderNo] [int] NULL,
	[SapCarrierServiceLevelCd] [varchar](10) NULL,
	[SapMaterialId] [bigint] NULL,
	[SapPlantCd] [varchar](10) NULL,
	[SapPlantStorageLocCd] [varchar](10) NULL,
	[SapPurchDocItemCatgCd] [varchar](10) NULL,
	[ShipToNm] [varchar](20) NULL,
	[SpecialBuyCustomerNm] [varchar](20) NULL,
	[UnitCostAm] [int] NULL,
	[VendorPartNo] [varchar](35) NULL,
	[VendorPriceAuthCd] [varchar](1) NULL,
	[ApplCreateDt] [datetime2](7) NULL,
	[ApplUpdateDt] [datetime2](7) NULL,
	[ApplActiveFromDt] [datetime2](7) NULL,
	[ApplActiveThruDt] [datetime2](7) NULL,
	[GrQt] [decimal](15, 3) NULL,
	[GiQt] [decimal](15, 3) NULL,
	[OpenQt] [decimal](15, 3) NULL,
	[CommittedDt] [datetime2](7) NULL,
	[CommittedQt] [decimal](15, 3) NULL,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PkPurchOrdItem] PRIMARY KEY CLUSTERED 
(
	[PoNbr] ASC,
	[PoLine] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[PurchOrdItemHistory] )
)

GO


