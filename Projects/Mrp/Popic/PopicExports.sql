--Edi Export
SELECT
	Popic.Mfg
	,Popic.PrcStgy
	,Popic.CC
	,Popic.Grp
	,Popic.ReschedDt
	,Popic.ConfDlvryDt
	,Popic.SchDlvryDt
	,NULL AS Accepted
	,NULL AS Rejected
	,CASE WHEN PoAction='CANCEL' THEN 'D' ELSE 'C' END AS [Type]
	,NULL AS BlockEdi
	,Ekko.PurReqDocType
	,Ekko.VenAccNbr
	,Ekko.PoNbr
	,CASE WHEN Eket.PurchReqNbr=0 THEN NULL ELSE Eket.PurchReqNbr END AS PurchReqNbr
	,CASE WHEN Eket.RequisitionItmNbr=0 THEN NULL ELSE Eket.RequisitionItmNbr END AS RequisitionItmNbr
	,Ekko.PurchOrg
	,Ekko.PurGrp
	,Ekko.CoCd
	,CONVERT(VARCHAR(10),Ekko.PoDt,112) AS CreateDt
	,CONVERT(VARCHAR(10),Ekko.ValidStartDt,112) AS ValidStartDt
	,CONVERT(VARCHAR(10), Ekko.ValidEndDt ,112) AS ValidEndDt
	,CASE WHEN Ekko.SupplyingPlant=0 THEN NULL ELSE Ekko.SupplyingPlant END AS SupplyingPlant
	,Ekpo.PoItmNbr
	,Ekpo.Material
	,Ekpo.MfgPartNbr
	,Ekpo.VendorMatNbr
	,Ekpo.ProgramId1 AS QuoteNbr
	,Ekpo.PriceUnit
	,CAST(Ekpo.PoQty AS INT) AS PoQty
	,CASE WHEN popic.PrcStgy='TIS' THEN 'K' ELSE '' END AS ItmCat
	,NULL AS AccAssignCat
	,Ekpo.OrderPriceUnit
	,CASE WHEN popic.PoAction='CANCEL' THEN CONVERT(VARCHAR,SchDlvryDt,112) ELSE CONVERT(VARCHAR,Popic.ReschedDt,112) END AS DeliveryDt
	,Ekpo.Plant
	,Ekpo.StorLoc
	,Eket.PoSchedLine
	,CAST(Eket.PoSchedQty AS INT) AS PoSchedQty
	,CASE WHEN popic.PoAction='CANCEL' THEN CONVERT(VARCHAR ,SchDlvryDt ,112) ELSE CONVERT(VARCHAR,Popic.ReschedDt,112) END AS SchedDelvryDt
	,CAST(Eket.PoSchedQty-Eket.QtyGoodRec AS INT) AS PoOpenQty
	,Ekpo.PoNetPrice
	,Popic.CostCond
	,Ekpo.PoNetPrice AS Cost
	,NULL AS ReturnsInd
	,Ekpo.LatestGrDt
	,NULL AS DelInd
	,ekpo.GRBasedIV
	,Ekpo.InvoiceReceipt
	,Popic.SrDir
	,Popic.Pld
	,Popic.MatlSpclst
	,Popic.MatlStatus
	,Popic.ZorQty
	,Popic.ZfcQty
	,Popic.ZsbQty
	,Popic.PoChgCount
	,Popic.AutoBuy
	,Popic.AvnetAbc
	,CustCount.CountOfCustomers AS SixMthCustCount
	,Popic.MrpCtrlr
	,Popic.NcnrFl
	,Popic.CancelWindow
	,Popic.SplrCancelWdw
	,Popic.StkFl
	,Popic.StkHigh
