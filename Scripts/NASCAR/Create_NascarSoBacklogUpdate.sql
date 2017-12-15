
use NascarTest
go
select *
into #NascarSoBacklogTemp
from(
select 
* from NascarSoBacklogImport) as temp

Merge NascarSoBacklog as TargetTbl
using #NascarSoBacklogTemp as SourceTbl
On( TargetTbl.SoldToParty=SourceTbl.SoldToParty and        
    TargetTbl.MaterialNbr=SourceTbl.MaterialNbr 
	and TargetTbl.SalesDoc=SourceTbl.SalesDoc  )
When Matched 
and  TargetTbl.Qty <> SourceTbl.Qty
or  TargetTbl.OrderValue <> SourceTbl.OrderValue
or  TargetTbl.ExtResale <> SourceTbl.ExtResale
or  TargetTbl.ExtCost <> SourceTbl.ExtCost
or  TargetTbl.EndCust <> SourceTbl.EndCust

Then 
	Update set
	TargetTbl.Qty = SourceTbl.Qty,
	TargetTbl.OrderValue = SourceTbl.OrderValue,
    TargetTbl.ExtResale = SourceTbl.ExtResale,
    TargetTbl.ExtCost = SourceTbl.ExtCost,
    TargetTbl.EndCust = SourceTbl.EndCust

When not matched by target then
Insert (SoldToParty,SalesDoc,MaterialNbr,Qty,OrderValue,ExtResale,ExtCost,EndCust)
Values(SourceTbl.SoldToParty,SourceTbl.SalesDoc,SourceTbl.MaterialNbr,SourceTbl.Qty,SourceTbl.OrderValue,SourceTbl.ExtResale,SourceTbl.ExtCost,SourceTbl.EndCust)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;
Drop table #NascarSoBacklogTemp;
 

