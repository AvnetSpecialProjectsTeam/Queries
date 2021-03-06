CREATE TABLE VendMatPurOrgPlant
(RowIdObject INT Not Null PRIMARY KEY,
Creator VARCHAR(200),
CreateDate DATETIME2,
UpdatedBy VARCHAR(200),
LastUpdateDte DATETIME2,
CondsolidationInd Float not null,
DeletedInd Float,
DeletedBy VARCHAR(200),
DeletedDate DATETIME2,
LastRowIdSystem VARCHAR(56) not null,
DirtyInd FLOAT,
InteractionId FLOAT,
HubStateInd FLOAT NOT NULL,
CMDirtyInd FLOAT,
SAPPurchasingOrgCD VARCHAR(16) NOT NULL,
SAPPlantCD VARCHAR(16),
PriceProtectEligibleFL VARCHAR(4),
SupplierMinPackageQt Decimal(13,3),
SupplierMinOrderQt DECIMAL(13,3),
MDMVendorMaterialId INT NOT NULL,
SAPPirCategoryDc VARCHAR(4) NOT NULL,
CONSTRAINT fkVendMatRelVendMatPurOrgPlnt FOREIGN KEY(MDMVendorMaterialId)
REFERENCES VendorMaterialRel(RowIdObject)
)