FROM
	(SELECT *
	FROM Popic.dbo.CdbPopic
	WHERE TransmitType='EDI' AND (PoAction='PUSH' OR PoAction='PULL' OR PoAction='CANCEL')) AS Popic
		INNER JOIN 
			(SELECT Spl.MaterialNbr, Spl.VendorNbr
			FROM CentralDbs.dbo.SapPartsList AS Spl
			WHERE Spl.MatHubState<>-1 AND Spl.SendToSapFl='Y') AS Spl
			ON Popic.MaterialNbr=Spl.MaterialNbr
		INNER JOIN
			(SELECT *
			FROM BI.dbo.BIPoBacklog AS Pobl) AS Pobl
			ON Popic.MrpNbr=Pobl.PoNbr AND Popic.MrpItem=Pobl.PoLine AND Popic.SchedItem=Pobl.PoSchedLine
		INNER JOIN SAP.dbo.Ekko
			ON Popic.MrpNbr=Ekko.PoNbr
		INNER JOIN SAP.dbo.Ekpo
			ON Popic.MrpNbr=Ekpo.PoNbr AND Popic.MrpItem=Ekpo.PoItmNbr
		INNER JOIN SAP.dbo.Eket
			ON Popic.MrpNbr=Eket.PoNbr AND Popic.MrpItem=Eket.PoItmNbr AND Popic.SchedItem=Eket.PoSchedLine

		INNER JOIN
			(SELECT PoNbr, PoLineNbr, CostCond, [Value] AS CostCondVal, Curr
			FROM
				(SELECT PoNbr, PoLineNbr, CostCond, [Value], Curr
						,RANK() OVER(PARTITION BY PoNbr, PoLineNbr ORDER BY CostCond DESC) AS Rank2
				FROM
					(SELECT PoNbr, PoLineNbr, CostCond, CAST(CostCondVal AS MONEY) AS Value, Curr
						,RANK() OVER(PARTITION BY IBPCC.PoNbr, PoLineNbr ORDER BY IBPCC.CostCondVal) AS Rank1
					FROM Bi.dbo.BiPoCostConditions AS IBPCC
					WHERE CAST(CostCondVal AS MONEY)>0 AND (CostCond='PBXX' OR CostCond='ZMPP' OR CostCond='ZDC' OR CostCond='ZSBP' OR CostCond='ZBMP' OR CostCond='ZCBM' OR CostCond='ZCSB')) AS RankTbl
				WHERE Rank1=1) AS IBPCC2
			WHERE Rank2=1) AS CostCon
			ON Popic.MrpNbr=CostCon.PoNbr AND Popic.MrpItem=CostCon.PoLineNbr
		LEFT JOIN
			(SELECT Material ,COUNT(DISTINCT TRY_CAST(CustNbr AS BIGINT)) CountOfCustomers
			FROM CentralDbs.dbo.BookBill AS Bb
				INNER JOIN 
					(
					SELECT DISTINCT Rda.FyMthNbr
					FROM CentralDbs.dbo.RefDateAvnet AS Rda
						INNER JOIN 
						(SELECT DISTINCT FyMthNbr
						FROM CentralDbs.dbo.RefDateAvnet AS Rda
						WHERE CAST(rda.DateDt AS DATE)= CAST(GETDATE() AS DATE)) AS Rda1
						ON Rda.FyMthNbr>=Rda1.FyMthNbr-6 AND Rda.FyMthNbr<=rda1.FyMthNbr-1
						) AS Rda
						ON Bb.FyMnthNbr=Rda.FyMthNbr
			GROUP BY Material) AS CustCount
			ON Popic.MaterialNbr=CustCount.Material
ORDER BY Popic.SrDir, Popic.Pld, Popic.MatlSpclst




