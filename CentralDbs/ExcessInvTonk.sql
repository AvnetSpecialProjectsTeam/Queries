
GO
DROP VIEW VbapToParts
GO
CREATE VIEW VbapToParts AS
SELECT DISTINCT NonHaImportTesting.dbo.VBAP.SaleDoc, NonHaImportTesting.dbo.VBAP.SaleDocItm, NonHaImportTesting.dbo.VBAP.MatNbr, mdm.dbo.ViewSapPartsListPart6.Mfg, mdm.dbo.ViewSapPartsListPart6.MfgPartNbr, NonHaImportTesting.dbo.VBAP.SaleDocItmCat, NonHaImportTesting.dbo.VBAP.HighLvlItmBillMatStruc, NonHaImportTesting.dbo.VBAP.DocNbrRefDoc, NonHaImportTesting.dbo.VBAP.ItmNbrRefItm, NonHaImportTesting.dbo.VBAP.PlntOwnExt, NonHaImportTesting.dbo.VBAP.DateRecCrt, NonHaImportTesting.dbo.VBAP.NamPersCrtObj, NonHaImportTesting.dbo.VBAP.Sub4PricProcCon, NonHaImportTesting.dbo.VBAP.ProfCntr, NonHaImportTesting.dbo.VBAP.SCMFlag, NonHaImportTesting.dbo.VBAP.MatNbrUsedCust, NonHaImportTesting.dbo.VBAP.ComCode2, NonHaImportTesting.dbo.VBAP.GrpCode, NonHaImportTesting.dbo.VBAP.UntPric, NonHaImportTesting.dbo.VBAP.RemQty, NonHaImportTesting.dbo.VBAP.LastConPromDate, NonHaImportTesting.dbo.VBAP.ATPDate, NonHaImportTesting.dbo.VBAP.LineItmStat, NonHaImportTesting.dbo.VBAP.NCNRFlag
FROM NonHaImportTesting.dbo.VBAP LEFT JOIN mdm.dbo.ViewSapPartsListPart6 ON NonHaImportTesting.dbo.VBAP.MatNbr=mdm.dbo.ViewSapPartsListPart6.MaterialNbr
WHERE NonHaImportTesting.dbo.VBAP.LineItmStat<>'Fully delivered' AND NonHaImportTesting.dbo.VBAP.ProfCntr=650003;
GO


GO 
DROP VIEW VbapPartsToVbak
GO
CREATE VIEW VbapPartsToVbak AS 
SELECT DISTINCT dbo.VbapToParts.SaleDoc, dbo.VbapToParts.SaleDocItm, dbo.VbapToParts.MatNbr, dbo.VbapToParts.Mfg, dbo.VbapToParts.MfgPartNbr, dbo.VbapToParts.SaleDocItmCat, dbo.VbapToParts.HighLvlItmBillMatStruc, dbo.VbapToParts.DocNbrRefDoc, dbo.VbapToParts.ItmNbrRefItm, dbo.VbapToParts.PlntOwnExt, dbo.VbapToParts.DateRecCrt, dbo.VbapToParts.NamPersCrtObj, dbo.VbapToParts.Sub4PricProcCon, dbo.VbapToParts.ProfCntr, dbo.VbapToParts.SCMFlag, dbo.VbapToParts.MatNbrUsedCust, dbo.VbapToParts.ComCode2, dbo.VbapToParts.GrpCode, dbo.VbapToParts.UntPric, dbo.VbapToParts.RemQty, dbo.VbapToParts.LastConPromDate, dbo.VbapToParts.ATPDate, dbo.VbapToParts.LineItmStat, dbo.VbapToParts.NCNRFlag, sap.dbo.Vbak.YourRef,  sap.dbo.Vbak.SoldToParty, sap.dbo.Vbak.CustPurcOrdNbr
FROM dbo.VbapToParts LEFT JOIN  sap.dbo.Vbak ON dbo.VbapToParts.SaleDoc=sap.dbo.Vbak.SaleDoc
WHERE sap.dbo.Vbak.SaleDocTyp='ZOR' OR sap.dbo.Vbak.SaleDocTyp='ZFC' OR sap.dbo.Vbak.SaleDocTyp='ZSB'; 
GO


GO 
DROP VIEW FinalTable
GO
CREATE VIEW FinalTable AS 
SELECT DISTINCT dbo.VbapPartsToVbak.SaleDoc, dbo.VbapPartsToVbak.SaleDocItm, dbo.VbapPartsToVbak.MatNbr, dbo.VbapPartsToVbak.Mfg, dbo.VbapPartsToVbak.MfgPartNbr, dbo.VbapPartsToVbak.SaleDocItmCat, dbo.VbapPartsToVbak.HighLvlItmBillMatStruc, dbo.VbapPartsToVbak.DocNbrRefDoc, dbo.VbapPartsToVbak.ItmNbrRefItm, dbo.VbapPartsToVbak.PlntOwnExt, dbo.VbapPartsToVbak.DateRecCrt, dbo.VbapPartsToVbak.NamPersCrtObj, dbo.VbapPartsToVbak.Sub4PricProcCon, dbo.VbapPartsToVbak.ProfCntr, dbo.VbapPartsToVbak.SCMFlag, dbo.VbapPartsToVbak.MatNbrUsedCust, dbo.VbapPartsToVbak.ComCode2, dbo.VbapPartsToVbak.GrpCode, dbo.VbapPartsToVbak.UntPric, dbo.VbapPartsToVbak.RemQty, dbo.VbapPartsToVbak.LastConPromDate, dbo.VbapPartsToVbak.ATPDate, dbo.VbapPartsToVbak.LineItmStat, dbo.VbapPartsToVbak.NCNRFlag, dbo.VbapPartsToVbak.YourRef,  dbo.VbapPartsToVbak.SoldToParty, dbo.VbapPartsToVbak.CustPurcOrdNbr
FROM dbo.VbapPartsToVbak INNER JOIN bi.dbo.SOBacklog ON (dbo.VbapPartsToVbak.SaleDoc=bi.dbo.SOBacklog.SalesDocNbr) AND (dbo.VbapPartsToVbak.SaleDocItm=bi.dbo.SOBacklog.SalesDocItemNbr);
GO



SELECT *
FROM FinalTable;