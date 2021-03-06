USE [References]
GO

/****** Object:  Table [dbo].[SupplierContactInfo]    Script Date: 12/5/2017 10:33:07 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DROP TABLE [dbo].[SupplierContactInfo]

CREATE TABLE [dbo].[SupplierContactInfo](
	[Pbg] [Varchar] (5) NULL,
	[Mfg] [varchar](5) NULL,
	[PrcStgy] [varchar](5) NULL,
	[Cc] [varchar](5) NULL,
	[Grp] [varchar](5) NULL,
	[SupplName] [varchar](50) NULL,
	[VendorNbr] [varchar](50) NULL,
	[MainCtc] [Varchar] (50) NULL,
	[MainCtcPhoneNbr] [Varchar] (50) NULL,
	[MainCtcEmail] [Varchar] (50) NULL,
	[PrmBackup] [Varchar] (50) NULL,
	[PrmBackupPhoneNbr] [Varchar] (50) NULL,
	[SecBackup] [Varchar] (50) NULL,
	[SecBackupPhoneNbr] [Varchar] (50) NULL,
	[ExpEditorAssign] [Varchar] (50) NULL,
	[ExpEditorAssignEmail] [Varchar] (50) NULL,
	[CommodityDataAnalyst] [Varchar] (50) NULL,
	[CommodityDataAnalystEmail] [Varchar] (50) NULL,
	[ApAssign] [Varchar] (50) NULL,
	[ApAssignEmail] [Varchar] (50) NULL,
	[Pld] [Varchar] (50) NULL,
	[SupplCtc] [Varchar] (50) NULL,
	[SupplCtcTitle] [Varchar] (50) NULL,
	[SupplCtcEmail] [Varchar] (50) NULL,
	[SupplCtcPhone] [Varchar] (50) NULL,
	[SupplCtcExt] [Varchar] (50) NULL,
	[SupplAltCtc] [Varchar] (50) NULL,
	[SupplAltCtcEmail] [Varchar] (50) NULL,
	[SupplDistSales] [Varchar] (50) NULL,
	[SupplDistSalesEmail] [Varchar] (50) NULL,
	[SupplDistSalesPhoneNbr] [Varchar] (50) NULL,
	[SupplDistSalesPhoneNbrExt] [Varchar] (50) NULL,
	[SupplDistSalesMobileNbr] [Varchar] (50) NULL,
	[Gst] [Varchar] (50) NULL,
	[RepFlg] [Int] NULL,
	[DropShipFlg] [Int] NULL,
	[DropShipFeeFlg] [Int] NULL,
	[DropShipFormFlg] [Int] NULL,
	[ShipMethod] [Varchar] (50) NULL,
	[ShipFromLocation] [Varchar] (50) NULL,
	[AcceptUpgradesFlg] [Int] NULL,
	[AcceptThirdPartyAccount] [Int] NULL,
	[ExpEditeFeeFlg] [Int] NULL,
	[ExpEditeFee] [Int] NULL,
	[PoFaxFlg] [Int] NULL,
	[PoEmailFlg] [Int] NULL,
	[PoPhoneFlg] [Int] NULL,
	[PoPortalFlg] [Int] NULL,
	[PoEdiFlg] [Int] NULL,
	[FreqofUpdates] [Varchar] (250) NULL,
	[ExpEditeRules] [Varchar] (250) NULL,
	[AllocationGuidelinesCmt] [Varchar] (250) NULL,
	[SupplAllocationFlg] [Int] NULL,
	[SupplPortalFlg] [Int] NULL,
	[SupplPortalUrl] [Varchar] (250) NULL,
	[SupplPortalUserId] [Varchar] (50) NULL,
	[SupplPortalPassword] [Varchar] (50) NULL,
	[SupplAltPortalUrl] [Varchar] (250) NULL,
	[SupplAltPortalUserId] [Varchar] (50) NULL,
	[SupplAltPortalPassword] [Varchar] (50) NULL,
	[PricingGuideline] [Varchar] (250) NULL,
	[HoldResaleFlg] [Int] NULL,
	[SdOrFactQuoteQtySensitiveFlg] [Int] NULL,
	[SdOrQuoteValidity] [Varchar] (250) NULL,
	[QuoteValidity] [Varchar] (250) NULL,
	[EdiPoFlg] [Int] NULL,
	[EdiPoConfirmFlg] [Int]  NULL,
	[EdiPoChgFlg] [Int]  NULL,
	[EdiPoChgConfirmFlg] [Int] NULL,
	[PoSFlg] [Int]  NULL,
	[ASNFlg] [Int] NULL,
	[AutobuyFlg] [Int] NULL,
	[PullInFlg] [Int]  NULL,
	[PushOutFlg] [Int]  NULL,
	[CancellationFlg] [Int] NULL,
	[SafetyStockFlg] [Int] NULL,
	[AlloworRotate] [Varchar] (max) NULL,
	[CancellationWindow] [Varchar] (250) NULL,
	[NpiReturns] [Varchar] (250) NULL,
	[EolReturns] [Varchar] (250) NULL,
	[AgreementNbr] [Varchar] (50) NULL,
	[AdditionalInfo] [Varchar] (max) NULL,
	[Attachment] [Varchar] (50) NULL,
)

GO


