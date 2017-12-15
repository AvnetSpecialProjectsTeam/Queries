use sap
go

Select Material, MapPerUnit Into #EbewMap From (
Select Sap.dbo.ebew.Material, [Map]/[PriceUnitItm] AS MapPerUnit From(
Select [3100-04_ebew_map_0].Material, [3100-04_ebew_map_0].TtlValStk, [3100-04_ebew_map_0].TimeStamp, Max(Sap.dbo.ebew.ValTyp) AS ValTyp From(
Select Sap.dbo.ebew.Material, Sap.dbo.ebew.TtlValStk, Max(Sap.dbo.ebew.TimeStamp) AS [TimeStamp] From(
Select Sap.dbo.Ebew.Material, Max(TtlValStk) As TtlValStk From(
Select Material From(
SELECT Ebew.Material, Ebew.Map
FROM Ebew
GROUP BY Ebew.Material, Ebew.Map
HAVING (((Ebew.Map)>0))) as [3100-01_ebew_non_0_map]) as [3100-02_non_0_map_materials] inner join Sap.dbo.ebew on [3100-02_non_0_map_materials].Material = Sap.dbo.ebew.Material
GROUP BY Sap.dbo.ebew.Material
HAVING (((Max(Sap.dbo.ebew.TtlValStk))=0))) as [3100-03_ebew_map_0]
INNER JOIN Sap.dbo.ebew ON [3100-03_ebew_map_0].Material = Sap.dbo.ebew.Material
GROUP BY Sap.dbo.ebew.Material, Sap.dbo.ebew.TtlValStk) as [3100-04_ebew_map_0] INNER JOIN Sap.dbo.ebew ON ([3100-04_ebew_map_0].TimeStamp = Sap.dbo.ebew.TimeStamp) AND ([3100-04_ebew_map_0].TtlValStk = Sap.dbo.ebew.TtlValStk) AND ([3100-04_ebew_map_0].Material = Sap.dbo.ebew.Material)
GROUP BY [3100-04_ebew_map_0].Material, [3100-04_ebew_map_0].TtlValStk, [3100-04_ebew_map_0].TimeStamp) as [3100-04a_ebew_map_0] INNER JOIN Sap.dbo.ebew ON ([3100-04a_ebew_map_0].TimeStamp = Sap.dbo.ebew.TimeStamp) AND ([3100-04a_ebew_map_0].ValTyp = Sap.dbo.ebew.ValTyp) AND ([3100-04a_ebew_map_0].TtlValStk = Sap.dbo.ebew.TtlValStk) AND ([3100-04a_ebew_map_0].Material = Sap.dbo.ebew.Material)
GROUP BY Sap.dbo.ebew.Material, [Map]/[PriceUnitItm]
Union
Select [3100-07_ebew_map_value].Material, [MapPer_Unit]/[TtlValStk] AS MapPerUnit From(
Select [3100-06_ebew_map_value].Material, Sum([3100-06_ebew_map_value].TtlValStk) AS TtlValStk, Sum([3100-06_ebew_map_value].MapPer_Unit) AS MapPer_Unit From( 
SELECT Sap.dbo.ebew.Material, Sap.dbo.ebew.TtlValStk, Sap.dbo.ebew.ValTtlValStk, Sap.dbo.ebew.Map, Sap.dbo.ebew.PriceUnitItm, [TtlValStk]*([map]/[PriceUnitItm]) AS MapPer_Unit
FROM Sap.dbo.ebew
WHERE (((Sap.dbo.ebew.TtlValStk)>0))) as [3100-06_ebew_map_value]
GROUP BY [3100-06_ebew_map_value].Material) as [3100-07_ebew_map_value]) as [3100-09_ebew_map_union]


