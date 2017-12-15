USE MDM

SELECT *
INTO #CRTEMPCostResale
FROM
(
	SELECT dbo.UniqueVendorMaterialRel.MDMMaterialID, dbo.ConditionHeader.ValidFromDt AS CostValidFrom, dbo.ConditionHeader.ValidToDt AS CostValidTo, dbo.ConditionItem.SAPConditionTypeCD AS CostTypeCd, dbo.ConditionItem.MinConditionQt AS CostMinQty, dbo.ConditionItem.MaxConditionQt AS CostMaxQty,  dbo.ConditionItem.ConditionAM AS PreCost, dbo.ConditionItem.ConditionPricingUnitQt AS CostUnt, dbo.ConditionItem.ConditionSqNo AS ConditionSeqNbr, dbo.Material.MaterialDs, dbo.Material.SendToSapFl
	FROM dbo.UniqueVendorMaterialRel INNER JOIN
		dbo.ConditionHeader INNER JOIN
		dbo.ConditionItem ON dbo.ConditionHeader.RowIdObject = dbo.ConditionItem.MDMConditionHeaderId INNER JOIN
		dbo.VendMatPurOrgPlant ON dbo.ConditionHeader.MDMVendMatlPoPlantId = dbo.VendMatPurOrgPlant.RowIdObject ON dbo.UniqueVendorMaterialRel.RowIdObject = dbo.VendMatPurOrgPlant.MDMVendorMaterialId INNER JOIN
		dbo.MaterialProdHier INNER JOIN
		dbo.Material ON dbo.MaterialProdHier.RowIdObject = dbo.Material.MaterialProdHierarchyId ON dbo.UniqueVendorMaterialRel.MDMMaterialID = dbo.Material.RowidObject
	WHERE (dbo.ConditionHeader.HubStateInd <> - 1) AND (dbo.VendMatPurOrgPlant.HubStateInd <> - 1) AND (dbo.VendMatPurOrgPlant.SAPPurchasingOrgCD = 'H100') AND (dbo.Material.HubStateInd <> - 1) AND (dbo.Material.SendToSapFl = 'Y') AND (dbo.MaterialProdHier.SapProductBusGroupCd = '0IT' OR dbo.MaterialProdHier.SapProductBusGroupCd = '0ST') AND (dbo.ConditionHeader.ValidFromDt <= GETDATE()) AND (dbo.ConditionHeader.ValidToDt >= GETDATE()) AND (dbo.ConditionItem.ConditionSqNo < 5) AND (dbo.ConditionItem.HubStateInd <> - 1)
) AS A
GO

SELECT *
INTO #CRTEMPMinQty
FROM
(
	SELECT        MDMMaterialID, CostTypeCd, MIN(CostMinQty) AS CostMinQty
	FROM            #CRTEMPCostResale
	GROUP BY MDMMaterialID, CostTypeCd
	HAVING        (CostTypeCd = 'ZDC')
	) AS B
GO

SELECT *
INTO #CRTempPart3
FROM
(
	SELECT dbo.#CRTEMPCostResale.MDMMaterialID, dbo.#CRTEMPCostResale.CostTypeCd, dbo.#CRTEMPCostResale.CostMinQty, MAX(dbo.#CRTEMPCostResale.PreCost) AS PreCost
	FROM dbo.#CRTEMPCostResale INNER JOIN
		 dbo.#CRTEMPMinQty ON dbo.#CRTEMPCostResale.MDMMaterialID = dbo.#CRTEMPMinQty.MDMMaterialID AND dbo.#CRTEMPCostResale.CostTypeCd = dbo.#CRTEMPMinQty.CostTypeCd AND dbo.#CRTEMPCostResale.CostMinQty = dbo.#CRTEMPMinQty.CostMinQty
	GROUP BY dbo.#CRTEMPCostResale.MDMMaterialID, dbo.#CRTEMPCostResale.CostTypeCd, dbo.#CRTEMPCostResale.CostMinQty
) AS C
GO

