USE [SAP]
GO

/****** Object:  Table [dbo].[Vbpa]    Script Date: 10/20/2017 10:15:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Vbpa](
	[Client] [varchar] (3) NULL,
	[SalesDocNbr] [varchar] (10) NULL,
	[SalesDocItmNbr] [int]NULL,
	[PartnerFunctn] [varchar] (2) NULL,
	[SoldToPartyId] [varchar] (10) NULL,
	[Vendor] [varchar] (10) NULL,
	[PersonnelNbr] [int] NULL,
	[ContactPerson] [int] NULL,
	[Address] [varchar] (10) NULL,
	[UnloadingPoint] [varchar] (25) NULL,
	[DestCountry] [varchar] (3) NULL,
	[AddressId] [varchar] (1) NULL,
	[OneTimeAcctId] [varchar] (1) NULL,
	[HierarchyTyp] [varchar] (1) NULL,
	[PriceDetermin] [varchar] (1) NULL,
	[RebateRelvId] [varchar] (1) NULL,
	[HierarchyLevel] [int] NULL,
	[PartnerDesc] [varchar] (32) NULL,
	[TransportZone] [varchar] (10) NULL,
	[HierAssignment] [int] NULL,
	[VatRegNbr] [varchar] (20) NULL,
	[FPartners] [varchar] (1) NULL,
	[PersonNbr] [varchar] (10) NULL,
	[MaintainAppointments] [varchar] (1) NULL,
) ON [PRIMARY]

GO
