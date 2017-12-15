Use AdminDb
Go

Create Proc UpdateJobHistorySuccess @JobNm Varchar(50), @TableNm varchar(50), @StepNm varchar(50), @Status varchar(50)
As
Begin
Declare @LastRunDt Datetime2(7)

Set @LastRunDt = (Select StartDt From(
Select *, Rank() Over (Partition by JobNm, StepNm, TableNm Order by JobNm, StepNm, TableNm, StartDt Desc) As LastRunRank From AdminDb.dbo.JobHistory Where JobNm = @JobNm and StepNm = @StepNm And TableNm = @TableNm) as LastRun 
Where LastRunRank = 1)

If @StepNm = 'Data Flow'
Begin
CREATE TABLE #tmpTableSizes
(
    tableName varchar(100),
    numberofRows varchar(100),
    reservedSize varchar(50),
    dataSize varchar(50),
    indexSize varchar(50),
    unusedSize varchar(50)
)
Set @TableNm = 'Import'+@TableNm
insert #tmpTableSizes
Exec sp_spaceused @TableNm
Select * From #tmpTableSizes

Update AdminDb.dbo.JobHistory Set EndDt = GetDate(), RecordCount = numberofRows, Status = @Status, Size = dataSize From #tmpTableSizes
Where JobNm = @JobNm and StepNm = @StepNm And TableNm = @TableNm and @LastRunDt = StartDt
End
Else If @StepNm = 'Insert'
Begin
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
Exec sp_spaceused @TableNm
Select * From #tmpTableSizes
Update AdminDb.dbo.JobHistory Set EndDt = GetDate(), RecordCount = numberofRows, Status = @Status, Size = dataSize From #tmpTableSizes
Where JobNm = @JobNm and StepNm = @StepNm And TableNm = @TableNm and @LastRunDt = StartDt

End
Update AdminDb.dbo.JobHistory Set EndDt = GetDate(), RecordCount = Case When @StepNm = Null Then Null When @StepNm = 'Script' Then 1 When @StepNm = 'Insert' Then 2 When @StepNm = 'Data Flow' Then 3 Else Null End, Status = @Status, Size = Case When @StepNm = Null Then Null When @StepNm = 'Script' Then 1 When @StepNm = 'Insert' Then 2 When @StepNm = 'Data Flow' Then 3 Else Null End
Where JobNm = @JobNm and StepNm = @StepNm And TableNm = @TableNm and @LastRunDt = StartDt
End