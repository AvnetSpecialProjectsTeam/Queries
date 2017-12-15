USE Popic
GO

/****** Object:  Table [dbo].[PopicRules]    Script Date: 11/10/2017 10:19:11 AM ******/
ALTER TABLE [dbo].[CdbPopic] SET ( SYSTEM_VERSIONING = OFF)
(HISTORY_TABLE= dbo.[CdbPopicHistory]));
GO

/****** Object:  Table [dbo].[PopicRules]    Script Date: 11/10/2017 10:19:11 AM ******/
DROP TABLE [dbo].[CdbPopic]
GO

/****** Object:  Table [dbo].[PopicRulesHistory]    Script Date: 11/10/2017 10:19:11 AM ******/
DROP TABLE [dbo].[CdbPopicHistory]
GO


/****** Object:  Table [dbo].[CdbPopic]    Script Date: 11/10/2017 10:18:53 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CdbPopic](
	[MrpDt] [date] NULL,
	[MaterialNbr] [bigint] NULL,
	[MfgPartNbr] [varchar](40) NULL,
	[Plant] [int] NOT NULL,
	[Mfg] [varchar](5) NULL,
	[PrcStgy] [varchar](4) NULL,
	[CC] [varchar](3) NULL,
	[Grp] [varchar](3) NULL,
	[MrpInd] [varchar](2) NULL,
	[ReqDt] [date] NULL,
	[MrpNbr] [bigint] NOT NULL,
	[MrpItem] [int] NOT NULL,
	[SchedItem] [int] NOT NULL,
	[ExceptnNbr] [smallint] NULL,
	[ExceptnKey] [varchar](2) NULL,
	[ReschedDt] [date] NULL,
	[ConfDlvryDt] [date] NULL,
	[SchDlvryDt] [date] NULL,
	[NetValue] [decimal](13, 2) NULL,
	[StkHigh] [varchar](1) NULL,
	[MrpCtrlr] [varchar](3) NULL,
	[PurchGrp] [varchar](3) NULL,
	[AutoBuy] [varchar](1) NULL,
	[AvnetAbc] [varchar](3) NULL,
	[SplrCancelWdw] [int] NULL,
	[MatlStatus] [varchar](2) NULL,
	[NcnrFl] [varchar](1) NULL,
	[StkFl] [varchar](3) NULL,
	[MrpElemntDesc] [varchar](30) NULL,
	[CancelWindow] [int] NULL,
	[QtrDay] [bigint] NULL,
	[InTransit] [varchar](1) NULL,
	[ZorQty] [bigint] NULL,
	[ZfcQty] [bigint] NULL,
	[ZsbQty] [bigint] NULL,
	[PoAction] [varchar](10) NOT NULL,
	[SrDir] [varchar](50) NULL,
	[Pld] [varchar](50) NULL,
	[MatlSpclst] [varchar](50) NULL,
	[PoChgCount] [int] NULL,
	[TransmitType] [varchar](4) NOT NULL
	,[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL
	,[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL
	CONSTRAINT [PkCdbPopic] PRIMARY KEY CLUSTERED 
	(
	[MrpNbr] ASC,
	[MrpItem] ASC,
	[SchedItem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[CdbPopicHistory] )
)
GO


