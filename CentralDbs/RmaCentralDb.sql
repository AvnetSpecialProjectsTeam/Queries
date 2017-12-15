--RMA REPORTING DATABASE _ OWNER KRISTA CROSS 


--0000_01 FORMAT VBFA FIELDS 
DROP TABLE #Rma1VBFA
USE SAP 
GO 
SELECT * INTO #Rma1VBFA
FROM (SELECT DISTINCT PrevSalesDoc, PrevSalesDocItem ,PrevSalesDocCat, SubseqSalesDoc,SubseqSalesDocItem, SubseqDocCat, Qty, CreatedDate, MovementType
FROM dbo.VBFA
WHERE PrevSalesDocCat='H') AS subquery1
GO



--0000_02 FORMAT VBAP FIELDS 
DROP TABLE #Rma2VBAP
USE NonHaImportTesting 
GO 
SELECT * INTO #Rma2VBAP
FROM (SELECT SaleDoc, SaleDocItm, MatNbr, BatchNbr, ShrtTxtSaleOrdItm AS MatDesc, SaleDocItmCat, ProdHier, NetValOrdItmDocCur AS NetValue, CumOrdQtySaleUnt AS SaleDocQty, RetItm AS RetItm, DocNbrRefDoc AS RefDoc, ItmNbrRefItm AS RefItm, PlntOwnExt AS Plant, DateRecCrt AS CreateDt, NetPric, CostDocCur AS Cost, CustPostGoodRec AS GrCheck, RetRea, RetRefCode, NbrMan1 AS Mfg, ResSrc AS ResaleSource, CostSrcVal, ProdBizGrp AS Pbg, UntPric, ResPric AS ResalePrice, SaleCost, RemQty, LastConPromDate, ATPDate, LineItmStat, NCNRFlag, ValTyp, StorLoc
FROM dbo.VBAP
Where ProdBizGrp = ' 0ST' OR  ProdBizGrp = ' 0IT') AS subquery2
GO
 

--0000_03 FORMAT VBAK FIELDS 
DROP TABLE #Rma3VBAK
USE SAP 
GO 
SELECT * INTO #Rma3VBAK
FROM (SELECT SaleDoc, SaleDocTyp, SaleOrg, SaleGrp, SaleOff, SoldToParty
FROM dbo.Vbak
WHERE SaleDocTyp='ZRE' Or SaleDocTyp='ZRE2' Or SaleDocTyp='ZRE3') AS subquery3
GO



--0000_04 FORMAT SOLD TO PARTY 
DROP TABLE #Rma4SoldToParty
USE MDM 
GO 
SELECT * INTO #Rma4SoldToParty
FROM (SELECT DISTINCT SapPartyId, SapPartyNm01, MdmPriPartyRoleTypeCd
FROM dbo.Party
WHERE MdmPriPartyRoleTypeCd='CUST' AND SapPartyId is not null) AS subquery4
GO


--0000_05 FORMAT MSEG 
DROP TABLE #Rma5MSEG
USE SAP
GO 
SELECT * INTO #Rma5MSEG
FROM( SELECT DISTINCT MovTyp, MaterialNbr, Plant, AccNbrCus
FROM dbo.Mseg) AS subquery5
GO


--0000_06 FORMAT CRM DATA 
DROP TABLE #Rma6Crm
USE CentralDbs
GO 
SELECT * INTO #Rma6Crm
FROM (SELECT CrmNbr, CAST(Left(CrmCreateDt,8) AS Date) AS CrmCreateDt, RmaNbr
FROM dbo.CrmRmaData) AS subquery6
GO


