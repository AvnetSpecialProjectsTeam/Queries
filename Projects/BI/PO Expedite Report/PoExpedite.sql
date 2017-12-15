--With Forecasts 

SELECT A.MaterialNbr, A.MfgPartNbr, A.Plant, A.SpecialStk, A.CustReqDtPoConf, A.AtpDatePoReqDt, A.DocCreateDt, A.OrderNbr, A.LineNbr, A.SchedLineNbr, A.QOH, 
	(SELECT CASE WHEN SUM(C.QOH) IS NULL THEN 0 ELSE SUM(C.QOH) END 
	FROM 
		(SELECT Di.MaterialNbr, Di.MfgPartNbr, Di.Plant, DI.SpecialStk, '1900-01-01' AS CustReqDtPoConf, NULL AS AtpDatePoReqDt, NULL AS DocCreateDt, NULL AS OrderNbr, NULL AS LineNbr, NULL AS SchedLineNbr, SUM(Di.TtlStkQty) AS QOH, NULL AS DollarValue, SUM(Di.AvlStkQty) AS QAS, 'Inv' AS Type, ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst 
			FROM Bi.dbo.DailyInv AS Di LEFT JOIN SAP.Dbo.MatAor AS Ma ON Di.MaterialNbr=ma.MatNbr
			WHERE Di.TtlStkQty<>0 AND Di.AvlStkQty<>0
			GROUP BY Di.MaterialNbr, Di.MfgPartNbr, Di.Plant, DI.SpecialStk, Di.Pbg,Di.Mfg, Di.PrcStgy, Di.TechCd, Di.Cc, Di.Grp, ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst
			UNION ALL
			--So backlog Append
			SELECT Sobl.MaterialNbr, SoBl.MfgPartNbr, SoBl.PlantId, NULL AS SpecialStk, SoBl.CustReqDockDt, SoBl.AtpDt, SoBl.SalesDocItCreateDt, SoBl.SalesDocNbr, SoBl.SalesDocItemNbr, SoBl.SoSchedLine, -SoBl.RemainingQty, SoBl.UnitPrice*SoBl.RemainingQty AS DollarValue, -SoBl.RemainingQty, CASE WHEN Sobl.SalesDocType ='ZOR' THEN 'SO' WHEN Sobl.SalesDocType = 'ZFC' THEN 'FC' ELSE NULL END AS [Type], ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst
			FROM BI.dbo.SoBacklog AS SoBl LEFT JOIN SAP.dbo.MatAor AS Ma ON SoBl.MaterialNbr=ma.MatNbr
			WHERE SoBl.RemainingQty>0 AND (SoBl.SalesDocType='ZOR' OR SoBl.SalesDocType='ZFC')
			UNION ALL
			--PoBacklog Append
			SELECT PoBl.MaterialNbr, M.ManufacturerPartNo, PoBl.Plant, NULL AS SpecialStk, PoBl.ConfDlvryDt, PoBl.SchedLineDeliveryDt, PoBl.OrderDt, PoBl.PoNbr, PoBl.PoLine, PoBl.PoSchedLine, Pobl.PoOpenQty, Pobl.PoRemainingValue, Pobl.PoOpenQty, 'PO' AS [Type],  ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst
			FROM Bi.dbo.BIPoBacklog AS PoBl INNER JOIN SAP.dbo.MatAor AS Ma ON PoBl.MaterialNbr=ma.MatNbr INNER JOIN MDM.dbo.Material AS M ON PoBl.MaterialNbr=M.SapMaterialId
			WHERE Pobl.PoOpenQty>0) AS C 
		WHERE C.MaterialNbr=A.MaterialNbr AND C.CustReqDtPoConf<=A.CustReqDtPoConf) AS TotalQOH, A.DollarValue, A.QAS, 

	(SELECT CASE WHEN SUM(D.QAS) IS NULL THEN 0 ELSE SUM(D.QAS) END
	FROM 
		(SELECT Di.MaterialNbr, Di.MfgPartNbr, Di.Plant, DI.SpecialStk, '1900-01-01' AS CustReqDtPoConf, NULL AS AtpDatePoReqDt, NULL AS DocCreateDt, NULL AS OrderNbr, NULL AS LineNbr, NULL AS SchedLineNbr, SUM(Di.TtlStkQty) AS QOH, NULL AS DollarValue, SUM(Di.AvlStkQty) AS QAS, 'Inv' AS Type, ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst 
		FROM DailyInv AS Di LEFT JOIN SAP.Dbo.MatAor AS Ma ON Di.MaterialNbr=ma.MatNbr
		WHERE Di.TtlStkQty<>0 AND Di.AvlStkQty<>0
		GROUP BY Di.MaterialNbr, Di.MfgPartNbr, Di.Plant, DI.SpecialStk, Di.Pbg,Di.Mfg, Di.PrcStgy, Di.TechCd, Di.Cc, Di.Grp, ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst
		UNION ALL
		--So backlog Append
		SELECT Sobl.MaterialNbr, SoBl.MfgPartNbr, SoBl.PlantId, NULL AS SpecialStk, SoBl.CustReqDockDt, SoBl.AtpDt, SoBl.SalesDocItCreateDt, SoBl.SalesDocNbr, SoBl.SalesDocItemNbr, SoBl.SoSchedLine, -SoBl.RemainingQty, SoBl.UnitPrice*SoBl.RemainingQty AS DollarValue, -SoBl.RemainingQty, CASE WHEN Sobl.SalesDocType ='ZOR' THEN 'SO' WHEN Sobl.SalesDocType = 'ZFC' THEN 'FC' ELSE NULL END AS [Type], ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst
		FROM SoBacklog AS SoBl LEFT JOIN SAP.dbo.MatAor AS Ma ON SoBl.MaterialNbr=ma.MatNbr
		WHERE SoBl.RemainingQty>0 AND (SoBl.SalesDocType='ZOR' OR SoBl.SalesDocType='ZFC')
		UNION ALL
		--PoBacklog Append
		SELECT PoBl.MaterialNbr, M.ManufacturerPartNo, PoBl.Plant, NULL AS SpecialStk, PoBl.ConfDlvryDt, PoBl.SchedLineDeliveryDt, PoBl.OrderDt, PoBl.PoNbr, PoBl.PoLine, PoBl.PoSchedLine, Pobl.PoOpenQty, Pobl.PoRemainingValue, Pobl.PoOpenQty, 'PO' AS [Type],  ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst
		FROM BIPoBacklog AS PoBl INNER JOIN SAP.dbo.MatAor AS Ma ON PoBl.MaterialNbr=ma.MatNbr INNER JOIN MDM.dbo.Material AS M ON PoBl.MaterialNbr=M.SapMaterialId
		WHERE Pobl.PoOpenQty>0) AS D 		
	WHERE D.MaterialNbr=A.MaterialNbr AND D.CustReqDtPoConf<=A.CustReqDtPoConf) AS TotalQAS, A.Type, A.Pbg, A.Mfg, A.PrcStgy, A.Cc, A.Grp, A.SrDir, A.Pld, A.MatlSpclst

