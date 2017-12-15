SELECT *
FROM MDM.dbo.Material AS M
WHERE M.SapMaterialId=9956271

--Material Sales Org
SELECT M.RowIdObject, Mso.*
FROM MDM.dbo.Material AS M INNER JOIN Mdm.dbo.MaterialSalesOrg AS Mso ON M.RowIdObject=Mso.MdmMaterialId
WHERE M.SapMaterialId=7000041281


SELECT MSo.MdmMaterialId, Mso.SapCentralStockPlantCd, Mso.SapSalesOrgCd, COUNT(Mso.MdmMaterialId)
FROM Mdm.dbo.MaterialSalesOrg AS MSO
WHERE Mso.HubStateInd<>-1
GROUP BY MSo.MdmMaterialId, Mso.SapCentralStockPlantCd, Mso.SapSalesOrgCd
HAVING COUNT(Mso.MdmMaterialId)>1


--DELETE FROM MaterialSalesOrg
--WHERE RowIdObject=63515223



--Vendor Material
SELECT M.RowIdObject, vmr.*
FROM MDM.dbo.Material AS M INNER JOIN Mdm.dbo.VendorMaterialRel AS vmr ON M.RowIdObject=vmr.MdmMaterialId
WHERE M.SapMaterialId=209412


--Vendor Material Purch Org Plant
SELECT M.RowIdObject, Vmpop.*
FROM MDM.dbo.Material AS M INNER JOIN Mdm.dbo.VendorMaterialRel AS vmr ON M.RowIdObject=vmr.MdmMaterialId INNER JOIN mdm.dbo.VendMatPurOrgPlant AS Vmpop ON vmr.RowIdObject=Vmpop.MDMVendorMaterialId
WHERE M.SapMaterialId=6019639

SELECT DISTINCT  M.RowIdObject AS MaterialRowID , M.SapMaterialId, Vmpop.SAPPurchasingOrgCD
FROM
	(SELECT Vmpop.MDMVendorMaterialId, Vmpop.SAPPurchasingOrgCD, Vmpop.SAPPirCategoryDc, COUNT(Vmpop.SAPPurchasingOrgCD) AS [Count]
		FROM Mdm.dbo.VendMatPurOrgPlant AS Vmpop
		WHERE HubStateInd<>-1
		GROUP BY Vmpop.MDMVendorMaterialId, Vmpop.SAPPurchasingOrgCD, Vmpop.SAPPirCategoryDc
		HAVING COUNT(Vmpop.SAPPurchasingOrgCD)>1) AS Vmpop
LEFT JOIN Mdm.dbo.VendorMaterialRel AS Vmr ON Vmpop.MDMVendorMaterialId=Vmr.RowIdObject
LEFT JOIN MDM.dbo.Material AS M ON Vmr.MdmMaterialId=M.RowIdObject
INNER JOIN MDM.dbo.VendMatPurOrgPlant AS Vmpop1 ON Vmpop1.MDMVendorMaterialId=Vmpop.MDMVendorMaterialId AND Vmpop1.SAPPurchasingOrgCD=Vmpop.SAPPurchasingOrgCD
WHERE M.HubStateInd<>-1 AND M.SendToSapFl='Y'

--Material Plant
SELECT M.RowIdObject, M.SapMaterialId, Mp.*
FROM MDM.dbo.Material AS M INNER JOIN Mdm.dbo.MaterialPlant AS Mp ON M.RowIdObject=Mp.MdmMaterialId
WHERE M.SapMaterialId=5246718
ORDER BY Mp.RowidObject, Mp.SapPlantCd

SELECT DISTINCT M.RowIdObject, M.SapMaterialId, Mp.SapPlantCd
FROM
	(SELECT Mp.MdmMaterialId, Mp.SapPlantCd, COUNT(Mp.SapPlantCd) AS [Count]
	FROM Mdm.dbo.MaterialPlant AS Mp
	WHERE HubStateInd<>-1
	GROUP BY Mp.MdmMaterialId, Mp.SapPlantCd
	HAVING COUNT(Mp.SapPlantCd)>1) AS Mp
LEFT JOIN MDM.dbo.Material AS M ON Mp.MdmMaterialId=M.RowIdObject
INNER JOIN MDM.dbo.MaterialPlant AS Mp1 ON Mp.MdmMaterialId=Mp1.MdmMaterialId AND MP1.SapPlantCd=Mp.SapPlantCd
WHERE M.HubStateInd<>-1 AND M.SendToSapFl='Y'


--DELETE FROM MDM.dbo.MaterialPlant
--WHERE RowidObject=35096186

--ConditionItem
SELECT M.RowIdObject
FROM MDM.dbo.Material AS M
	INNER JOIN MDM.dbo.VendorMaterialRel AS Vmr
		ON M.RowIdObject=Vmr.MDMMaterialID
		INNER JOIN MDM.dbo.VendMatPurOrgPlant AS Vmpop
			ON Vmr.RowIdObject=Vmpop.MDMVendorMaterialId
			INNER JOIN MDM.dbo.ConditionHeader AS Ch
				ON Vmpop.RowIdObject=Ch.MDMVendMatlPoPlantId
				INNER JOIN MDM.dbo.ConditionItem AS Ci
					ON Ch.RowIdObject=Ci.MDMConditionHeaderId
WHERE M.SapMaterialId=5260957


SELECT M.SapMaterialId, Ci.ConditionAM, Ci.SAPConditionTypeCD, Ch.ValidFromDt, Ch.ValidToDt
FROM MDM.dbo.Material AS M
	INNER JOIN MDM.dbo.VendorMaterialRel AS Vmr
		ON M.RowIdObject=Vmr.MDMMaterialID
		INNER JOIN MDM.dbo.VendMatPurOrgPlant AS Vmpop
			ON Vmr.RowIdObject=Vmpop.MDMVendorMaterialId
			INNER JOIN MDM.dbo.ConditionHeader AS Ch
				ON Vmpop.RowIdObject=Ch.MDMVendMatlPoPlantId
				INNER JOIN MDM.dbo.ConditionItem AS Ci
					ON Ch.RowIdObject=Ci.MDMConditionHeaderId
WHERE M.SapMaterialId=5260957 AND M.HubStateInd<>-1 AND Vmr.HubStateInd<>-1 AND Vmpop.HubStateInd<>-1 AND Ci.HubStateInd<>-1 AND Ch.HubStateInd<>-1


SELECT *
FROM CentralDbs.dbo.CostResale
WHERE MaterialNbr=5260957