--0000_07 FORMAT DATES 
DROP TABLE #Rma7Dates
USE CentralDbs
GO 
SELECT * INTO #Rma7Dates
FROM (SELECT #Rma6Crm.CrmNbr, RefDateAvnet.DateDt AS CrmCreateDt, #Rma6Crm.RmaNbr
FROM dbo.#Rma6Crm LEFT JOIN  dbo.RefDateAvnet ON #Rma6Crm.CrmCreateDt=RefDateAvnet.SapDt) AS subquery7
GO



--1000_01 VBAP TO CRM 
DROP TABLE #Rma8VbapCrm
USE CentralDbs
GO 
SELECT * INTO #Rma8VbapCrm
FROM (SELECT DISTINCT #Rma7Dates.CrmNbr, #Rma7Dates.CrmCreateDt, #Rma2VBAP.SaleDoc, #Rma2VBAP.SaleDocItm, #Rma2VBAP.MatNbr, #Rma2VBAP.BatchNbr, #Rma2VBAP.ValTyp, #Rma2VBAP.MatDesc, #Rma2VBAP.SaleDocItmCat, #Rma2VBAP.ProdHier, #Rma2VBAP.NetValue, #Rma2VBAP.SaleDocQty, #Rma2VBAP.RetItm, #Rma2VBAP.RefDoc, #Rma2VBAP.RefItm, #Rma2VBAP.Plant, #Rma2VBAP.CreateDt, #Rma2VBAP.NetPric, #Rma2VBAP.Cost, #Rma2VBAP.RetRea, #Rma2VBAP.RetRefCode, #Rma2VBAP.Mfg, #Rma2VBAP.ResaleSource, #Rma2VBAP.CostSrcVal, #Rma2VBAP.Pbg, #Rma2VBAP.UntPric, #Rma2VBAP.ResalePrice, #Rma2VBAP.SaleCost, #Rma2VBAP.RemQty, #Rma2VBAP.LastConPromDate, #Rma2VBAP.ATPDate, #Rma2VBAP.LineItmStat, #Rma2VBAP.NCNRFlag, #Rma2VBAP.StorLoc
FROM #Rma2VBAP INNER JOIN #Rma7Dates ON #Rma2VBAP.SaleDoc=#Rma7Dates.RmaNbr) AS subquery8
GO


--1000_02 VBAP TO VBAK 
DROP TABLE #Rma9VbapVbak
USE CentralDbs
GO 
SELECT * INTO #Rma9VbapVbak
FROM (SELECT DISTINCT #Rma8VbapCrm.SaleDoc, #Rma8VbapCrm.SaleDocItm, #Rma8VbapCrm.MatNbr, #Rma8VbapCrm.BatchNbr, #Rma8VbapCrm.ValTyp, #Rma8VbapCrm.MatDesc, #Rma8VbapCrm.SaleDocItmCat, #Rma8VbapCrm.ProdHier, #Rma8VbapCrm.NetValue, #Rma8VbapCrm.SaleDocQty, #Rma8VbapCrm.RetItm, #Rma8VbapCrm.RefDoc, #Rma8VbapCrm.RefItm, #Rma8VbapCrm.Plant, #Rma8VbapCrm.CreateDt, #Rma8VbapCrm.NetPric, #Rma8VbapCrm.Cost, #Rma8VbapCrm.RetRea, #Rma8VbapCrm.RetRefCode, #Rma8VbapCrm.Mfg, #Rma8VbapCrm.ResaleSource, #Rma8VbapCrm.CostSrcVal, #Rma8VbapCrm.Pbg, #Rma8VbapCrm.UntPric, #Rma8VbapCrm.ResalePrice, #Rma8VbapCrm.StorLoc, #Rma8VbapCrm.SaleCost, #Rma8VbapCrm.RemQty, #Rma8VbapCrm.LastConPromDate, #Rma8VbapCrm.ATPDate, #Rma8VbapCrm.LineItmStat, #Rma8VbapCrm.NCNRFlag, sap.dbo.Vbak.SaleDocTyp, sap.dbo.Vbak.SaleOrg, sap.dbo.Vbak.SaleGrp, sap.dbo.Vbak.SaleOff, sap.dbo.Vbak.SoldToParty
FROM #Rma8VbapCrm LEFT JOIN sap.dbo.Vbak ON #Rma8VbapCrm.SaleDoc = sap.dbo.Vbak.SaleDoc) AS subquery9
GO 


USE CentralDbs
GO 
SELECT * INTO #Rma10
FROM (SELECT DISTINCT #Rma8VbapCrm.SaleDoc, #Rma8VbapCrm.SaleDocItm, #Rma8VbapCrm.MatNbr, #Rma8VbapCrm.BatchNbr, #Rma8VbapCrm.ValTyp, #Rma8VbapCrm.MatDesc, #Rma8VbapCrm.SaleDocItmCat, #Rma8VbapCrm.ProdHier, #Rma8VbapCrm.NetValue, #Rma8VbapCrm.SaleDocQty, #Rma8VbapCrm.RetItm, #Rma8VbapCrm.RefDoc, #Rma8VbapCrm.RefItm, #Rma8VbapCrm.Plant, #Rma8VbapCrm.CreateDt, #Rma8VbapCrm.NetPric, #Rma8VbapCrm.Cost, #Rma8VbapCrm.RetRea, #Rma8VbapCrm.RetRefCode, #Rma8VbapCrm.Mfg, #Rma8VbapCrm.ResaleSource, #Rma8VbapCrm.CostSrcVal, #Rma8VbapCrm.Pbg, #Rma8VbapCrm.UntPric, #Rma8VbapCrm.ResalePrice, #Rma8VbapCrm.StorLoc, #Rma8VbapCrm.SaleCost, #Rma8VbapCrm.RemQty, #Rma8VbapCrm.LastConPromDate, #Rma8VbapCrm.ATPDate, #Rma8VbapCrm.LineItmStat, #Rma8VbapCrm.NCNRFlag, sap.dbo.Vbak.SaleDocTyp, sap.dbo.Vbak.SaleOrg, sap.dbo.Vbak.SaleGrp, sap.dbo.Vbak.SaleOff, sap.dbo.Vbak.SoldToParty
FROM #Rma8VbapCrm LEFT JOIN sap.dbo.Vbak ON #Rma8VbapCrm.SaleDoc = sap.dbo.Vbak.SaleDoc) AS subquery9
GO 