--Sto Export================================================================================================================
SELECT Popic.Mfg
	,Popic.PrcStgy
	,Popic.CC
	,Popic.Grp
	,Popic.ReschedDt
	,Popic.ConfDlvryDt
	,Popic.SchDlvryDt
	,NULL AS Accepted
	,NULL AS Rejected
	,CASE WHEN PoAction='CANCEL' THEN 'D' ELSE 'C' END AS [Type]
	,NULL AS BlockEdi
	,Ekko.PurReqDocType
	,Ekko.VenAccNbr
	,Ekko.PoNbr
	,CASE WHEN Eket.PurchReqNbr=0 THEN NULL ELSE Eket.PurchReqNbr END AS PurchReqNbr
	,CASE WHEN Eket.RequisitionItmNbr=0 THEN NULL ELSE Eket.RequisitionItmNbr END AS RequisitionItmNbr
	,Ekko.PurchOrg
	,Ekko.PurGrp
	,Ekko.CoCd
	,CONVERT(VARCHAR(10),Ekko.PoDt,112) AS CreateDt
	,CONVERT(VARCHAR(10),Ekko.ValidStartDt,112) AS ValidStartDt
	,CONVERT(VARCHAR(10), Ekko.ValidEndDt ,112) AS ValidEndDt
	,CASE WHEN Ekko.SupplyingPlant=0 THEN NULL ELSE Ekko.SupplyingPlant END AS SupplyingPlant
	,Ekpo.PoItmNbr
	,Ekpo.Material
	,Ekpo.MfgPartNbr
	,Ekpo.VendorMatNbr
	,Ekpo.ProgramId1 AS QuoteNbr
	,Ekpo.PriceUnit
	,CAST(Ekpo.PoQty AS INT) AS PoQty
	,'U' AS ItmCat
	,NULL AS AccAssignCat
	,Ekpo.OrderPriceUnit
	,CASE WHEN popic.PoAction='CANCEL' THEN CONVERT(VARCHAR,SchDlvryDt,112) ELSE CONVERT(VARCHAR,Popic.ReschedDt,112) END AS DeliveryDt
	,Ekpo.Plant
	,Ekpo.StorLoc
	,Eket.PoSchedLine
	,CAST(Eket.PoSchedQty AS INT) AS PoSchedQty
	,CASE WHEN popic.PoAction='CANCEL' THEN CONVERT(VARCHAR ,SchDlvryDt ,112) ELSE CONVERT(VARCHAR,Popic.ReschedDt,112) END AS SchedDelvryDt
	,CAST(Eket.PoSchedQty-Eket.QtyGoodRec AS INT) AS PoOpenQty
	,Ekpo.PoNetPrice
	,Popic.CostCond
	,Ekpo.PoNetPrice AS Cost
	,NULL AS ReturnsInd
	,Ekpo.LatestGrDt
	,NULL AS DelInd
	,ekpo.GRBasedIV
	,Ekpo.InvoiceReceipt
	,Popic.SrDir
	,Popic.Pld
	,Popic.MatlSpclst
	--, CostCon.CostCond, CostCon.CostCondVal
FROM
	(SELECT *
	FROM Popic.dbo.CdbPopic
	WHERE TransmitType='EDI' AND (PoAction='StoPush' OR PoAction='StoPULL' OR PoAction='StoCANCEL')) AS Popic
		INNER JOIN 
			(SELECT Spl.MaterialNbr, Spl.VendorNbr
			FROM CentralDbs.dbo.SapPartsList AS Spl
			WHERE Spl.MatHubState<>-1 AND Spl.SendToSapFl='Y') AS Spl
			ON Popic.MaterialNbr=Spl.MaterialNbr
		INNER JOIN
			(SELECT *
			FROM BI.dbo.BIPoBacklog AS Pobl) AS Pobl
			ON Popic.MrpNbr=Pobl.PoNbr AND Popic.MrpItem=Pobl.PoLine AND Popic.SchedItem=Pobl.PoSchedLine
		INNER JOIN SAP.dbo.Ekpo
			ON Popic.MrpNbr=Ekpo.PoNbr AND Popic.MrpItem=Ekpo.PoItmNbr
				INNER JOIN SAP.dbo.Ekko
			ON Popic.MrpNbr=Ekko.PoNbr
		INNER JOIN SAP.dbo.Eket
			ON Popic.MrpNbr=Eket.PoNbr AND Popic.MrpItem=Eket.PoItmNbr AND Popic.SchedItem=Eket.PoSchedLine
		LEFT JOIN
			(SELECT Material ,COUNT(DISTINCT TRY_CAST(CustNbr AS BIGINT)) CountOfCustomers
			FROM CentralDbs.dbo.BookBill AS Bb
				INNER JOIN 
					(
					SELECT DISTINCT Rda.FyMthNbr
					FROM CentralDbs.dbo.RefDateAvnet AS Rda
						INNER JOIN 
						(SELECT DISTINCT FyMthNbr
						FROM CentralDbs.dbo.RefDateAvnet AS Rda
						WHERE CAST(rda.DateDt AS DATE)= CAST(GETDATE() AS DATE)) AS Rda1
						ON Rda.FyMthNbr>=Rda1.FyMthNbr-6 AND Rda.FyMthNbr<=rda1.FyMthNbr-1
						) AS Rda
						ON Bb.FyMnthNbr=Rda.FyMthNbr
			GROUP BY Material) AS CustCount
			ON Popic.MaterialNbr=CustCount.Material
