
CREATE TABLE VendorMaterialRel
(RowIdObject INT NOT NULL PRIMARY KEY,
Creator VARCHAR(200),
CreateDate DATETIME2,
UpdateBy VARCHAR(200),
LastUpdateDate DATETIME2,
ConsolidationInd FLOAT NOT NULL,
DeleteInd FLOAT,
DeleteBy VARCHAR(200),
DeleteDate DATETIME2,
LastRowIdSystem VARCHAR(56) NOT NULL,
DirtyInd FLOAT,
InteractionId FLOAT,
HubStateInd FLOAT NOT NULL,
CMDirtyInd FLOAT,
MDMMaterialID INT NOT NULL,
MDMVendorPartyId INT,
VendorPartNo VARCHAR(140),
CONSTRAINT fkMatVendMatRel FOREIGN KEY(MDMMaterialID)
REFERENCES Material(RowIdObject)
)