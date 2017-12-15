USE MDM
GO

Select dbo.Material.LastUpdateDate, [MatAor].[SrDir],[MatAor].[Pld],[MatAor].[MatlMgr],[MatAor].[MatlSpclst], dbo.Material.SapMaterialId,[MatAor].[Pbg],[MatAor].[Mfg],[MatAor].[PrcStgy],[MatAor].[Cc],[MatAor].[Grp], dbo.Material.SapMaterialStatusCd As SapMaterialStatusCdNewValue, dbo.MaterialHistory.SapMaterialStatusCd as SapMaterialStatusCdOldValue 
From Material INNER JOIN MAterialHistory on MAterial.RowIdObject = MaterialHistory.RowIdObject INNER JOIN
SAP.dbo.MatAor On MatAor.MatNbr = Material.SapMaterialId
WHERE (CAST(dbo.MaterialHistory.SqlEndTime AS Date) > CAST(GETDATE() - 5 AS date)) AND (dbo.Material.SapMaterialStatusCd <>  dbo.MaterialHistory.SapMaterialStatusCd Or (dbo.Material.SapMaterialStatusCd Is Null And dbo.MaterialHistory.SapMaterialStatusCd Is Not Null) Or (dbo.Material.SapMaterialStatusCd Is Not Null AND dbo.MaterialHistory.SapMaterialStatusCd Is Null))