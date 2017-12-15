USE SAP
GO

SELECT ZtHdr.AORID, ZtHdr.AOREmpID, ZtHdr.EmpFirstName, ZtHdr.EmpLastName, ZtHdr.Job, ZtHdr.Position, ZtHdr.AORRole, ZtHdr.AORFunc, ZtHdr.StartDate, ZtHdr.EndDate
INTO ##AorProdFilter
FROM Ztqtcaorhdr AS ZtHdr
WHERE ZtHdr.AORRole='PRODUCT TEAM' AND ZtHdr.StartDate<=CAST(GETDATE() AS DATE) AND ZtHdr.EndDate>CAST(GETDATE() AS DATE);
GO

--SELECT *
--FROM ##AorProdFilter

SELECT ZAI.ProdBusiGrp AS pbg, ZAI.Manuf AS mfg, ZAI.ProcStrat AS prc_stgy, ZAI.Tech AS tech, ZAI.ComProdHier AS cc, ZAI.GrpCode AS grp, ZAI.AOREmpID, ZAI.AorId
 --,ZAI.SaleOff, ZAI.SaleGrp, ZAI.GlobEnter
--, ZAI.SoldTo, ZAI.AccTyp
INTO ##AorProdItem
FROM ##AorProdFilter INNER JOIN ZtqtcAorItm AS ZAI ON ##AorProdFilter.AORID = ZAI.AORID
GROUP BY ZAI.ProdBusiGrp, ZAI.Manuf, ZAI.ProcStrat, ZAI.Tech, ZAI.ComProdHier, ZAI.GrpCode, ZAI.AOREmpID, ZAI.AorId
--, ZAI.SaleOff, ZAI.SaleGrp, ZAI.GlobEnter
--, ZAI.SoldTo, ZAI.AccTyp;
GO


SELECT *
FROM ##AorProdItem
WHERE AorId=376 OR AorId=714


--Create SAP Parts list
USE mdm

SELECT dbo.Material.RowIdObject AS MaterialRowIdObject, dbo.Material.SapMaterialId AS MaterialNbr, dbo.Material.SapMaterialTypeCd AS MaterialType, 
                  dbo.Material.SapMatItemCatgGroupCd AS ItemCat, dbo.Material.ManufacturerPartNo AS MfgPartNbr, dbo.MaterialProdHier.SapProductBusGroupCd AS Pbg, 
                  Party_1.SapPartyId AS Mfg, dbo.MaterialProdHier.ProductHierarchyCode AS ProdHrchy, dbo.MaterialProdHier.SapProcureStrategyCd AS PrcStgy, 
                  dbo.MaterialProdHier.SapTechnologyCd AS Tech, dbo.MaterialProdHier.SapCommodityCd AS CC, dbo.MaterialProdHier.SapProductGroupCd AS Grp, 
                  dbo.Party.SapPartyId AS VendorNbr, dbo.VendorMaterialRel.VendorPartNo AS VendorPartNbr, dbo.Material.PartDs
INTO ##AorSapPartsList2
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


SELECT MaterialNbr AS BknMaterialNbr, Mfg, PrcStgy, MfgPartNbr, LEFT(MfgPartNbr, LEN(MfgPartNbr) - 4) AS CoreMfgNbr
INTO ##AorSapPartsList3
FROM     ##AorSapPartsList2
WHERE  (MfgPartNbr LIKE '%/BKN');


SELECT dbo.##AorSapPartsList2.MaterialNbr AS CoreMaterialNbr, dbo.##AorSapPartsList3.BknMaterialNbr
INTO ##AorSapPartsList4
FROM     dbo.##AorSapPartsList2 INNER JOIN dbo.##AorSapPartsList3 ON dbo.##AorSapPartsList2.Mfg = dbo.##AorSapPartsList3.Mfg AND dbo.##AorSapPartsList2.PrcStgy = dbo.##AorSapPartsList3.PrcStgy AND dbo.##AorSapPartsList2.MfgPartNbr = dbo.##AorSapPartsList3.CoreMfgNbr;

SELECT dbo.##AorSapPartsList2.MaterialRowIdObject, dbo.##AorSapPartsList2.MaterialNbr, dbo.##AorSapPartsList2.MaterialType, dbo.##AorSapPartsList2.ItemCat, dbo.##AorSapPartsList2.MfgPartNbr, dbo.##AorSapPartsList2.Pbg, dbo.##AorSapPartsList2.Mfg, dbo.##AorSapPartsList2.ProdHrchy, dbo.##AorSapPartsList2.PrcStgy, dbo.##AorSapPartsList2.Tech, dbo.##AorSapPartsList2.CC, dbo.##AorSapPartsList2.Grp, dbo.##AorSapPartsList2.VendorNbr, dbo.##AorSapPartsList2.VendorPartNbr, dbo.##AorSapPartsList2.PartDs, dbo.##AorSapPartsList4.BknMaterialNbr, Vspl1.CoreMaterialNbr
INTO ##AorSapPartsList5
FROM     dbo.##AorSapPartsList2 LEFT OUTER JOIN dbo.##AorSapPartsList4 AS Vspl1 ON dbo.##AorSapPartsList2.MaterialNbr = Vspl1.BknMaterialNbr LEFT OUTER JOIN dbo.##AorSapPartsList4 ON dbo.##AorSapPartsList2.MaterialNbr = dbo.##AorSapPartsList4.CoreMaterialNbr;

