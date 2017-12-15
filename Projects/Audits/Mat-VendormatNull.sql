SELECT 
	Mat.RowIdObject AS MatRow
	,Mat.SapMaterialId
	,mat.SapMaterialTypeCd
	,VMR.RowIdObject AS VmrRow
FROM 
	Material AS Mat LEFT JOIN VendorMaterialRel AS VMR ON Mat.RowIdObject = VMR.MDMMaterialID
WHERE 
	VMR.RowIdObject IS NULL AND mat.SapMaterialTypeCd is null AND Mat.HubStateInd<>-1 AND mat.SendToSapFl='Y' 
ORDER BY 
	MatRow

SELECT *
FROM Material
WHERE Material.SapMaterialId=7000023387