DROP TABLE #CRTEMPMinQty

SELECT *
INTO #CRTempPart4
FROM
(
	SELECT dbo.#CRTEMPCostResale.MDMMaterialID, dbo.#CRTEMPCostResale.CostTypeCd, dbo.#CRTEMPCostResale.CostMinQty, dbo.#CRTEMPCostResale.CostMaxQty, dbo.#CRTEMPCostResale.PreCost, MAX(dbo.#CRTEMPCostResale.CostUnt) AS CostUnt
	FROM dbo.#CRTempPart3 INNER JOIN
		dbo.#CRTEMPCostResale ON dbo.#CRTempPart3.MDMMaterialID = dbo.#CRTEMPCostResale.MDMMaterialID AND dbo.#CRTempPart3.CostTypeCd = dbo.#CRTEMPCostResale.CostTypeCd AND dbo.#CRTempPart3.CostMinQty = dbo.#CRTEMPCostResale.CostMinQty AND dbo.#CRTempPart3.PreCost = dbo.#CRTEMPCostResale.PreCost
	GROUP BY dbo.#CRTEMPCostResale.MDMMaterialID, dbo.#CRTEMPCostResale.CostTypeCd, dbo.#CRTEMPCostResale.CostMinQty, dbo.#CRTEMPCostResale.CostMaxQty, dbo.#CRTEMPCostResale.PreCost
) AS D
GO

SELECT *
INTO #CRTempPart5
FROM
(
	SELECT MDMMaterialID, PreCost, CostUnt, PreCost / CostUnt AS UntBookCost
	FROM dbo.#CRTempPart4
	WHERE(CostUnt <> 0)
) AS E
GO


SELECT*
INTO #CRTempPart6
FROM 
(
	SELECT MDMMaterialID, CostTypeCd, MIN(CostMinQty) AS CostMinQty
	FROM dbo.#CRTEMPCostResale
	GROUP BY MDMMaterialID, CostTypeCd
	HAVING (CostTypeCd = 'ZSRP')
) AS F
GO


SELECT *
INTO #CRTempPart7
FROM
(
	SELECT dbo.#CRTEMPCostResale.MDMMaterialID, dbo.#CRTEMPCostResale.CostTypeCd, dbo.#CRTEMPCostResale.CostMinQty, MAX(dbo.#CRTEMPCostResale.PreCost) AS PreCost
	FROM dbo.#CRTEMPCostResale INNER JOIN
	dbo.#CRTempPart6 ON dbo.#CRTEMPCostResale.MDMMaterialID = dbo.#CRTempPart6.MDMMaterialID AND dbo.#CRTEMPCostResale.CostTypeCd = dbo.#CRTempPart6.CostTypeCd AND dbo.#CRTEMPCostResale.CostMinQty = dbo.#CRTempPart6.CostMinQty
	GROUP BY dbo.#CRTEMPCostResale.MDMMaterialID, dbo.#CRTEMPCostResale.CostTypeCd, dbo.#CRTEMPCostResale.CostMinQty
) AS G
GO


SELECT*
INTO #CRTempPart8
FROM
(
	SELECT dbo.#CRTEMPCostResale.MDMMaterialID, dbo.#CRTEMPCostResale.CostTypeCd, dbo.#CRTEMPCostResale.CostMinQty, dbo.#CRTEMPCostResale.CostMaxQty, dbo.#CRTEMPCostResale.PreCost, MAX(dbo.#CRTEMPCostResale.CostUnt) AS CostUnt
	FROM dbo.#CRTempPart7 INNER JOIN
		dbo.#CRTEMPCostResale ON dbo.#CRTempPart7.MDMMaterialID = dbo.#CRTEMPCostResale.MDMMaterialID AND dbo.#CRTempPart7.CostMinQty = dbo.#CRTEMPCostResale.CostMinQty AND dbo.#CRTempPart7.PreCost = dbo.#CRTEMPCostResale.PreCost
		GROUP BY dbo.#CRTEMPCostResale.MDMMaterialID, dbo.#CRTEMPCostResale.CostTypeCd, dbo.#CRTEMPCostResale.CostMinQty, dbo.#CRTEMPCostResale.CostMaxQty, dbo.#CRTEMPCostResale.PreCost
) AS H
GO

