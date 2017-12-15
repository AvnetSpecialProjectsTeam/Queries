--[0900-01] Create Drop Ship Temp Table


DROP TABLE IF EXISTS #DropShips

SELECT        CONCAT(MaterialDocNbr,MatDocItmZEILE) as MatDocKey, MaterialDocNbr As MatDocNbr, MatDocItmZEILE As MatDocItm, Plant, MovementTyp As MovTyp, SalesOrderNbr As SoNbr, PoNbr
INTO		  #DropShips 
FROM          sap.dbo.Mseg
WHERE         (MovementTyp = 101) AND (PoNbr LIKE '32%') OR (MovementTyp = 102) AND (PoNbr LIKE '32%')



--[1000_01] Select Needed Fields from SAP Table-MSEG, Create 1000_01 Temp Table with results of Query
DROP TABLE IF EXISTS #1000_01
SELECT CASE When [BatchNbr] is null Then [Valtyp] ELSE [BatchNbr] END As Batch, CASE When [BatchNbr] is null Then 'Valtyp' ELSE 'Batch' END As BatchTyp, Material, Plant, StorLoc, CONCAT(MaterialDocNbr,MatDocItmZEILE) as MatDocKey, MaterialDocNbr As MatDocNbr, MatDocItmZEILE As MatDocItm, MovementTyp As MovTyp, SpecialStk, SoldToPartyId, SalesOrderNbr As SoNbr, SalesOrderItm As SoItmNbr, Returns, OrderCurrency As Crncy, CASE When [Returns] ='S' Then [SchedQty] ELSE [SchedQty]*-1 END As Qty, PoNbr, PoItmNbr, ProfitCenter, convert(varchar(10), DocPostingDt2, 101) AS PostDt,MvmtId, Consumption
INTO #1000_01
FROM sap.dbo.Mseg

--[1000_02] Exclude Drop Ships found in Temp Table #DropShips, Create 1000_02 Temp Table with results of Query
DROP TABLE IF EXISTS #1000_02
SELECT Batch, BatchTyp, Material, #1000_01.Plant, StorLoc, #1000_01.MatDocKey, #1000_01.MatDocNbr, #1000_01.MatDocItm, #1000_01.MovTyp, SpecialStk, SoldToPartyId, #1000_01.SoNbr, SoItmNbr, Crncy, Qty, #1000_01.PoNbr, PoItmNbr, ProfitCenter, #1000_01.PostDt, MvmtId, Consumption
INTO #1000_02
FROM #1000_01 LEFT OUTER JOIN #DropShips on #1000_01.MatDocKey = #DropShips.MatDocKey
Where #DropShips.MatDocKey IS NULL

--[2000] Batch Date

--[2000-01] Get Min Batch Date from SAP Table-MCHB, Create #MchbMinBatch Temp Table with results of Query
DROP TABLE IF EXISTS #MchbMinBatch
SELECT BatchNbr As Batch, min(Convert(varchar(10), CreatedOn, 101)) AS  BatchDt
INTO #MchbMinBatch
FROM sap.dbo.Mchb
GROUP BY BatchNbr

--[2000-02] Get Min Batch Date from #1000_02 (MSEG), Create #MsegMinBatchDt Temp Table with results of Query
DROP TABLE IF EXISTS #MsegMinBatchDt
SELECT Batch, min(PostDt) AS PostDt
INTO #MsegMinBatchDt
FROM #1000_02
GROUP BY Batch


--[2000-03] Get batches in MSEG not found in MCHB, Create #MissingBatches Temp Table with results of Query
DROP TABLE IF EXISTS #MissingBatches
SELECT #MsegMinBatchDt.Batch, PostDt
INTO #MissingBatches
FROM #MsegMinBatchDt LEFT OUTER JOIN #MchbMinBatch on #MsegMinBatchDt.Batch = #MchbMinBatch.Batch
Where #MchbMinBatch.Batch IS NULL

--[2000-04] Add Missing MSEG Batches to MCHB Batches (namely,QIT Valuation Types in MSEG not found in MCHB), Create #Batches Temp Table with results of Query
DROP TABLE IF EXISTS #Batches
SELECT *
INTO #Batches
FROM #MchbMinBatch

INSERT INTO #Batches
SELECT *
FROM #MissingBatches

--[2000-05] Add Min Batch Date to MSEG (1000_02) Data, Create #MsegMinBatch Temp Table with results of Query
DROP TABLE IF EXISTS #MsegMinBatch
SELECT #1000_02.Batch, BatchTyp, Material, Plant, StorLoc, MatDocNbr, MatDocItm, MovTyp, SpecialStk, SoldToPartyId, SoNbr, SoItmNbr, Crncy, Qty, PoNbr, PoItmNbr, ProfitCenter, PostDt, #Batches.BatchDt, MvmtId, Consumption
INTO #MsegMinBatch
FROM #1000_02 LEFT OUTER JOIN #Batches on #1000_02.Batch = #Batches.Batch

--[2000-06] Add Min Batch Date to MSEG (1000_02) Data, Create #MsegMinBatch Temp Table with results of Query
DROP TABLE IF EXISTS #MsegMinBatchSmry
SELECT Batch, BatchTyp, Material, Plant, StorLoc, SpecialStk, sum(Qty) AS Qty, Crncy, BatchDt, min(PostDt) AS PostDt, ProfitCenter, MvmtId, Consumption
INTO #MsegMinBatchSmry
FROM #MsegMinBatch
GROUP BY Batch, BatchTyp, Material, Plant, StorLoc, SpecialStk, Crncy, BatchDt, ProfitCenter, MvmtId, Consumption

