Select * Into #Fcsts from(
Select FcstParty, Material, Sum(FcastReceived) As FcastReceived, Sum(FcstOverwriteQty) As FcstOverwriteQty from CentralDbs.dbo.LastFcstMth  cross join CentralDbs.dbo.RefDateAvnet Where LastFcstMth.FyMthNbr >=216 and Cast(DateDt as date) = Cast(GetDate() as date) and RefDateAvnet.FyMthNbr>= LastFcstMth.FyMthNbr Group by FcstParty, CustMat, Material) as iq1

Select * Into #Billings From(
Select Material, Case When Try_Cast(CustNbr as bigint) is Null Then Null Else  Cast(CustNbr as bigint) End as CustNbr, Sum(BillingsQty) as BillingsQty, Sum(Billings) As Billings  From CentralDbs.dbo.Bookbill   cross join CentralDbs.dbo.RefDateAvnet where Type = 'Billings' and FyMnthNbr> 216 and Cast(DateDt as date) = Cast(GetDate() as date) and RefDateAvnet.FyMthNbr>= FyMnthNbr Group By Material, Case When Try_Cast(CustNbr as bigint) is Null Then Null Else  Cast(CustNbr as bigint) End) as iq1

Truncate Table CentralDbs.dbo.ScrubUpSell

Insert Into CentralDbs.dbo.ScrubUpSell
Select FcstParty, FcstNm, Material, Mfg, MfgPartNbr, FcastReceived As FcastReceived, FcstOverwriteQty As FcstOverwriteQty, BillingsQty As BillingsQty, Billings, OverboughtQty, InvIncQty-SalesIncQty as InvIncQty, (InvIncQty-SalesIncQty) * MapPerUnit  As InvIncVal, SalesIncQty, SalesIncVal, MapPerUnit From(
Select FcstParty, SapPartyNm01 As FcstNm, iq1.Material, Mfg, MfgPartNbr, FcastReceived As FcastReceived, FcstOverwriteQty As FcstOverwriteQty, BillingsQty As BillingsQty, Billings, 
Case When BillingsQty > FcastReceived Then BillingsQty - FcastReceived Else 0 End As OverboughtQty, 
Case When FcstOverwriteQty > FcastReceived Then FcstOverwriteQty - FcastReceived Else 0 End As InvIncQty,
Case When BillingsQty > FcastReceived And FcstOverwriteQty > FcastReceived and (BillingsQty - FcastReceived) > (FcstOverwriteQty - FcastReceived) Then FcstOverwriteQty - FcastReceived When BillingsQty > FcastReceived And FcstOverwriteQty > FcastReceived Then BillingsQty - FcastReceived Else 0 End As SalesIncQty, 
Map.MapPerUnit, 
Case When FcstOverwriteQty > FcastReceived Then FcstOverwriteQty - FcastReceived Else 0 End * MapPerUnit As InvIncVal, 
Case When BillingsQty =0 Then 0 Else (Billings/BillingsQty)* Case When BillingsQty > FcastReceived And FcstOverwriteQty > FcastReceived and (BillingsQty - FcastReceived) > (FcstOverwriteQty - FcastReceived) Then FcstOverwriteQty - FcastReceived When BillingsQty > FcastReceived And FcstOverwriteQty > FcastReceived Then BillingsQty - FcastReceived Else 0 End End As SalesIncVal  
From(
	Select FcstParty, Material, Sum(FcastReceived) As FcastReceived, Sum(FcstOverwriteQty) As FcstOverwriteQty, Sum(BillingsQty) As BillingsQty, Sum(Billings) As Billings From(
		Select #Fcsts.*, Case When #Billings.BillingsQty Is Null Then 0 Else #Billings.BillingsQty End As BillingsQty,  Case When #Billings.Billings Is Null Then 0 Else #Billings.Billings End As Billings From #Fcsts Left Outer Join #Billings on (#Fcsts.Material = #Billings.Material and #Fcsts.FcstParty = #Billings.CustNbr) Where FcstOverwriteQty > FcastReceived) as iq1 Group by FcstParty, Material) as iq1  
Left Outer Join  CentralDbs.dbo.Map on iq1.Material = Map.Material Left Outer Join Mdm.dbo.CustNames on FcstParty = CustNames.SapPartyId Left Join CentralDbs.dbo.SapPartsList on iq1.Material = MaterialNbr) as iq2

Select Count(*) from CentralDbs.dbo.ScrubUpSell

Select Sum(SalesIncVal) From CentralDbs.dbo.ScrubUpSell

/*
 Select FcastReceived, FcstOverwriteqty, FyTagMth From(
 Select Sum(FcastReceived) as FcastReceived, Sum(FcstOverwriteqty) as FcstOverwriteqty,  Count(*) As CountOfMaterials, FyTagMth From (
 Select #Fcsts.*, Case When #Billings.BillingsQty Is Null Then 0 Else #Billings.BillingsQty End As BillingsQty,  Case When #Billings.Billings Is Null Then 0 Else #Billings.Billings End As Billings From #Fcsts Left Outer Join #Billings on (#Fcsts.Material = #Billings.Material and #Fcsts.FcstParty = #Billings.CustNbr and #Fcsts.FyTagMth = #Billings.FyTagMth) where FcastReceived < FcstOverwriteqty) as iq1 Group by FyTagMth) as iq2 

 */

