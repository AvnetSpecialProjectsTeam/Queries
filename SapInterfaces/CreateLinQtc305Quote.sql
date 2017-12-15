USE Interfaces
GO

/****** Object:  Table [dbo].[LinQtc305Quote]    Script Date: 11/2/2017 2:44:33 PM ******/
ALTER TABLE [dbo].[LinQtc305Quote] SET ( SYSTEM_VERSIONING = OFF  )
GO

/****** Object:  Table [dbo].[LinQtc305Quote]    Script Date: 11/2/2017 2:44:33 PM ******/
DROP TABLE [dbo].[LinQtc305Quote]
GO

/****** Object:  Table [dbo].[LinQtc305QuoteHistory]    Script Date: 11/2/2017 2:44:33 PM ******/
DROP TABLE [dbo].[LinQtc305QuoteHistory]
GO

/****** Object:  Table [dbo].[LinQtc305QuoteHistory]    Script Date: 11/2/2017 2:44:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LinQtc305QuoteHistory](
	[QuoteId] [int] NOT NULL,
	[BackgroundProcessCompleteFlag] [varchar](1) NOT NULL,
	[CreateDt] [datetime2](7) NOT NULL,
	[CreateUserId] [varchar](30) NOT NULL,
	[CustomerDataOverriddenFlag] [varchar](1) NULL,
	[CustomerDueDt] [datetime2](7) NULL,
	[CustomerQuoteNbr] [varchar](30) NULL,
	[CustomerRequireOnDockDt] [datetime2](7) NULL,
	[EndCustomerUoFlag] [varchar](1) NULL,
	[FieldSalesRepId] [varchar](30) NULL,
	[FollowUpDt] [datetime2](7) NULL,
	[InsideRepUserId] [varchar](30) NOT NULL,
	[LoadEndDt] [datetime2](7) NULL,
	[LostSaleReasonCd] [varchar](3) NULL,
	[MdmEndCustomerId] [varchar](15) NULL,
	[MdmEndUserCustomerId] [varchar](15) NULL,
	[MdmHierarchyCustomerId] [varchar](15) NULL,
	[MdmShipToCustomerId] [varchar](15) NULL,
	[MdmSoldToCustomerId] [varchar](15) NULL,
	[MultipleEndCustomerAcctFlag] [varchar](1) NULL,
	[MultipleShipToCustomerAcctFlag] [varchar](1) NULL,
	[OpportunityId] [varchar](15) NULL,
	[ProjectBoardName] [varchar](50) NULL,
	[QuoteInputMethodCd] [varchar](3) NOT NULL,
	[QuoteTypeCd] [varchar](4) NOT NULL,
	[SalesDueDt] [datetime2](7) NULL,
	[SapSalesOfficeCd] [varchar](4) NULL,
	[SapSalesOrgCd] [varchar](4) NULL,
	[SubdivideRequestColChangeTx] [varchar](max) NULL,
	[ApplCreateDt] [datetime2](7) NOT NULL,
	[ApplUpdateDt] [datetime2](7) NOT NULL,
	[ApplActiveFromDt] [datetime2](7) NOT NULL,
	[ApplActiveThruDt] [datetime2](7) NOT NULL,
	[MdmEndUserContactPartyId] [varchar](15) NULL,
	[MdmSoldtoContactPartyId] [varchar](15) NULL,
	[SapShipToCustomerAcctGrpCd] [varchar](4) NULL,
	[SapSoldToCustomerAcctGrpCd] [varchar](4) NULL,
	[EcommerceQuoteId] [varchar](30) NULL,
	[FinalResponseCustFl] [char](1) NULL,
	[FinalResponseCustDt] [datetime2](7) NULL,
	[PartialResponseCustFl] [char](1) NULL,
	[PartialResponseCustDt] [datetime2](7) NULL,
	[SqlStartTime] [datetime2](7) NOT NULL,
	[SqlEndTime] [datetime2](7) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

/****** Object:  Table [dbo].[LinQtc305Quote]    Script Date: 11/2/2017 2:44:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LinQtc305Quote](
	[QuoteId] [int] NOT NULL,
	[BackgroundProcessCompleteFlag] [varchar](1) NOT NULL,
	[CreateDt] [datetime2](7) NOT NULL,
	[CreateUserId] [varchar](30) NOT NULL,
	[CustomerDataOverriddenFlag] [varchar](1) NULL,
	[CustomerDueDt] [datetime2](7) NULL,
	[CustomerQuoteNbr] [varchar](30) NULL,
	[CustomerRequireOnDockDt] [datetime2](7) NULL,
	[EndCustomerUoFlag] [varchar](1) NULL,
	[FieldSalesRepId] [varchar](30) NULL,
	[FollowUpDt] [datetime2](7) NULL,
	[InsideRepUserId] [varchar](30) NOT NULL,
	[LoadEndDt] [datetime2](7) NULL,
	[LostSaleReasonCd] [varchar](3) NULL,
	[MdmEndCustomerId] [varchar](15) NULL,
	[MdmEndUserCustomerId] [varchar](15) NULL,
	[MdmHierarchyCustomerId] [varchar](15) NULL,
	[MdmShipToCustomerId] [varchar](15) NULL,
	[MdmSoldToCustomerId] [varchar](15) NULL,
	[MultipleEndCustomerAcctFlag] [varchar](1) NULL,
	[MultipleShipToCustomerAcctFlag] [varchar](1) NULL,
	[OpportunityId] [varchar](15) NULL,
	[ProjectBoardName] [varchar](50) NULL,
	[QuoteInputMethodCd] [varchar](3) NOT NULL,
	[QuoteTypeCd] [varchar](4) NOT NULL,
	[SalesDueDt] [datetime2](7) NULL,
	[SapSalesOfficeCd] [varchar](4) NULL,
	[SapSalesOrgCd] [varchar](4) NULL,
	[SubdivideRequestColChangeTx] [varchar](max) NULL,
	[ApplCreateDt] [datetime2](7) NOT NULL,
	[ApplUpdateDt] [datetime2](7) NOT NULL,
	[ApplActiveFromDt] [datetime2](7) NOT NULL,
	[ApplActiveThruDt] [datetime2](7) NOT NULL,
	[MdmEndUserContactPartyId] [varchar](15) NULL,
	[MdmSoldtoContactPartyId] [varchar](15) NULL,
	[SapShipToCustomerAcctGrpCd] [varchar](4) NULL,
	[SapSoldToCustomerAcctGrpCd] [varchar](4) NULL,
	[EcommerceQuoteId] [varchar](30) NULL,
	[FinalResponseCustFl] [char](1) NULL,
	[FinalResponseCustDt] [datetime2](7) NULL,
	[PartialResponseCustFl] [char](1) NULL,
	[PartialResponseCustDt] [datetime2](7) NULL,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PkLinQtc305Quote] PRIMARY KEY CLUSTERED 
(
	[QuoteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[LinQtc305QuoteHistory] )
)

GO


