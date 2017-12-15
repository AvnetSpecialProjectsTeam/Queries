
CREATE TABLE ConditionHeader
(
RowIdObject INT Not NUll PRIMARY KEY,
Creator VARCHAR(200),
CreateDate DATETIME2,
UpdateBy VARCHAR(200),
LastUpdateDate	DATETIME2,
ConsolidationInd FLOAT NOT NULL,
DeletionInd	FLOAT,
DeletedBy VARCHAR(200),
DeletedDate	DATETIME2,
LastRowIdSystem	VARCHAR(56) NOT NULL,
DirtyInd FLOAT,
FLOATeractionId FLOAT,
HubStateInd	FLOAT NOT NULL,
CMDirtyInd FLOAT,
ConditionRecordNo VARCHAR(40),
ValidFromDt	DATETIME2 NOT NULL,
ValidToDt DATETIME2 NOT NULL,
SAPConditionTypeCode VARCHAR(16) NOT NULL,
MDMVendMatlPoPlantId INT NOT NULL,
CONSTRAINT fkVndMatPurOrgPlntCondHead FOREIGN KEY(MDMVendMatlPoPlantId)
REFERENCES VendMatPurOrgPlant(RowIdObject)
)