SELECT dbo.##AorSapPartsList5.MaterialNbr, dbo.##AorSapPartsList5.MfgPartNbr, dbo.##AorSapPartsList5.Mfg, dbo.##AorSapPartsList5.PrcStgy, dbo.##AorSapPartsList5.CoreMaterialNbr
INTO ##AorSapPartsList6
FROM     dbo.##AorSapPartsList5 INNER JOIN dbo.##AorSapPartsList3 ON dbo.##AorSapPartsList5.MaterialNbr = dbo.##AorSapPartsList3.BknMaterialNbr
WHERE  (dbo.##AorSapPartsList5.CoreMaterialNbr IS NULL);

SELECT dbo.##AorSapPartsList5.MaterialRowIdObject, dbo.##AorSapPartsList5.MaterialNbr, dbo.##AorSapPartsList5.MaterialType, dbo.##AorSapPartsList5.ItemCat, dbo.##AorSapPartsList5.MfgPartNbr, dbo.##AorSapPartsList5.Pbg, dbo.##AorSapPartsList5.Mfg, dbo.##AorSapPartsList5.ProdHrchy, dbo.##AorSapPartsList5.PrcStgy, dbo.##AorSapPartsList5.Tech, dbo.##AorSapPartsList5.CC, dbo.##AorSapPartsList5.Grp, dbo.##AorSapPartsList5.VendorNbr, dbo.##AorSapPartsList5.VendorPartNbr, dbo.##AorSapPartsList5.PartDs, dbo.##AorSapPartsList5.BknMaterialNbr, dbo.##AorSapPartsList5.CoreMaterialNbr, dbo.##AorSapPartsList5.MaterialNbr AS BknNoCore
INTO ##TempSapPartsList7
FROM     dbo.##AorSapPartsList5 LEFT OUTER JOIN
                  dbo.##AorSapPartsList6 ON dbo.##AorSapPartsList5.MaterialNbr = dbo.##AorSapPartsList6.MaterialNbr

DROP TABLE ##AorSapPartsList2
DROP TABLE ##AorSapPartsList3
DROP TABLE ##AorSapPartsList4
DROP TABLE ##AorSapPartsList5
DROP TABLE ##AorSapPartsList6
GO

USE SAP
SELECT *
INTO ##ProdAorHier
FROM
	(SELECT DISTINCT SPL.pbg, SPL.mfg, SPL.Prcstgy, SPL.Tech, SPL.cc, SPL.grp, API.AOREmpID
	FROM ##AorProdItem AS API INNER JOIN ##TempSapPartsList7 AS SPL ON (API.prc_stgy=SPL.PrcStgy) AND (API.grp=SPL.grp)
	UNION
	SELECT DISTINCT SPL.pbg, SPL.mfg, SPL.Prcstgy, SPL.Tech, SPL.cc, SPL.grp, API.AOREmpID
	FROM ##AorProdItem AS API INNER JOIN ##TempSapPartsList7 AS SPL ON (API.prc_stgy=SPL.PrcStgy) AND (API.cc=SPL.cc)
	WHERE API.grp=' '
	UNION
	SELECT DISTINCT SPL.pbg, SPL.mfg, SPL.Prcstgy, SPL.Tech, SPL.cc, SPL.grp, API.AOREmpID
	FROM ##AorProdItem AS API INNER JOIN ##TempSapPartsList7 AS SPL ON (API.prc_stgy=SPL.PrcStgy) AND (API.tech=SPL.tech)
	WHERE API.grp=' ' AND API.cc=' '
	UNION
	SELECT DISTINCT SPL.pbg, SPL.mfg, SPL.Prcstgy, SPL.Tech, SPL.cc, SPL.grp, API.AOREmpID
	FROM ##AorProdItem AS API INNER JOIN ##TempSapPartsList7 AS SPL ON (API.prc_stgy=SPL.PrcStgy)
	WHERE API.grp=' ' AND API.cc=' ' AND API.tech=' ') AS A
GO

--SELECT *
--FROM ##ProdAorHier

---Create Account Heirarchy
SELECT CAST(C.GlobEnter AS INT) AS GlobEnter, CAST(CH5.Customer AS INT) AS AccountNbr
INTO ##GEAN
FROM
	(SELECT B.GlobEnter, CH4.Customer, CH4.Hglvcust
	FROM
		(SELECT A.GlobEnter, CH3.Customer, CH3.Hglvcust
		FROM 
			(SELECT CH.Customer AS GlobEnter, CH.Hglvcust, CH.ValidFrom, CH.ValidTo
			FROM Knvh AS CH
			INNER JOIN Knvh AS CH2 ON CH.Customer=CH2.Hglvcust
			WHERE CH.ValidFrom<GETDATE() AND CH.ValidTo>GETDATE() AND CH.Hglvcust=' ') AS A
		INNER JOIN Knvh AS CH3 ON A.GlobEnter=CH3.Hglvcust) AS B
	INNER JOIN Knvh AS CH4 ON B.Customer=CH4.Hglvcust) AS C
INNER JOIN Knvh AS CH5 ON C.Customer=CH5.Hglvcust


--Add in sales level and Account
SELECT DISTINCT A.mfg, CONCAT(A.Pbg, A.Prcstgy, A.Tech, A.cc, A.grp) AS PH, CAST(A.Saleoff AS INT) AS SaleOff, CAST(A.SaleGrp AS INT) AS SaleGrp, CAST(A.GlobEnter AS INT) GlobEnter, GN.AccountNbr, A.AorEmpId
INTO ##ProdSaleAOR
FROM
(
	SELECT DISTINCT PAH.pbg, PAH.mfg, PAH.Prcstgy, PAH.Tech, PAH.cc, PAH.grp, ZAI.SaleOff, ZAI.SaleGrp, ZAI.GlobEnter, PAH.AOREmpID
	FROM ##ProdAorHier AS PAH INNER JOIN ZtqtcAorItm AS ZAI ON PAH.prcstgy=ZAI.ProcStrat AND PAH.grp=ZAI.GrpCode
	WHERE PAH.AOREmpID = ZAI.AOREmpID
	UNION
	SELECT DISTINCT PAH.pbg, PAH.mfg, PAH.Prcstgy, PAH.Tech, PAH.cc, PAH.grp, ZAI.SaleOff, ZAI.SaleGrp, ZAI.GlobEnter, PAH.AOREmpID
	FROM ##ProdAorHier AS PAH INNER JOIN ZtqtcAorItm AS ZAI ON PAH.prcstgy=ZAI.ProcStrat AND PAH.cc=ZAI.ComProdHier
	WHERE PAH.AOREmpID = ZAI.AOREmpID AND ZAI.GrpCode=' '
	UNION
	SELECT DISTINCT PAH.pbg, PAH.mfg, PAH.Prcstgy, PAH.Tech, PAH.cc, PAH.grp, ZAI.SaleOff, ZAI.SaleGrp, ZAI.GlobEnter, PAH.AOREmpID
	FROM ##ProdAorHier AS PAH INNER JOIN ZtqtcAorItm AS ZAI ON PAH.prcstgy=ZAI.ProcStrat AND PAH.tech=ZAI.Tech
	WHERE PAH.AOREmpID = ZAI.AOREmpID AND ZAI.GrpCode=' ' AND ZAI.ComProdHier=' '
	UNION
	SELECT DISTINCT PAH.pbg, PAH.mfg, PAH.Prcstgy, PAH.Tech, PAH.cc, PAH.grp, ZAI.SaleOff, ZAI.SaleGrp, ZAI.GlobEnter, PAH.AOREmpID
	FROM ##ProdAorHier AS PAH INNER JOIN ZtqtcAorItm AS ZAI ON PAH.prcstgy=ZAI.ProcStrat
	WHERE PAH.AOREmpID = ZAI.AOREmpID AND ZAI.GrpCode=' ' AND ZAI.ComProdHier=' ' AND ZAI.Tech=' ') AS A
	LEFT JOIN ##GEAN AS GN ON A.GlobEnter=GN.GlobEnter
GO


DROP TABLE ##TempSapPartsList7
DROP TABLE ##AorProdItem
DROP TABLE ##AorProdFilter
DROP TABLE ##ProdAorHier
DROP TABLE ##GEAN
GO



SELECT *
FROM ##GEAN

SELECT *
FROM ##ProdSaleAOR
WHERE (AOREmpID=116 oR AOREmpID=12518) AND SaleOff=6141 AND PH='0STFSC0SD0DDTXM'

SELECT * 
FROM Ztqtcaorhdr 
WHERE (AORID=376 oR AORID=714)

SELECT * 
FROM ZtqtcAorItm
WHERE (AOREmpID=116 oR AOREmpID=12518) AND SaleOff=6141 AND ProcStrat='FSC'





DROP TABLE ##ProdSaleAOR
