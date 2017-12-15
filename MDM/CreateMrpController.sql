USE NonHaImportTesting
GO

CREATE TABLE MRP_CONTROLLER(
	RowidObject Int NOT NULL,
	Creator Varchar(50),
	CreateDate DateTime2(6),
	UpdatedBy Varchar(50),
	LastUpdateDate DateTime2(6),
	ConsolidationInd Int NOT NULL,
	DeletedInd Int,
	DeletedBy Varchar(50),
	DeletedDate DateTime2(6) ,
	LastRowidSystem Varchar(50) NOT NULL,
	DirtyInd Int,
	InteractionId Int,
	HubStateInd Int NOT NULL,
	CmDirtyInd Int,
	SapMrpControllerCd Varchar(50) NOT NULL,
	SapMrpControllerNm Varchar(50),
	IddDisplayName Varchar(50),
	SapPlantCd Varchar(50)
)
