TRUNCATE TABLE CentralDbs.dbo.SapPartslist




INSERT INTO CentralDbs.dbo.SapPartslist
SELECT SPLB.MaterialRowIdObject, SPLB.MaterialNbr, SPLB.MaterialType, SPLB.ItemCat, SPLB.MfgPartNbr, SPLB.Pbg, SPLB.Mfg, SPLB.ProdHrchy, SPLB.PrcStgy, SPLB.Tech, SPLB.CC, SPLB.Grp, SPLB.VendorNbr, SPLB.VendorPartNbr, SPLB.PartDs, SPLB.MatHubState, SPLB.SendToSapFl,CoreMatBkn.BknMaterialNbr, BknMatCore.CoreMaterialNbr, CASE WHEN SPLB.MfgPartNbr LIKE '%BKN' AND BknMatCore.CoreMaterialNbr IS NULL THEN 'X' END AS BknNoCore
FROM

		(SELECT M.RowIdObject AS MaterialRowIdObject, M.SapMaterialId AS MaterialNbr, M.SapMaterialTypeCd AS MaterialType, M.SapMatItemCatgGroupCd AS ItemCat, M.ManufacturerPartNo AS MfgPartNbr, Mph.SapProductBusGroupCd AS Pbg, Party_1.SapPartyId AS Mfg, Mph.ProductHierarchyCode AS ProdHrchy, Mph.SapProcureStrategyCd AS PrcStgy, Mph.SapTechnologyCd AS Tech, Mph.SapCommodityCd AS CC, Mph.SapProductGroupCd AS Grp, P.SapPartyId AS VendorNbr, Vmr.VendorPartNo AS VendorPartNbr, M.PartDs,M.HubStateInd AS MatHubState, M.SendToSapFl, Vmr.HubStateInd AS VendMatHubState
		FROM (SELECT P.RowidObject, P.SapPartyId
				FROM MDM.dbo.Party AS P
				WHERE P.MdmPriPartyRoleTypeCd='VNDR' AND P.SapVendorAcctGroupCd='MFGR' AND P.HubStateInd<>-1) AS Party_1
		INNER JOIN MDM.dbo.Material AS M
		INNER JOIN MDM.dbo.MaterialProdHier AS Mph
			ON M.MaterialProdHierarchyId = Mph.RowIdObject
			ON Party_1.RowidObject = M.MdmManufacturerPartyId
			--LEFT OUTER JOIN dbo.UniqueVendorMaterialRel
		LEFT OUTER JOIN MDM.dbo.VendorMaterialRel AS Vmr
		INNER JOIN (SELECT Vmr.RowIdObject, Vmr.VendorPartNo, Vmr.MDMVendorPartyId, Vmr.MDMMaterialID
						FROM MDM.dbo.VendorMaterialRel AS Vmr
						INNER JOIN (SELECT MAX(RowIdObject) AS RowIdObject
									FROM MDM.dbo.VendorMaterialRel AS Vmr
									WHERE Vmr.HubStateInd<>-1 OR Vmr.HubStateInd IS NULL
									GROUP BY MDMMaterialID) AS B 
							ON Vmr.RowIdObject = B.RowIdObject
						WHERE Vmr.HubStateInd<>-1) AS UniqueVendorMaterialRel  
			ON UniqueVendorMaterialRel.RowIdObject = Vmr.RowIdObject
		INNER JOIN (SELECT P.RowidObject, P.SapPartyId 
					FROM MDM.dbo.Party AS P
					WHERE P.MdmPriPartyRoleTypeCd='VNDR' AND TRY_CONVERT(INT, P.SapPartyId) IS NOT NULL AND P.HubStateInd<>-1) AS P
			ON Vmr.MDMVendorPartyId = P.RowidObject
			ON M.RowIdObject = Vmr.MDMMaterialID
		WHERE (M.SentToSapDate > CONVERT(DATETIME, '2015-12-31 00:00:00', 102) OR M.SentToSapDate IS NULL)) AS SPLB
