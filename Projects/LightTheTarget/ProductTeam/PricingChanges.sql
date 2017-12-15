USE MDM
GO

--This query loses ALOT of records due to the inner join between the Material Table and the MatAor 
--This is because we are not interested in all parts, just the ones in the MatAor Table

SELECT dbo.ConditionItem.LastUpdateDate, dbo.Material.SapMaterialId, dbo.VendMatPurOrgPlant.SAPPurchasingOrgCD, dbo.ConditionItem.SapConditionTypeCd, dbo.ConditionItem.ConditionAM AS ConditionItemNew, dbo.ConditionItemHistory.ConditionAM AS ConditionItemOld, dbo.ConditionItem.ConditionPricingUnitQt As ConditionPricingUnitQtNew, dbo.ConditionItemHistory.ConditionPricingUnitQt As ConditionPricingUnitQtNew, dbo.ConditionItem.MinConditionQt AS MinConditionQtNew, dbo.ConditionItemHistory.MinConditionQt AS MinConditionQtOld, dbo.ConditionItem.SqlStartTime, dbo.ConditionItem.SqlEndTime
FROM dbo.ConditionHeader INNER JOIN
dbo.ConditionItem ON dbo.ConditionHeader.RowIdObject = dbo.ConditionItem.MDMConditionHeaderId INNER JOIN
dbo.VendMatPurOrgPlant ON dbo.ConditionHeader.MDMVendMatlPoPlantId = dbo.VendMatPurOrgPlant.RowIdObject INNER JOIN
dbo.VendorMaterialRel ON dbo.VendMatPurOrgPlant.MDMVendorMaterialId = dbo.VendorMaterialRel.RowIdObject INNER JOIN
dbo.Material ON dbo.VendorMaterialRel.MDMMaterialID = dbo.Material.RowIdObject INNER JOIN
dbo.ConditionItemHistory ON (dbo.ConditionHeader.RowIdObject = dbo.ConditionItemHistory.MDMConditionHeaderId and dbo.ConditionItemHistory.RowIdObject = ConditionItem.RowIdObject)
WHERE (CAST(dbo.ConditionItem.SqlEndTime AS Date) > CAST(GETDATE() - 5 AS date)) AND dbo.ConditionItem.ConditionAM <> dbo.ConditionItemHistory.ConditionAM and sapmaterialid = '24817'

--To join with ProdAor need full product heirarchy: group, cc, tech, mfg
--Also need the sales group, sales office, account number