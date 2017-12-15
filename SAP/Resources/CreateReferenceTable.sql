USE AdminDb

DROP TABLE SapTableReference
go 

CREATE TABLE SapTableReference(
[Columns] int,
SqlFieldNames varchar (30),
SqlDataType varchar (15),
SqlLengthPrecision int,
SqlScale int,
SqlNullable varchar (4),
ExternalFieldName varchar (30),
SapFieldNames varchar (30),
ExternalDataElement varchar (30),
ExternalDataType varchar (30),
ExternalLengthPrecision int,
ExternalScale int,
ShortDesc varchar (60),
[Table] varchar (50)
);