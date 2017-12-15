USE [SAP]
GO

/****** Object:  Table [dbo].[Aufk]    Script Date: 10/19/2017 11:39:42 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
drop table aufk
go

CREATE TABLE [dbo].[Aufk](
	[Client] [varchar] (4) NULL,
	[OrderNbr] [varchar] (13) NULL,
	[OrderTyp] [varchar] (5) NULL,
	[OrderCat] [int],
	[Order] [varchar] (13) NULL,
	[EnteredBy] [varchar] (13) NULL,
	[CreatedOn] [date] NULL,
	[ChangedBy] [varchar] (13) NULL,
	[ChangeDtOrderMaster] [date]NULL,
	[Description] [varchar] (41) NULL,
	[LongTxtExists] [varchar] (2) NULL,
	[CoCd] [varchar] (5) NULL,
	[Plant] [varchar] (5) NULL,
	[BusArea] [varchar] (5) NULL,
	[CoArea] [varchar] (5) NULL,
	[CostCollectorKey] [varchar] (24) NULL,
	[RespCostCntr] [varchar] (11) NULL,
	[Location] [varchar] (11) NULL,
	[LocationPlant] [varchar] (5) NULL,
	[StatisticalOrderId] [varchar] (2) NULL,
	[OrderCurrency] [varchar] (6) NULL,
	[OrderStatus] [int],
	[StatusChange] [date] NULL,
	[ReachedStatus] [int],
	[Created] [varchar] (2) NULL,
	[Released] [varchar] (2) NULL,
	[Completed] [varchar] (2) NULL,
	[Closed] [varchar] (2) NULL,
	[PlannedRelease] [date] NULL,
	[Plannedcompltn] [date] NULL,
	[PlannedCloDat] [date] NULL,
	[ReleaseDt] [date] NULL,
	[TechCompletionDt] [date] NULL,
	[CloseDt] [date] NULL,
	[ObjectId] [varchar] (2) NULL,
	[DisTranGrp] [varchar] (5) NULL,
	[PurOrgData] [varchar] (2) NULL,
	[PlanLineItmems] [varchar] (2) NULL,
	[Usage] [varchar] (2) NULL,
	[Application] [varchar] (3) NULL,
	[CostingSheet] [varchar] (7) NULL,
	[OverheadKey1] [varchar] (7) NULL,
	[ProcessGrp] [int],
	[SettlementElement] [varchar] (11) NULL,
	[CostCenter] [varchar] (11) NULL,
	[GLAcct] [varchar] (11) NULL,
	[AllocationSet] [varchar] (13) NULL,
	[CostCtrTruePost] [varchar] (11) NULL,
	[ValidFrom] [date] NULL,
	[SequenceNbr] [int],
	[Applicant] [varchar] (21) NULL,
	[ApplicantPhone] [varchar] (21) NULL,
	[PersonResp] [varchar] (21) NULL,
	[PhonePersCharge] [varchar] (21) NULL,
	[EstimatedCosts] [money],
	[ApplicDt] [date] NULL,
	[Department] [varchar] (16) NULL,
	[WorkStart] [date] NULL,
	[EndOfWork] [date] NULL,
	[WorkPermitItm] [varchar] (2) NULL,
	[ObjNbrItm] [varchar] (23) NULL,
	[ProfItmCenter] [varchar] (11) NULL,
	[WbsElement] [int],
	[VarianceKey] [varchar] (7) NULL,
	[ResultAnalysisKey2] [varchar] (7) NULL,
	[TaxJur1] [varchar] (16) NULL,
	[FunctionalArea] [varchar] (17) NULL,
	[ObjectClass] [varchar] (3) NULL,
	[IntegPlanning] [varchar] (2) NULL,
	[SalesOrderNbr] [varchar] (11) NULL,
	[SalesOrderItm] [int],
	[ExtOrderNbr] [varchar] (21) NULL,
	[InvestMeasureProf] [varchar] (7) NULL,
	[LogicalSystem] [varchar] (11) NULL,
	[OrderMultiItm] [varchar] (2) NULL,
	[RequestingCoCd] [varchar] (5) NULL,
	[RequestCostCenter] [varchar] (11) NULL,
	[Scale] [varchar] (3) NULL,
	[InvestReason] [varchar] (3) NULL,
	[EnvirInvest] [varchar] (6) NULL,
	[CostCollector] [varchar] (2) NULL,
	[InterestProf] [varchar] (8) NULL,
	[PROCNRCostCollector] [varchar] (13) NULL,
	[RequestOrder] [varchar] (13) NULL,
	[ProdProcNbr] [bigint],
	[ProcessCat] [varchar] (5) NULL,
	[Refurbishment] [varchar] (2) NULL,
	[AcctId] [varchar] (3) NULL,
	[AddressNbr] [varchar] (11) NULL,
	[TimeCreated] [time] NULL,
	[ChangedAt] [time] NULL,
	[CostingVariant] [varchar] (5) NULL,
	[CostEstimateNbr] [bigint],
	[UserResponsible] [varchar] (13) NULL,
	[JointVenture] [varchar] (7) NULL,
	[RecoveryId] [varchar] (3) NULL,
	[EquityTyp] [varchar] (4) NULL,
	[ObjectTyp] [varchar] (5) NULL,
	[JibJibeClass] [varchar] (4) NULL,
	[JibJibeSbclassA] [varchar] (6) NULL,
	[OrCostObj] [varchar] (2) NULL,
	[CuOrderCompatibleUnitItm] [varchar] (9) NULL,
	[ConstructMeasureNbr] [varchar] (5) NULL,
	[AutoEstCosts] [varchar] (5) NULL,
	[CuDesignNbr] [varchar] (2) NULL,
	[MainWorkCtr] [varchar] (13) NULL,
	[WorkCntrPlant] [varchar] (2) NULL,
	[RegId] [varchar] (13) NULL,
	[ClmCreationCntrlId] [varchar] (2) NULL,
	[ClaimInconsistent] [varchar] (2) NULL,
	[ClaimUpdTrigger] [varchar] (2) NULL,
	[CustNbr] [varchar] (51) NULL,
	[MatAvailDt] [date] NULL,
	[OsiFlag] [varchar] (2) NULL,
	[OsiNbr] [varchar] (23) NULL,
	[PullDt] [date] NULL,
	[Segment] [bigint],
	[Team] [varchar] (25) NULL,
	[SplItmIdicator] [varchar] (2) NULL,
	[GsfcWorkOrder] [varchar] (21) NULL
) ON [PRIMARY]

GO
