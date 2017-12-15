Select * Into #MinZdcPrice From(
Select Distinct MaterialNbr, SAPCurrencyCode, Col1Qty, Col1$, Rank() Over(Partition by MaterialNbr Order By MaterialNbr, Col1$) as MinPrice From Mdm.dbo.MultiColumnCost Where SapConditionTypeCd = 'ZDC') as iq1
Select * Into #MinZmppPrice From(
Select Distinct MaterialNbr, SAPCurrencyCode, Col1Qty, Col1$, Rank() Over(Partition by MaterialNbr Order By MaterialNbr, Col1$) as MinPrice From Mdm.dbo.MultiColumnCost Where SapConditionTypeCd = 'ZMPP')as iq1
Select * Into #SapPartsListTemp From(
Select Distinct MaterialNbr, Mfg, MfgPartNbr From CentralDbs.dbo.SapPartsList Where MatHubState<>-1 and SendToSapFl = 'Y' and MaterialNbr is not null) as iq1
Select Material, MapPerUnit Into #MapTemp From(
Select Material, Cast(Map/PriceUnitItm as decimal(15,6)) as MapPerUnit, Rank() Over(Partition by Material Order by Material, ValArea Asc) as MinPlant From CentralDbs.dbo.MapPlant) as iq1 Where MinPlant = 1

--Drop Table CentralDbs.dbo.CostStrategy
--Select * Into CentralDbs.dbo.CostStrategy From(
Truncate table CentralDbs.dbo.CostStrategy
Insert Into CentralDbs.dbo.CostStrategy
Select *, Case When Map = 0 Then (Case When (Zdc < Zmpp  AND ZDC <> 0) Or ZMPP=0 Then Zdc Else Zmpp End) Else Map End CostStrategy1,
Case When ZDC =0 AND ZMPP = 0 Then Map Else (Case When (Zdc < Zmpp  AND ZDC <> 0) Or ZMPP=0 Then Zdc Else Zmpp End) End As CostStrategy2, Case When ZDC = 0 and Map = 0 and Zmpp =0 Then 'No Cost' End As Comment  From(
Select SPL.MaterialNbr As Material, Mfg, MfgPartNbr,
Case When MZP.Col1$ is Null then 0 Else MZP.Col1$ End as Zdc,
Case When MPP.Col1$ is Null then 0 Else MPP.Col1$ End as Zmpp,
Case When MapPerUnit is Null then 0 Else MapPerUnit End as Map
From #SapPartsListTemp as SPL left outer join #MinZdcPrice MZP on SPL.MaterialNbr = MZP.MaterialNbr left outer join #MinZmppPrice MPP on MPP.MaterialNbr = SPL.MaterialNbr left outer join #MapTemp MT on MT.Material = SPl.MaterialNbr) as iq1
--) as iq2
