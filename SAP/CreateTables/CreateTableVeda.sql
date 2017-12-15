USE [SAP]
GO

/****** Object:  Table [dbo].[Vbpa]    Script Date: 10/20/2017 10:15:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Veda](
	[Client] [varchar] (3) NULL,
	[SalesDocNbr] [varchar] (10) NULL,
	[SalesDocItm] [int] NULL,
	[ValidityPeriodContract] [int] NULL,
	[ValidityPeriodContractUnit] [varchar] (1) NULL,
	[ValPeriodCat] [varchar] (2) NULL,
	[InstallDt] [datetime2] NULL,
	[AcceptanceDt] [datetime2] NULL,
	[ContractStartDt] [datetime2] NULL,
	[ContractSignedDt] [datetime2] NULL,
	[CancelProced] [varchar] (4) NULL,
	[EocAction] [varchar] (4) NULL,
	[ReceiptOfCancDt] [datetime2] NULL,
	[ReqCancelDt] [datetime2] NULL,
	[CancelParty] [varchar] (1) NULL,
	[ReasonCancel] [varchar] (2) NULL,
	[ContractEndDt] [datetime2] NULL,
	[CancelDocNbr] [varchar] (20) NULL,
	[CancelDocDt] [datetime2] NULL,
	[ContractStartRule] [varchar] (2) NULL,
	[LeadTimeActivity] [int] NULL,
	[LeadTimeUnit] [varchar] (1) NULL,
	[DismantleDt] [datetime2] NULL,
	[AccDt] [datetime2] NULL,
	[WorkItemId] [int] NULL,
	[AccDtRule] [varchar] (2) NULL,
	[ContractEndRuleDt] [varchar] (2) NULL,
) ON [PRIMARY]

GO
