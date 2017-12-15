--EOM SALES ORDERS 



--FIND EOM DATE
SELECT CentralDbs.dbo.RefDateAvnet.BusDay99, CentralDbs.dbo.RefDateAvnet.FyMthNbr-1 AS FyMthNbr,  BI.dbo.SOBacklog.VersionDt, BI.dbo.SOBacklog.LogDt, BI.dbo.SOBacklog.LogTime, BI.dbo.SOBacklog.[OutsideSalesRep], BI.dbo.SOBacklog.[InsideSalesRep], BI.dbo.SOBacklog.[SoldToPartyId], BI.dbo.SOBacklog.SoldToParty, BI.dbo.SOBacklog.[SalesDocItCreateDt], BI.dbo.SOBacklog.[SalesDocNbr], BI.dbo.SOBacklog.[SalesDocItemNbr], BI.dbo.SOBacklog.[SoSchedLine], BI.dbo.SOBacklog.[CustomerPoNbr], BI.dbo.SOBacklog.[CustomerPartNbr], BI.dbo.SOBacklog.[MaterialTxt], BI.dbo.SOBacklog.grp, BI.dbo.SOBacklog.PBG, BI.dbo.SOBacklog.CC, BI.dbo.SOBacklog.mfg, BI.dbo.SOBacklog.PrcStgy, BI.dbo.SOBacklog.tech, BI.dbo.SOBacklog.[MaterialNbr], BI.dbo.SOBacklog.[MfgPartNbr], BI.dbo.SOBacklog.plantId, BI.dbo.SOBacklog.[BillingBlock], BI.dbo.SOBacklog.[PricingBlock], BI.dbo.SOBacklog.[ShipAndDebitBlock], BI.dbo.SOBacklog.[CreditBlock], BI.dbo.SOBacklog.[DlvryBlock], BI.dbo.SOBacklog.[ProgrammingBlock], BI.dbo.SOBacklog.[CustReqDockDt], BI.dbo.SOBacklog.[LastConfPromDt], BI.dbo.SOBacklog.[DlvryDt], BI.dbo.SOBacklog.[OrginPromDt], BI.dbo.SOBacklog.[AtpDt], BI.dbo.SOBacklog.[OrderQty], BI.dbo.SOBacklog.[RemainingQty], BI.dbo.SOBacklog.[UnitPrice], BI.dbo.SOBacklog.[TtlOrderValue], BI.dbo.SOBacklog.[MrpCntrl], BI.dbo.SOBacklog.abc, BI.dbo.SOBacklog.[StockProfile], BI.dbo.SOBacklog.[OrderReason], BI.dbo.SOBacklog.[BufferType], BI.dbo.SOBacklog.[PlantSpecificMatl], BI.dbo.SOBacklog.[SalesDocType], BI.dbo.SOBacklog.[ResaleSource], BI.dbo.SOBacklog.[PurGrp], BI.dbo.SOBacklog.[BlockedOrders], BI.dbo.SOBacklog.[SalesOrg], BI.dbo.SOBacklog.[SalesOffice], BI.dbo.SOBacklog.[SalesGrp], BI.dbo.SOBacklog.[MatBaseUnit], BI.dbo.SOBacklog.[CondType], BI.dbo.SOBacklog.[OverallDlvryStatus], BI.dbo.SOBacklog.[ExtCost], BI.dbo.SOBacklog.[MatGpPercent], BI.dbo.SOBacklog.[DlvryStatus]
FROM BI.dbo.SOBacklog INNER JOIN CentralDbs.dbo.RefDateAvnet ON BI.dbo.SOBacklog.VersionDt = CentralDbs.dbo.RefDateAvnet.DateDt
WHERE CentralDbs.dbo.RefDateAvnet.BusDay99='1';



SELECT BI.dbo.[SoBacklogHistory].VersionDt, CentralDbs.dbo.RefDateAvnet.BusDay99 fROM BI.dbo.[SoBacklogHistory] INNER JOIN CentralDbs.dbo.RefDateAvnet ON BI.dbo.[SoBacklogHistory].VersionDt = CentralDbs.dbo.RefDateAvnet.DateDt group by  BI.dbo.[SoBacklogHistory].VersionDt, CentralDbs.dbo.RefDateAvnet.BusDay99


SELECT BI.dbo.SOBacklog.VersionDt, CentralDbs.dbo.RefDateAvnet.BusDay99 fROM BI.dbo.SOBacklog INNER JOIN CentralDbs.dbo.RefDateAvnet ON BI.dbo.SOBacklog.VersionDt = CentralDbs.dbo.RefDateAvnet.DateDt group by  BI.dbo.SOBacklog.VersionDt, CentralDbs.dbo.RefDateAvnet.BusDay99

--APPEND TO EOM SALES ORDERS 
MERGE BI.dbo.SalesOrderBacklogEom AS TargetTbl
USING BI.dbo.SoBacklog AS SourceTbl
ON (TargetTbl.SalesDocNbr=SourceTbl.SalesDocNbr AND TargetTbl.SalesDocItemNbr=SourceTbl.SalesDocItemNbr AND TargetTbl.SoSchedLine=SourceTbl.SoSchedLine)
When  (BI.dbo.SoBacklog.bus_day_99)=1;
