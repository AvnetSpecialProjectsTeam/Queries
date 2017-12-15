Use CentralDbs
go

drop table InvEomBackup
select * Into InvEomBackup from InventoryEomDetail

--Delete all from IED for today's data
Delete From CentralDbs.dbo.InventoryEomDetail from CentralDbs.dbo.InventoryEomDetail as IED Where VersionDt = Cast(GetDate() As Date)


--Insert statement from DailyInv to the BI Table
Insert Into CentralDbs.dbo.InventoryEomDetail(VersionDt,
FyMthNbr,
MaterialNbr,
MfgPartNbr,
Pbg,
Mfg,
PrcStgy,
TechCd,
Cc,
Grp,
Qty,
Val)
Select VersionDt, Case When RDA.BusDay99 >1 Then FyMthNbr Else FyMthNbr-1 End, MaterialNbr, MfgPartNbr, Pbg,Mfg, PrcStgy, TechCd, Cc, Grp, Sum(TtlStkqty) as Qty, Sum(TtlStkValue) as Val From Bi.dbo.DailyInv as DI, CentralDbs.dbo.RefDateAvnet as RDA Where VersionDt = Cast(GetDate() as date) And RDA.DateDt = Cast(GetDate() as date) Group by VersionDt, FyMthNbr, MaterialNbr, Mfg, MfgPartNbr, Pbg, PrcStgy, TechCd, Cc, Grp, BusDay99


Select IED.VersionDt, IED.FyMthNbr, RDA.BusDay99, Sum(Val) From CentralDbs.dbo.InventoryEomDetail as IED, CentralDbs.dbo.RefDateAvnet as RDA Where RDA.DateDt = VersionDt group by versiondt, IED.fymthnbr, BusDay99 Order by fymthnbr

 
