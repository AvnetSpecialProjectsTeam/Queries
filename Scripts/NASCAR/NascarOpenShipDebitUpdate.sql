
use NascarProd
go
select *
into #NascarOSD
from(
select 
* from NascarOpenShipDebitDailyUpload) as temp

Merge NascarOpenShipDebit as TargetTbl
using #NascarOSD as SourceTbl
On( TargetTbl.SapAgreement=SourceTbl.SapAgreement and        TargetTbl.AuthorizationNbr=SourceTbl.AuthorizationNbr and 
   TargetTbl.SoldtoParty=SourceTbl.SoldtoParty and 
   TargetTbl.ShipToParty=SourceTbl.ShipToParty and 
  TargetTbl.MaterialNbr=SourceTbl.MaterialNbr  )
When Matched 
and TargetTbl.ValidFrom <> SourceTbl.ValidFrom
or  TargetTbl.ValidTo <> SourceTbl.ValidTo
or  TargetTbl.Rate <> SourceTbl.Rate
or  TargetTbl.RemainingQtyVistex <> SourceTbl.RemainingQtyVistex
or  TargetTbl.AvnetResale <> SourceTbl.AvnetResale


Then 
	Update set
	TargetTbl.ValidFrom = SourceTbl.ValidFrom,
	TargetTbl.ValidTo = SourceTbl.ValidTo,
	TargetTbl.Rate = SourceTbl.Rate,
	TargetTbl.RemainingQtyVistex = SourceTbl.RemainingQtyVistex,
	TargetTbl.AvnetResale = SourceTbl.AvnetResale

When not matched by target then
Insert (SapAgreement,AuthorizationNbr,SoldtoParty,ShiptoParty,MaterialNbr,ValidFrom,ValidTo,Rate,RemainingQtyVistex,AvnetResale)
Values(SourceTbl.SapAgreement,SourceTbl.AuthorizationNbr,SourceTbl.SoldtoParty,SourceTbl.ShiptoParty,SourceTbl.MaterialNbr,SourceTbl.ValidFrom,SourceTbl.ValidTo,SourceTbl.Rate,SourceTbl.RemainingQtyVistex,SourceTbl.AvnetResale)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;
Drop table #NascarOSD;


