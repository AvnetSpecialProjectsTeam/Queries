USE [CentralDbs]
GO


DROP TABLE  dbo.[BookBill]
GO

CREATE TABLE dbo.[BookBill](
	[LogDt] [datetime2] NULL,
	[LogTime] [datetime2] NULL,
	[TransDt] [datetime2] NULL,
	[BusDay99] [int] NULL,
	[WkNbr] [int] NULL,
	[FyMnthNbr] [int] NULL,
	[FyTagMnth] [varchar](30) NULL,
	[Material] [bigint] NULL,
	[Pbg] [varchar](3) NULL,
	[Mfg] [varchar](3) NULL,
	[PrcStgy] [varchar](3) NULL,
	[Cc] [varchar](3) NULL,
	[Grp] [varchar](3) NULL,
	[Tech] [varchar](3) NULL,
	[MfgPartNbr] [varchar](100) NULL,
	[SalesGrp] [varchar](20) NULL,
	[SalesGrpKey] [varchar](20) NULL,
	[SalesOffice] [varchar](50) NULL,
	[SalesOfficeKey] [varchar](50) NULL,
	[CustName] [varchar](100) NULL,
	[CustNbr] [varchar](50) NULL,
	[SalesDocTyp] [varchar](50) NULL,
	[RefBillingNbr] [bigint] NULL,
	[SalesDocNbr] [bigint] NULL,
	[SalesDocLnItm] [int] NULL,
	[BillingsQty] [int] NULL,
	[Billings] [money] NULL,
	[Cogs] [money] NULL,
	[BillingsGp] [money] NULL,
	[BookingsQty] [int] NULL,
	[Bookings] [money] NULL,
	[BookingsCost] [money] NULL,
	[BookingsGp] [money] NULL,
	[Type] [Varchar](10) NULL
) ON [PRIMARY]

GO