ORDER BY Popic.SrDir, Popic.Pld, Popic.MatlSpclst

--Nedi Export mat specialists============================================================================================
SELECT
	Popic.Mfg
	,Popic.PrcStgy
	,Popic.CC
	,Popic.Grp
	,Popic.PoAction
	,Popic.ReschedDt
	,Popic.ConfDlvryDt
	,Popic.SchDlvryDt
	,NULL AS Accepted
	,NULL AS Rejected
	,CASE WHEN popic.PoAction='CANCEL' THEN 'D' ELSE 'C' END AS [Type]
	,'X' AS BlockEdi
	,Ekko.PurReqDocType
	,Ekko.VenAccNbr
	,Ekko.PoNbr
	,CASE WHEN Eket.PurchReqNbr=0 THEN NULL ELSE Eket.PurchReqNbr END AS PurchReqNbr
	,CASE WHEN Eket.RequisitionItmNbr=0 THEN NULL ELSE Eket.RequisitionItmNbr END AS RequisitionItmNbr
	,Ekko.PurchOrg
	,Ekko.PurGrp
	,Ekko.CoCd
	,CONVERT(VARCHAR(10),Ekko.PoDt,112) AS CreateDt
	,CONVERT(VARCHAR(10),Ekko.ValidStartDt,112) AS ValidStartDt
	,CONVERT(VARCHAR(10), Ekko.ValidEndDt ,112) AS ValidEndDt
	,CASE WHEN Ekko.SupplyingPlant=0 THEN NULL ELSE Ekko.SupplyingPlant END AS SupplyingPlant
	,Ekpo.PoItmNbr
	,Ekpo.Material
	,Ekpo.MfgPartNbr
	,Ekpo.VendorMatNbr
	,Ekpo.ProgramId1 AS QuoteNbr
	,Ekpo.PriceUnit
	,CAST(Ekpo.PoQty AS INT) AS PoQty
	,CASE WHEN popic.PrcStgy='TIS' THEN 'K' ELSE '' END AS ItmCat
	,NULL AS AccAssignCat
	,Ekpo.OrderPriceUnit
	,CASE WHEN popic.PoAction='CANCEL' THEN CONVERT(VARCHAR,SchDlvryDt,112) ELSE CONVERT(VARCHAR,Popic.ReschedDt,112) END AS DeliveryDt
	,Ekpo.Plant
	,Ekpo.StorLoc
	,Eket.PoSchedLine
	,CAST(Eket.PoSchedQty AS INT) AS PoSchedQty
	,CASE WHEN popic.PoAction='CANCEL' THEN CONVERT(VARCHAR ,SchDlvryDt ,112) ELSE CONVERT(VARCHAR,Popic.ReschedDt,112) END AS SchedDelvryDt
	,CAST(Eket.PoSchedQty-Eket.QtyGoodRec AS INT) AS PoOpenQty
	,Ekpo.PoNetPrice
	,Popic.CostCond
	,Ekpo.PoNetPrice AS Cost
	,NULL AS ReturnsInd
	,Ekpo.LatestGrDt
	,NULL AS DelInd
	,ekpo.GRBasedIV
	,Ekpo.InvoiceReceipt
	,Popic.SrDir
	,Popic.Pld
	,Popic.MatlSpclst
	,Ma.EmpId
	,Popic.MatlStatus
	,Popic.ZorQty
	,Popic.ZfcQty
	,Popic.ZsbQty
	,Popic.PoChgCount
	,Popic.AutoBuy
	,Popic.AvnetAbc
	,CustCount.CountOfCustomers AS SixMthCustCount
	,Popic.MrpCtrlr
	,Popic.NcnrFl
	,Popic.CancelWindow
	,Popic.SplrCancelWdw
	,Popic.StkFl
	,Popic.StkHigh