FROM 
	--Daily Inv Append
	(SELECT Di.MaterialNbr, Di.MfgPartNbr, Di.Plant, DI.SpecialStk, '1900-01-01' AS CustReqDtPoConf, NULL AS AtpDatePoReqDt, NULL AS DocCreateDt, NULL AS OrderNbr, NULL AS LineNbr, NULL AS SchedLineNbr, SUM(Di.TtlStkQty) AS QOH, NULL AS DollarValue, SUM(Di.AvlStkQty) AS QAS, 'Inv' AS Type, ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst 
	FROM DailyInv AS Di LEFT JOIN SAP.Dbo.MatAor AS Ma ON Di.MaterialNbr=ma.MatNbr
	WHERE Di.TtlStkQty<>0 AND Di.AvlStkQty<>0
	GROUP BY Di.MaterialNbr, Di.MfgPartNbr, Di.Plant, DI.SpecialStk, Di.Pbg,Di.Mfg, Di.PrcStgy, Di.TechCd, Di.Cc, Di.Grp, ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst
	UNION ALL

	--So backlog Append
	SELECT Sobl.MaterialNbr, SoBl.MfgPartNbr, SoBl.PlantId, NULL AS SpecialStk, SoBl.CustReqDockDt, SoBl.AtpDt, SoBl.SalesDocItCreateDt, SoBl.SalesDocNbr, SoBl.SalesDocItemNbr, SoBl.SoSchedLine, -SoBl.RemainingQty, SoBl.UnitPrice*SoBl.RemainingQty AS DollarValue, -SoBl.RemainingQty, CASE WHEN Sobl.SalesDocType ='ZOR' THEN 'SO' WHEN Sobl.SalesDocType = 'ZFC' THEN 'FC' ELSE NULL END AS [Type], ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst
	FROM SoBacklog AS SoBl LEFT JOIN SAP.dbo.MatAor AS Ma ON SoBl.MaterialNbr=ma.MatNbr
	WHERE SoBl.RemainingQty>0 AND (SoBl.SalesDocType='ZOR' OR SoBl.SalesDocType='ZFC')
	UNION ALL

	--PoBacklog Append
	SELECT PoBl.MaterialNbr, M.ManufacturerPartNo, PoBl.Plant, NULL AS SpecialStk, PoBl.ConfDlvryDt, PoBl.SchedLineDeliveryDt, PoBl.OrderDt, PoBl.PoNbr, PoBl.PoLine, PoBl.PoSchedLine, Pobl.PoOpenQty, Pobl.PoRemainingValue, Pobl.PoOpenQty, 'PO' AS [Type],  ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst
	FROM BIPoBacklog AS PoBl INNER JOIN SAP.dbo.MatAor AS Ma ON PoBl.MaterialNbr=ma.MatNbr INNER JOIN MDM.dbo.Material AS M ON PoBl.MaterialNbr=M.SapMaterialId
	WHERE Pobl.PoOpenQty>0) AS A

