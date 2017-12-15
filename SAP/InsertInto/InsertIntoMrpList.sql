--TRUNCATE TABLE SAP.dbo.MrpList

--INSERT INTO SAP.dbo.MrpList 
--( 
--	[Client]
--    ,[MrpDt]
--    ,MaterialNbr
--    ,[Plant]
--    ,[MrpInd]
--    ,[ReqDt]
--    ,[MrpNbr]
--    ,[MrpItem]
--    ,[SchedItem]
--    ,[ExceptnNbr]
--    ,[ExceptnKey]
--    ,[ReschedDt]
--    ,[ConfDlvryDt]
--    ,[SchDlvryDt]
--    ,[NetValue]
--    ,[PlndOrdr]
--    ,[FirmPlndOrdr]
--    ,[PurchReq]
--    ,[ProdOrdr]
--    ,[PullIn]
--    ,[Expedite]
--    ,[InsidePush]
--    ,[InsideCancel]
--    ,[ByndPush]
--    ,[ByndCancel]
--    ,[StkHigh]
--    ,[MrpCtrlr]
--    ,[PurchGrp]
--    ,[AutoBuy]
--    ,[AvnetAbc]
--    ,[SplrCancelWdw]
--    ,[MfgPartNbr]
--    ,[Mfg]
--    ,[MatlStatus]
--    ,[NcnrFl]
--    ,[CC]
--    ,[Grp]
--    ,[StkFl]
--    ,[SpecialBuy]
--    ,[MrpElemntDesc]
--	)
--SELECT
--	[Column 0]
--	,CASE 
--		WHEN Try_CAST([Column 1] As Datetime2) Is not null And [Column 1] LIKE '%[/]%' Then [Column 1]
--		When tRY_CAST(STUFF(STUFF([Column 1],5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN NULL
--		Else STUFF(STUFF([Column 1],5,0,'/'),8,0,'/')
--	END
--	,[Column 2]
--	,[Column 3]
--	,[Column 4]
--	,CASE 
--		WHEN Try_CAST([Column 5] As Datetime2) Is not null And [Column 5] LIKE '%[/]%' Then [Column 5]
--		When tRY_CAST(STUFF(STUFF([Column 5],5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN nULL
--		Else STUFF(STUFF([Column 5],5,0,'/'),8,0,'/')
--	END
--	,[Column 6]
--	,[Column 7]
--	,[Column 8]
--	,[Column 9]
--	,[Column 10]
--	,CASE
--			WHEN Try_CAST([Column 11] As Datetime2) Is not null And [Column 11] LIKE '%[/]%' Then [Column 11]
--			When tRY_CAST(STUFF(STUFF([Column 11],5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN nULL 
--			Else STUFF(STUFF([Column 11],5,0,'/'),8,0,'/')
--		END
--	,CASE
--			WHEN Try_CAST([Column 12] As Datetime2) Is not null And [Column 12] LIKE '%[/]%' Then [Column 12]
--			When tRY_CAST(STUFF(STUFF([Column 12],5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN nULL
--			Else STUFF(STUFF([Column 12],5,0,'/'),8,0,'/')
--		END
--	,CASE
--			WHEN Try_CAST([Column 13] As Datetime2) Is not null And [Column 13] LIKE '%[/]%' Then [Column 13]
--			When tRY_CAST(STUFF(STUFF([Column 13],5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN nULL
--			Else STUFF(STUFF([Column 13],5,0,'/'),8,0,'/')
--		END
--	,[Column 14]
--	,[Column 15]
--	,[Column 16]
--	,[Column 17]
--	,[Column 18]
--	,[Column 19]
--	,[Column 20]
--	,[Column 21]
--	,[Column 22]
--	,[Column 23]
--	,[Column 24]
--	,[Column 25]
--	,[Column 26]
--	,[Column 27]
--	,[Column 28]
--	,[Column 29]
--	,CASE WHEN [Column 30] LIKE '%[.]%' THEN LEFT([Column 30], CHARINDEX('.', [Column 30]) - 1)
--				ELSE [Column 30]
--			END
--	,[Column 31]
--	,[Column 32]
--	,[Column 33]
--	,[Column 34]
--	,[Column 35]
--	,[Column 36]
--	,[Column 37]
--	,[Column 38]
--	  ,Case When [Column 4] = 'BA' Then 'Purchase Requsition' When [Column 4] = 'BE' Then 'Order Item Schedule Line' When [Column 4] = 'FE' Then 'Production Order'  When [Column 4] = 'LA' Then 'Shipping Notification' When [Column 4] = 'BA' Then 'Planned Order' End
	
--FROM NonHaImportTesting.dbo.ImportMrpList 
--WHERE [Column 0] <> ' ' AND [Column 0] Is not Null


--TRUNCATE TABLE NonHaImportTesting.dbo.ImportMrpList

If (SELECT COUNT(*) From NonHaImportTesting.dbo.ImportMrpList) = 0  THROW 50000, 'Import Table Was Blank, BAD BAD BAD', 1 

SELECT *
INTO #MrpTemp
FROM(
	SELECT *, RANK() OVER(PARTITION BY [Column 6], [Column 7], [Column 8], [Column 3] ORDER BY [Column 6] ASC, [Column 7] ASC, [Column 8] ASC, [Column 3] ASC, [Column 5], [Column 4] DESC, [Column 9] ASC, [Column 11] DESC) AS Rank1
	FROM NonHaImportTesting.dbo.ImportMrpList
	WHERE [Column 0] IS NOT NULL) AS A
WHERE Rank1=1 AND [Column 0] IS NOT NULL

CREATE NONCLUSTERED INDEX PkIndex
ON #MrpTemp ([Column 6], [Column 7], [Column 8], [Column 3])


MERGE SAP.dbo.MrpList AS TargetTbl
USING #MrpTemp AS SourceTbl
ON (TargetTbl.[MrpNbr]=SourceTbl.[Column 6] AND TargetTbl.[MrpItem]=SourceTbl.[Column 7] AND TargetTbl.[SchedItem]=SourceTbl.[Column 8] AND TargetTbl.Plant=SourceTbl.[Column 3])
WHEN MATCHED 
	AND TargetTbl.[MrpDt] <> CASE 
			WHEN Try_CAST(SourceTbl.[Column 1] As Datetime2) Is not null And SourceTbl.[Column 1] LIKE '%[/]%' Then [Column 1]
			When tRY_CAST(STUFF(STUFF(SourceTbl.[Column 1],5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN NULL
			Else STUFF(STUFF(SourceTbl.[Column 1],5,0,'/'),8,0,'/')
		END
	OR TargetTbl.[MrpInd]<> SourceTbl.[Column 4]
	OR TargetTbl.[ReqDt] <> CASE 
			WHEN Try_CAST(SourceTbl.[Column 5] As Datetime2) Is not null And SourceTbl.[Column 5] LIKE '%[/]%' Then SourceTbl.[Column 5]
			When tRY_CAST(STUFF(STUFF(SourceTbl.[Column 5],5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN nULL
			Else STUFF(STUFF(SourceTbl.[Column 5],5,0,'/'),8,0,'/')
		END
	OR TargetTbl.[ExceptnNbr] <> SourceTbl.[Column 9]
	OR TargetTbl.[ReschedDt] <> CASE
			WHEN Try_CAST(SourceTbl.[Column 11] As Datetime2) Is not null And SourceTbl.[Column 11] LIKE '%[/]%' Then SourceTbl.[Column 11]
			When tRY_CAST(STUFF(STUFF(SourceTbl.[Column 11],5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN nULL 
			Else STUFF(STUFF(SourceTbl.[Column 11],5,0,'/'),8,0,'/')
		END
	OR TargetTbl.[ConfDlvryDt] <> CASE
			WHEN Try_CAST(SourceTbl.[Column 12] As Datetime2) Is not null And SourceTbl.[Column 12] LIKE '%[/]%' Then SourceTbl.[Column 12]
			When tRY_CAST(STUFF(STUFF(SourceTbl.[Column 12],5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN nULL
			Else STUFF(STUFF(SourceTbl.[Column 12],5,0,'/'),8,0,'/')
		END
	OR TargetTbl.[SchDlvryDt] <> CASE
			WHEN Try_CAST(SourceTbl.[Column 13] As Datetime2) Is not null And SourceTbl.[Column 13] LIKE '%[/]%' Then SourceTbl.[Column 13]
			When tRY_CAST(STUFF(STUFF(SourceTbl.[Column 13],5,0,'/'),8,0,'/') as DATETIME2) IS NULL THEN nULL
			Else STUFF(STUFF(SourceTbl.[Column 13],5,0,'/'),8,0,'/')
		END
	OR TargetTbl.[NetValue] <> SourceTbl.[Column 14]
	OR TargetTbl.[PurchReq] <> SourceTbl.[Column 17]

THEN
	UPDATE SET
	TargetTbl.[MrpDt] = 
		CASE 
			WHEN Try_CAST(SourceTbl.[Column 1] As DATE) Is not null And SourceTbl.[Column 1] LIKE '%[/]%' Then [Column 1]
			When tRY_CAST(STUFF(STUFF(SourceTbl.[Column 1],5,0,'/'),8,0,'/') as DATE) IS NULL THEN NULL
			Else STUFF(STUFF(SourceTbl.[Column 1],5,0,'/'),8,0,'/')
		END
	,TargetTbl.[MrpInd]= SourceTbl.[Column 4]
	,TargetTbl.[ReqDt] = 
		CASE 
			WHEN Try_CAST(SourceTbl.[Column 5] As DATE) Is not null And SourceTbl.[Column 5] LIKE '%[/]%' Then SourceTbl.[Column 5]
			When tRY_CAST(STUFF(STUFF(SourceTbl.[Column 5],5,0,'/'),8,0,'/') as DATE) IS NULL THEN nULL
			Else STUFF(STUFF(SourceTbl.[Column 5],5,0,'/'),8,0,'/')
		END
	,TargetTbl.[ExceptnNbr] = SourceTbl.[Column 9]
	,TargetTbl.[ReschedDt] = 
		CASE
			WHEN Try_CAST(SourceTbl.[Column 11] As DATE) Is not null And SourceTbl.[Column 11] LIKE '%[/]%' Then SourceTbl.[Column 11]
			When tRY_CAST(STUFF(STUFF(SourceTbl.[Column 11],5,0,'/'),8,0,'/') as DATE) IS NULL THEN nULL 
			Else STUFF(STUFF(SourceTbl.[Column 11],5,0,'/'),8,0,'/')
		END
	,TargetTbl.[ConfDlvryDt] = 
		CASE
			WHEN Try_CAST(SourceTbl.[Column 12] As DATE) Is not null And SourceTbl.[Column 12] LIKE '%[/]%' Then SourceTbl.[Column 12]
			When tRY_CAST(STUFF(STUFF(SourceTbl.[Column 12],5,0,'/'),8,0,'/') as DATE) IS NULL THEN nULL
			Else STUFF(STUFF(SourceTbl.[Column 12],5,0,'/'),8,0,'/')
		END
	,TargetTbl.[SchDlvryDt] = 
		CASE
			WHEN Try_CAST(SourceTbl.[Column 13] As DATE) Is not null And SourceTbl.[Column 13] LIKE '%[/]%' Then SourceTbl.[Column 13]
			When tRY_CAST(STUFF(STUFF(SourceTbl.[Column 13],5,0,'/'),8,0,'/') as DATE) IS NULL THEN nULL
			Else STUFF(STUFF(SourceTbl.[Column 13],5,0,'/'),8,0,'/')
		END
	,TargetTbl.[NetValue] = SourceTbl.[Column 14]
	,TargetTbl.[PurchReq] = SourceTbl.[Column 17]

WHEN NOT MATCHED BY TARGET THEN
INSERT(
[Client]
      ,[MrpDt]
      ,MaterialNbr
      ,[Plant]
      ,[MrpInd]
      ,[ReqDt]
      ,[MrpNbr]
      ,[MrpItem]
      ,[SchedItem]
      ,[ExceptnNbr]
      ,[ExceptnKey]
      ,[ReschedDt]
      ,[ConfDlvryDt]
      ,[SchDlvryDt]
      ,[NetValue]
      ,[PlndOrdr]
      ,[FirmPlndOrdr]
      ,[PurchReq]
      ,[ProdOrdr]
      ,[PullIn]
      ,[Expedite]
      ,[InsidePush]
      ,[InsideCancel]
      ,[ByndPush]
      ,[ByndCancel]
      ,[StkHigh]
      ,[MrpCtrlr]
      ,[PurchGrp]
      ,[AutoBuy]
      ,[AvnetAbc]
      ,[SplrCancelWdw]
      ,[MfgPartNbr]
      ,[Mfg]
      ,[MatlStatus]
      ,[NcnrFl]
      ,[CC]
      ,[Grp]
      ,[StkFl]
      ,[SpecialBuy]
      ,[MrpElemntDesc]
)
VALUES(
	[Column 0]
	,CASE 
		WHEN Try_CAST(SourceTbl.[Column 1] As DATE) Is not null And SourceTbl.[Column 1] LIKE '%[/]%' Then [Column 1]
		When tRY_CAST(STUFF(STUFF(SourceTbl.[Column 1],5,0,'/'),8,0,'/') as DATE) IS NULL THEN NULL
		Else STUFF(STUFF(SourceTbl.[Column 1],5,0,'/'),8,0,'/')
	END
	,[Column 2]
	,[Column 3]
	,[Column 4]
	,CASE 
		WHEN Try_CAST(SourceTbl.[Column 5] As DATE) Is not null And SourceTbl.[Column 5] LIKE '%[/]%' Then SourceTbl.[Column 5]
		When tRY_CAST(STUFF(STUFF(SourceTbl.[Column 5],5,0,'/'),8,0,'/') as DATE) IS NULL THEN nULL
		Else STUFF(STUFF(SourceTbl.[Column 5],5,0,'/'),8,0,'/')
	END
	,[Column 6]
	,[Column 7]
	,[Column 8]
	,[Column 9]
	,[Column 10]
	,CASE
			WHEN Try_CAST(SourceTbl.[Column 11] As DATE) Is not null And SourceTbl.[Column 11] LIKE '%[/]%' Then SourceTbl.[Column 11]
			When tRY_CAST(STUFF(STUFF(SourceTbl.[Column 11],5,0,'/'),8,0,'/') as DATE) IS NULL THEN nULL 
			Else STUFF(STUFF(SourceTbl.[Column 11],5,0,'/'),8,0,'/')
		END
	,CASE
			WHEN Try_CAST(SourceTbl.[Column 12] As DATE) Is not null And SourceTbl.[Column 12] LIKE '%[/]%' Then SourceTbl.[Column 12]
			When tRY_CAST(STUFF(STUFF(SourceTbl.[Column 12],5,0,'/'),8,0,'/') as DATE) IS NULL THEN nULL
			Else STUFF(STUFF(SourceTbl.[Column 12],5,0,'/'),8,0,'/')
		END
	,CASE
			WHEN Try_CAST(SourceTbl.[Column 13] As DATE) Is not null And SourceTbl.[Column 13] LIKE '%[/]%' Then SourceTbl.[Column 13]
			When tRY_CAST(STUFF(STUFF(SourceTbl.[Column 13],5,0,'/'),8,0,'/') as DATE) IS NULL THEN nULL
			Else STUFF(STUFF(SourceTbl.[Column 13],5,0,'/'),8,0,'/')
		END
	,[Column 14]
	,[Column 15]
	,[Column 16]
	,[Column 17]
	,[Column 18]
	,[Column 19]
	,[Column 20]
	,[Column 21]
	,[Column 22]
	,[Column 23]
	,[Column 24]
	,[Column 25]
	,[Column 26]
	,[Column 27]
	,[Column 28]
	,[Column 29]
	,CASE WHEN [Column 30] LIKE '%[.]%' THEN LEFT([Column 30], CHARINDEX('.', [Column 30]) - 1)
				ELSE [Column 30]
			END
	,[Column 31]
	,[Column 32]
	,[Column 33]
	,[Column 34]
	,[Column 35]
	,[Column 36]
	,[Column 37]
	,[Column 38]
	  ,Case When [Column 4] = 'BA' Then 'Purchase Requsition' When [Column 4] = 'BE' Then 'Order Item Schedule Line' When [Column 4] = 'FE' Then 'Production Order'  When [Column 4] = 'LA' Then 'Shipping Notification' When [Column 4] = 'BA' Then 'Planned Order' End
	)
WHEN NOT MATCHED BY SOURCE THEN
DELETE
;



TRUNCATE TABLE ImportMrpList