FROM
	(SELECT *
	FROM Popic.dbo.CdbPopic
	WHERE TransmitType='NEDI' AND (PoAction='PUSH' OR PoAction='PULL' OR PoAction='CANCEL')) AS Popic
		INNER JOIN 
			(SELECT Spl.MaterialNbr, Spl.VendorNbr
			FROM CentralDbs.dbo.SapPartsList AS Spl
			WHERE Spl.MatHubState<>-1 AND Spl.SendToSapFl='Y') AS Spl
			ON Popic.MaterialNbr=Spl.MaterialNbr
		INNER JOIN
			(SELECT *
			FROM BI.dbo.BIPoBacklog AS Pobl) AS Pobl
			ON Popic.MrpNbr=Pobl.PoNbr AND Popic.MrpItem=Pobl.PoLine AND Popic.SchedItem=Pobl.PoSchedLine
		INNER JOIN SAP.dbo.Ekko
			ON Popic.MrpNbr=Ekko.PoNbr
		INNER JOIN SAP.dbo.Ekpo
			ON Popic.MrpNbr=Ekpo.PoNbr AND Popic.MrpItem=Ekpo.PoItmNbr
		INNER JOIN SAP.dbo.Eket
			ON Popic.MrpNbr=Eket.PoNbr AND Popic.MrpItem=Eket.PoItmNbr AND Popic.SchedItem=Eket.PoSchedLine
		LEFT JOIN CentralDbs.dbo.MaterialAor AS Ma
			ON Popic.MaterialNbr=Ma.Material
		INNER JOIN
			(SELECT PoNbr, PoLineNbr, CostCond, [Value] AS CostCondVal, Curr
			FROM
				(SELECT PoNbr, PoLineNbr, CostCond, [Value], Curr
						,RANK() OVER(PARTITION BY PoNbr, PoLineNbr ORDER BY CostCond DESC) AS Rank2
				FROM
					(SELECT PoNbr, PoLineNbr, CostCond, CAST(CostCondVal AS MONEY) AS Value, Curr
						,RANK() OVER(PARTITION BY IBPCC.PoNbr, PoLineNbr ORDER BY IBPCC.CostCondVal) AS Rank1
					FROM Bi.dbo.BiPoCostConditions AS IBPCC
					WHERE CAST(CostCondVal AS MONEY)>0 AND (CostCond='PBXX' OR CostCond='ZMPP' OR CostCond='ZDC' OR CostCond='ZSBP' OR CostCond='ZBMP' OR CostCond='ZCBM' OR CostCond='ZCSB')) AS RankTbl
				WHERE Rank1=1) AS IBPCC2
			WHERE Rank2=1) AS CostCon
			ON Popic.MrpNbr=CostCon.PoNbr AND Popic.MrpItem=CostCon.PoLineNbr
		LEFT JOIN
			(SELECT Material ,COUNT(DISTINCT TRY_CAST(CustNbr AS BIGINT)) CountOfCustomers
			FROM CentralDbs.dbo.BookBill AS Bb
				INNER JOIN 
					(
					SELECT DISTINCT Rda.FyMthNbr
					FROM CentralDbs.dbo.RefDateAvnet AS Rda
						INNER JOIN 
						(SELECT DISTINCT FyMthNbr
						FROM CentralDbs.dbo.RefDateAvnet AS Rda
						WHERE CAST(rda.DateDt AS DATE)= CAST(GETDATE() AS DATE)) AS Rda1
						ON Rda.FyMthNbr>=Rda1.FyMthNbr-6 AND Rda.FyMthNbr<=rda1.FyMthNbr-1
						) AS Rda
						ON Bb.FyMnthNbr=Rda.FyMthNbr
			GROUP BY Material) AS CustCount
			ON Popic.MaterialNbr=CustCount.Material
		INNER JOIN 
			(SELECT *
			FROM Popic.dbo.PopicRules AS Pr
			WHERE OnlySendMsEmail=1) AS Pr
			ON Popic.Mfg=Pr.Mfg AND Popic.PrcStgy=pr.PrcStgy AND Popic.CC=Pr.Cc AND Popic.Grp=Pr.Grp
