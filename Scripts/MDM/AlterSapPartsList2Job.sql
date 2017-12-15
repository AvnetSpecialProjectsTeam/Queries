USE [MDM]
GO

/****** Object:  View [dbo].[SAPPartsList2]    Script Date: 5/17/2017 2:11:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [dbo].[SAPPartsList2]
AS
SELECT dbo.Material.RowIdObject AS MaterialRowIdObject, dbo.Material.SapMaterialId AS MaterialNbr, dbo.Material.SapMaterialTypeCd AS MaterialType, 
                  dbo.Material.SapMatItemCatgGroupCd AS ItemCat, dbo.Material.ManufacturerPartNo AS MfgPartNbr, dbo.MaterialProdHier.SapProductBusGroupCd AS Pbg, 
                  Party_1.SapPartyId AS Mfg, dbo.MaterialProdHier.ProductHierarchyCode AS ProdHrchy, dbo.MaterialProdHier.SapProcureStrategyCd AS PrcStgy, 
                  dbo.MaterialProdHier.SapTechnologyCd AS Tech, dbo.MaterialProdHier.SapCommodityCd AS CC, dbo.MaterialProdHier.SapProductGroupCd AS Grp, 
                  dbo.Party.SapPartyId AS VendorNbr, dbo.VendorMaterialRel.VendorPartNo AS VendorPartNbr, dbo.Material.PartDs
FROM     dbo.Party AS Party_1 INNER JOIN
                  dbo.Material INNER JOIN
                  dbo.MaterialProdHier ON dbo.Material.MaterialProdHierarchyId = dbo.MaterialProdHier.RowIdObject ON 
                  Party_1.RowidObject = dbo.Material.MdmManufacturerPartyId LEFT OUTER JOIN
                  dbo.UniqueVendorMaterialRel INNER JOIN
                  dbo.VendorMaterialRel ON dbo.UniqueVendorMaterialRel.RowIdObject = dbo.VendorMaterialRel.RowIdObject INNER JOIN
                  dbo.Party ON dbo.VendorMaterialRel.MDMVendorPartyId = dbo.Party.RowidObject ON dbo.Material.RowIdObject = dbo.VendorMaterialRel.MDMMaterialID
WHERE  (dbo.Material.HubStateInd <> - 1) AND (dbo.VendorMaterialRel.HubStateInd <> - 1 OR
                  dbo.VendorMaterialRel.HubStateInd IS NULL) AND (dbo.Material.SendToSapFl = 'Y' OR
                  dbo.Material.SendToSapFl IS NULL) OR
                  (dbo.Material.HubStateInd <> - 1) AND (dbo.VendorMaterialRel.HubStateInd <> - 1 OR
                  dbo.VendorMaterialRel.HubStateInd IS NULL) AND (dbo.Material.SentToSapDate > CONVERT(DATETIME, '2015-12-31 00:00:00', 102) OR
                  dbo.Material.SentToSapDate IS NULL)
GO