LEFT OUTER JOIN

	(SELECT SapPart1.MaterialNbr AS CoreMaterialNbr, BKNlist.BknMaterialNbr
	FROM
		(SELECT M.SapMaterialId AS MaterialNbr,M.ManufacturerPartNo AS MfgPartNbr, Mph.SapProductBusGroupCd AS Pbg, Party_1.SapPartyId AS Mfg, Mph.SapProcureStrategyCd AS PrcStgy
				FROM 
					(SELECT P.RowidObject, P.SapPartyId
						FROM MDM.dbo.Party AS P
						WHERE P.MdmPriPartyRoleTypeCd='VNDR' AND P.SapVendorAcctGroupCd='MFGR' AND P.HubStateInd<>-1) AS Party_1
				INNER JOIN MDM.dbo.Material AS M
				INNER JOIN MDM.dbo.MaterialProdHier AS Mph 
					ON M.MaterialProdHierarchyId = Mph.RowIdObject
					ON Party_1.RowidObject = M.MdmManufacturerPartyId 
				WHERE ((M.SentToSapDate > CONVERT(DATETIME, '2015-12-31 00:00:00', 102) OR M.SentToSapDate IS NULL))) AS SapPart1
		INNER JOIN
		--BKN SapMat#, BKN Mfg#, Mfg, PrcStgy, CoreMfg# 
			(SELECT M.SapMaterialId AS BknMaterialNbr, M.ManufacturerPartNo AS BKNMfgNbr,  LEFT(ManufacturerPartNo, LEN(ManufacturerPartNo) - 4) AS CoreMfgNbr, Mph.SapProductBusGroupCd AS Pbg, Party_1.SapPartyId AS Mfg, Mph.SapProcureStrategyCd AS PrcStgy
			FROM (SELECT P.RowidObject, P.SapPartyId
						FROM MDM.dbo.Party AS P
						WHERE P.MdmPriPartyRoleTypeCd='VNDR' AND P.SapVendorAcctGroupCd='MFGR' AND P.HubStateInd<>-1) AS Party_1
			INNER JOIN MDM.dbo.Material AS M
			INNER JOIN MDM.dbo.MaterialProdHier AS Mph ON M.MaterialProdHierarchyId = Mph.RowIdObject ON Party_1.RowidObject = M.MdmManufacturerPartyId
			WHERE ((M.SendToSapFl = 'Y' OR M.SendToSapFl IS NULL) AND (M.HubStateInd <> - 1) OR (M.HubStateInd <> - 1) AND (M.SentToSapDate > CONVERT(DATETIME, '2015-12-31 00:00:00', 102) OR M.SentToSapDate IS NULL)) AND (M.ManufacturerPartNo LIKE '%/BKN')) AS BKNlist
			ON SapPart1.Mfg =BKNlist.Mfg AND SapPart1.PrcStgy = BKNlist.PrcStgy AND SapPart1.MfgPartNbr = BKNlist.CoreMfgNbr) AS CoreMatBkn
ON SPLB.MaterialNbr=CoreMatBkn.CoreMaterialNbr 
LEFT OUTER JOIN

	(SELECT SapPart1.MaterialNbr AS CoreMaterialNbr, BKNlist.BknMaterialNbr
	FROM
		(SELECT M.SapMaterialId AS MaterialNbr,M.ManufacturerPartNo AS MfgPartNbr, Mph.SapProductBusGroupCd AS Pbg, Party_1.SapPartyId AS Mfg, Mph.SapProcureStrategyCd AS PrcStgy
				FROM 
					(SELECT P.RowidObject, P.SapPartyId
						FROM MDM.dbo.Party AS P
						WHERE P.MdmPriPartyRoleTypeCd='VNDR' AND P.SapVendorAcctGroupCd='MFGR' AND P.HubStateInd<>-1) AS Party_1
				INNER JOIN MDM.dbo.Material AS M
				INNER JOIN MDM.dbo.MaterialProdHier AS Mph 
					ON M.MaterialProdHierarchyId = Mph.RowIdObject
					ON Party_1.RowidObject = M.MdmManufacturerPartyId 
				WHERE ((M.SentToSapDate > CONVERT(DATETIME, '2015-12-31 00:00:00', 102) OR M.SentToSapDate IS NULL))) AS SapPart1
		INNER JOIN
		--BKN SapMat#, BKN Mfg#, Mfg, PrcStgy, CoreMfg# 
			(SELECT M.SapMaterialId AS BknMaterialNbr, M.ManufacturerPartNo AS BKNMfgNbr,  LEFT(ManufacturerPartNo, LEN(ManufacturerPartNo) - 4) AS CoreMfgNbr, Mph.SapProductBusGroupCd AS Pbg, Party_1.SapPartyId AS Mfg, Mph.SapProcureStrategyCd AS PrcStgy
			FROM (SELECT P.RowidObject, P.SapPartyId
						FROM MDM.dbo.Party AS P
						WHERE P.MdmPriPartyRoleTypeCd='VNDR' AND P.SapVendorAcctGroupCd='MFGR' AND P.HubStateInd<>-1) AS Party_1
			INNER JOIN MDM.dbo.Material AS M
			INNER JOIN MDM.dbo.MaterialProdHier AS Mph ON M.MaterialProdHierarchyId = Mph.RowIdObject ON Party_1.RowidObject = M.MdmManufacturerPartyId
			WHERE ((M.SendToSapFl = 'Y' OR M.SendToSapFl IS NULL) AND (M.HubStateInd <> - 1) OR (M.HubStateInd <> - 1) AND (M.SentToSapDate > CONVERT(DATETIME, '2015-12-31 00:00:00', 102) OR M.SentToSapDate IS NULL)) AND (M.ManufacturerPartNo LIKE '%/BKN')) AS BKNlist
			ON SapPart1.Mfg =BKNlist.Mfg AND SapPart1.PrcStgy = BKNlist.PrcStgy AND SapPart1.MfgPartNbr = BKNlist.CoreMfgNbr) AS BknMatCore
ON SPLB.MaterialNbr=BknMatCore.BknMaterialNbr
