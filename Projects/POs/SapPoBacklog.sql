--INSERT INTO CentralDbs.dbo.PoBacklog
	--([PoNbr]
 --     ,[PoItmNbr]
 --     ,[PoSchedLine]
 --     ,[Material]
 --     ,[Plant]
 --     ,[SupplyingPlant]
 --     ,[PoDt]
 --     ,[ChangeDtOrderMaster]
 --     ,[ChangedOn]
 --     ,[PurReqDocType]
 --     ,[PurchOrg]
 --     ,[PurGrp]
 --     ,[ValidStartDt]
 --     ,[ValidEndDt]
 --     ,[QuoteNbr]
 --     ,[CompanyCd]
 --     ,[StorLoc]
 --     ,[NbrPurchInfoRecord]
 --     ,[VendorMatNbr]
 --     ,[OrderPriceUnit]
 --     ,[PoItmCat]
 --     ,[AcctAssignmentCat]
 --     ,[GRBasedIV]
 --     ,[InvoiceReceipt]
 --     ,[ProfitCenter]
 --     ,[PurchReqNbr]
 --     ,[RequisitionItmNbr]
 --     ,[MfgPartNbr]
 --     ,[SupplierSalesOrderNbr]
 --     ,[ReqDt]
 --     ,[EstShipDt]
 --     ,[EstDockDt]
 --     ,[PoQty]
 --     ,[PoSchedQty]
 --     ,[QtyGoodRec]
 --     ,[PoDelId]
 --     ,[CreatedBy]
 --     ,[Requisitioner]
 --     ,[PoNetPrice]
 --     ,[PriceUnit]
 --     ,[PoGrossOrder]
 --     ,[SequentialNbr]
 --     ,[StatRelDlvryDt]
 --     ,[OrderDtSchedLine]
 --     ,[Pbg]
 --     ,[Mfg]
 --     ,[PrcStgy]
 --     ,[Tech]
 --     ,[CC]
 --     ,[Grp]
	--  )
SELECT *
FROM
(
SELECT
	PoHdr.PoNbr
	,PoItm.PoItmNbr
	,PoSched.PoSchedLine
	,PoConf.VenConfSeqNbr
	,PoItm.Material
	,PoItm.Plant
	,CASE WHEN PoHdr.supplyingPlant=0 THEN NULL
		ELSE PoHdr.supplyingPlant
	END AS SupplyingPlant ,CAST(PoHdr.PoDt AS DATE) AS PoDt
	,CAST(PoHdr.ChangedDt AS DATE) AS PoHdrChangedDt
	,CAST(PoItm.ChangedOn AS DATE) AS PoItmChangedOn
	,PoHdr.PurReqDocType
	,PoHdr.PurchOrg
	,Pohdr.PurGrp
	,CAST(PoHdr.ValidStartDt AS DATE) AS ValidStartDt
	,CAST(PoHdr.ValidEndDt AS DATE) AS ValidEndDt
	,PoItm.ProgramId1 AS QuoteNbr
	,PoItm.CompanyCd
	,PoItm.StorLoc
	,PoItm.NbrPurchInfoRecord
	,PoItm.VendorMatNbr 
	,PoItm.OrderPriceUnit
	,PoItm.PoItmCat
	,PoItm.AcctAssignmentCat
	,PoItm.GRBasedIV
	,PoItm.InvoiceReceipt
	,PoItm.ProfitCenter
	,CASE WHEN PoSched.PurchReqNbr=0 THEN NULL ELSE PoSched.PurchReqNbr END AS PurchReqNbr
	,CASE WHEN PoSched.RequisitionItmNbr=0 THEN NULL ELSE PoSched.RequisitionItmNbr END AS RequisitionItmNbr
	,PoItm.MfgPartNbr
	,PoItm.SupplierSalesOrderNbr
	,PoItm.ReqDt
	,CAST(PoItm.EstShipDt AS DATE) AS EstShipDt
	,CAST(PoItm.EstDockDt AS DATE) AS EstDockDt
	,PoItm.PoQty
	,PoSched.PoSchedQty
	,PoSched.QtyGoodRec
	,PoItm.PoDelId
	,PoHdr.CreatedBy
	,PoItm.Requisitioner
	,PoItm.PoNetPrice
	,PoItm.PriceUnit
	,PoItm.PoGrossOrder
	,CAST(PoSched.StatRelDlvryDt AS DATE) AS StatRelDlvryDt
	,CAST(PoSched.OrderDtSchedLine AS DATE) AS OrderDtSchedLine
	,PoConf.BatchNbr
	,PoConf.CreatedOn
	,PoConf.ConfCat AS ConfType
	,PoConf.ItmDlvryDt AS SupplierConfDt
	,Spl.pbg
	,Spl.Mfg
	,Spl.PrcStgy
	,Spl.Tech
	,Spl.CC
	,Spl.Grp
FROM SAP.dbo.EKKO AS PoHdr
	INNER JOIN SAP.dbo.Ekpo AS PoItm
		ON PoHdr.PoNbr=PoItm.PoNbr
		LEFT JOIN 
			(SELECT DISTINCT spl.MaterialNbr ,spl.Pbg ,Spl.Mfg ,Spl.PrcStgy ,Spl.Tech ,Spl.CC ,Spl.Grp
			FROM CentralDbs.dbo.SapPartsList AS Spl
			WHERE Spl.MatHubState<>-1 AND Spl.SendToSapFl='Y') AS Spl
			ON PoItm.Material=Spl.MaterialNbr
		INNER JOIN SAP.dbo.Eket AS PoSched
			ON PoHdr.PoNbr=PoSched.poNbr AND PoItm.PoItmNbr=PoSched.PoItmNbr
		INNER JOIN 
			--(SELECT *
			--FROM
				(
				SELECT *
				--, DENSE_RANK() OVER(PARTITION BY PoConf.PoNbr, PoConf.PoItmNbr ORDER BY PoConf.PoNbr, PoConf.PoItmNbr, PoConf.VenConfSeqNbr DESC) AS RANK1
				FROM Sap.dbo.ekes AS PoConf
				WHERE PoConf.MrpRelevant='X' AND PoConf.SchedQty>0
				) AS PoConf
			--WHERE Rank1=1
			--) AS PoConf
			ON PoHdr.PoNbr=PoConf.PoNbr AND PoItm.PoItmNbr=PoConf.PoItmNbr
WHERE Poitm.PoDelId<>'L'
	AND PoSched.PoSchedQty<>PoSched.QtyGoodRec
	AND PoItm.PoQty<>0
	AND PoSched.PoSchedQty<>0
	AND PoItm.DlvryCompletedId<>'X'
	) AS A
ORDER BY A.PoNbr, A.PoItmNbr, A.PoSchedLine, A.VenConfSeqNbr