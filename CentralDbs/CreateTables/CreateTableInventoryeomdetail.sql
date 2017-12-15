USE CentralDbs
go

Drop Table InventoryEomDetail
Go
Create Table InventoryEomDetail(
VersionDt datetime2,
FyMthNbr int,
MaterialNbr bigint,
MfgPartNbr varchar(50),
Pbg varchar(3),
Mfg varchar(3),
PrcStgy varchar(3),
TechCd varchar(3),
Cc varchar(3),
Grp varchar(3),
Qty int,
Val decimal(15,2)
)

Delete From InventoryEomDetail from InventoryEomDetail as IED, CentralDbs.dbo.RefDateAvnet as RDA Where RDA.FyMthNbr = IED.FyMthNbr AND RDA.DateDt = Cast(GetDate() as date)

Insert into InventoryEomDetail Values('2017/01/02', 218, 12312, 'dsa', 'asd','aaa','bbb','ccc','ddd','eee',50, 152.53)

Select * From InventoryEOMDETAIL