INNER JOIN

	(SELECT DISTINCT DiSoPo.MaterialNbr
	FROM 
	--Daily Inv Append
		(SELECT Di.MaterialNbr, Di.MfgPartNbr, Di.Plant, DI.SpecialStk, '1900-01-01' AS CustReqDtPoConf, NULL AS AtpDatePoReqDt, NULL AS DocCreateDt, NULL AS OrderNbr, NULL AS LineNbr, NULL AS SchedLineNbr, SUM(Di.TtlStkQty) AS QOH, NULL AS DollarValue, SUM(Di.AvlStkQty) AS QAS, 'Inv' AS Type, ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst 
		FROM DailyInv AS Di LEFT JOIN SAP.Dbo.MatAor AS Ma ON Di.MaterialNbr=ma.MatNbr
		WHERE Di.TtlStkQty<>0 AND Di.AvlStkQty<>0
		GROUP BY Di.MaterialNbr, Di.MfgPartNbr, Di.Plant, DI.SpecialStk, Di.Pbg,Di.Mfg, Di.PrcStgy, Di.TechCd, Di.Cc, Di.Grp, ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst
		UNION ALL
		--So backlog Append
		SELECT Sobl.MaterialNbr, SoBl.MfgPartNbr, SoBl.PlantId, NULL AS SpecialStk, SoBl.CustReqDockDt, SoBl.AtpDt, SoBl.SalesDocItCreateDt, SoBl.SalesDocNbr, SoBl.SalesDocItemNbr, SoBl.SoSchedLine, -SoBl.RemainingQty, SoBl.UnitPrice*SoBl.RemainingQty AS DollarValue, -SoBl.RemainingQty, CASE WHEN Sobl.SalesDocType ='ZOR' THEN 'SO' WHEN Sobl.SalesDocType = 'ZFC' THEN 'FC' ELSE NULL END AS [Type], ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst
		FROM SoBacklog AS SoBl LEFT JOIN SAP.dbo.MatAor AS Ma ON SoBl.MaterialNbr=ma.MatNbr
		WHERE SoBl.RemainingQty>0 AND (SoBl.SalesDocType='ZOR' OR SoBl.SalesDocType='ZFC')
		UNION ALL
		--PoBacklog Append
		SELECT PoBl.MaterialNbr, M.ManufacturerPartNo, PoBl.Plant, NULL AS SpecialStk, PoBl.ConfDlvryDt, PoBl.SchedLineDeliveryDt, PoBl.OrderDt, PoBl.PoNbr, PoBl.PoLine, PoBl.PoSchedLine, Pobl.PoOpenQty, Pobl.PoRemainingValue, Pobl.PoOpenQty, 'PO' AS [Type],  ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst
		FROM BIPoBacklog AS PoBl INNER JOIN SAP.dbo.MatAor AS Ma ON PoBl.MaterialNbr=ma.MatNbr INNER JOIN MDM.dbo.Material AS M ON PoBl.MaterialNbr=M.SapMaterialId
		WHERE Pobl.PoOpenQty>0) AS DiSoPo

	WHERE (SELECT SUM(B.QOH)
			FROM (SELECT Di.MaterialNbr, Di.MfgPartNbr, Di.Plant, DI.SpecialStk, '1900-01-01' AS CustReqDtPoConf, NULL AS AtpDatePoReqDt, NULL AS DocCreateDt, NULL	 AS OrderNbr, NULL AS LineNbr, NULL AS SchedLineNbr, SUM(Di.TtlStkQty) AS QOH, NULL AS DollarValue, SUM(Di.AvlStkQty) AS QAS, 'Inv' AS Type, ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst 
				FROM DailyInv AS Di LEFT JOIN SAP.Dbo.MatAor AS Ma ON Di.MaterialNbr=ma.MatNbr
				WHERE Di.TtlStkQty<>0 AND Di.AvlStkQty<>0
				GROUP BY Di.MaterialNbr, Di.MfgPartNbr, Di.Plant, DI.SpecialStk, Di.Pbg,Di.Mfg, Di.PrcStgy, Di.TechCd, Di.Cc, Di.Grp, ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst
				UNION ALL

				--So backlog Append
				SELECT Sobl.MaterialNbr, SoBl.MfgPartNbr, SoBl.PlantId, NULL AS SpecialStk, SoBl.CustReqDockDt, SoBl.AtpDt, SoBl.SalesDocItCreateDt, SoBl.SalesDocNbr, SoBl.SalesDocItemNbr, SoBl.SoSchedLine, -SoBl.RemainingQty, SoBl.UnitPrice*SoBl.RemainingQty AS DollarValue, -SoBl.RemainingQty, CASE WHEN Sobl.SalesDocType ='ZOR' THEN 'SO' WHEN Sobl.SalesDocType = 'ZFC' THEN 'FC' ELSE NULL END AS [Type], ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst
				FROM SoBacklog AS SoBl LEFT JOIN SAP.dbo.MatAor AS Ma ON SoBl.MaterialNbr=ma.MatNbr
				WHERE SoBl.RemainingQty>0 AND (SoBl.SalesDocType='ZOR' OR SoBl.SalesDocType='ZFC')
				UNION ALL

				--PoBacklog Append
				SELECT PoBl.MaterialNbr, M.ManufacturerPartNo, PoBl.Plant, NULL AS SpecialStk, PoBl.ConfDlvryDt, PoBl.SchedLineDeliveryDt, PoBl.OrderDt, PoBl.PoNbr, PoBl.PoLine, PoBl.PoSchedLine, Pobl.PoOpenQty, Pobl.PoRemainingValue, Pobl.PoOpenQty, 'PO' AS [Type],  ma.Pbg, ma.Mfg, ma.PrcStgy, ma.Cc, ma.Grp, ma.SrDir, ma.Pld, ma.MatlMgr, ma.MatlSpclst
				FROM BIPoBacklog AS PoBl INNER JOIN SAP.dbo.MatAor AS Ma ON PoBl.MaterialNbr=ma.MatNbr INNER JOIN MDM.dbo.Material AS M ON PoBl.MaterialNbr=M.SapMaterialId
				WHERE Pobl.PoOpenQty>=0) AS B 

	WHERE B.MaterialNbr=DiSoPo.MaterialNbr AND DiSoPo.CustReqDtPoConf<=B.CustReqDtPoConf)<0) AS C ON A.MaterialNbr=C.MaterialNbr
