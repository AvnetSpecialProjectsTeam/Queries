USE NonHaImportTesting
GO

 DROP TABLE Ausp

CREATE TABLE Ausp(
	Client varchar (4),
	[Object] varchar (51),
	InternalChar bigint,
	CharValCounter int,
	ObjectClass varchar (2),
	ClassTyp varchar (4),
	IntCounterArchivObj int,
	CharVal varchar (51),
	FloatingPtValFrom real,
	IntMeasUnItm2 varchar (4),
	FloatingPtValTo real,
	IntMeasUnItm1 varchar (4),
	CdValDependency varchar (2),
	ToleranceFrom real,
	ToleranceTo real,
	ToleranceAsPctageId varchar (2),
	IncrementWithinInterval real,
	Author varchar (2),
	ChangeNbr varchar (13),
	ValidFromDt DateTime2,
	DeletionId varchar (2),
	InternalChar1 bigint,
	InstanceCntr int,
	SortFieldAUSP int,
	CompTyp varchar (2)
)