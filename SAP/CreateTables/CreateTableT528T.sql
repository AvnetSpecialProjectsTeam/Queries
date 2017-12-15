USE SAP
GO
Create Table T528T(
Client Varchar (3),
LangKey Varchar (1),
ObjectTyp Varchar (2),
Position int,
EndDt Datetime2,
StartDt Datetime2,
PositShortTxt Varchar (30),
MaintOfTblEntryOm Varchar (1)
)

--Truncate final table to prepare for import
Truncate Table T528T
--Update Queries to Format Data
--Insert Into Statement
Insert Into T528T Select * From ImportT528T Where [Column 0] <> ' ' AND [Column 0] Is Not Null
--Truncate Import Table to free up space
Truncate Table ImportT528T

