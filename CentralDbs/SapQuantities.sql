
--CREATE NONCLUSTERED INDEX MpHubstateIndex
--ON [dbo].[MaterialPlant] ([HubStateInd])
--INCLUDE ([MdmMaterialId],[SapPlantCd],[PlannedDeliveryDayQt],[SafetyStockQt],[ManualSupplLeadDayQt],[VendorEdiLeadDayQt],[SuppCancelWindowDayQt],[RoundingValueNo],[LeadTimeOverrideFl])



--CREATE NONCLUSTERED INDEX MsoHubStateIndex
--ON [dbo].[MaterialSalesOrg] ([SapSalesOrgCd],[HubStateInd])
--INCLUDE ([MdmMaterialId],[SalesMinimumOrderQt])

TRUNCATE TABLE Centraldbs.dbo.SapQuantities

INSERT INTO Centraldbs.dbo.SapQuantities
SELECT DISTINCT Spl.MaterialRowIdObject, Spl.MaterialNbr, Mp.SapPlantCd, Vmr.SAPPurchasingOrgCD, Spl.VendorNbr, Mp.SafetyStockQt, Mp.SuppCancelWindowDayQt, Mp.RoundingValueNo, Mp.PlannedDeliveryDayQt AS LtPlanDlvry, Mp.VendorEdiLeadDayQt AS LtVndrEdi, Mp.ManualSupplLeadDayQt AS LtManual, Mp.LeadTimeOverrideFl AS LtOverrideFl, Vmr.SupplierMinPackageQt, Vmr.SupplierMinOrderQt, Mso.SalesMinimumOrderQt
FROM (SELECT *
		FROM CentralDbs.dbo.SapPartsList AS Spl
		WHERE Spl.MatHubState<>-1 AND Spl.SendToSapFl='Y') AS Spl
	INNER JOIN (SELECT UniqueVendorMaterialRel.MDMMaterialID, Vmpop.SAPPurchasingOrgCD, Vmpop.SupplierMinPackageQt, Vmpop.SupplierMinOrderQt
				FROM (SELECT Vmr.RowIdObject, Vmr.VendorPartNo, Vmr.MDMVendorPartyId, Vmr.MDMMaterialID
						FROM MDM.dbo.VendorMaterialRel AS Vmr
						INNER JOIN (SELECT MAX(RowIdObject) AS RowIdObject
									FROM MDM.dbo.VendorMaterialRel AS Vmr
									WHERE Vmr.HubStateInd<>-1 OR Vmr.HubStateInd IS NULL
									GROUP BY MDMMaterialID) AS B 
							ON Vmr.RowIdObject = B.RowIdObject
						WHERE Vmr.HubStateInd<>-1) AS UniqueVendorMaterialRel
				INNER JOIN (SELECT Vmpop.MDMVendorMaterialId, Vmpop.SAPPurchasingOrgCD, Vmpop.SupplierMinPackageQt, Vmpop.SupplierMinOrderQt
							FROM MDM.dbo.VendMatPurOrgPlant AS Vmpop
							WHERE Vmpop.HubStateInd<>-1 AND Vmpop.SAPPirCategoryDc='0') AS Vmpop
					ON UniqueVendorMaterialRel.RowIdObject=Vmpop.MDMVendorMaterialId) AS Vmr

		ON Spl.MaterialRowIdObject=vmr.MDMMaterialID
	INNER JOIN MDM.dbo.MaterialPlant AS Mp
		ON Spl.MaterialRowIdObject=Mp.MdmMaterialId
	LEFT JOIN
		(SELECT MdmMaterialId, SalesMinimumOrderQt
		FROM MDM.dbo.MaterialSalesOrg
		WHERE  SapSalesOrgCd = 'U001' AND HubStateInd <> - 1
		GROUP BY MdmMaterialId, SalesMinimumOrderQt) AS Mso
		ON Spl.MaterialRowIdObject=Mso.MdmMaterialId
WHERE Mp.HubStateInd<>-1
	


SELECT *
FROM CentralDbs.dbo.SapQuantities
WHERE MaterialNbr=7000041281
ORDER By Plant


ALTER TABLE CentralDbs.dbo.SapQuantities
ADD CONSTRAINT PkCdbsQuantities PRIMARY KEY(MaterialNbr, Plant, PurchaseOrg)

SELECT MaterialNbr, Plant, PurchaseOrg, COUNT(MaterialNbr)
FROM
	(SELECT *
	FROM CentralDbs.dbo.sapquantities
	) AS A
GROUP BY MaterialNbr, Plant, PurchaseOrg
HAVING COUNT(MaterialNbr)>1
ORDER BY MaterialNbr, Plant, PurchaseOrg



--DROP INDEX MpHubstateIndex ON [MaterialPlant]
--DROP INDEX MsoHubStateIndex ON [MaterialSalesOrg]