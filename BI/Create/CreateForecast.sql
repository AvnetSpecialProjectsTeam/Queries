USE BI
GO

Create Table BIForecast(
ForecastParty VARCHAR(10),
SalesOrg VARCHAR(4),
DistChannel VARCHAR(2),
CustMatNbrEntered VARCHAR(35),
MatNbr VARCHAR(20),
ValidToDt Datetime2,
SourceSysId VARCHAR(2),
CustMatNbr VARCHAR(50),
ReservFl VARCHAR(1),
Plant VARCHAR(4),
ScpmId VARCHAR(12),
ConsignFl VARCHAR(1),
ProdHeir VARCHAR(18),
MfgPartNbr VARCHAR(42),
ScpmName VARCHAR(62)
)