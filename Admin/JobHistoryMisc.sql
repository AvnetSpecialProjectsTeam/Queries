Drop Table AdminDb.dbo.JobHistory 
Create Table AdminDb.dbo.JobHistory(
JobNm varchar(50) Not Null,
TableNm varchar(50)Not Null,
StepNm varchar(50)Not Null,
StartDt Datetime2 Not Null,
EndDt Datetime2,
Duration as Case When EndDt > Cast('2016-01-01 00:00:00.0000000' as datetime2) Then DateDiff(MINUTE,StartDt,EndDt) Else Null End,
RecordCount bigint,
Size bigint,
Status varchar(50),
Constraint Status_Values Check (Status in ('Success', 'Error'))
)

CREATE TABLE #tmpTableSizes
(
    tableName varchar(100),
    numberofRows varchar(100),
    reservedSize varchar(50),
    dataSize varchar(50),
    indexSize varchar(50),
    unusedSize varchar(50)
)
insert #tmpTableSizes
EXEC sp_MSforeachtable @command1="EXEC sp_spaceused 'ZfcUploadLog'"

Select numberofRows From #tmpTableSizes

Select * From Admindb.dbo.JobHistory 

Create AdminDb.dbo.InsertJobHistory @JobNm Varchar(50), @TableNm varchar(50), @StepNm varchar(50)
As
Begin
Insert Into AdminDb.dbo.JobHistory (JobNm, TableNm, StepNm, StartDt, EndDt,RecordCount, Size, Status)
Select Distinct @JobNm, @TableNm, @StepNm, GetDate() As StartDate, Null As EndDate,Null, Null, NUll
End

USE [AdminDb]
GO
Create Proc [dbo].[CheckBiImportTable] @ImportTableName Varchar(50)
As
Begin
DECLARE @cmd NVARCHAR (255)
SET @cmd = 'If (SELECT COUNT(*) From Bi.dbo.' + @ImportTableName + ') = 0  THROW 50000, ''Import Table Was Blank, BAD BAD BAD'', 1'
EXEC sp_executesql @cmd
End

EXEC CheckBiImportTable 'TableName'
