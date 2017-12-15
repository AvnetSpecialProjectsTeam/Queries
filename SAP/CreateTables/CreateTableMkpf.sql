USE [SAP]
GO

/****** Object:  Table [dbo].[Mkpf]    Script Date: 11/6/2017 2:16:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
DROP TABLE Sap.dbo.[Mkpf]
CREATE TABLE Sap.[dbo].[Mkpf](
	[Client] int NULL,							--[Column 0]
	[MatDocNbr] bigint NULL,					--[Column 1]
	[MatDocYr] int NULL,						--[Column 2]
	[TransactEventTyp1] [varchar](5) NULL,		--[Column 3]
	[DocTyp] [varchar](5) NULL,					--[Column 4]
	[DocTypRev] [varchar](5) NULL,				--[Column 5]
	[DocDt] [datetime2](7) NULL,				--[Column 6]
	[DocPostingDt] [datetime2](7) NULL,			--[Column 7]
	[EnteredOnDt] [datetime2](7) NULL,			--[Column 8]
	[EnteredAtTime] [time](7) NULL,				--[Column 9]
	[ChangeDt] [datetime2](7) NULL,				--[Column 10]	
	[UserName] [varchar](13) NULL,				--[Column 11]
	[NotMoreCloselyDefined] [varchar](5) NULL,	--[Column 12]
	[RefDocNbr] bigint NULL,					--[Column 13]
	[DocHeaderText] [varchar](36) NULL,			--[Column 14]
	[UnplDlvryCosts] [int] NULL,				--[Column 15]
	[BillOfLadingNbr] [varchar](38) NULL,		--[Column 16]
	[PrintVersion] int NULL,					--[Column 17]
	[GrSlipNbr] [varchar](11) NULL,				--[Column 18]
	[LogicalSystem] [varchar](11) NULL,			--[Column 19]
	[DocTypAd] [varchar](5) NULL,				--[Column 20]
	[TransactionCd] [varchar](21) NULL,			--[Column 21]
	[ExtWmsControl] int NULL,					--[Column 22]
	[ForeignTradeDataNbr] [varchar](11) NULL,	--[Column 23]
	[GoodsIssueTime] [time](6) NULL,			--[Column 24]
	[TimeZone] [varchar](7) NULL,				--[Column 25]
	[Delivery] bigint NULL,						--[Column 26]
	[LogicalSystemEwm] [varchar](11) NULL,		--[Column 27]
	[MaterialDocEwm] [varchar](17) NULL,		--[Column 28]
	[CustRefNbrScrap] [varchar](36) NULL,		--[Column 29]
	[DocCond] [varchar](25) NULL,				--[Column 30]	
	[StoreReturnInOut] [varchar](5) NULL,		--[Column 31]
	[AdvReturns] [varchar](5) NULL				--[Column 32]
) ON [PRIMARY]

GO


