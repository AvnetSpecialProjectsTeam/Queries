USE AdminDb
Go

Create Proc InsertJobHistory @JobNm Varchar(50), @TableNm varchar(50), @StepNm varchar(50)
As
Begin
Insert Into AdminDb.dbo.JobHistory (JobNm, TableNm, StepNm, StartDt, EndDt,RecordCount, Size, Status)
Select Distinct @JobNm, @TableNm, @StepNm, GetDate() As StartDate, Null As EndDate,Null, Null, NUll
End