--[3000-01] 
DROP TABLE IF EXISTS #MsegMinBatchSmryWithMap
SELECT #MsegMinBatchSmry.Material, Plant, StorLoc, Batch, BatchTyp, SpecialStk, Qty, Crncy, BatchDt, PostDt, ProfitCenter, MvmtId, Consumption, (CentralDbs.dbo.MapBatch.Map/CentralDbs.dbo.MapBatch.PriceUnitItm) AS Map, ((CentralDbs.dbo.MapBatch.Map/CentralDbs.dbo.MapBatch.PriceUnitItm)*Qty) AS ExtCost
INTO #MsegMinBatchSmryWithMap
FROM #MsegMinBatchSmry LEFT OUTER JOIN CentralDbs.dbo.MapBatch on #MsegMinBatchSmry.Batch = CentralDbs.dbo.MapBatch.ValTyp And #MsegMinBatchSmry.Plant = CentralDbs.dbo.MapBatch.ValArea And #MsegMinBatchSmry.Material = CentralDbs.dbo.MapBatch.Material
ORDER By Material, Plant, StorLoc, Batch

--[3000-02] 
DROP TABLE IF EXISTS #MsegMinBatchSmryWithMapNoSpclStk1
SELECT Material, Plant, StorLoc, Batch, BatchTyp, Crncy, BatchDt, ProfitCenter, sum(Qty) As Qty1
INTO #MsegMinBatchSmryWithMapNoSpclStk1
FROM #MsegMinBatchSmry
GROUP By Material, Plant, StorLoc, Batch, BatchTyp, Crncy, BatchDt, ProfitCenter
ORDER By Material, Plant, StorLoc, Batch

--[3000-03] 
DROP TABLE IF EXISTS #MsegMinBatchSmryWithMapNoSpclStk2
SELECT #MsegMinBatchSmryWithMapNoSpclStk1.Material, Plant, StorLoc, Batch, BatchTyp, Qty1 As Qty, Crncy, BatchDt, ProfitCenter, (CentralDbs.dbo.MapBatch.Map/CentralDbs.dbo.MapBatch.PriceUnitItm) AS Map, ((CentralDbs.dbo.MapBatch.Map/CentralDbs.dbo.MapBatch.PriceUnitItm)*Qty1) AS ExtCost
INTO #MsegMinBatchSmryWithMapNoSpclStk2
FROM #MsegMinBatchSmryWithMapNoSpclStk1 LEFT OUTER JOIN CentralDbs.dbo.MapBatch on #MsegMinBatchSmryWithMapNoSpclStk1.Batch = CentralDbs.dbo.MapBatch.ValTyp And #MsegMinBatchSmryWithMapNoSpclStk1.Plant = CentralDbs.dbo.MapBatch.ValArea And #MsegMinBatchSmryWithMapNoSpclStk1.Material = CentralDbs.dbo.MapBatch.Material
ORDER By Material, Plant, StorLoc, Batch

--[3000-04]
DROP TABLE IF EXISTS #MchbSmry
SELECT [BatchNbr] As Batch
	  ,[Plant]
      ,[Material]
      ,Sum([ValUnrestrictUseStk]+[StkInTrans]+[StkQualityInspect]+[TtlStkRestrictBatches]+[BlockStk]+[BlockStkReturns]) As BatchQty
INTO #MchbSmry
FROM sap.dbo.Mchb
GROUP By BatchNbr, Plant, Material

--[3000-05]
DROP TABLE IF EXISTS InventoryBatchAll
SELECT convert(varchar(10), CAST(GETDATE() As date), 101) As RptDt, #MsegMinBatchSmryWithMapNoSpclStk2.Material, #MsegMinBatchSmryWithMapNoSpclStk2.Plant, StorLoc, #MsegMinBatchSmryWithMapNoSpclStk2.Batch, BatchTyp, Qty, Crncy, BatchDt, Map, ExtCost, ProfitCenter
INTO InventoryBatchAll
FROM #MsegMinBatchSmryWithMapNoSpclStk2 INNER JOIN #MchbSmry On #MsegMinBatchSmryWithMapNoSpclStk2.Material = #MchbSmry.Material And #MsegMinBatchSmryWithMapNoSpclStk2.Plant = #MchbSmry.Plant And #MsegMinBatchSmryWithMapNoSpclStk2.Batch = #MchbSmry.Batch
Order By #MsegMinBatchSmryWithMapNoSpclStk2.Material, #MsegMinBatchSmryWithMapNoSpclStk2.Plant, StorLoc, #MsegMinBatchSmryWithMapNoSpclStk2.Batch

--[3000-06]
DROP TABLE IF EXISTS InventoryBatch
SELECT convert(varchar(10), CAST(GETDATE() As date), 101) As RptDt, #MsegMinBatchSmryWithMapNoSpclStk2.Material, #MsegMinBatchSmryWithMapNoSpclStk2.Plant, StorLoc, #MsegMinBatchSmryWithMapNoSpclStk2.Batch, BatchTyp, Qty, Crncy, BatchDt, Map, ExtCost, ProfitCenter
INTO InventoryBatch
FROM #MsegMinBatchSmryWithMapNoSpclStk2 INNER JOIN #MchbSmry On #MsegMinBatchSmryWithMapNoSpclStk2.Material = #MchbSmry.Material And #MsegMinBatchSmryWithMapNoSpclStk2.Plant = #MchbSmry.Plant And #MsegMinBatchSmryWithMapNoSpclStk2.Batch = #MchbSmry.Batch
WHERE Qty <>0	
Order By #MsegMinBatchSmryWithMapNoSpclStk2.Material, #MsegMinBatchSmryWithMapNoSpclStk2.Plant, StorLoc, #MsegMinBatchSmryWithMapNoSpclStk2.Batch