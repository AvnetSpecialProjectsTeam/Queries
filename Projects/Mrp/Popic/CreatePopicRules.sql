USE Popic
GO


--ALTER TABLE [PopicRules] SET (SYSTEM_VERSIONING = OFF)
------ALTER TABLE [PopicRules1] SET (SYSTEM_VERSIONING = Off)
-- (HISTORY_TABLE= dbo.PopicRulesHistory));

--DROP TABLE [PopicRules1]
--DROP TABLE PopicRules1History



CREATE TABLE Popic.[dbo].[PopicRules](
	[Mfg] [varchar](3) NOT NULL,
	[PrcStgy] [varchar](3) NOT NULL,
	[Cc] [varchar](3) NOT NULL,
	[Grp] [varchar](3) NOT NULL,
	[EdiPurchReq] BIT Default 0,
	[EdiCancel] BIT Default 0,
	[EdiPushOut] BIT Default 0,
	[EdiPullIn] BIT Default 0,
	[EdiPurchMinVal] [money] DEFAULT 0,
	[EdiPurchMaxVal] [money] DEFAULT 0,
	[EdiCancelMinVal] [money] DEFAULT 0,
	[EdiCancelMaxVal] [money] DEFAULT 0,
	[EdiPushMinVal] [money] DEFAULT 0,
	[EdiPushMaxVal] [money] DEFAULT 0,
	[EdiPullMinVal] [money] DEFAULT 0,
	[EdiPullMaxVal] [money] DEFAULT 0,
	[EdiPurchCancelWindowIsLeadTime] INT NULL,
	[EdiCancelCancelWindowIsLeadTime] INT NULL,
	[EdiPushCancelWindowIsLeadTime] INT NULL,
	[EdiPullCancelWindowIsLeadTime] INT NULL,
	[EdiPurchActionWindowStart] [int] NULL,
	[EdiPurchActionWindowEnd] [int] NULL,
	[EdiCancelActionWindowStart] [int] NULL,
	[EdiCancelActionWindowEnd] [int] NULL,
	[EdiPushActionWindowStart] [int] NULL,
	[EdiPushActionWindowEnd] [int] NULL,
	[EdiPullActionWindowStart] [int] NULL,
	[EdiPullActionWindowEnd] [int] NULL
	,EdiPurchZorDemand BIT Default 0
	,EdiCancelZorDemand BIT Default 0
	,EdiPushZorDemand BIT Default 0
	,EdiPullZorDemand BIT Default 0
	,EdiPurchZfcDemand BIT Default 0
	,EdiCancelZfcDemand BIT Default 0
	,EdiPushZfcDemand BIT Default 0
	,EdiPullZfcDemand BIT Default 0
	,EdiPurchZsbDemand BIT Default 0
	,EdiCancelZsbDemand BIT Default 0
	,EdiPushZsbDemand BIT Default 0
	,EdiPullZsbDemand BIT Default 0
	,[EdiPurchMaxPoChangeCount] [int] NULL
	,[EdiCancelMaxPoChangeCount] [int] NULL
	,[EdiPushMaxPoChangeCount] [int] NULL
	,[EdiPullMaxPoChangeCount] [int] NULL
	,[NonEdiPurchReq] BIT Default 0
	,[NonEdiCancel] BIT Default 0
	,[NonEdiPushOut] BIT Default 0
	,[NonEdiPullIn] BIT Default 0
	,[NonEdiPurchMinVal] [money] Default 0
	,[NonEdiPurchMaxVal] [money] DEFAULT 0
	,[NonEdiCancelMinVal] [money] Default 0
	,[NonEdiCancelMaxVal] [money] DEFAULT 0
	,[NonEdiPushMinVal] [money] Default 0
	,[NonEdiPushMaxVal] [money] DEFAULT 0
	,[NonEdiPullMinVal] [money] Default 0
	,[NonEdiPullMaxVal] [money] DEFAULT 0
	,[NonEdiPurchCancelWindowIsLeadTime] INT NULL
	,[NonEdiCancelCancelWindowIsLeadTime] INT NULL
	,[NonEdiPushCancelWindowIsLeadTime] INT NULL
	,[NonEdiPullCancelWindowIsLeadTime] INT NULL
	,[NonEdiPurchActionWindowStart] [int] NULL
	,[NonEdiPurchActionWindowEnd] [int] NULL
	,[NonEdiCancelActionWindowStart] [int] NULL
	,[NonEdiCancelActionWindowEnd] [int] NULL
	,[NonEdiPushActionWindowStart] [int] NULL
	,[NonEdiPushActionWindowEnd] [int] NULL
	,[NonEdiPullActionWindowStart] [int] NULL
	,[NonEdiPullActionWindowEnd] [int] NULL
	,NonEdiPurchZorDemand BIT Default 0
	,NonEdiCancelZorDemand BIT Default 0
	,NonEdiPushZorDemand BIT Default 0
	,NonEdiPullZorDemand BIT Default 0
	,NonEdiPurchZfcDemand BIT Default 0
	,NonEdiCancelZfcDemand BIT Default 0
	,NonEdiPushZfcDemand BIT Default 0
	,NonEdiPullZfcDemand BIT Default 0
	,NonEdiPurchZsbDemand BIT Default 0
	,NonEdiCancelZsbDemand BIT Default 0
	,NonEdiPushZsbDemand BIT Default 0
	,NonEdiPullZsbDemand BIT Default 0
	,[NonEdiPurchMaxPoChangeCount] [int] NULL
	,[NonEdiCancelMaxPoChangeCount] [int] NULL
	,[NonEdiPushMaxPoChangeCount] [int] NULL
	,[NonEdiPullMaxPoChangeCount] [int] NULL

	,[NcnrExcemption] BIT Default 0
	,[OnlySendMsEmail] BIT NULL Default 0
	,EmailFrequency INT Default 7
	,RemoveFromPopic BIT DEFAULT 0
	,[850Po] BIT Default 0
	,[855PoAck] BIT Default 0
	,[860PoChg] BIT Default 0
	,[865PoChgAck]BIT Default 0
	,[VendorNbr] [bigint] NULL 
	,Rv RowVersion
	,UserId VARCHAR(7)
	,ComputerId VARCHAR(30)
	,SqlStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL
    ,SqlEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL
	,PERIOD FOR SYSTEM_TIME (SqlStartTime, SqlEndTime),
	CONSTRAINT PkPopicRules PRIMARY KEY([Mfg], [PrcStgy], [Cc], [Grp])
)

WITH
	(
		SYSTEM_VERSIONING = ON (HISTORY_TABLE= dbo.PopicRulesHistory)
	)
;

GO