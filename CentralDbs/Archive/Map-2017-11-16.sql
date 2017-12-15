
--Map Batch Level
Truncate Table CentralDbs.dbo.MapBatch
Insert Into CentralDbs.dbo.MapBatch 
Select Material, ValArea, ValTyp, Map, PriceUnitItm From Sap.dbo.mbew Where ValTyp is Not Null and ValTyp <> '' Group by Material, ValArea, ValTyp, Map, PriceUnitItm 
UNION

Select Material, ValArea, ValTyp, Map, PriceUnitItm 
From(Select Material, ValArea, ValTyp, Map, PriceUnitItm, Rank() Over (Partition By Material, ValArea, ValTyp Order By Material, ValArea, ValTyp, [TimeStamp] Desc, TtlValStk Desc, Map Desc) As Rank1 From Sap.dbo.Ebew Where ValTyp is Not Null and ValTyp <> '' AND NOT EXISTS (Select Material, ValArea, ValTyp From Sap.dbo.mbew Where ValTyp is Not Null and ValTyp <> '' AND Ebew.Material = Mbew.Material and Ebew.ValArea = Mbew.ValArea and Ebew.ValTyp = Mbew.ValTyp Group by Material, ValArea, ValTyp )) as iq1 Where Rank1 = 1 Group by Material, ValArea, ValTyp, Map, PriceUnitItm

--Material Plant Level
Truncate Table CentralDbs.dbo.MapPlant 
Insert Into CentralDbs.dbo.MapPlant 
Select Material, ValArea, Case When Sum(TtlValStk) = 0 Then 0 Else Sum(ValTtlValStk)/Sum(TtlValStk)*1000 End As Map, 1000 As PriceUnitItm From Sap.dbo.Mbew Where ValTyp is Not Null and ValTyp <> '' Group by Material, ValArea, PriceUnitItm
Union
Select Material, ValArea, Map, PriceUnitItm 
From(Select Material, ValArea, Map, PriceUnitItm, Rank() Over (Partition By Material, ValArea Order By Material, ValArea, [TimeStamp] Desc, TtlValStk Desc, Map Desc) As Rank1 From Sap.dbo.Ebew Where ValTyp is Not Null and ValTyp <> '' AND NOT EXISTS (Select Material, ValArea From Sap.dbo.Mbew Where ValTyp is Not Null and ValTyp <> '' AND Ebew.Material = Mbew.Material and Ebew.ValArea = Mbew.ValArea)) as iq1 Where Rank1 = 1 Group by Material, ValArea, Map, PriceUnitItm

