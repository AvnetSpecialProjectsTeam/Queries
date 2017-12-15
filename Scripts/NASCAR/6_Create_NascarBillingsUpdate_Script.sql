USE [msdb]
GO

/****** Object:  Job [NascarUpdateBillings]    Script Date: 11/28/2017 8:28:35 AM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 11/28/2017 8:28:35 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'NascarUpdateBillings', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'AMER\execMSSQL', 
		@notify_email_operator_name=N'specialprojectsteam', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [DBAIsPrimary]    Script Date: 11/28/2017 8:28:36 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'DBAIsPrimary', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=1, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BEGIN
IF  [dbo].[fn_hadr_group_is_primary] (''ProdMatAG01'') = 0
RAISERROR(N''Not Primary Replica - Ending Job'', 16, 1);
ELSE
PRINT ''Proceeding to next job step'';
END', 
		@database_name=N'msdb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Update]    Script Date: 11/28/2017 8:28:36 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'

use NascarProd
go
select *
into #NascarBillingsTemp
from(
select 
* from NascarBillingsImport) as temp

Merge NascarBillings as TargetTbl
using #NascarBillingsTemp as SourceTbl
On( TargetTbl.SoldToParty=SourceTbl.SoldToParty and        
    TargetTbl.MaterialNbr=SourceTbl.MaterialNbr 
	and TargetTbl.SalesDoc=SourceTbl.SalesDoc  )
When Matched 
and  TargetTbl.Qty <> SourceTbl.Qty
or  TargetTbl.OrderValue <> SourceTbl.OrderValue
or  TargetTbl.ExtResale <> SourceTbl.ExtResale
or  TargetTbl.ExtCost <> SourceTbl.ExtCost
or  TargetTbl.EndCust <> SourceTbl.EndCust

Then 
	Update set
	TargetTbl.Qty = SourceTbl.Qty,
	TargetTbl.OrderValue = SourceTbl.OrderValue,
    TargetTbl.ExtResale = SourceTbl.ExtResale,
    TargetTbl.ExtCost = SourceTbl.ExtCost,
    TargetTbl.EndCust = SourceTbl.EndCust

When not matched by target then
Insert (SoldToParty,SalesDoc,MaterialNbr,Qty,OrderValue,ExtResale,ExtCost,EndCust)
Values(SourceTbl.SoldToParty,SourceTbl.SalesDoc,SourceTbl.MaterialNbr,SourceTbl.Qty,SourceTbl.OrderValue,SourceTbl.ExtResale,SourceTbl.ExtCost,SourceTbl.EndCust)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;
Drop table #NascarBillingsTemp;
 


 

', 
		@database_name=N'NascarProd', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20171102, 
		@active_end_date=99991231, 
		@active_start_time=41000, 
		@active_end_time=235959, 
		@schedule_uid=N'53ad5ff0-2279-497b-b3aa-b4b3aaeb3fd5'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