SELECT*
INTO #CRTempPart9
FROM
(
	SELECT        MDMMaterialID, PreCost, CostUnt, PreCost / CostUnt AS UnitResale
	FROM            dbo.[#CRTempPart8]
	WHERE        (PreCost <> 0)
) AS I
GO

SELECT*
INTO #CRTempPart10
FROM
(
	SELECT        MDMMaterialID, CostTypeCd, MIN(CostMinQty) AS CostMinQty, MAX(PreCost) AS PreCost
	FROM            dbo.#CRTEMPCostResale
	GROUP BY MDMMaterialID, CostTypeCd
	HAVING        (CostTypeCd = 'ZMPP')
) AS J
GO

SELECT*
INTO #CRTempPart11
FROM
(
	SELECT dbo.#CRTEMPCostResale.MDMMaterialID, dbo.#CRTEMPCostResale.CostTypeCd, dbo.#CRTEMPCostResale.CostMinQty, dbo.#CRTEMPCostResale.CostMaxQty, dbo.#CRTEMPCostResale.PreCost, MAX(dbo.#CRTEMPCostResale.CostUnt) AS CostUnt
	FROM dbo.#CRTEMPCostResale INNER JOIN
	dbo.#CRTempPart10 ON dbo.#CRTEMPCostResale.MDMMaterialID = dbo.#CRTempPart10.MDMMaterialID AND dbo.#CRTEMPCostResale.CostTypeCd = dbo.#CRTempPart10.CostTypeCd AND dbo.#CRTEMPCostResale.CostMinQty = dbo.#CRTempPart10.CostMinQty AND dbo.#CRTEMPCostResale.PreCost = dbo.#CRTempPart10.PreCost
	GROUP BY dbo.#CRTEMPCostResale.MDMMaterialID, dbo.#CRTEMPCostResale.CostTypeCd, dbo.#CRTEMPCostResale.CostMinQty, dbo.#CRTEMPCostResale.CostMaxQty, dbo.#CRTEMPCostResale.PreCost
) AS K
GO

DROP TABLE #CRTEMPCostResale

SELECT*
INTO #CRTempPart12
FROM
(
	SELECT        MDMMaterialID, PreCost, CostUnt, PreCost / CostUnt AS UntSpecialCost
	FROM            dbo.#CRTempPart11
	WHERE        (CostUnt <> 0)
) AS L
GO

--SAP Parts list
SELECT dbo.Material.RowIdObject AS MaterialRowIdObject, dbo.Material.SapMaterialId AS MaterialNbr, dbo.Material.SapMaterialTypeCd AS MaterialType, 
                  dbo.Material.SapMatItemCatgGroupCd AS ItemCat, dbo.Material.ManufacturerPartNo AS MfgPartNbr, dbo.MaterialProdHier.SapProductBusGroupCd AS Pbg, 
                  Party_1.SapPartyId AS Mfg, dbo.MaterialProdHier.ProductHierarchyCode AS ProdHrchy, dbo.MaterialProdHier.SapProcureStrategyCd AS PrcStgy, 
                  dbo.MaterialProdHier.SapTechnologyCd AS Tech, dbo.MaterialProdHier.SapCommodityCd AS CC, dbo.MaterialProdHier.SapProductGroupCd AS Grp, 
                  dbo.Party.SapPartyId AS VendorNbr, dbo.VendorMaterialRel.VendorPartNo AS VendorPartNbr, dbo.Material.PartDs
INTO #CrSapPartsList
FROM     dbo.Party AS Party_1 INNER JOIN
                  dbo.Material INNER JOIN
                  dbo.MaterialProdHier ON dbo.Material.MaterialProdHierarchyId = dbo.MaterialProdHier.RowIdObject ON 
                  Party_1.RowidObject = dbo.Material.MdmManufacturerPartyId LEFT OUTER JOIN
                  dbo.UniqueVendorMaterialRel INNER JOIN
                  dbo.VendorMaterialRel ON dbo.UniqueVendorMaterialRel.RowIdObject = dbo.VendorMaterialRel.RowIdObject INNER JOIN
                  dbo.Party ON dbo.VendorMaterialRel.MDMVendorPartyId = dbo.Party.RowidObject ON dbo.Material.RowIdObject = dbo.VendorMaterialRel.MDMMaterialID
WHERE  (dbo.Material.HubStateInd <> - 1) AND (dbo.VendorMaterialRel.HubStateInd <> - 1 OR
                  dbo.VendorMaterialRel.HubStateInd IS NULL) AND (dbo.Material.SendToSapFl = 'Y') OR
                  (dbo.Material.HubStateInd <> - 1) AND (dbo.VendorMaterialRel.HubStateInd <> - 1 OR
                  dbo.VendorMaterialRel.HubStateInd IS NULL) AND (dbo.Material.SentToSapDate > CONVERT(DATETIME, '2015-12-31 00:00:00', 102));
GO


SELECT *
INTO #CRTempPart13
FROM
(
	SELECT dbo.#CrSapPartsList.MaterialRowIdObject, dbo.#CrSapPartsList.MaterialNbr, dbo.#CRTempPart5.UntBookCost
	FROM dbo.#CrSapPartsList LEFT OUTER JOIN
	dbo.#CRTempPart5 ON dbo.#CrSapPartsList.MaterialRowIdObject = dbo.#CRTempPart5.MDMMaterialID
) AS M
GO

DROP TABLE #CrSapPartsList

SELECT *
INTO #CRTempPart14
FROM
(
	SELECT dbo.#CRTempPart13.MaterialRowIdObject, dbo.#CRTempPart13.MaterialNbr, dbo.#CRTempPart13.UntBookCost, dbo.#CRTempPart9.UnitResale
	FROM dbo.#CRTempPart13  LEFT OUTER JOIN
		dbo.#CRTempPart9 ON dbo.#CRTempPart13.MaterialRowIdObject = dbo.#CRTempPart9.MDMMaterialID
) AS N
GO


SELECT*
INTO #CRTempPart15
FROM
(
	SELECT dbo.#CRTempPart14.MaterialNbr, dbo.#CRTempPart14.UntBookCost, dbo.#CRTempPart14.UnitResale,ISNULL(dbo.#CRTempPart12.UntSpecialCost, 0) AS UntSpecialCost
	FROM  dbo.#CRTempPart14 LEFT OUTER JOIN
	dbo.#CRTempPart12 ON dbo.#CRTempPart14.MaterialRowIdObject = dbo.#CRTempPart12.MDMMaterialID
) AS O
GO

USE MDM
GO

TRUNCATE TABLE Centraldbs.dbo.CostResale
Go


INSERT INTO Centraldbs.dbo.CostResale
SELECT * 
FROM
(
	SELECT DISTINCT MaterialNbr 
	,UntBookCost
	,UnitResale
	,UntSpecialCost
	FROM dbo.#CRTempPart15
) AS P
GO

DROP TABLE #CRTempPart3
DROP TABLE #CRTempPart4
DROP TABLE #CRTempPart5
DROP TABLE #CRTempPart6
DROP TABLE #CRTempPart7
DROP TABLE #CRTempPart8
DROP TABLE #CRTempPart9
DROP TABLE #CRTempPart10
DROP TABLE #CRTempPart11
DROP TABLE #CRTempPart12
DROP TABLE #CRTempPart13
DROP TABLE #CRTempPart14
DROP TABLE #CRTempPart15