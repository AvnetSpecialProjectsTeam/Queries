SELECT dbo.Material.RowIdObject AS MaterialRowIdObject, dbo.Material.SapMaterialId AS MaterialNbr, dbo.Material.SapMaterialTypeCd AS MaterialType, dbo.Material.SapMatItemCatgGroupCd AS ItemCat, dbo.Material.ManufacturerPartNo AS MfgPartNbr, dbo.MaterialProdHier.SapProductBusGroupCd AS Pbg, Party_1.SapPartyId AS Mfg, dbo.MaterialProdHier.ProductHierarchyCode AS ProdHrchy, dbo.MaterialProdHier.SapProcureStrategyCd AS PrcStgy, dbo.MaterialProdHier.SapTechnologyCd AS Tech, dbo.MaterialProdHier.SapCommodityCd AS CC, dbo.MaterialProdHier.SapProductGroupCd AS Grp, dbo.Party.SapPartyId AS VendorNbr, dbo.VendorMaterialRel.VendorPartNo AS VendorPartNbr, dbo.Material.PartDs
INTO ##TempSapPartsList2
FROM     dbo.Party AS Party_1 INNER JOIN
                  dbo.Material INNER JOIN
                  dbo.MaterialProdHier ON dbo.Material.MaterialProdHierarchyId = dbo.MaterialProdHier.RowIdObject ON Party_1.RowidObject = dbo.Material.MdmManufacturerPartyId LEFT OUTER JOIN dbo.UniqueVendorMaterialRel INNER JOIN dbo.VendorMaterialRel ON dbo.UniqueVendorMaterialRel.RowIdObject = dbo.VendorMaterialRel.RowIdObject INNER JOIN dbo.Party ON dbo.VendorMaterialRel.MDMVendorPartyId = dbo.Party.RowidObject ON dbo.Material.RowIdObject = dbo.VendorMaterialRel.MDMMaterialID
WHERE  (dbo.Material.HubStateInd <> - 1) AND (dbo.VendorMaterialRel.HubStateInd <> - 1 OR
                  dbo.VendorMaterialRel.HubStateInd IS NULL) AND (dbo.Material.SendToSapFl = 'Y') OR
                  (dbo.Material.HubStateInd <> - 1) AND (dbo.VendorMaterialRel.HubStateInd <> - 1 OR
                  dbo.VendorMaterialRel.HubStateInd IS NULL) AND (dbo.Material.SentToSapDate > CONVERT(DATETIME, '2015-12-31 00:00:00', 102));




SELECT MaterialNbr AS BknMaterialNbr, Mfg, PrcStgy, MfgPartNbr, LEFT(MfgPartNbr, LEN(MfgPartNbr) - 4) AS CoreMfgNbr
INTO ##TempSapPartsList3
FROM     ##TempSapPartsList2
WHERE  (MfgPartNbr LIKE '%/BKN');



SELECT dbo.##TempSapPartsList2.MaterialNbr AS CoreMaterialNbr, dbo.##TempSapPartsList3.BknMaterialNbr
INTO ##TempSapPartsList4
FROM     dbo.##TempSapPartsList2 INNER JOIN
				dbo.##TempSapPartsList3 ON dbo.##TempSapPartsList2.Mfg = dbo.##TempSapPartsList3.Mfg AND dbo.##TempSapPartsList2.PrcStgy = dbo.##TempSapPartsList3.PrcStgy AND dbo.##TempSapPartsList2.MfgPartNbr = dbo.##TempSapPartsList3.CoreMfgNbr;



SELECT dbo.##TempSapPartsList2.MaterialRowIdObject, dbo.##TempSapPartsList2.MaterialNbr, dbo.##TempSapPartsList2.MaterialType, dbo.##TempSapPartsList2.ItemCat, dbo.##TempSapPartsList2.MfgPartNbr, dbo.##TempSapPartsList2.Pbg, dbo.##TempSapPartsList2.Mfg, dbo.##TempSapPartsList2.ProdHrchy, dbo.##TempSapPartsList2.PrcStgy, dbo.##TempSapPartsList2.Tech, dbo.##TempSapPartsList2.CC, dbo.##TempSapPartsList2.Grp, dbo.##TempSapPartsList2.VendorNbr, dbo.##TempSapPartsList2.VendorPartNbr, dbo.##TempSapPartsList2.PartDs, dbo.##TempSapPartsList4.BknMaterialNbr, Vspl1.CoreMaterialNbr
INTO ##TempSapPartsList5
FROM     dbo.##TempSapPartsList2 LEFT OUTER JOIN
                  dbo.##TempSapPartsList4 AS Vspl1 ON dbo.##TempSapPartsList2.MaterialNbr = Vspl1.BknMaterialNbr LEFT OUTER JOIN
                  dbo.##TempSapPartsList4 ON dbo.##TempSapPartsList2.MaterialNbr = dbo.##TempSapPartsList4.CoreMaterialNbr;


SELECT dbo.##TempSapPartsList5.MaterialNbr, dbo.##TempSapPartsList5.MfgPartNbr, dbo.##TempSapPartsList5.Mfg, dbo.##TempSapPartsList5.PrcStgy, dbo.##TempSapPartsList5.CoreMaterialNbr
INTO ##TempSapPartsList6
FROM     dbo.##TempSapPartsList5 INNER JOIN
                  dbo.##TempSapPartsList3 ON dbo.##TempSapPartsList5.MaterialNbr = dbo.##TempSapPartsList3.BknMaterialNbr
WHERE  (dbo.##TempSapPartsList5.CoreMaterialNbr IS NULL);



SELECT dbo.##TempSapPartsList5.MaterialRowIdObject, dbo.##TempSapPartsList5.MaterialNbr, dbo.##TempSapPartsList5.MaterialType, dbo.##TempSapPartsList5.ItemCat, dbo.##TempSapPartsList5.MfgPartNbr, dbo.##TempSapPartsList5.Pbg, dbo.##TempSapPartsList5.Mfg, dbo.##TempSapPartsList5.ProdHrchy, dbo.##TempSapPartsList5.PrcStgy, dbo.##TempSapPartsList5.Tech, dbo.##TempSapPartsList5.CC, dbo.##TempSapPartsList5.Grp, dbo.##TempSapPartsList5.VendorNbr, dbo.##TempSapPartsList5.VendorPartNbr, dbo.##TempSapPartsList5.PartDs, dbo.##TempSapPartsList5.BknMaterialNbr, dbo.##TempSapPartsList5.CoreMaterialNbr, dbo.##TempSapPartsList6.MaterialNbr AS BknNoCore
INTO  ##TempSapPartsList7
FROM     dbo.##TempSapPartsList5 LEFT JOIN dbo.##TempSapPartsList6 ON dbo.##TempSapPartsList5.MaterialNbr = dbo.##TempSapPartsList6.MaterialNbr


DECLARE @cnt INT=2
DECLARE @Table1 VARCHAR(MAX)

WHILE @cnt<8
BEGIN
SET @TABLE1='DROP TABLE ##TempSapPartsList'+CAST(@cnt AS VARCHAR)
--SELECT @Table1
EXEC (@Table1)
Set @cnt=@cnt+1
END