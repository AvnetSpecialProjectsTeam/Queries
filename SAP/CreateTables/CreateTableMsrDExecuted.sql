USE [SAP]
GO

DROP TABLE 
[sap].[dbo].[MsrDExecuted]

CREATE TABLE [dbo].[MsrDExecuted]
(
Client varchar (4),
ProcessIdNbr varchar (11),
ItmNbr int,
SplitIdNbr int,
StepID varchar (5),
DocTyp varchar (3),
DocNbr varchar (31),
DocItm int,
StatDocItm varchar (2),
AppStatofReturns varchar (2),
SequenceIdNbr varchar (5),
ChainIdNbr varchar (5),
UtcTimeStampShortForm decimal (15),
CreatedBy varchar (13),
DocAutomCreate varchar (2),
UtcTimeStamp decimal (15),
ChangedBy varchar (13),
ReturnQuantityinBaseUoM decimal (13, 3),
BaseUnitofMeasure varchar (4),
Plant varchar (5),
StorLoc varchar (5),
StkTyp varchar (2),
Plant1 varchar (5),
VendCreditAcctNbr varchar (11),
AddressNbr varchar (11),
VendorRmaNbr varchar (31),
VendorRmaNbrReq varchar (2),
InspectCd varchar (5),
ReturnsRefundCd varchar (4),
RefundControl varchar (2),
ReturnReason varchar (4),
ReplaceMat varchar (19),
ReplaceMatQty decimal (15, 3),
ReplaceMatUom varchar (4),
AtpEncryption varchar (23),
ReplacedQtyByMat decimal (15, 3),
UomQtyCustReturns varchar (4),
CmReqQty decimal (15, 3),
UomCmReqQty varchar (4),
RejectionReason varchar (3),
RefundTyp varchar (2),
SuppPlantReplaceMat varchar (5),
PreRefundDetermined varchar (2),
ReleaseDlvryFree varchar (2),
ReleaseCmReq varchar (2),
VendorReqReplaceMat varchar (2),
SpecialStkId varchar (2),
BillingBlock varchar (3),
DlvryBlock varchar (3),
RefDocTyp varchar (3),
RefDocNbr varchar (31),
RefDocItm int,
VendorReplaceMatReceived varchar (19),
MaintFollowUp varchar (2),
TargetPlantTranStk varchar (5),
TargetMatTransStk varchar (19),
Material varchar (19),
ProcessGrReplaceMat varchar (2),
ExternalIdDlvryNote varchar (36)
) ON [PRIMARY]

GO


