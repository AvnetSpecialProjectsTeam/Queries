CREATE TABLE ##TempInvSoPo
	(MaterialNbr BIGINT
	,MfgPartNbr VARCHAR(50)
	,Plant INT
	,SpecialStk VARCHAR(2)
	,CustReqDtPoConf DATETIME2
	,AtpDatePoReqDt DATETIME2
	,DocCreateDt DATETIME2
	,OrderNbr BIGINT
	,LineNbr INT
	,SchedLineNbr INT
	,QOH BIGINT
	,DollarValue MONEY
	,QAS BIGINT
	,[Type] VARCHAR(5)
	,Pbg VARCHAR(3)
	,Mfg VARCHAR(3)
	,PrcStgy VARCHAR(3)
	,Cc VARCHAR(3)
	,Grp VARCHAR(3)
	,SrDir VARCHAR(50)
	,Pld VARCHAR(50)
	,MatlMgr VARCHAR(50)
	,MatlSpclst VARCHAR(50)
	INDEX MatTempInvSoPo  (MaterialNbr))
GO

INSERT INTO ##TempInvSoPo
SELECT Di.MaterialNbr, Di.MfgPartNbr, Di.Plant, DI.SpecialStk, '1900-01-01' AS CustReqDtPoConf, NULL AS AtpDatePoReqDt, NULL AS DocCreateDt, NULL	 AS OrderNbr, NULL AS LineNbr, NULL AS SchedLineNbr, SUM(Di.TtlStkQty) AS QOH, NULL AS DollarValue, SUM(Di.AvlStkQty) AS QAS, 'Inv' AS Type, ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst
FROM DailyInv AS Di LEFT JOIN SAP.Dbo.MatAor AS Ma ON Di.MaterialNbr=Ma.MaterialNbr
WHERE Di.TtlStkQty<>0
GROUP BY Di.MaterialNbr, Di.MfgPartNbr, Di.Plant, DI.SpecialStk, Di.Pbg,Di.Mfg, Di.PrcStgy, Di.TechCd, Di.Cc, Di.Grp, ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst
UNION ALL

--So backlog Append
SELECT Sobl.MaterialNbr, SoBl.MfgPartNbr, SoBl.PlantId, NULL AS SpecialStk, SoBl.CustReqDockDt, SoBl.AtpDt, SoBl.SalesDocItCreateDt, SoBl.SalesDocNbr, SoBl.SalesDocItemNbr, SoBl.SoSchedLine, -SoBl.RemainingQty, SoBl.UnitPrice*-SoBl.RemainingQty AS DollarValue, -SoBl.RemainingQty, CASE WHEN Sobl.SalesDocType ='ZOR' THEN 'SO' WHEN Sobl.SalesDocType = 'ZFC' THEN 'FC' ELSE NULL END AS [Type], ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst
FROM SoBacklog AS SoBl LEFT JOIN SAP.dbo.MatAor AS Ma ON SoBl.MaterialNbr=ma.MaterialNbr
WHERE SoBl.RemainingQty>0 AND (SoBl.SalesDocType='ZOR')
UNION ALL

--PoBacklog Append
SELECT *
FROM
	(SELECT PoBl.MaterialNbr, M.ManufacturerPartNo, PoBl.Plant, NULL AS SpecialStk, E.DelvDtofVendorConf AS VendorConfDelDt, PoBl.SchedLineDeliveryDt, PoBl.OrderDt, PoBl.PoNbr, PoBl.PoLine, PoBl.PoSchedLine, CASE WHEN E.ConfCategory='A1' THEN E.QtyPerVendorConf ELSE PoBl.PoOpenQty END AS PoQty, (Pobl.PoRemainingValue / pobl.PoOpenQty) * E.QtyPerVendorConf AS PoValue, CASE WHEN E.ConfCategory='A1' THEN E.QtyPerVendorConf ELSE PoBl.PoOpenQty END AS PoQas, PoBl.DocType AS [Type],  ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst
	FROM BIPoBacklog AS PoBl LEFT JOIN SAP.dbo.EKES AS E ON PoBl.PoNbr = E.PurchaseDocNbr AND PoBl.PoLine=E.ItemNbrofPurchaseDoc
		INNER JOIN SAP.dbo.MatAor AS Ma ON PoBl.MaterialNbr=ma.MaterialNbr
		INNER JOIN MDM.dbo.Material AS M ON PoBl.MaterialNbr=M.SapMaterialId
		--LEFT JOIN BI.dbo.BiPoCostConditions AS PoCc ON Pobl.PoNbr=PoCc.PONbr AND PoBl.PoLine=PoCc.PoLineNbr
	WHERE Pobl.PoOpenQty>0 AND E.ConfCategory='A1' AND E.DelvDtofVendorConf IS NOT NULL) AS T
GROUP BY MaterialNbr, ManufacturerPartNo, Plant, SpecialStk, VendorConfDelDt, SchedLineDeliveryDt, OrderDt, PoNbr, PoLine, PoSchedLine, PoQty, PoValue, PoQas, [Type],  Pbg, Mfg, PrcStgy, Cc, Grp, SrDir, Pld, MatlMgr, MatlSpclst
GO


TRUNCATE TABLE InvSoPo
GO
--===============================================================
INSERT INTO InvSoPo
SELECT A.MaterialNbr, A.MfgPartNbr, A.Plant, A.SpecialStk, A.CustReqDtPoConf, A.AtpDatePoReqDt, A.DocCreateDt, A.OrderNbr, A.LineNbr, A.SchedLineNbr, A.QOH, 
	(SELECT CASE WHEN SUM(C.QOH) IS NULL THEN 0 ELSE SUM(C.QOH) END 
	FROM ##TempInvSoPo AS C 
		WHERE C.MaterialNbr=A.MaterialNbr AND C.CustReqDtPoConf<=A.CustReqDtPoConf) AS TotalQOH, A.DollarValue, A.QAS, 

	(SELECT CASE WHEN SUM(D.QAS) IS NULL THEN 0 ELSE SUM(D.QAS) END
	FROM ##TempInvSoPo AS D 		
	WHERE D.MaterialNbr=A.MaterialNbr AND D.CustReqDtPoConf<=A.CustReqDtPoConf) AS TotalQAS, A.Type, MC.SupLeadTime AS LeadTime, A.Pbg, A.Mfg, A.PrcStgy, A.Cc, A.Grp, A.SrDir, A.Pld, A.MatlSpclst
FROM 
	--Daily Inv Append
	##TempInvSoPo AS A

LEFT JOIN

	(SELECT DISTINCT DiSoPo.MaterialNbr
	FROM 
	--Daily Inv Append
		##TempInvSoPo AS DiSoPo
	WHERE (SELECT SUM(B.QOH)
			FROM ##TempInvSoPo AS B
			WHERE B.MaterialNbr=DiSoPo.MaterialNbr AND DiSoPo.CustReqDtPoConf<=B.CustReqDtPoConf)<0) AS C ON A.MaterialNbr=C.MaterialNbr

LEFT JOIN SAP.dbo.MARC AS MC ON A.MaterialNbr=MC.MatNbr AND A.Plant=MC.Plnt

ORDER BY A.MaterialNbr ASC, A.Plant ASC, A.CustReqDtPoConf ASC;
GO

DROP TABLE ##TempInvSoPo

--SELECT *
--FROM ##TempInvSoPo
--ORDER BY MaterialNbr, Plant, CustReqDtPoConf
--WHERE MaterialNbr=5070717