ORDER BY Popic.SrDir, Popic.Pld, Popic.MatlSpclst


--Nedi Export Suppliers===========================================================================================================
SELECT
	Popic.Mfg
	,Popic.PrcStgy
	,Popic.CC
	,Popic.Grp
	,Popic.ReschedDt
	,Popic.ConfDlvryDt
	,Popic.SchDlvryDt
	,NULL AS Accepted
	,NULL AS Rejected
	,CASE WHEN PoAction='CANCEL' THEN 'D' ELSE 'C' END AS [Type]
	,'X' AS BlockEdi
	,Ekko.PurReqDocType
	,Ekko.VenAccNbr
	,Ekko.PoNbr
	,CASE WHEN Eket.PurchReqNbr=0 THEN NULL ELSE Eket.PurchReqNbr END AS PurchReqNbr
	,CASE WHEN Eket.RequisitionItmNbr=0 THEN NULL ELSE Eket.RequisitionItmNbr END AS RequisitionItmNbr
	,Ekko.PurchOrg
	,Ekko.PurGrp
	,Ekko.CoCd
	,CONVERT(VARCHAR(10),Ekko.PoDt,112) AS CreateDt
	,CONVERT(VARCHAR(10),Ekko.ValidStartDt,112) AS ValidStartDt
	,CONVERT(VARCHAR(10), Ekko.ValidEndDt ,112) AS ValidEndDt
	,CASE WHEN Ekko.SupplyingPlant=0 THEN NULL ELSE Ekko.SupplyingPlant END AS SupplyingPlant
	,Ekpo.PoItmNbr
	,Ekpo.Material
	,Ekpo.MfgPartNbr
	,Ekpo.VendorMatNbr
	,Ekpo.ProgramId1 AS QuoteNbr
	,Ekpo.PriceUnit
	,CAST(Ekpo.PoQty AS INT) AS PoQty
	,CASE WHEN popic.PrcStgy='TIS' THEN 'K' ELSE '' END AS ItmCat
	,NULL AS AccAssignCat
	,Ekpo.OrderPriceUnit
	,CASE WHEN popic.PoAction='CANCEL' THEN CONVERT(VARCHAR,SchDlvryDt,112) ELSE CONVERT(VARCHAR,Popic.ReschedDt,112) END AS DeliveryDt
	,Ekpo.Plant
	,Ekpo.StorLoc
	,Eket.PoSchedLine
	,CAST(Eket.PoSchedQty AS INT) AS PoSchedQty
	,CASE WHEN popic.PoAction='CANCEL' THEN CONVERT(VARCHAR ,SchDlvryDt ,112) ELSE CONVERT(VARCHAR,Popic.ReschedDt,112) END AS SchedDelvryDt
	,CAST(Eket.PoSchedQty-Eket.QtyGoodRec AS INT) AS PoOpenQty
	,Ekpo.PoNetPrice
	,Popic.CostCond
	,Ekpo.PoNetPrice AS Cost
	,NULL AS ReturnsInd
	,Ekpo.LatestGrDt
	,NULL AS DelInd
	,ekpo.GRBasedIV
	,Ekpo.InvoiceReceipt
	,Popic.SrDir
	,Popic.Pld
	,Popic.MatlSpclst
	,Ma.EmpId

