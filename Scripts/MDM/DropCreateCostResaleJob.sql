USE [msdb]
GO

/****** Object:  Job [CDBs]    Script Date: 5/11/2017 2:05:19 PM ******/
EXEC msdb.dbo.sp_delete_job @job_id=N'7963aa27-7762-4852-8a21-d4d1dc02bc71', @delete_unused_schedule=1
GO

/****** Object:  Job [CDBs]    Script Date: 5/11/2017 2:05:19 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 5/11/2017 2:05:19 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'CDBs', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'AMER\043675', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [CostResale]    Script Date: 5/11/2017 2:05:19 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'CostResale', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SELECT *
INTO ##TEMPCostResale
FROM
(
	SELECT dbo.UniqueVendorMaterialRel.MDMMaterialID, dbo.ConditionHeader.ValidFromDt AS CostValidFrom, dbo.ConditionHeader.ValidToDt AS CostValidTo, dbo.ConditionItem.SAPConditionTypeCD AS CostTypeCd, dbo.ConditionItem.MinConditionQt AS CostMinQty, dbo.ConditionItem.MaxConditionQt AS CostMaxQty,  dbo.ConditionItem.ConditionAM AS PreCost, dbo.ConditionItem.ConditionPricingUnitQt AS CostUnt, dbo.ConditionItem.ConditionSqNo AS ConditionSeqNbr, dbo.Material.MaterialDs, dbo.Material.SendToSapFl
	FROM dbo.UniqueVendorMaterialRel INNER JOIN
		dbo.ConditionHeader INNER JOIN
		dbo.ConditionItem ON dbo.ConditionHeader.RowIdObject = dbo.ConditionItem.MDMConditionHeaderId INNER JOIN
		dbo.VendMatPurOrgPlant ON dbo.ConditionHeader.MDMVendMatlPoPlantId = dbo.VendMatPurOrgPlant.RowIdObject ON dbo.UniqueVendorMaterialRel.RowIdObject = dbo.VendMatPurOrgPlant.MDMVendorMaterialId INNER JOIN
		dbo.MaterialProdHier INNER JOIN
		dbo.Material ON dbo.MaterialProdHier.RowIdObject = dbo.Material.MaterialProdHierarchyId ON dbo.UniqueVendorMaterialRel.MDMMaterialID = dbo.Material.RowidObject
	WHERE (dbo.ConditionHeader.HubStateInd <> - 1) AND (dbo.VendMatPurOrgPlant.HubStateInd <> - 1) AND (dbo.VendMatPurOrgPlant.SAPPurchasingOrgCD = ''H100'') AND (dbo.Material.HubStateInd <> - 1) AND (dbo.Material.SendToSapFl = ''Y'') AND (dbo.MaterialProdHier.SapProductBusGroupCd = ''0IT'' OR dbo.MaterialProdHier.SapProductBusGroupCd = ''0ST'') AND (dbo.ConditionHeader.ValidFromDt <= GETDATE()) AND (dbo.ConditionHeader.ValidToDt >= GETDATE()) AND (dbo.ConditionItem.ConditionSqNo < 5) AND (dbo.ConditionItem.HubStateInd <> - 1)
) AS A
GO

SELECT *
INTO ##TEMPMinQty
FROM
(
	SELECT        MDMMaterialID, CostTypeCd, MIN(CostMinQty) AS CostMinQty
	FROM            ##TEMPCostResale
	GROUP BY MDMMaterialID, CostTypeCd
	HAVING        (CostTypeCd = ''ZDC'')
	) AS B
GO

SELECT *
INTO ##TEMPPart3
FROM
(
	SELECT dbo.##TEMPCostResale.MDMMaterialID, dbo.##TEMPCostResale.CostTypeCd, dbo.##TEMPCostResale.CostMinQty, MAX(dbo.##TEMPCostResale.PreCost) AS PreCost
	FROM dbo.##TEMPCostResale INNER JOIN
		 dbo.##TEMPMinQty ON dbo.##TEMPCostResale.MDMMaterialID = dbo.##TEMPMinQty.MDMMaterialID AND dbo.##TEMPCostResale.CostTypeCd = dbo.##TEMPMinQty.CostTypeCd AND dbo.##TEMPCostResale.CostMinQty = dbo.##TEMPMinQty.CostMinQty
	GROUP BY dbo.##TEMPCostResale.MDMMaterialID, dbo.##TEMPCostResale.CostTypeCd, dbo.##TEMPCostResale.CostMinQty
) AS C
GO

DROP TABLE ##TEMPMinQty

SELECT *
INTO ##TEMPPart4
FROM
(
	SELECT dbo.##TEMPCostResale.MDMMaterialID, dbo.##TEMPCostResale.CostTypeCd, dbo.##TEMPCostResale.CostMinQty, dbo.##TEMPCostResale.CostMaxQty, dbo.##TEMPCostResale.PreCost, MAX(dbo.##TEMPCostResale.CostUnt) AS CostUnt
	FROM dbo.##TEMPPart3 INNER JOIN
		dbo.##TEMPCostResale ON dbo.##TEMPPart3.MDMMaterialID = dbo.##TEMPCostResale.MDMMaterialID AND dbo.##TEMPPart3.CostTypeCd = dbo.##TEMPCostResale.CostTypeCd AND dbo.##TEMPPart3.CostMinQty = dbo.##TEMPCostResale.CostMinQty AND dbo.##TEMPPart3.PreCost = dbo.##TEMPCostResale.PreCost
	GROUP BY dbo.##TEMPCostResale.MDMMaterialID, dbo.##TEMPCostResale.CostTypeCd, dbo.##TEMPCostResale.CostMinQty, dbo.##TEMPCostResale.CostMaxQty, dbo.##TEMPCostResale.PreCost
) AS D
GO

SELECT *
INTO ##TEMPPart5
FROM
(
	SELECT MDMMaterialID, PreCost, CostUnt, PreCost / CostUnt AS UntBookCost
	FROM dbo.##TEMPPart4
	WHERE(CostUnt <> 0)
) AS E
GO


SELECT*
INTO ##TEMPPart6
FROM 
(
	SELECT MDMMaterialID, CostTypeCd, MIN(CostMinQty) AS CostMinQty
	FROM dbo.##TEMPCostResale
	GROUP BY MDMMaterialID, CostTypeCd
	HAVING (CostTypeCd = ''ZSRP'')
) AS F
GO


SELECT *
INTO ##TEMPPart7
FROM
(
	SELECT dbo.##TEMPCostResale.MDMMaterialID, dbo.##TEMPCostResale.CostTypeCd, dbo.##TEMPCostResale.CostMinQty, MAX(dbo.##TEMPCostResale.PreCost) AS PreCost
	FROM dbo.##TEMPCostResale INNER JOIN
	dbo.##TEMPPart6 ON dbo.##TEMPCostResale.MDMMaterialID = dbo.##TEMPPart6.MDMMaterialID AND dbo.##TEMPCostResale.CostTypeCd = dbo.##TEMPPart6.CostTypeCd AND dbo.##TEMPCostResale.CostMinQty = dbo.##TEMPPart6.CostMinQty
	GROUP BY dbo.##TEMPCostResale.MDMMaterialID, dbo.##TEMPCostResale.CostTypeCd, dbo.##TEMPCostResale.CostMinQty
) AS G
GO


SELECT*
INTO ##TEMPPart8
FROM
(
	SELECT dbo.##TEMPCostResale.MDMMaterialID, dbo.##TEMPCostResale.CostTypeCd, dbo.##TEMPCostResale.CostMinQty, dbo.##TEMPCostResale.CostMaxQty, dbo.##TEMPCostResale.PreCost, MAX(dbo.##TEMPCostResale.CostUnt) AS CostUnt
	FROM dbo.##TEMPPart7 INNER JOIN
		dbo.##TEMPCostResale ON dbo.##TEMPPart7.MDMMaterialID = dbo.##TEMPCostResale.MDMMaterialID AND dbo.##TEMPPart7.CostMinQty = dbo.##TEMPCostResale.CostMinQty AND dbo.##TEMPPart7.PreCost = dbo.##TEMPCostResale.PreCost
		GROUP BY dbo.##TEMPCostResale.MDMMaterialID, dbo.##TEMPCostResale.CostTypeCd, dbo.##TEMPCostResale.CostMinQty, dbo.##TEMPCostResale.CostMaxQty, dbo.##TEMPCostResale.PreCost
) AS H
GO

SELECT*
INTO ##TEMPPart9
FROM
(
	SELECT        MDMMaterialID, PreCost, CostUnt, PreCost / CostUnt AS UnitResale
	FROM            dbo.[##TEMPPart8]
	WHERE        (PreCost <> 0)
) AS I
GO

SELECT*
INTO ##TEMPPart10
FROM
(
	SELECT        MDMMaterialID, CostTypeCd, MIN(CostMinQty) AS CostMinQty, MAX(PreCost) AS PreCost
	FROM            dbo.##TEMPCostResale
	GROUP BY MDMMaterialID, CostTypeCd
	HAVING        (CostTypeCd = ''ZMPP'')
) AS J
GO

SELECT*
INTO ##TEMPPart11
FROM
(
	SELECT dbo.##TEMPCostResale.MDMMaterialID, dbo.##TEMPCostResale.CostTypeCd, dbo.##TEMPCostResale.CostMinQty, dbo.##TEMPCostResale.CostMaxQty, dbo.##TEMPCostResale.PreCost, MAX(dbo.##TEMPCostResale.CostUnt) AS CostUnt
	FROM dbo.##TEMPCostResale INNER JOIN
	dbo.##TEMPPart10 ON dbo.##TEMPCostResale.MDMMaterialID = dbo.##TEMPPart10.MDMMaterialID AND dbo.##TEMPCostResale.CostTypeCd = dbo.##TEMPPart10.CostTypeCd AND dbo.##TEMPCostResale.CostMinQty = dbo.##TEMPPart10.CostMinQty AND dbo.##TEMPCostResale.PreCost = dbo.##TEMPPart10.PreCost
	GROUP BY dbo.##TEMPCostResale.MDMMaterialID, dbo.##TEMPCostResale.CostTypeCd, dbo.##TEMPCostResale.CostMinQty, dbo.##TEMPCostResale.CostMaxQty, dbo.##TEMPCostResale.PreCost
) AS K
GO

DROP TABLE ##TEMPCostResale

SELECT*
INTO ##TEMPPart12
FROM
(
	SELECT        MDMMaterialID, PreCost, CostUnt, PreCost / CostUnt AS UntSpecialCost
	FROM            dbo.##TEMPPart11
	WHERE        (CostUnt <> 0)
) AS L
GO

SELECT *
INTO ##TEMPPart13
FROM
(
	SELECT dbo.SAPPartsList2.MaterialRowIdObject, dbo.SAPPartsList2.MaterialNbr, dbo.##TEMPPart5.UntBookCost
	FROM dbo.SAPPartsList2 LEFT OUTER JOIN
	dbo.##TEMPPart5 ON dbo.SAPPartsList2.MaterialRowIdObject = dbo.##TEMPPart5.MDMMaterialID
) AS M
GO


SELECT *
INTO ##TEMPPart14
FROM
(
	SELECT dbo.##TEMPPart13.MaterialRowIdObject, dbo.##TEMPPart13.MaterialNbr, dbo.##TEMPPart13.UntBookCost, dbo.##TEMPPart9.UnitResale
	FROM dbo.##TEMPPart13  LEFT OUTER JOIN
		dbo.##TEMPPart9 ON dbo.##TEMPPart13.MaterialRowIdObject = dbo.##TEMPPart9.MDMMaterialID
) AS N
GO


SELECT*
INTO ##TEMPPart15
FROM
(
	SELECT dbo.##TEMPPart14.MaterialNbr, dbo.##TEMPPart14.UntBookCost, dbo.##TEMPPart14.UnitResale,ISNULL(dbo.##TEMPPart12.UntSpecialCost, 0) AS UntSpecialCost
	FROM  dbo.##TEMPPart14 LEFT OUTER JOIN
	dbo.##TEMPPart12 ON dbo.##TEMPPart14.MaterialRowIdObject = dbo.##TEMPPart12.MDMMaterialID
) AS O
GO

USE MDM
GO

TRUNCATE TABLE CostResale
Go


INSERT INTO CostResale
SELECT * 
FROM
(
	SELECT MaterialNbr AS material_nbr, UntBookCost AS unit_book_cost, UnitResale AS unit_resale, UntSpecialCost AS unit_special_cost
	FROM dbo.##TEMPPart15
) AS P
GO

DROP TABLE ##TEMPPart3
DROP TABLE ##TEMPPart4
DROP TABLE ##TEMPPart5
DROP TABLE ##TEMPPart6
DROP TABLE ##TEMPPart7
DROP TABLE ##TEMPPart8
DROP TABLE ##TEMPPart9
DROP TABLE ##TEMPPart10
DROP TABLE ##TEMPPart11
DROP TABLE ##TEMPPart12
DROP TABLE ##TEMPPart13
DROP TABLE ##TEMPPart14
DROP TABLE ##TEMPPart15', 
		@database_name=N'MDM', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=63, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20170404, 
		@active_end_date=99991231, 
		@active_start_time=34000, 
		@active_end_time=235959, 
		@schedule_uid=N'7233ef08-da19-4560-931e-8a690308125c'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


