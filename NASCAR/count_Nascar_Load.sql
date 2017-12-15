select top (10) MaterialNbr,COUNT(MaterialNbr) as mat_count from NascarPhase2Part12 group by NascarPhase2Part12.MaterialNbr Order by mat_count DESC 

