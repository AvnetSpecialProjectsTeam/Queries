INSERT INTO CentralDbs.dbo.PoBacklog
([PoNbr]
      ,[PoLine]
      ,[PoSchedLine]
      ,[PoConfLine]
	  ,[Plant]
      ,[MaterialNbr]
      ,[MfgPartNnbr]
      ,[StorLoc]
      ,[PurchOrg]
      ,[Mfg]
      ,[PrcStgy]
      ,[Tech]
      ,[CC]
      ,[Grp]
      ,[RefDocNbr]
      ,[PoSchedConfCd]
      ,[OrderDt]
      ,[SchedLineDeliveryDt]
      ,[ConfDlvryDt]
      ,[SchedQty]
      ,[SchedLineValue]
      ,SchedOpenQty
      ,SchedOpenValue
      ,[CostAm]
      ,[PriceUnitQt]
      ,[DocType]
      ,[PoTypeDesc]
      ,[GenericPoType]
      ,[Age]
      ,[AgeBucket]
	  )
SELECT DISTINCT
	 Hdr.PoNbr
	,Itm.PoLine
	,Sched.PoSchedLine
	,ISNULL(Conf.PoCnfLine,0)
	,Itm.SapPlantCd AS Plant
	,Itm.SapMaterialId AS MaterialNbr
	,Itm.ManufacturerPartNo
	,Itm.SapPlantStorageLocCd AS StorLoc
	,Hdr.SapPurchasingOrgCd AS PurchOrg
	,Spl.Mfg
	,Spl.PrcStgy
	,Spl.Tech
	,SPl.CC
	,Spl.Grp
	,Hdr.LegacyPoNo AS RefDocNbr
	,Conf.SapConfirmationCategoryCd AS PoSchedConfCd
	,CAST(Hdr.PurchaseOrderDt AS DATE) AS OrderDt
	,CAST(Sched.DeliveryDt AS DATE) AS SchedLineDeliveryDt
	,CAST(Conf.DeliveryDt AS DATE) AS ConfDlvryDt
	,Sched.ScheduleQt
	,CAST(((Itm.CostAm/NULLIF(Itm.PriceUnitQt,0)) * Sched.ScheduleQt) AS MONEY) AS SchedLineValue
	,Sched.OpenQt AS SchedOpenQty
	,CAST(((Itm.CostAm/NULLIF(Itm.PriceUnitQt,0)) * Sched.OpenQt) AS MONEY) AS SchedOpenValue
	,Itm.CostAm
	,Itm.PriceUnitQt
	,Hdr.SapPurchasingDocTypeCd AS DocType
	,Hdr.SapPurchaseOrderDescr AS PoTypeDesc
	,Pt.GenericPoType
	,DATEDIFF(Day, Hdr.PurchaseOrderDt,GETDATE()) AS Age
	,CASE
		WHEN DATEDIFF(Day, Hdr.PurchaseOrderDt,GETDATE())<6 THEN '0-5 Days'
		WHEN DATEDIFF(Day, Hdr.PurchaseOrderDt,GETDATE())<11 THEN '6-10 Days'
		WHEN DATEDIFF(Day, Hdr.PurchaseOrderDt,GETDATE())<21 THEN '11-20 Days'
		WHEN DATEDIFF(Day, Hdr.PurchaseOrderDt,GETDATE())<100 THEN '21-99 Days'
		ELSE '100+ Days'
	END AS AgeBucket

FROM SAP.dbo.PurchOrd AS Hdr
	INNER JOIN SAP.dbo.PurchOrdItem AS Itm
		ON Hdr.PoNbr=ITM.PoNbr
		INNER JOIN SAP.dbo.PurchOrdItemSched AS Sched
			ON Itm.PoNbr=Sched.PoNbr AND Itm.PoLine=Sched.PoLine
		LEFT JOIN
			(SELECT *
			FROM SAP.dbo.PurchOrdItemConf AS Conf
			WHERE Conf.NetConfirmedQt>0) AS Conf
			ON Itm.PoNbr=Conf.PoNbr AND Itm.PoLine=Conf.PoLine
		LEFT JOIN CentralDbs.dbo.SapPartsList AS Spl
			ON Itm.SapMaterialId=Spl.MaterialNbr
	INNER JOIN Bi.dbo.PoType AS Pt
		ON Hdr.SapPurchasingDocTypeCd=Pt.DocType
WHERE ITM.SapMaterialId IS NOT NULL
--WHERE  Hdr.PoNbr=3200000277

--SELECT *
--FROM SAP.dbo.PurchOrdItemConf AS Conf
--WHERE POnbr=3100000006

