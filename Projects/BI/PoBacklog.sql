USE MDM

SELECT *
INTO #PoBlTempCostResale
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
INTO #PoBlTempMinQty
FROM
(
	SELECT        MDMMaterialID, CostTypeCd, MIN(CostMinQty) AS CostMinQty
	FROM            #PoBlTempCostResale
	GROUP BY MDMMaterialID, CostTypeCd
	HAVING        (CostTypeCd = 'ZDC')
	) AS B
GO

SELECT *
INTO #PoBlTempPart3
FROM
(
	SELECT dbo.#PoBlTempCostResale.MDMMaterialID, dbo.#PoBlTempCostResale.CostTypeCd, dbo.#PoBlTempCostResale.CostMinQty, MAX(dbo.#PoBlTempCostResale.PreCost) AS PreCost
	FROM dbo.#PoBlTempCostResale INNER JOIN
		 dbo.#PoBlTempMinQty ON dbo.#PoBlTempCostResale.MDMMaterialID = dbo.#PoBlTempMinQty.MDMMaterialID AND dbo.#PoBlTempCostResale.CostTypeCd = dbo.#PoBlTempMinQty.CostTypeCd AND dbo.#PoBlTempCostResale.CostMinQty = dbo.#PoBlTempMinQty.CostMinQty
	GROUP BY dbo.#PoBlTempCostResale.MDMMaterialID, dbo.#PoBlTempCostResale.CostTypeCd, dbo.#PoBlTempCostResale.CostMinQty
) AS C
GO

DROP TABLE #PoBlTempMinQty

SELECT *
INTO #PoBlTempPart4
FROM
(
	SELECT dbo.#PoBlTempCostResale.MDMMaterialID, dbo.#PoBlTempCostResale.CostTypeCd, dbo.#PoBlTempCostResale.CostMinQty, dbo.#PoBlTempCostResale.CostMaxQty, dbo.#PoBlTempCostResale.PreCost, MAX(dbo.#PoBlTempCostResale.CostUnt) AS CostUnt
	FROM dbo.#PoBlTempPart3 INNER JOIN
		dbo.#PoBlTempCostResale ON dbo.#PoBlTempPart3.MDMMaterialID = dbo.#PoBlTempCostResale.MDMMaterialID AND dbo.#PoBlTempPart3.CostTypeCd = dbo.#PoBlTempCostResale.CostTypeCd AND dbo.#PoBlTempPart3.CostMinQty = dbo.#PoBlTempCostResale.CostMinQty AND dbo.#PoBlTempPart3.PreCost = dbo.#PoBlTempCostResale.PreCost
	GROUP BY dbo.#PoBlTempCostResale.MDMMaterialID, dbo.#PoBlTempCostResale.CostTypeCd, dbo.#PoBlTempCostResale.CostMinQty, dbo.#PoBlTempCostResale.CostMaxQty, dbo.#PoBlTempCostResale.PreCost
) AS D
GO

SELECT *
INTO #PoBlTempPart5
FROM
(
	SELECT MDMMaterialID, PreCost, CostUnt, PreCost / CostUnt AS UntBookCost
	FROM dbo.#PoBlTempPart4
	WHERE(CostUnt <> 0)
) AS E
GO


SELECT*
INTO #PoBlTempPart6
FROM 
(
	SELECT MDMMaterialID, CostTypeCd, MIN(CostMinQty) AS CostMinQty
	FROM dbo.#PoBlTempCostResale
	GROUP BY MDMMaterialID, CostTypeCd
	HAVING (CostTypeCd = 'ZSRP')
) AS F
GO


SELECT *
INTO #PoBlTempPart7
FROM
(
	SELECT dbo.#PoBlTempCostResale.MDMMaterialID, dbo.#PoBlTempCostResale.CostTypeCd, dbo.#PoBlTempCostResale.CostMinQty, MAX(dbo.#PoBlTempCostResale.PreCost) AS PreCost
	FROM dbo.#PoBlTempCostResale INNER JOIN
	dbo.#PoBlTempPart6 ON dbo.#PoBlTempCostResale.MDMMaterialID = dbo.#PoBlTempPart6.MDMMaterialID AND dbo.#PoBlTempCostResale.CostTypeCd = dbo.#PoBlTempPart6.CostTypeCd AND dbo.#PoBlTempCostResale.CostMinQty = dbo.#PoBlTempPart6.CostMinQty
	GROUP BY dbo.#PoBlTempCostResale.MDMMaterialID, dbo.#PoBlTempCostResale.CostTypeCd, dbo.#PoBlTempCostResale.CostMinQty
) AS G
GO


