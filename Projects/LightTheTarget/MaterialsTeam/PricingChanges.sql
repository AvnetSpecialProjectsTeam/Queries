USE MDM
GO

--This query loses ALOT of records due to the inner join between the Material Table and the MatAor 
--This is because we are not interested in all parts, just the ones in the MatAor Table

SELECT dbo.ConditionItem.LastUpdateDate,[MatAor].[SrDir],[MatAor].[Pld],[MatAor].[MatlMgr],[MatAor].[MatlSpclst], dbo.Material.SapMaterialId,[MatAor].[Pbg],[MatAor].[Mfg],[MatAor].[PrcStgy],[MatAor].[Cc],[MatAor].[Grp], dbo.VendMatPurOrgPlant.SAPPurchasingOrgCD, dbo.ConditionItem.SapConditionTypeCd, dbo.ConditionItem.ConditionAM AS ConditionItemNew, dbo.ConditionItemHistory.ConditionAM AS ConditionItemOld, dbo.ConditionItem.ConditionPricingUnitQt As ConditionPricingUnitQtNew, dbo.ConditionItemHistory.ConditionPricingUnitQt As ConditionPricingUnitQtNew, dbo.ConditionItem.MinConditionQt AS MinConditionQtNew, dbo.ConditionItemHistory.MinConditionQt AS MinConditionQtOld, dbo.ConditionItem.SqlStartTime, dbo.ConditionItem.SqlEndTime
FROM dbo.ConditionHeader INNER JOIN
dbo.ConditionItem ON dbo.ConditionHeader.RowIdObject = dbo.ConditionItem.MDMConditionHeaderId INNER JOIN
dbo.VendMatPurOrgPlant ON dbo.ConditionHeader.MDMVendMatlPoPlantId = dbo.VendMatPurOrgPlant.RowIdObject INNER JOIN
dbo.VendorMaterialRel ON dbo.VendMatPurOrgPlant.MDMVendorMaterialId = dbo.VendorMaterialRel.RowIdObject INNER JOIN
dbo.Material ON dbo.VendorMaterialRel.MDMMaterialID = dbo.Material.RowIdObject INNER JOIN
dbo.ConditionItemHistory ON dbo.ConditionHeader.RowIdObject = dbo.ConditionItemHistory.RowIdObject INNER JOIN
Sap.dbo.MatAor ON MatAor.MatNbr = Material.SapMaterialId
WHERE (CAST(dbo.ConditionItemHistory.SqlEndTime AS Date) > CAST(GETDATE() - 10 AS date)) AND dbo.ConditionItem.ConditionAM <> dbo.ConditionItemHistory.ConditionAM
