USE MDM
GO

--This query loses some records due to the inner join between the Material Table and the MatAor 
--This is because we are not interested in all parts, just the ones in the MatAor Table

SELECT MSO.LastUpdateDate, [MatAor].[SrDir],[MatAor].[Pld],[MatAor].[MatlMgr],[MatAor].[MatlSpclst], 
dbo.Material.SapMaterialId,[MatAor].[Pbg],[MatAor].[Mfg],[MatAor].[PrcStgy],[MatAor].[Cc],[MatAor].[Grp], 
MSO.SapSalesOrgCd, MSO.SapCentralStockPlantCd, MSOH.NonCancelNonReturnFl AS NonCancelNonReturnFlOldValue, MSO.NonCancelNonReturnFl AS NonCancelNonReturnFlNewValue, MSOH.SqlStartTime, MSOH.SqlEndTime
FROM dbo.MaterialSalesOrgHistory AS MSOH INNER JOIN 
dbo.MaterialSalesOrg AS MSO ON MSOH.RowIdObject = MSO.RowIdObject INNER JOIN 
dbo.Material ON MSO.MdmMaterialId = dbo.Material.RowIdObject  INNER JOIN
SAP.dbo.MatAor on MatAor.MatNbr = dbo.Material.SapMaterialId
WHERE  (CAST(MSOH.SqlEndTime AS Date) >= CAST(GETDATE() - 3 AS date)) AND (MSO.NonCancelNonReturnFl IS NULL) AND (MSOH.NonCancelNonReturnFl IS NOT NULL) OR (CAST(MSOH.SqlEndTime AS Date) >= CAST(GETDATE() - 3 AS date)) AND (MSO.NonCancelNonReturnFl IS NOT NULL) AND (MSOH.NonCancelNonReturnFl IS NULL)