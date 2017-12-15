



select  t1.PrcStgy,t1.Grp,t1.CC,t2.Thresh30 as Threshold30,t2.total,t1.Val1 from (SELECT
    Rank() over (Partition by PrcStgy,Grp,CC Order by PrcStgy,Grp,CC, Val1,NascarBatchExportId,QUoteId,LineitemNo) as ranks,
    PrcStgy,Grp,CC,NascarBatchExportId,QUoteId,LineitemNo,Val1
FROM 
    NascarAor
	where Nascar_Dt >= GETDATE()-30) as t1
	inner join
    (select PrcStgy,Grp,CC, cast(round(count(AUTH)*.3,0) as int) as Thresh30,
	cast(round(count(AUTH)*.4,0) as int) as Thresh40,
	cast(round(count(AUTH)*.5,0) as int) as Thresh50,
	cast(count(AUTH)as int) as total
	from NascarAor
	group by PrcStgy,Grp,CC) as t2 
	on t1.PrcStgy = t2.PrcStgy and t1.Grp= t2.Grp and t1.CC = t2.CC and t1.ranks = t2.Thresh30
	group by t1.PrcStgy,t1.Grp,t1.CC,ranks,Thresh30,total,Val1
	order by t2.total desc

