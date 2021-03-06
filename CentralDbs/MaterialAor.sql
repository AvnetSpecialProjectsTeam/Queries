--DROP TABLE #TempMaterialAor
SELECT DISTINCT MA.*, CAST(Pa.Personnelnumber AS BIGINT) AS EmpId
INTO #TempMaterialAor
FROM
	(SELECT Ma.material_nbr AS Material ,Ma.Pbg ,Ma.Mfg ,Ma.prc_stgy AS PrcStgy,Spl.Tech ,Ma.Cc ,Ma.Grp, Ma.sr_dir AS SrDir ,Ma.Pld ,Ma.matl_mgr AS MatlMgr ,Ma.matl_spclst AS MatlSpclst ,CASE WHEN Ma.matl_spclst ='Unassigned' THEN 'Unassigned' ELSE SUBSTRING(Ma.matl_spclst, CHARINDEX(',', Ma.matl_spclst)+2, 100) END AS FirstName , CASE WHEN LEN(SUBSTRING(Ma.matl_spclst, 1, CHARINDEX(',', Ma.matl_spclst)))<=1 THEN NULL ELSE SUBSTRING(Ma.matl_spclst, 1, CHARINDEX(',', Ma.matl_spclst)-1) END AS LastName 
	FROM NonHaImportTesting.dbo.ImportMaterialAor AS Ma
		LEFT JOIN CentralDbs.dbo.SapPartsList AS Spl
			ON Ma.material_nbr=Spl.MaterialNbr) AS Ma
	LEFT JOIN 
		(SELECT *
		FROM
			(SELECT *, DENSE_RANK() OVER(PARTITION BY Pa.FormattedNameofEmployeeorApplicant ORDER BY StartDate DESC) AS Rank1
			FROM SAP.dbo.Pa0001 AS Pa
			WHERE SYSDATETIME() BETWEEN Pa.StartDate AND Pa.EndDate) AS Pa
		WHERE Rank1=1) AS Pa
		ON CONCAT(Ma.FirstName, ' ',Ma.Lastname)=Pa.FormattedNameofEmployeeorApplicant


MERGE CentralDbs.dbo.MaterialAor AS TargetTbl
USING #TempMaterialAor AS SourceTbl
ON (TargetTbl.Material=SourceTbl.Material)
WHEN MATCHED 
	AND TargetTbl.MatlSpclst <> SourceTbl.MatlSpclst
	THEN UPDATE
		SET
			TargetTbl.SrDir = SourceTbl.SrDir
			,TargetTbl.Pld = SourceTbl.Pld
			,TargetTbl.MatlMgr = SourceTbl.MatlMgr
			,TargetTbl.MatlSpclst = SourceTbl.MatlSpclst
			,TargetTbl.FirstName = SourceTbl.FirstName
			,TargetTbl.LastName = SourceTbl.LastName
			,TargetTbl.EmpId = SourceTbl.EmpId	
WHEN NOT MATCHED BY TARGET THEN
	INSERT
		(
		[Material]
		,[Pbg]
		,[Mfg]
		,[PrcStgy]
		,[Tech]
		,[Cc]
		,[Grp]
		,[SrDir]
		,[Pld]
		,[MatlMgr]
		,[MatlSpclst]
		,[FirstName]
		,[LastName]
		,[EmpId]
		)
	VALUES(
		[Material]
		,[Pbg]
		,[Mfg]
		,[PrcStgy]
		,[Tech]
		,[Cc]
		,[Grp]
		,[SrDir]
		,[Pld]
		,[MatlMgr]
		,[MatlSpclst]
		,[FirstName]
		,[LastName]
		,[EmpId])
WHEN NOT MATCHED BY SOURCE THEN
DELETE;

