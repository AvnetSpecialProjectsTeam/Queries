USE [msdb]
GO

/****** Object:  Job [NascarUpdateOpenShipDebit]    Script Date: 11/3/2017 1:37:05 PM ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'93ca2857-c27d-454e-a9a2-6d6fe2612492', @delete_unused_schedule=1
GO

/****** Object:  Job [NascarUpdateOpenShipDebit]    Script Date: 11/3/2017 1:37:05 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 11/3/2017 1:37:05 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'NascarUpdateOpenShipDebit', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'AMER\execmssql', 
		@notify_email_operator_name=N'specialprojectsteam', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [DBAIsPrimary]    Script Date: 11/3/2017 1:37:05 PM ******/
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
/****** Object:  Step [Update]    Script Date: 11/3/2017 1:37:05 PM ******/
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
into #NascarOSD
from(
select 
* from NascarOpenShipDebitDailyUpload) as temp

Merge NascarOpenShipDebit as TargetTbl
using #NascarOSD as SourceTbl
On( 
   TargetTbl.SoldtoParty=SourceTbl.SoldtoParty and 
   TargetTbl.ShipToParty=SourceTbl.ShipToParty and 
  TargetTbl.MaterialNbr=SourceTbl.MaterialNbr  )
When Matched 
and TargetTbl.ValidFrom <> SourceTbl.ValidFrom
or  TargetTbl.ValidTo <> SourceTbl.ValidTo
or  TargetTbl.Rate <> SourceTbl.Rate
or  TargetTbl.RemainingQtyVistex <> SourceTbl.RemainingQtyVistex
or  TargetTbl.AvnetResale <> SourceTbl.AvnetResale
or  TargetTbl.SapAgreement <> SourceTbl.SapAgreement      
or  TargetTbl.AuthorizationNbr <> SourceTbl.AuthorizationNbr 


Then 
	Update set
	TargetTbl.ValidFrom = SourceTbl.ValidFrom,
	TargetTbl.ValidTo = SourceTbl.ValidTo,
	TargetTbl.Rate = SourceTbl.Rate,
	TargetTbl.RemainingQtyVistex = SourceTbl.RemainingQtyVistex,
	TargetTbl.AvnetResale = SourceTbl.AvnetResale,
	TargetTbl.SapAgreement = SourceTbl.SapAgreement ,      
    TargetTbl.AuthorizationNbr = SourceTbl.AuthorizationNbr 

When not matched by target then
Insert (SapAgreement,AuthorizationNbr,SoldtoParty,ShiptoParty,MaterialNbr,ValidFrom,ValidTo,Rate,RemainingQtyVistex,AvnetResale)
Values(SourceTbl.SapAgreement,SourceTbl.AuthorizationNbr,SourceTbl.SoldtoParty,SourceTbl.ShiptoParty,SourceTbl.MaterialNbr,SourceTbl.ValidFrom,SourceTbl.ValidTo,SourceTbl.Rate,SourceTbl.RemainingQtyVistex,SourceTbl.AvnetResale)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;
Drop table #NascarOSD;


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
		@active_start_time=60000, 
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


