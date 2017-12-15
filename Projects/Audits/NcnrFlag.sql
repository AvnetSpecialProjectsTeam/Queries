SELECT DISTINCT mat.RowIdObject AS MatRow, Mat.SapMaterialId AS SapNbr, MSO.NonCancelNonReturnFl
FROM Material AS Mat INNER JOIN MaterialSalesOrg AS MSO ON Mat.RowIdObject=mso.MdmMaterialId
WHERE MSO.NonCancelNonReturnFl IS NOT NULL
--GROUP BY Mat.RowIdObject, Mat.SapMaterialId, MSO.NonCancelNonReturnFl


SELECT COUNT(*)
FROM Material AS Mat INNER JOIN MaterialSalesOrg AS MSO ON Mat.RowIdObject=mso.MdmMaterialId

SELECT COUNT(*)
FROM Material

SELECT COUNT(*)
FROM MaterialSalesOrg