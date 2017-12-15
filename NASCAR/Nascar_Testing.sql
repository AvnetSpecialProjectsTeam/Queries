select * from NascarPhase2Part12 where NascarPhase2Part12.MaterialNbr = 5189878
select MaterialNbr,COUNT(MaterialNbr) as mat_count from NascarPhase2Part4 group by NascarPhase2Part4.MaterialNbr Order by mat_count DESC 
select * from [dbo].[ViewSapQty2570] where MaterialNbr = 7000004030

select * from [dbo].[NascarPhase2QtyPart4] where MaterialNbr = 7000258935
drop table NascarImportHeaderTest
select * into NascarImportHeaderTest from NascarImportHeader