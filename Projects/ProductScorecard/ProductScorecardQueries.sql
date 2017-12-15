--DROP TABLE #UniqueSobl;
WITH CTE
AS
	(SELECT sobl.*, RANK() OVER(PARTITION BY Sobl.SalesDocNbr, SoBl.SalesDocItemNbr, sobl.FyMthNbr ORDER BY Sobl.SalesDocNbr, SoBl.SalesDocItemNbr, Sobl.SqlStartTime Desc) AS Rank1
	FROM BI.dbo.SoBacklog 
	FOR SYSTEM_TIME ALL AS SoBl)
SELECT  *
INTO #UniqueSobl
FROM CTE
WHERE Rank1=1



SELECT 
	'90Day SOBKLG' AS metric
	,Stuff(Replace('/'+Convert(varchar(10), Sobl.[LogDt], 101),'/0','/'),1,1,'') AS LogDt
	,NULL AS LogTime
	,Stuff(RefDateAvnet.FyYyyyQtr,5,1,'-') AS FyQtr
	,NULL AS TransDt
	,RefDateAvnet.BusDay99
	,NULL AS WkNbr
	,SoBl.FyMthNbr
	,RefDateAvnet.FyTagMth
	,SoBl.MaterialNbr
	,SoBl.Pbg
	,SoBl.Mfg
	,SoBl.PrcStgy
	,SoBl.Tech
	,SoBl.Cc
	,SoBl.Grp
	,SoBl.MfgPartNbr
	,SoBl.BlockedOrders
	,SoBl.PricingBlock
	,CAST(Sobl.[SalesOffice] AS varchar(15)) AS SalesOffice
	,NULL AS SalesOfficeKey
	,CAST(Sobl.[SalesGrp] AS varchar(15)) AS SalesGrp
	,NULL AS SalesGrpKey
	,NULL AS CustName
	,NULL AS CustNbr
	,SoBl.SalesDocType
	,NULL AS RefBillingNbr
	,CASE WHEN SoBl.LastConfPromDt BETWEEN GETDATE() AND GETDATE()+90 OR Sobl.CustReqDockDt BETWEEN GETDATE() AND GETDATE()+30 THEN SoBl.TtlOrderValue ELSE 0 END AS [value]
	,Sobl.[SalesDocNbr] AS SalesDocNbr
	,Sobl.[SalesDocItemNbr] AS SalesDocItemNbr
	,CASE WHEN Pasobl.EmpFirstName IS NULL OR Pasobl.EmpFirstName IS NULL THEN '' ELSE CONCAT(Pasobl.EmpLastName, ', ', Pasobl.EmpFirstName) END AS ProductSpecialist
	,SoBl.AtpDt
	,SoBl.DlvryDt
	,Stuff(Replace('/'+Convert(varchar(10), Sobl.[AtpDt], 101),'/0','/'),1,1,'') AS AtpDt2
	,SoBl.ExtResale
	,SoBl.ExtCost
	,NULL AS SGPM
	,SoBl.LastConfPromDt
	,Sobl.CustReqDockDt
		
