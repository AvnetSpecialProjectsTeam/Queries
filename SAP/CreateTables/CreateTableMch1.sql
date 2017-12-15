USE [SAP]
GO


DROP TABLE sap.Dbo.Mch1

CREATE TABLE [dbo].[Mch1](
Client varchar (4),
Material varchar (19),
BatchNbr varchar (11),
ValTyp varchar (2),
CreatedOn datetime2,
EnteredBy varchar (13),
ChangedBy varchar (13),
LastChange datetime2,
AvailableDt datetime2,
ShelfLifeExp datetime2,
BatchStatusKey varchar (2),
BatchRestr varchar (2),
LastChangeDt datetime2,
Vendor varchar (11),
VendorBatch varchar (16),
OriginBatch varchar (11),
Plant varchar (5),
OriginMat varchar (19),
BatchIssueUnit int,
LastGoodsRec datetime2,
DtUnrUse1 datetime2,
DtUnrUse2 datetime2,
DtUnrUse3 datetime2,
DtUnrUse4 datetime2,
DtUnrUse5 datetime2,
DtUnrUse6 datetime2 ,
CtryOfOrigin varchar (4),
RegOfOrigin varchar (4),
ExpImportGrp varchar (5),
NextInspect datetime2,
MfgDt datetime2,
IntObjNbrBatchClass1 int,
BatchDeactivated varchar (2),
BatchTyp varchar (2),
StkSegment varchar (17),
) ON [PRIMARY]

GO