ORDER BY A.MaterialNbr ASC, A.CustReqDtPoConf ASC;




CREATE TABLE ##MaterialsShort
	(MaterialNbr BIGINT)
CREATE INDEX InMatNbr on ##MaterialsShort (MaterialNbr)
GO

INSERT INTO ##MaterialsShort
SELECT DISTINCT C.MaterialNbr
FROM SAP.dbo.DailyInvSoPoQty AS C
WHERE (SELECT SUM(D.[Qty(QOH)]) FROM SAP.dbo.DailyInvSoPoQty AS D WHERE D.MaterialNbr=C.MaterialNbr AND D.FullfilmentDt<=C.FullfilmentDt)<0
GO


SELECT A.MaterialNbr, A.MfgPartNbr, A.FullfilmentDt, A.CustReqDt, A.CreateDt, A.OrderNbr, A.LineNbr, A.SchedNbr, A.[Qty(QOH)], 
	
	(SELECT SUM(B.[Qty(QOH)]) 
	FROM DailyInvSoPoQty AS B 
	WHERE B.MaterialNbr=A.MaterialNbr AND B.FullfilmentDt<=A.FullfilmentDt) AS TotalQOH, A.DollarValue, A.[Qty(QAS)], 
	
	(SELECT SUM(B.[Qty(QAS)]) 
	FROM DailyInvSoPoQty AS B 
	WHERE B.MaterialNbr=A.MaterialNbr AND B.FullfilmentDt<=A.FullfilmentDt) AS TotalQAS, A.Type, A.Pbg, A.Mfg, A.PrcStgy, A.TechCd, A.Cc, A.Grp, A.SrDirector, A.Pld, A.MatSpecialist


FROM DailyInvSoPoQty AS A 
	INNER JOIN ##MaterialsShort AS E ON E.MaterialNbr=A.MaterialNbr

ORDER BY A.MaterialNbr, A.FullfilmentDt;

--DROP TABLE ##MaterialsShort