FROM 
	(SELECT *
	FROM #UniqueSobl) AS Sobl
	INNER JOIN 
		(SELECT *
		FROM CentralDbs.dbo.RefDateAvnet AS RefDateAvnet
		WHERE BusDay99 = 1) AS RefDateAvnet
		ON CAST(SoBl.sqlstarttime AS DATE)=RefDateAvnet.DateDt
	LEFT JOIN CentralDbs.dbo.ProdAorSobl AS PaSobl 
		ON SoBl.SalesDocNbr=PaSobl.SalesDocNbr AND  SoBl.SalesDocItemNbr=PaSobl.SalesDocItemNbr
	INNER JOIN SAP.dbo.Ztqtcaorhdr AS ZAH ON ZAH.AORID=PaSobl.AorId
	LEFT JOIN MDM.dbo.CostResale AS CR ON SoBl.MaterialNbr=cr.material_nbr
	WHERE ([SalesDocType]= 'ZOR' OR [SalesDocType]='ZKE1') AND [RemainingQty]<>0 AND ZAH.startdate<=CAST(GETDATE() AS DATE) AND ZAH.EndDate>CAST(GETDATE() AS DATE)

UNION ALL

SELECT 
	'30Day SOBKLG' AS metric
	,Stuff(Replace('/'+Convert(varchar(10), Sobl.[LogDt], 101),'/0','/'),1,1,'') AS LogDt
	,NULL AS LogTime
	,Stuff(RefDateAvnet.FyYyyyQtr,5,1,'-') AS FyQtr
	,NULL AS TransDt
	,RefDateAvnet.BusDay99
	,NULL AS WkNbr
	,SoBl.FyMthNbr
	,RefDateAvnet.FyTagMth
	,SoBl.MaterialNbr
	,SoBl.Pbg
	,SoBl.Mfg
	,SoBl.PrcStgy
	,SoBl.Tech
	,SoBl.Cc
	,SoBl.Grp
	,SoBl.MfgPartNbr
	,SoBl.BlockedOrders
	,SoBl.PricingBlock
	,CAST(Sobl.[SalesOffice] AS varchar(15)) AS SalesOffice
	,NULL AS SalesOfficeKey
	,CAST(Sobl.[SalesGrp] AS varchar(15)) AS SalesGrp
	,NULL AS SalesGrpKey
	,NULL AS CustName
	,NULL AS CustNbr
	,SoBl.SalesDocType
	,NULL AS RefBillingNbr
	,CASE WHEN SoBl.LastConfPromDt BETWEEN GETDATE() AND GETDATE()+30 OR Sobl.CustReqDockDt BETWEEN GETDATE() AND GETDATE()+30 THEN SoBl.TtlOrderValue ELSE 0 END AS [value]
	,Sobl.[SalesDocNbr] AS SalesDocNbr
	,Sobl.[SalesDocItemNbr] AS SalesDocItemNbr
	,CASE WHEN Pasobl.EmpFirstName IS NULL OR Pasobl.EmpFirstName IS NULL THEN '' ELSE CONCAT(Pasobl.EmpLastName, ', ', Pasobl.EmpFirstName) END AS ProductSpecialist
	,SoBl.AtpDt
	,SoBl.DlvryDt
	,Stuff(Replace('/'+Convert(varchar(10), Sobl.[AtpDt], 101),'/0','/'),1,1,'') AS AtpDt2
	,SoBl.ExtResale
	,SoBl.ExtCost
	,NULL AS SGPM
	,SoBl.LastConfPromDt
	,Sobl.CustReqDockDt		
FROM 
	(SELECT *
	FROM #UniqueSobl) AS Sobl
	INNER JOIN 
		(SELECT *
		FROM CentralDbs.dbo.RefDateAvnet AS RefDateAvnet
		WHERE BusDay99 = 1) AS RefDateAvnet
		ON CAST(SoBl.sqlstarttime AS DATE)=RefDateAvnet.DateDt
	LEFT JOIN CentralDbs.dbo.ProdAorSobl AS PaSobl 
		ON SoBl.SalesDocNbr=PaSobl.SalesDocNbr AND  SoBl.SalesDocItemNbr=PaSobl.SalesDocItemNbr
	INNER JOIN SAP.dbo.Ztqtcaorhdr AS ZAH ON ZAH.AORID=PaSobl.AorId
	LEFT JOIN MDM.dbo.CostResale AS CR ON SoBl.MaterialNbr=cr.material_nbr
	WHERE ([SalesDocType]= 'ZOR' OR [SalesDocType]='ZKE1') AND [RemainingQty]<>0 AND ZAH.startdate<=CAST(GETDATE() AS DATE) AND ZAH.EndDate>CAST(GETDATE() AS DATE)

UNION ALL


SELECT 
	'Delq SO' AS metric
	,Stuff(Replace('/'+Convert(varchar(10), Sobl.[LogDt], 101),'/0','/'),1,1,'') AS LogDt
	,NULL AS LogTime
	,Stuff(RefDateAvnet.FyYyyyQtr,5,1,'-') AS FyQtr
	,NULL AS TransDt
	,RefDateAvnet.BusDay99
	,NULL AS WkNbr
	,SoBl.FyMthNbr
	,RefDateAvnet.FyTagMth
	,SoBl.MaterialNbr
	,SoBl.Pbg
	,SoBl.Mfg
	,SoBl.PrcStgy
	,SoBl.Tech
	,SoBl.Cc
	,SoBl.Grp
	,SoBl.MfgPartNbr
	,SoBl.BlockedOrders
	,SoBl.PricingBlock
	,CAST(Sobl.[SalesOffice] AS varchar(15)) AS SalesOffice
	,NULL AS SalesOfficeKey
	,CAST(Sobl.[SalesGrp] AS varchar(15)) AS SalesGrp
	,NULL AS SalesGrpKey
	,NULL AS CustName
	,NULL AS CustNbr
	,SoBl.SalesDocType
	,NULL AS RefBillingNbr
	,CASE WHEN SoBl.LastConfPromDt > Cast(DlvryDt as Date) THEN SoBl.TtlOrderValue ELSE 0 END AS [value]
	,Sobl.[SalesDocNbr] AS SalesDocNbr
	,Sobl.[SalesDocItemNbr] AS SalesDocItemNbr
	,CASE WHEN Pasobl.EmpFirstName IS NULL OR Pasobl.EmpFirstName IS NULL THEN '' ELSE CONCAT(Pasobl.EmpLastName, ', ', Pasobl.EmpFirstName) END AS ProductSpecialist
	,SoBl.AtpDt
	,SoBl.DlvryDt
	,Stuff(Replace('/'+Convert(varchar(10), Sobl.[AtpDt], 101),'/0','/'),1,1,'') AS AtpDt2
	,SoBl.ExtResale
	,SoBl.ExtCost
	,CASE WHEN SoBl.ExtResale IS NULL OR SoBl.ExtResale = 0 THEN 0 ELSE (SoBl.ExtResale - SoBl.ExtCost) END AS SGPM
	,SoBl.LastConfPromDt
	,Sobl.CustReqDockDt	
FROM 
	(SELECT *
	FROM #UniqueSobl) AS Sobl
	INNER JOIN 
		(SELECT *
		FROM CentralDbs.dbo.RefDateAvnet AS RefDateAvnet
		WHERE BusDay99 = 1) AS RefDateAvnet
		ON CAST(SoBl.sqlstarttime AS DATE)=RefDateAvnet.DateDt
	LEFT JOIN CentralDbs.dbo.ProdAorSobl AS PaSobl 
		ON SoBl.SalesDocNbr=PaSobl.SalesDocNbr AND  SoBl.SalesDocItemNbr=PaSobl.SalesDocItemNbr
	INNER JOIN SAP.dbo.Ztqtcaorhdr AS ZAH ON ZAH.AORID=PaSobl.AorId
	LEFT JOIN MDM.dbo.CostResale AS CR ON SoBl.MaterialNbr=cr.material_nbr
	WHERE ([SalesDocType]= 'ZOR' OR [SalesDocType]='ZKE1') AND [RemainingQty]<>0 AND ZAH.startdate<=CAST(GETDATE() AS DATE) AND ZAH.EndDate>CAST(GETDATE() AS DATE)

			

UNION ALL


SELECT
	'Sales Orders' AS metric
	,Stuff(Replace('/'+Convert(varchar(10), Sobl.[LogDt], 101),'/0','/'),1,1,'') AS LogDt
	,NULL AS LogTime
	,Stuff(RefDateAvnet.FyYyyyQtr,5,1,'-') AS FyQtr
	,NULL AS TransDt
	,RefDateAvnet.BusDay99
	,NULL AS WkNbr
	,SoBl.FyMthNbr
	,RefDateAvnet.FyTagMth
	,SoBl.MaterialNbr
	,SoBl.Pbg
	,SoBl.Mfg
	,SoBl.PrcStgy
	,SoBl.Tech
	,SoBl.Cc
	,SoBl.Grp
	,SoBl.MfgPartNbr
	,SoBl.BlockedOrders
	,SoBl.PricingBlock
	,CAST(Sobl.[SalesOffice] AS varchar(15)) AS SalesOffice
	,NULL AS SalesOfficeKey
	,CAST(Sobl.[SalesGrp] AS varchar(15)) AS SalesGrp
	,NULL AS SalesGrpKey
	,NULL AS CustName
	,NULL AS CustNbr
	,SoBl.SalesDocType
	,NULL AS RefBillingNbr
	,SoBl.TtlOrderValue AS [value]
	,Sobl.[SalesDocNbr]AS SalesDocNbr
	,Sobl.[SalesDocItemNbr] AS SalesDocItemNbr
	,CASE WHEN Pasobl.EmpFirstName IS NULL OR Pasobl.EmpFirstName IS NULL THEN '' ELSE CONCAT(Pasobl.EmpLastName, ', ', Pasobl.EmpFirstName) END AS ProductSpecialist
	,SoBl.AtpDt
	,SoBl.DlvryDt
	,Stuff(Replace('/'+Convert(varchar(10), Sobl.[AtpDt], 101),'/0','/'),1,1,'') AS AtpDt2
	,SoBl.ExtResale
	,SoBl.ExtCost
	,CASE WHEN SoBl.ExtResale IS NULL OR SoBl.ExtResale = 0 THEN 0 ELSE (SoBl.ExtResale - SoBl.ExtCost) END AS SGPM
        ,SoBl.LastConfPromDt
	,Sobl.CustReqDockDt
FROM 
	(SELECT *
	FROM #UniqueSobl) AS Sobl
	INNER JOIN 
		(SELECT *
		FROM CentralDbs.dbo.RefDateAvnet AS RefDateAvnet
		WHERE BusDay99 = 1) RefDateAvnet
		ON CAST(SoBl.SqlStartTime AS DATE)=RefDateAvnet.DateDt
	LEFT JOIN CentralDbs.dbo.ProdAorSobl AS PaSobl 
		ON SoBl.SalesDocNbr=PaSobl.SalesDocNbr AND  SoBl.SalesDocItemNbr=PaSobl.SalesDocItemNbr
	INNER JOIN SAP.dbo.Ztqtcaorhdr AS ZAH ON ZAH.AORID=PaSobl.AorId
	LEFT JOIN MDM.dbo.CostResale AS CR ON SoBl.MaterialNbr=cr.material_nbr
	WHERE ([SalesDocType]= 'ZOR' OR [SalesDocType]='ZKE1') AND [RemainingQty]<>0 AND ZAH.startdate<=CAST(GETDATE() AS DATE) AND ZAH.EndDate>CAST(GETDATE() AS DATE)


UNION ALL

--==================================================Bookbill===================================================

SELECT
	'Billings$' AS metric
	,Stuff(Replace('/'+Convert(varchar(10), Bb.TransDt,101),'/0','/'),1,1,'') AS LogDt
	,[LogTime]
	,Stuff(RefDateAvnet.FyYyyyQtr,5,1,'-') AS FyQtr
	,[TransDt]
	,Bb.BusDay99
	,Bb.WkNbr
	,[FyMnthNbr] AS FyMthNbr
	,[FyTagMnth] AS FyTagMth
	,Bb.Material
	,[Pbg]
	,[Mfg]
	,[PrcStgy]
	,[Tech]
	,[Cc]
	,[Grp]
	,Bb.MfgPartNbr
	,NULL AS BlockedOrders
	,NULL AS PricingBlock
	,[SalesOffice]
	,[SalesOfficeKey]
	,[SalesGrp]
	,[SalesGrpKey]
	,[CustName]
	,[CustNbr]
	,[SalesDocTyp]
	,[RefBillingNbr]
	,[Billings] AS [value]
	,Bb.[SalesDocNbr]
	,CAST(Bb.[SalesDocLnItm] AS INT) AS [SalesDocLnItm]
	,CASE WHEN ProdAorBb.EmpFirstName IS NULL OR ProdAorBb.EmpFirstName IS NULL THEN '' ELSE CONCAT(ProdAorBb.EmpLastName, ', ', ProdAorBb.EmpFirstName) END AS ProductSpecialist
	,NULL AS AtpDt
	,NULL AS DlvryDt
	,NULL AS AtpDt2
	,NULL AS ExtResale
	,NULL AS ExtCost
	,NULL AS SGPM
	,NULL AS LastConfPromDt
	,NULL AS CustReqDockDt
FROM CentralDbs.dbo.BookBill AS Bb 
	LEFT JOIN Centraldbs.dbo.ProdAorBookBill AS ProdAorBb 
			ON Bb.SalesDocNbr=ProdAorBb.SalesDocNbr AND  Bb.SalesDocLnItm=ProdAorBb.SalesDocLnItm AND Bb.[Type]=ProdAorBb.[Type]
			--INNER JOIN SAP.dbo.Ztqtcaorhdr AS ZAH ON 
			--	ZAH.AORID=ProdAorBb.AorId
		LEFT JOIN CentralDbs.dbo.CostResale AS CR 
			ON Bb.Material=cr.MaterialNbr
	INNER JOIN CentralDbs.dbo.RefDateAvnet AS RefDateAvnet
		ON Bb.LogDt= RefDateAvnet.DateDt
WHERE Bb.[Type]='BILLINGS' 
--AND EmpLastName LIKE '%Bartlett%'


UNION ALL

SELECT 
	'BillingsGp$' AS metric
	,Stuff(Replace('/'+Convert(varchar(10), Bb.TransDt,101),'/0','/'),1,1,'') AS LogDt
	,[LogTime]
	,Stuff(RefDateAvnet.FyYyyyQtr,5,1,'-') AS FyQtr
	,[TransDt]
	,Bb.BusDay99
	,Bb.WkNbr
	,[FyMnthNbr] AS FyMthNbr
	,[FyTagMnth] AS FyTagMth
	,Bb.Material
	,[Pbg]
	,[Mfg]
	,[PrcStgy]
	,[Tech]
	,[Cc]
	,[Grp]
	,Bb.MfgPartNbr
	,NULL AS BlockedOrders
	,NULL AS PricingBlock
	,[SalesOffice]
	,[SalesOfficeKey]
	,[SalesGrp]
	,[SalesGrpKey]
	,[CustName]
	,[CustNbr]
	,[SalesDocTyp]
	,[RefBillingNbr]
	,[BillingsGP] AS [value]
	,ProdAorBb.[SalesDocNbr]
	,CAST(ProdAorBb.[SalesDocLnItm] AS INT) AS [SalesDocLnItm]
	,CASE WHEN ProdAorBb.EmpFirstName IS NULL OR ProdAorBb.EmpFirstName IS NULL THEN '' ELSE CONCAT(ProdAorBb.EmpLastName, ', ', ProdAorBb.EmpFirstName) END AS ProductSpecialist
	,NULL AS AtpDt
	,NULL AS DlvryDt
	,NULL AS AtpDt2
	,NULL AS ExtResale
	,NULL AS ExtCost
	,NULL AS SGPM
	,NULL AS LastConfPromDt
	,NULL AS CustReqDockDt
FROM CentralDbs.dbo.BookBill AS Bb 
	LEFT JOIN Centraldbs.dbo.ProdAorBookBill AS ProdAorBb 
			ON Bb.SalesDocNbr=ProdAorBb.SalesDocNbr AND  Bb.SalesDocLnItm=ProdAorBb.SalesDocLnItm AND Bb.[Type]=ProdAorBb.[Type]
			--INNER JOIN SAP.dbo.Ztqtcaorhdr AS ZAH ON 
			--	ZAH.AORID=ProdAorBb.AorId
		LEFT JOIN CentralDbs.dbo.CostResale AS CR 
			ON Bb.Material=cr.MaterialNbr
	INNER JOIN CentralDbs.dbo.RefDateAvnet AS RefDateAvnet
		ON Bb.LogDt= RefDateAvnet.DateDt
WHERE Bb.Type='BILLINGS'



UNION ALL

SELECT DISTINCT
	'Bookings$' AS metric
		,Stuff(Replace('/'+Convert(varchar(10), Bb.TransDt,101),'/0','/'),1,1,'') AS LogDt
	,[LogTime]
	,Stuff(RefDateAvnet.FyYyyyQtr,5,1,'-') AS FyQtr
	,[TransDt]
	,Bb.BusDay99
	,Bb.WkNbr
	,[FyMnthNbr] AS FyMthNbr
	,[FyTagMnth] AS FyTagMth
	,Bb.Material
	,[Pbg]
	,[Mfg]
	,[PrcStgy]
	,[Tech]
	,[Cc]
	,[Grp]
	,Bb.MfgPartNbr
	,NULL AS BlockedOrders
	,NULL AS PricingBlock
	,[SalesOffice]
	,[SalesOfficeKey]
	,[SalesGrp]
	,[SalesGrpKey]
	,[CustName]
	,[CustNbr]
	,[SalesDocTyp]
	,[RefBillingNbr]
	,Bookings AS [value]
	,ProdAorBb.[SalesDocNbr]
	,CAST(ProdAorBb.[SalesDocLnItm] AS INT) AS SalesDocLnItm
	,CASE WHEN ProdAorBb.EmpFirstName IS NULL OR ProdAorBb.EmpFirstName IS NULL THEN '' ELSE CONCAT(ProdAorBb.EmpLastName, ', ', ProdAorBb.EmpFirstName) END AS ProductSpecialist
	,NULL AS AtpDt
	,NULL AS DlvryDt
	,NULL AS AtpDt2
	,NULL AS ExtResale
	,NULL AS ExtCost
	,NULL AS SGPM
	,NULL AS LastConfPromDt
	,NULL AS CustReqDockDt
FROM CentralDbs.dbo.BookBill AS Bb
	LEFT JOIN Centraldbs.dbo.ProdAorBookBill AS ProdAorBb 
			ON Bb.SalesDocNbr=ProdAorBb.SalesDocNbr AND  Bb.SalesDocLnItm=ProdAorBb.SalesDocLnItm AND Bb.[Type]=ProdAorBb.[Type]
			--INNER JOIN SAP.dbo.Ztqtcaorhdr AS ZAH ON 
			--	ZAH.AORID=ProdAorBb.AorId
		LEFT JOIN CentralDbs.dbo.CostResale AS CR 
			ON Bb.Material=cr.MaterialNbr
	INNER JOIN CentralDbs.dbo.RefDateAvnet AS RefDateAvnet
		ON Bb.LogDt= RefDateAvnet.DateDt
WHERE Bb.Type='BOOKINGS'

