USE [msdb]
GO

/****** Object:  Job [UpdateNascarMaterialValueThreshold]    Script Date: 10/11/2017 10:01:54 AM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 10/11/2017 10:01:54 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'UpdateNascarMaterialValueThreshold', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'AMER\execmssqldev', 
		@notify_email_operator_name=N'specialprojectsteam', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [DBAIs Primary]    Script Date: 10/11/2017 10:01:54 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'DBAIs Primary', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
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
/****** Object:  Step [Step 2]    Script Date: 10/11/2017 10:01:54 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Step 2', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'use [NascarProd]
go
select *
into ##NascarMaterialThersholdValueTemp
from(
select 
MaterialNbr,
iif((OverwriteFlag = ''x'' or OverwriteFlag = ''X''),OverwriteThresholdValue,ThresholdValue) as ThresholdValue,
  WindowsUsername
from NascarFrontEnd) as temp

Merge NascarMaterialThresholdValue as TargetTbl
using ##NascarMaterialThersholdValueTemp as SourceTbl
On(TargetTbl.MaterialNbr=SourceTbl.MaterialNbr)
When Matched 
and TargetTbl.ThresholdValue <> SourceTbl.ThresholdValue
Then 
	Update set
	TargetTbl.ThresholdValue = SourceTbl.ThresholdValue,
	TargetTbl.WindowsUsername = SourceTbl.WindowsUserName

When not matched by target then
Insert (MaterialNbr,ThresholdValue,WindowsUsername)
Values(SourceTbl.MaterialNbr,SourceTbl.ThresholdValue,SourceTbl.WindowsUsername)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;

drop table ##NascarMaterialThersholdValueTemp;

', 
		@database_name=N'NascarProd', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Schedule', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20171011, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'47f45018-1f32-4519-aab8-1892f0fe7df6'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