Select Material, MapPerUnit Into #MbewMap From (
SELECT Sap.dbo.mbew.Material, [Map]/[PriceUnitItm] AS MapPerUnit From(
SELECT [3101-04_mbew_map_0].Material, [3101-04_mbew_map_0].TtlValStk, [3101-04_mbew_map_0].TimeStamp, Max(Sap.dbo.mbew.ValTyp) AS ValTyp From(
SELECT Sap.dbo.mbew.Material, Sap.dbo.mbew.TtlValStk, Max(Sap.dbo.mbew.TimeStamp) AS [TimeStamp] From(
Select Sap.dbo.mbew.Material, Max(Sap.dbo.mbew.TtlValStk) AS TtlValStk From(
Select [3101-01_mbew_non_0_map].Material From(
SELECT Sap.dbo.mbew.Material, Sap.dbo.mbew.Map
FROM Sap.dbo.mbew
GROUP BY Sap.dbo.mbew.Material, Sap.dbo.mbew.Map
HAVING (((Sap.dbo.mbew.Map)>0))) as [3101-01_mbew_non_0_map]
GROUP BY [3101-01_mbew_non_0_map].Material) as [3101-02_non_0_map_materials] INNER JOIN Sap.dbo.Mbew ON Sap.dbo.mbew.Material = [3101-02_non_0_map_materials].Material
GROUP BY Sap.dbo.mbew.Material
HAVING (((Max(Sap.dbo.mbew.TtlValStk))=0))) as [3101-03_mbew_map_0] INNER JOIN Sap.dbo.mbew ON [3101-03_mbew_map_0].Material = Sap.dbo.mbew.Material
GROUP BY Sap.dbo.mbew.Material, Sap.dbo.mbew.TtlValStk) as [3101-04_mbew_map_0] INNER JOIN Sap.dbo.mbew ON ([3101-04_mbew_map_0].TimeStamp = Sap.dbo.mbew.TimeStamp) AND ([3101-04_mbew_map_0].TtlValStk = Sap.dbo.mbew.TtlValStk) AND ([3101-04_mbew_map_0].Material = Sap.dbo.mbew.Material)
GROUP BY [3101-04_mbew_map_0].Material, [3101-04_mbew_map_0].TtlValStk, [3101-04_mbew_map_0].TimeStamp) as [3101-04a_mbew_map_0]
INNER JOIN Sap.dbo.mbew ON ([3101-04a_mbew_map_0].TimeStamp = Sap.dbo.mbew.TimeStamp) AND ([3101-04a_mbew_map_0].ValTyp = Sap.dbo.mbew.ValTyp) AND ([3101-04a_mbew_map_0].TtlValStk = Sap.dbo.mbew.TtlValStk) AND ([3101-04a_mbew_map_0].Material = Sap.dbo.mbew.Material)
GROUP BY Sap.dbo.mbew.Material, [Map]/[PriceUnitItm]
UNION
SELECT [3101-07_mbew_map_value].Material, [MapPer_Unit]/[TtlValStk] AS MapPerUnit From(
SELECT [3101-06_mbew_map_value].Material, Sum([3101-06_mbew_map_value].TtlValStk) AS TtlValStk, Sum([3101-06_mbew_map_value].MapPer_Unit) AS MapPer_Unit From(
SELECT Sap.dbo.mbew.Material, Sap.dbo.mbew.TtlValStk, Sap.dbo.mbew.ValTtlValStk, Sap.dbo.mbew.Map, Sap.dbo.mbew.PriceUnitItm, [TtlValStk]*([map]/[PriceUnitItm]) AS MapPer_Unit
FROM Sap.dbo.mbew
WHERE (((Sap.dbo.mbew.TtlValStk)>0))) as [3101-06_mbew_map_value]
GROUP BY [3101-06_mbew_map_value].Material) as [3101-07_mbew_map_value]) as [3101-0_mbew_map_union]

Truncate Table CentralDbs.dbo.Map

Insert into CentralDbs.dbo.map
SELECT #EbewMap.Material, #EbewMap.MapPerUnit
FROM #EbewMap LEFT JOIN #MbewMap ON #EbewMap.Material = #MbewMap.Material
WHERE (((#MbewMap.Material) Is Null))
UNION SELECT Material, MapPerUnit
FROM #MbewMap