SELECT*
INTO #PoBlTempPart8
FROM
(
	SELECT dbo.#PoBlTempCostResale.MDMMaterialID, dbo.#PoBlTempCostResale.CostTypeCd, dbo.#PoBlTempCostResale.CostMinQty, dbo.#PoBlTempCostResale.CostMaxQty, dbo.#PoBlTempCostResale.PreCost, MAX(dbo.#PoBlTempCostResale.CostUnt) AS CostUnt
	FROM dbo.#PoBlTempPart7 INNER JOIN
		dbo.#PoBlTempCostResale ON dbo.#PoBlTempPart7.MDMMaterialID = dbo.#PoBlTempCostResale.MDMMaterialID AND dbo.#PoBlTempPart7.CostMinQty = dbo.#PoBlTempCostResale.CostMinQty AND dbo.#PoBlTempPart7.PreCost = dbo.#PoBlTempCostResale.PreCost
		GROUP BY dbo.#PoBlTempCostResale.MDMMaterialID, dbo.#PoBlTempCostResale.CostTypeCd, dbo.#PoBlTempCostResale.CostMinQty, dbo.#PoBlTempCostResale.CostMaxQty, dbo.#PoBlTempCostResale.PreCost
) AS H
GO

SELECT*
INTO #PoBlTempPart9
FROM
(
	SELECT        MDMMaterialID, PreCost, CostUnt, PreCost / CostUnt AS UnitResale
	FROM            dbo.[#PoBlTempPart8]
	WHERE        (PreCost <> 0)
) AS I
GO

SELECT*
INTO #PoBlTempPart10
FROM
(
	SELECT        MDMMaterialID, CostTypeCd, MIN(CostMinQty) AS CostMinQty, MAX(PreCost) AS PreCost
	FROM            dbo.#PoBlTempCostResale
	GROUP BY MDMMaterialID, CostTypeCd
	HAVING        (CostTypeCd = 'ZMPP')
) AS J
GO

SELECT*
INTO #PoBlTempPart11
FROM
(
	SELECT dbo.#PoBlTempCostResale.MDMMaterialID, dbo.#PoBlTempCostResale.CostTypeCd, dbo.#PoBlTempCostResale.CostMinQty, dbo.#PoBlTempCostResale.CostMaxQty, dbo.#PoBlTempCostResale.PreCost, MAX(dbo.#PoBlTempCostResale.CostUnt) AS CostUnt
	FROM dbo.#PoBlTempCostResale INNER JOIN
	dbo.#PoBlTempPart10 ON dbo.#PoBlTempCostResale.MDMMaterialID = dbo.#PoBlTempPart10.MDMMaterialID AND dbo.#PoBlTempCostResale.CostTypeCd = dbo.#PoBlTempPart10.CostTypeCd AND dbo.#PoBlTempCostResale.CostMinQty = dbo.#PoBlTempPart10.CostMinQty AND dbo.#PoBlTempCostResale.PreCost = dbo.#PoBlTempPart10.PreCost
	GROUP BY dbo.#PoBlTempCostResale.MDMMaterialID, dbo.#PoBlTempCostResale.CostTypeCd, dbo.#PoBlTempCostResale.CostMinQty, dbo.#PoBlTempCostResale.CostMaxQty, dbo.#PoBlTempCostResale.PreCost
) AS K
GO

DROP TABLE #PoBlTempCostResale

SELECT*
INTO #PoBlTempPart12
FROM
(
	SELECT        MDMMaterialID, PreCost, CostUnt, PreCost / CostUnt AS UntSpecialCost
	FROM            dbo.#PoBlTempPart11
	WHERE        (CostUnt <> 0)
) AS L
GO

--SAP Parts list
SELECT dbo.Material.RowIdObject AS MaterialRowIdObject, dbo.Material.SapMaterialId AS MaterialNbr, dbo.Material.SapMaterialTypeCd AS MaterialType, 
                  dbo.Material.SapMatItemCatgGroupCd AS ItemCat, dbo.Material.ManufacturerPartNo AS MfgPartNbr, dbo.MaterialProdHier.SapProductBusGroupCd AS Pbg, 
                  Party_1.SapPartyId AS Mfg, dbo.MaterialProdHier.ProductHierarchyCode AS ProdHrchy, dbo.MaterialProdHier.SapProcureStrategyCd AS PrcStgy, 
                  dbo.MaterialProdHier.SapTechnologyCd AS Tech, dbo.MaterialProdHier.SapCommodityCd AS CC, dbo.MaterialProdHier.SapProductGroupCd AS Grp, 
                  dbo.Party.SapPartyId AS VendorNbr, dbo.VendorMaterialRel.VendorPartNo AS VendorPartNbr, dbo.Material.PartDs
INTO #PoBlSapPL
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
INTO #PoBlTempPart13
FROM
(
	SELECT dbo.#PoBlSapPL.MaterialRowIdObject, dbo.#PoBlSapPL.MaterialNbr, dbo.#PoBlTempPart5.UntBookCost
	FROM dbo.#PoBlSapPL LEFT OUTER JOIN
	dbo.#PoBlTempPart5 ON dbo.#PoBlSapPL.MaterialRowIdObject = dbo.#PoBlTempPart5.MDMMaterialID
) AS M
GO

DROP TABLE #PoBlSapPL

SELECT *
INTO #PoBlTempPart14
FROM
(
	SELECT dbo.#PoBlTempPart13.MaterialRowIdObject, dbo.#PoBlTempPart13.MaterialNbr, dbo.#PoBlTempPart13.UntBookCost, dbo.#PoBlTempPart9.UnitResale
	FROM dbo.#PoBlTempPart13  LEFT OUTER JOIN
		dbo.#PoBlTempPart9 ON dbo.#PoBlTempPart13.MaterialRowIdObject = dbo.#PoBlTempPart9.MDMMaterialID
) AS N
GO


SELECT*
INTO #PoBlTempPart15
FROM
(
	SELECT dbo.#PoBlTempPart14.MaterialNbr, dbo.#PoBlTempPart14.UntBookCost, dbo.#PoBlTempPart14.UnitResale,ISNULL(dbo.#PoBlTempPart12.UntSpecialCost, 0) AS UntSpecialCost
	FROM  dbo.#PoBlTempPart14 LEFT OUTER JOIN
	dbo.#PoBlTempPart12 ON dbo.#PoBlTempPart14.MaterialRowIdObject = dbo.#PoBlTempPart12.MDMMaterialID
) AS O
GO

USE MDM
GO

SELECT * 
INTO #PoBlCostResale
FROM
(
	SELECT MaterialNbr AS material_nbr
	,UntBookCost AS unit_book_cost
	,UnitResale AS unit_resale
	,UntSpecialCost AS unit_special_cost
	,CASE
		WHEN UntSpecialCost>0 AND UntBookCost<=UntSpecialCost THEN UntBookCost
		WHEN UntSpecialCost=0 OR UntSpecialCost IS NULL Then UntBookCost
		ELSE UntSpecialCost
	END AS MinCost
	FROM dbo.#PoBlTempPart15
) AS P
GO

DROP TABLE #PoBlTempPart3
DROP TABLE #PoBlTempPart4
DROP TABLE #PoBlTempPart5
DROP TABLE #PoBlTempPart6
DROP TABLE #PoBlTempPart7
DROP TABLE #PoBlTempPart8
DROP TABLE #PoBlTempPart9
DROP TABLE #PoBlTempPart10
DROP TABLE #PoBlTempPart11
DROP TABLE #PoBlTempPart12
DROP TABLE #PoBlTempPart13
DROP TABLE #PoBlTempPart14
DROP TABLE #PoBlTempPart15
GO
	
	
	
	USE BI


	--Get Scope to Phil
	SELECT DISTINCT A.PoNbr
	,A.PoLine
	,A.PoSchedLine
	,A.MaterialNbr
	,A.Plant
	,A.StorLoc
	,A.PurchOrg
	,A.mfg
	,A.ProdHrchy
	,A.RefDocNbr
	,A.PoSchedConfCd
	,A.PoItemCd
	,A.OrderDt
	,A.SchedLineDeliveryDt
	,A.ConfDlvryDt
	,A.SchedQty
	,PbCr.MinCost*SchedQty AS ShedLineValue
	,A.PoOpenQty
	,CASE 
		WHEN A.Mfg='TIS' THEN PbCr.MinCost*A.PoOpenQty
		ELSE A.PoNetValue
	 END AS PoRemainingValue
	,PT.DocType
	,PT.PoTypeDesc
	,PT.GenericPoType
	,DATEDIFF(DAY, A.OrderDT,(CAST(GETDATE() AS DATE))) AS Age
	,DB.Category AS AgeBucket
	FROM 
	DateBuckets AS DB,
	(SELECT POBL.*, LEFT(POBL.PoNbr,2) AS PoLeadNbr, CASE WHEN BIConfirmationDecoder.ConfirmationType IS NULL THEN 'UnConfirmed' ELSE 'Confirmed' END AS ConfType
	FROM BIPoBacklog AS POBL LEFT JOIN BIConfirmationDecoder ON POBL.PoSchedConfCd=BIConfirmationDecoder.ConfirmationCode
	WHERE LEFT(ProdHrchy, 3)= '0IT' OR LEFT(ProdHrchy, 3)= '0ST' AND PurchOrg LIKE 'H%'
	) AS A
	INNER JOIN PoType AS PT ON A.PoLeadNbr=PT.PoLeadingDigits
	LEFT JOIN #PoBlCostResale AS PbCr ON A.MaterialNbr=PbCr.material_nbr
	WHERE DATEDIFF(DAY, A.OrderDT,(CAST(GETDATE() AS DATE)))>=DB.LBound AND DATEDIFF(DAY, A.OrderDT,(CAST(GETDATE() AS DATE)))<=DB.UBound AND PoOpenQty>0
	GO


	DROP TABLE #PoBlCostResale