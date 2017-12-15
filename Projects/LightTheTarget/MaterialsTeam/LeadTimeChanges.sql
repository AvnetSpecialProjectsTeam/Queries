USE MDM
GO

--This query loses some records due to the inner join between the Material Table and the MatAor 
--This is because we are not interested in all parts, just the ones in the MatAor Table

SELECT  MP.LastUpdateDate,[MatAor].[SrDir],[MatAor].[Pld],[MatAor].[MatlMgr],[MatAor].[MatlSpclst], dbo.Material.SapMaterialId,[MatAor].[Pbg],[MatAor].[Mfg],[MatAor].[PrcStgy],[MatAor].[Cc],[MatAor].[Grp], MPH.ManualSupplLeadDayQt AS ManualSupplLeadDayQtOldValue, MP.ManualSupplLeadDayQt AS ManualSupplLeadDayQtNewValue, MPH.VendorEdiLeadDayQt AS VendorEdiLeadDayQtOldValue, MP.VendorEdiLeadDayQt AS VendorEdiLeadDayQtNewValue, MPH.LeadTimeOverrideFl AS LeadTimeOverrideFlOldValue, MP.LeadTimeOverrideFl AS LeadTimeOverrideFlNewValue, MPH.SqlStartTime, MPH.SqlEndTime
FROM dbo.MaterialPlantHistory AS MPH INNER JOIN 
dbo.MaterialPlant AS MP ON MPH.RowidObject = MP.RowidObject INNER JOIN
dbo.Material ON MP.MdmMaterialId = dbo.Material.RowIdObject INNER JOIN
SAP.dbo.MatAor ON SAP.dbo.MatAor.MatNbr = dbo.Material.SapMaterialId
WHERE  ((CAST(MPH.SqlEndTime AS Date) >= CAST(GETDATE() - 3 AS date)) AND (MP.ManualSupplLeadDayQt <> MPH.ManualSupplLeadDayQt)) OR ((CAST(MPH.SqlEndTime AS Date) >= CAST(GETDATE() - 3 AS date)) AND (MPH.VendorEdiLeadDayQt <> MP.VendorEdiLeadDayQt)) OR ((CAST(MPH.SqlEndTime AS Date) >= CAST(GETDATE() - 3 AS date)) AND ((MP.LeadTimeOverrideFl IS Null And MPH.LeadTimeOverrideFl Is Not Null) Or (MPH.LeadTimeOverrideFl IS Null And MP.LeadTimeOverrideFl Is Not Null)))