FROM
	(SELECT *
	FROM Popic.dbo.CdbPopic
	WHERE TransmitType='NEDI' AND (PoAction='PUSH' OR PoAction='PULL' OR PoAction='CANCEL')) AS Popic
		INNER JOIN 
			(SELECT Spl.MaterialNbr, Spl.VendorNbr
			FROM CentralDbs.dbo.SapPartsList AS Spl
			WHERE Spl.MatHubState<>-1 AND Spl.SendToSapFl='Y') AS Spl
			ON Popic.MaterialNbr=Spl.MaterialNbr
		INNER JOIN
			(SELECT *
			FROM BI.dbo.BIPoBacklog AS Pobl) AS Pobl
			ON Popic.MrpNbr=Pobl.PoNbr AND Popic.MrpItem=Pobl.PoLine AND Popic.SchedItem=Pobl.PoSchedLine
		INNER JOIN SAP.dbo.Ekko
			ON Popic.MrpNbr=Ekko.PoNbr
		INNER JOIN SAP.dbo.Ekpo
			ON Popic.MrpNbr=Ekpo.PoNbr AND Popic.MrpItem=Ekpo.PoItmNbr
		INNER JOIN SAP.dbo.Eket
			ON Popic.MrpNbr=Eket.PoNbr AND Popic.MrpItem=Eket.PoItmNbr AND Popic.SchedItem=Eket.PoSchedLine
		LEFT JOIN CentralDbs.dbo.MaterialAor AS Ma
			ON Popic.MaterialNbr=Ma.Material
		INNER JOIN
			(SELECT PoNbr, PoLineNbr, CostCond, [Value] AS CostCondVal, Curr
			FROM
				(SELECT PoNbr, PoLineNbr, CostCond, [Value], Curr
						,RANK() OVER(PARTITION BY PoNbr, PoLineNbr ORDER BY CostCond DESC) AS Rank2
				FROM
					(SELECT PoNbr, PoLineNbr, CostCond, CAST(CostCondVal AS MONEY) AS Value, Curr
						,RANK() OVER(PARTITION BY IBPCC.PoNbr, PoLineNbr ORDER BY IBPCC.CostCondVal) AS Rank1
					FROM Bi.dbo.BiPoCostConditions AS IBPCC
					WHERE CAST(CostCondVal AS MONEY)>0 AND (CostCond='PBXX' OR CostCond='ZMPP' OR CostCond='ZDC' OR CostCond='ZSBP' OR CostCond='ZBMP' OR CostCond='ZCBM' OR CostCond='ZCSB')) AS RankTbl
				WHERE Rank1=1) AS IBPCC2
			WHERE Rank2=1) AS CostCon
			ON Popic.MrpNbr=CostCon.PoNbr AND Popic.MrpItem=CostCon.PoLineNbr
		LEFT JOIN
			(SELECT Material ,COUNT(DISTINCT TRY_CAST(CustNbr AS BIGINT)) CountOfCustomers
			FROM CentralDbs.dbo.BookBill AS Bb
				INNER JOIN 
					(
					SELECT DISTINCT Rda.FyMthNbr
					FROM CentralDbs.dbo.RefDateAvnet AS Rda
						INNER JOIN 
						(SELECT DISTINCT FyMthNbr
						FROM CentralDbs.dbo.RefDateAvnet AS Rda
						WHERE CAST(rda.DateDt AS DATE)= CAST(GETDATE() AS DATE)) AS Rda1
						ON Rda.FyMthNbr>=Rda1.FyMthNbr-6 AND Rda.FyMthNbr<=rda1.FyMthNbr-1
						) AS Rda
						ON Bb.FyMnthNbr=Rda.FyMthNbr
			GROUP BY Material) AS CustCount
			ON Popic.MaterialNbr=CustCount.Material
		INNER JOIN 
			(SELECT *
			FROM Popic.dbo.PopicRules AS Pr
			WHERE OnlySendMsEmail=0) AS Pr
			ON Popic.Mfg=Pr.Mfg AND Popic.PrcStgy=pr.PrcStgy AND Popic.CC=Pr.Cc AND Popic.Grp=Pr.Grp
ORDER BY Popic.SrDir, Popic.Pld, Popic.MatlSpclst
