
truncate Table NonHaImportTesting.dbo.export

Select Count(*) from NonHaImportTesting.dbo.export

--Insert Statement for historical data
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
Select Cast(Version_Dt as date), RDA.FyMthNbr-1, Material_Nbr, Mfg_Part_Nbr, Pbg,Mfg, Prc_Stgy, Tech_Cd, Cc, Grp, Sum(Try_Cast(Try_Cast(Ttl_Stk_qty as decimal(15,0))as int)) as Qty, Sum(Try_Cast(Try_Cast(Replace(Replace(Replace(Ttl_Stk_Value,'(',''),')',''),'$','') as float) as decimal(15,2)))  as Val From NonHaImportTesting.dbo.export as DI, CentralDbs.dbo.RefDateAvnet as RDA Where RDA.DateDt = Cast(DI.Version_Dt as date) and mfg <> '0026013014' Group by Version_Dt, FyMthNbr, Material_Nbr, Mfg, Mfg_Part_Nbr, Pbg, Prc_Stgy, Tech_Cd, Cc, Grp 

