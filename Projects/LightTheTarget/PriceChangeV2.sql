use mdm
go

DECLARE @Start DATETIME2 = GETDATE()-5
DECLARE @End DATETIME2=GETDATE()


Select PriceChanges.RowIdObject,
dbo.Material.SapMaterialId, dbo.VendMatPurOrgPlant.MDMVendorMaterialId, dbo.VendMatPurOrgPlant.SAPPurchasingOrgCD, 
PriceChanges.SapConditionTypeCd, PriceChanges.ConditionAM,PriceChanges.MdmUpdateDate,  PriceChanges.SqlServerStartDate, PriceChanges.SqlServerEndDate, MatAor.* --dbo.ConditionItem.ConditionPricingUnitQt As ConditionPricingUnitQtNew, dbo.ConditionItem.MinConditionQt AS MinConditionQtNew, dbo.ConditionItem.SqlStartTime, dbo.ConditionItem.SqlEndTime 
From (
SELECT Distinct B.RowidObject, B.MDMConditionHeaderId, B.MdmUpdateDate, B.SqlServerStartDate, B.SqlServerEndDate, B.ConditionAM, B.SAPConditionTypeCD
FROM
       (SELECT A.*
       FROM
             (--Grabbing all records that have a change on ConditionAm except current (current = rank 1)
			 SELECT Ci.RowIdObject, Ci.MDMConditionHeaderId, SapConditionTypeCd, CAST(Ci.LastUpdateDate AS DATE) AS MdmUpdateDate, CAST(Ci.SqlStartTime AS DATE) AS SqlServerStartDate, CAST(Ci.SqlEndTime AS DATE) AS SqlServerEndDate, Ci.ConditionAm, RANK() OVER(PARTITION BY Ci.RowIdObject ORDER BY Ci.RowIdObject,  Ci.ConditionAM) AS Rank1
             FROM MDM.dbo.ConditionItem
             FOR SYSTEM_TIME
             BETWEEN @Start AND @End AS Ci) AS A
             WHERE Rank1>1) AS A
       INNER JOIN 
             (--Grabbing everything that has changes
			 SELECT Ci.RowIdObject, Ci.MDMConditionHeaderId, SapConditionTypeCd, CAST(Ci.LastUpdateDate AS DATE) AS MdmUpdateDate, CAST(Ci.SqlStartTime AS DATE) AS SqlServerStartDate, CAST(Ci.SqlEndTime AS DATE) AS SqlServerEndDate, Ci.ConditionAm, RANK() OVER(PARTITION BY Ci.RowIdObject ORDER BY Ci.RowIdObject,  Ci.ConditionAM) AS Rank1
             FROM MDM.dbo.ConditionItem
             FOR SYSTEM_TIME
             BETWEEN @Start AND @End AS Ci) AS B
             ON A.RowIdObject=B.RowIdObject
--ORDER BY B.RowIdObject, B.SqlServerStartDate
) AS PriceChanges Inner join 
dbo.ConditionHeader On ConditionHeader.RowIdObject = PriceChanges.MdmConditionHeaderId INNER JOIN
dbo.VendMatPurOrgPlant ON dbo.ConditionHeader.MDMVendMatlPoPlantId = dbo.VendMatPurOrgPlant.RowIdObject INNER JOIN
dbo.VendorMaterialRel ON dbo.VendMatPurOrgPlant.MDMVendorMaterialId = dbo.VendorMaterialRel.RowIdObject INNER JOIN
dbo.Material ON dbo.VendorMaterialRel.MDMMaterialID = dbo.Material.RowIdObject inner join Sap.dbo.MatAor on Sap.dbo.MatAor.[MatNbr] = dbo.Material.SapMaterialId

Where sapmaterialid = 5260957
Order by PriceChanges.RowIdObject, MdmUpdateDate


