USE SAP
GO

TRUNCATE TABLE Knvh

Insert Into Knvh
(
Client,
HierTyp,
SoldToPartyId,
SalesOrg,
DistrChannel,
Division,
ValidFrom,
ValidTo,
HighLvlCust,
HighLvlSalesOrg,
HighLvlDistrib,
HighLvlDivis,
RoutineNbr,
Rebate,
PriceDetermin,
HierAssign
)
Select
	[Column 0]
	,[Column 1]
	,[Column 2]
	,[Column 3]
	,[Column 4]
	,[Column 5]
	,TRY_CAST([Column 6] AS DATE)
	,TRY_CAST([Column 7] AS DATE)
	,[Column 8]
	,[Column 9]
	,[Column 10]
	,[Column 11]
	,[Column 12]
	,[Column 13]
	,[Column 14]
	,[Column 15]

From NonHaImportTesting.dbo.ImportKnvh
WHERE [Column 0] IS NOT NULL AND [Column 0]<>''


TRUNCATE TABLE NonHaImportTesting.dbo.ImportKnvh;