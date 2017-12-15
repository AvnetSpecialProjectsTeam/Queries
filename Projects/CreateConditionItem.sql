
CREATE TABLE MDM.dbo.ConditionItem
(
RowIdObject INT NOT NULL PRIMARY KEY,
Creator	VARCHAR(200),
CreateDate DATETIME2,
UpdatedBy VARCHAR(200),
LasteUpdateDate DATETIME2,
ConditionIdn FLOAT NOT NULL,
DeletedInd FLOAT,
DeletedBy VARCHAR(200),
DeletedDate DATETIME2,
LastRowIdSystem VARCHAR(56) NOT NULL,
DirtyInd FLOAT,
InteractionId FLOAT,
HubStateInd FLOAT NOT NULL,
CMDirtyInd FLOAT,
ConditionAM DECIMAL(11,2) NOT NULL,
ConditionSqNo FLOAT NOT NULL,
MinConditionQt DECIMAL(15,2),
MaxConditionQt DECIMAL(15,2),
SAPCurrencyCode VARCHAR(20) NOT NULL,
MDMConditionHeaderId INT NOT NULL,
ConditionPricingUnitQt DECIMAL(5,0) NOT NULL,
SAPConditionScaleUomCD VARCHAR(12) NOT NULL,
SAPConditionTypeCD VARCHAR(16) NOT NULL
CONSTRAINT fkCondHeadCondItem FOREIGN KEY(MDMConditionHeaderId)
REFERENCES ConditionHeader(RowIdObject)
)
