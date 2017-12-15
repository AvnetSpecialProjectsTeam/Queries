
TRUNCATE TABLE CentralDbs.dbo.SapFlagsCodes

INSERT INTO CentralDbs.dbo.SapFlagsCodes


SELECT DISTINCT Spl.MaterialRowIdObject, Spl.MaterialNbr, Mp.SapPlantCd, M.SapEcomStockStrategyCd AS eComm, M.MdmWebCd, M.SapMaterialStatusCd, Mp.AbcCd, Mp.SapStockingProfile,  A.NonCancelNonReturnFl
FROM (SELECT Spl.MaterialRowIdObject, Spl.MaterialNbr, Spl.SendToSapFl
		FROM CentralDbs.dbo.SapPartsList AS Spl
		WHERE Spl.SendToSapFl='Y' AND Spl.MatHubState<>-1
		GROUP BY Spl.MaterialRowIdObject, Spl.MaterialNbr, Spl.SendToSapFl) AS Spl
INNER JOIN MDM.dbo.Material AS M
	ON Spl.MaterialRowIdObject = M.RowIdObject
INNER JOIN MDM.dbo.MaterialPlant AS Mp
	ON M.RowIdObject = Mp.MdmMaterialId
LEFT OUTER JOIN
	(SELECT DISTINCT Mso.MdmMaterialId, Mso.NonCancelNonReturnFl
			FROM     MDM.dbo.MaterialSalesOrg AS Mso
			WHERE  (Mso.HubStateInd <> - 1) AND (Mso.SapSalesOrgCd = 'U001')) AS A
	ON M.RowIdObject=A.MdmMaterialId
WHERE  (Mp.HubStateInd <> - 1)


