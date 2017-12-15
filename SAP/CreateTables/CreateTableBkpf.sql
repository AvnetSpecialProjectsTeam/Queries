Use SAP
GO

Drop table Bkpf

Create Table Bkpf
(
Client varchar (4),
CoCd varchar (5),
AcctDocNbr varchar (11),
FY int,
DocTyp varchar (3),
DocDt datetime2,
DocPostingDt datetime2,
[Period] int,
EnteredOnDt datetime2,
EnteredAtTime1 time (6),
ChangeDtOrderMaster datetime2,
LastUpDt datetime2,
TranslationDt datetime2,
UserNameUSNAM varchar (13),
TransactionCode varchar (41),
CrossCoCdPostTransNbr varchar (47),
RefDocNbr varchar (60),
RecEntryDocNbr varchar (50),
ReversedWith varchar (15),
FYReverseDoc int,
DocHeaderTxt varchar (46),
OrderCurr varchar (6),
ExchangeRate decimal (9, 5),
GrpCurr varchar (6),
GroupExchRate decimal (9, 5),
DocStat varchar (2),
DocPostId varchar (2),
UnplDlvryCosts money,
BackPostingId varchar (2),
BusTrans varchar (5),
BatchInputSessName varchar (13),
DocNameArchSys varchar (41),
ExtractIdDocHeader varchar (11),
InternalDocTyp varchar (3),
RefTrans varchar (6),
RefKey varchar (21),
FinMgmtArea varchar (5),
LocalCurr varchar (6),
LocalCurr2Key varchar (6),
LocalCurr3Key varchar (6),
ExchangeRate2 decimal (9, 5),
ExchangeRate3 decimal (9, 5),
SourceCurr1 varchar (2),
SourceCurr2 varchar (2),
TransDt2Curr varchar (2),
TransDt3Curr varchar (2),
ReversalFlagId varchar (2),
ReversalDt datetime2,
CalculateTax varchar (2),
[2LocalCurrTyp] varchar (3),
[3LocalCurrTyp] varchar (3),
ExchRateTyp varchar (5),
ExchRateTyp1 varchar (5),
NetEntry varchar (2),
SourceCoCd varchar (5),
TaxDetailId varchar (2),
DataTransStatus varchar (2),
LogicalSys varchar (11),
RateForTaxe decimal (9, 5),
RequestNbr varchar (11),
BExBfDueDtId varchar (2),
ReversalReason varchar (3),
ParkedBy varchar (13),
BranchNbr varchar (5),
NbrOfPages int,
DiscountDocId varchar (2),
RefKeyDocHead1 varchar (21),
RefKeyDocHead2 varchar (21),
ReversalId varchar (2),
InvRecptDt datetime2,
Ledger varchar (3),
LedgerGrp varchar (5),
MgmtDt varchar (14),
AltRefNbr varchar (27),
TaxReportDt datetime2,
RequestCat varchar (3),
Reason varchar (11),
Region varchar (11),
ReversalReasonIsPSrequests varchar (2),
FileNbr varchar (31),
IntFormula varchar (5),
InterestCalcDt datetime2,
PostingDay datetime2,
Actual varchar (2),
ChangedOn datetime2,
ChangedAt time (6),
PmtTransTyp varchar (2),
CardTyp varchar (5),
CardNbr varchar (26),
SamplingBlock varchar (2),
LotNbrDoc varchar (11),
UserNameSNAME varchar (13),
SampledInvoice varchar (2),
PpaExcludeId varchar (2),
BudgetLedgerId varchar (2),
OffsetStatus varchar (3),
DtReferred datetime2,
ReasonDelay varchar (3),
DocCondNbr varchar (11),
SplPostingId varchar (2),
CashFlowRelvDoc varchar (2),
FollowOn varchar (2),
Reorganized varchar (2),
SubsetFico varchar (5),
ExchRateTyp2 varchar (5),
MdExchangeRate decimal (28, 14),
MdExchRate2 decimal (28, 14),
MdExchRate3 decimal (28, 14),
DocFromMca varchar (2),
FIDocClass varchar (7),
ResubmissionDt datetime2,
F15Belegstatus varchar (2)

)