
Select * Into #MapBatchTemp From(
Select Material, ValArea, ValTyp, Map, PriceUnitItm From Sap.dbo.mbew Where ValTyp is Not Null and ValTyp <> '' and ValTyp collate Latin1_General_CS_AS not like 'aa%' Group by Material, ValArea, ValTyp, Map, PriceUnitItm 
UNION

Select Material, ValArea, ValTyp, Map, PriceUnitItm 
From(Select Material, ValArea, ValTyp, Map, PriceUnitItm, Rank() Over (Partition By Material, ValArea, ValTyp Order By Material, ValArea, ValTyp, [TimeStamp] Desc, TtlValStk Desc, Map Desc) As Rank1 From Sap.dbo.Ebew Where ValTyp is Not Null and ValTyp <> '' AND NOT EXISTS (Select Material, ValArea, ValTyp From Sap.dbo.mbew Where ValTyp is Not Null and ValTyp <> '' AND Ebew.Material = Mbew.Material and Ebew.ValArea = Mbew.ValArea and Ebew.ValTyp = Mbew.ValTyp Group by Material, ValArea, ValTyp )) as iq1 Where Rank1 = 1 Group by Material, ValArea, ValTyp, Map, PriceUnitItm) as iq2


Merge CentralDbs.dbo.MapBatch MB
Using #MapBatchTemp MBT
ON MB.Material = MBT.Material and MB.ValArea = MBT.ValArea AND MB.ValTyp = MBT.ValTyp
When Matched and (MB.Map <> MBT.Map or MB.PriceUnitItm <> MBT.PriceUnitItm) Then
Update Set MB.Map = MBT.Map,
MB.PriceUnitItm = MBT.PriceUnitItm
When Not Matched By Target Then Insert
(Material, ValArea, ValTyp, Map, PriceUnitItm) Values(MBT.Material, MBT.ValArea, MBT.ValTyp, MBT.Map, MBT.PriceUnitItm)
When Not Matched By Source Then Delete;

Select * Into #MapPlantTemp From(
Select *, Rank() Over(Partition By Material,ValArea Order By Material, ValArea, PriceUnitItm Desc) as HighestQty From(
Select Material, ValArea, Case When Sum(TtlValStk) = 0 Then 0 Else Sum(ValTtlValStk)/Sum(TtlValStk)*1000 End As Map, PriceUnitItm From Sap.dbo.Mbew Where ValTyp is Not Null and ValTyp <> '' Group by Material, ValArea, PriceUnitItm
Union
Select Material, ValArea, Map, PriceUnitItm 
From(Select Material, ValArea, Map, PriceUnitItm, Rank() Over (Partition By Material, ValArea Order By Material, ValArea, [TimeStamp] Desc, TtlValStk Desc, Map Desc) As Rank1 From Sap.dbo.Ebew Where ValTyp is Not Null and ValTyp <> '' AND NOT EXISTS (Select Material, ValArea From Sap.dbo.Mbew Where ValTyp is Not Null and ValTyp <> '' AND Ebew.Material = Mbew.Material and Ebew.ValArea = Mbew.ValArea)) as iq1 Where Rank1 = 1 Group by Material, ValArea, Map, PriceUnitItm) as iq2)as iq3 Where HighestQty =1 

Merge CentralDbs.dbo.MapPlant MP
Using #MapPlantTemp MPT
ON MP.Material = MPT.Material and MP.ValArea = MPT.ValArea
When Matched and (MP.Map <> MPT.Map or MP.PriceUnitItm <> MPT.PriceUnitItm) Then
Update Set MP.Map = MPT.Map,
MP.PriceUnitItm = MPT.PriceUnitItm
When Not Matched By Target Then Insert
(Material, ValArea, Map, PriceUnitItm) Values(MPT.Material, MPT.ValArea, MPT.Map, MPT.PriceUnitItm)
When Not Matched By Source Then Delete;


Select Material, Map, PriceUnitItm Into #MapMaterialTemp From(
Select Material, Map, PriceUnitItm, Rank() Over(Partition By Material Order By Material, ValArea) As MinPlant From CentralDbs.dbo.MapPlant) as iq1 Where MinPlant = 1

Merge CentralDbs.dbo.MapMaterial MM
Using #MapMaterialTemp MMT
ON MM.Material = MMT.Material
When Matched and (MM.Map <> MMT.Map or MM.PriceUnitItm <> MMT.PriceUnitItm) Then
Update Set MM.Map = MMT.Map,
MM.PriceUnitItm = MMT.PriceUnitItm
When Not Matched By Target Then Insert
(Material, Map, PriceUnitItm) Values(MMT.Material, MMT.Map, MMT.PriceUnitItm)
When Not Matched By Source Then Delete;