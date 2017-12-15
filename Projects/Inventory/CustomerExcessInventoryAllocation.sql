
--5000-05d_POs
 If OBJECT_ID('tempdb.dbo.#POTemp','U') Is Not Null
 Drop Table #POTemp;
 Select * Into #POTemp From(
Select MaterialNbr, Sum(Case When PoDt<=Cast(GetDate()+90 as date) and PoDt> Cast(GetDate()-14 as date) Then PoOpenQty Else 0 End) As [90DayPoQty] From(Select MaterialNbr, PoOpenQty, Case When ConfDlvryDt is Null Then SchedLineDeliveryDt Else ConfDlvryDt End As PoDt From Bi.dbo.BIPoBacklog where PoTypeDesc = 'Drop Ship' or PoTypeDesc = 'Normal' and GenericPoType ='External') as iq1 Group by MaterialNbr)as iq2

--5000-04c_add_SOs
 If OBJECT_ID('tempdb.dbo.#SalesTemp','U') Is Not Null
 Drop Table #SalesTemp;
Select * Into #SalesTemp From(
Select MaterialNbr, Sum(Case When Try_Cast(STUFF(STUFF(CustReqDockDt,5,0,'/'),8,0,'/')as datetime2)<=Cast(GetDate()+90 as date) And Try_Cast(STUFF(STUFF(CustReqDockDt,5,0,'/'),8,0,'/') as datetime2)>Cast(GetDate()-14 as date) Then Replace(RemainingQty,',','') Else 0 End) As [90DaySoQty] From Bi.dbo.SalesOrderBacklog Where SalesDocTyp = 'Zor' or SalesDocTyp = 'ZFC' Group by MaterialNbr) as iq1

--Brought in as a join on make table
 If OBJECT_ID('tempdb.dbo.#MatAorTemp','U') Is Not Null
 Drop Table #MatAorTemp;
Select * Into #MatAorTemp From(
Select * From Sap.dbo.MatAor) as iq1

--0100-02_ncnr_fl
 If OBJECT_ID('tempdb.dbo.#NcnrTemp','U') Is Not Null
 Drop Table #NcnrTemp;
Select * Into #NcnrTemp From(
Select MaterialNbr, Ncnr From(Select MaterialNbr, Ncnr, Rank() Over(Partition by MaterialNbr Order By SapPlantCd Desc) As MinPlant From CentralDbs.dbo.SapFlagsCodes) as iq1 Where MinPlant = 1) as iq1

--0300-02_LT
 If OBJECT_ID('tempdb.dbo.#LtTemp','U') Is Not Null
 Drop Table #LtTemp;
Select * Into #LtTemp From(
Select MaterialNbr, LtPlanDlvry From(Select MaterialNbr, LtPlanDlvry, Rank() Over(Partition by MaterialNbr Order By MaterialNbr, Plant) As MinPlant From CentralDbs.dbo.SapQuantities) as iq1 Where MinPlant = 1)as iq2

--90 Days Inv Val and Qty in Branch Report
--1000-02_90_day_inv
 If OBJECT_ID('tempdb.dbo.#InvTemp','U') Is Not Null
 Drop Table #InvTemp;
Select * Into #InvTemp From(
Select MaterialNbr, Sum(Case When AgedDays>90 Then TtlStkQty Else 0 End) As [90DayInvQty], SUm(Case When AgedDays>90 Then TtlStkValue Else 0 End) As [90DayInvVal], Sum(TtlStkQty) as TtlStkQty, Sum(TtlStkValue) As TtlStkValue  From Bi.dbo.DailyInv Group By MaterialNbr) as iq1 Where [90DayInvQty] > 0

--Branch Report
--1010-02_single_plant_materials
 If OBJECT_ID('tempdb.dbo.#InvPlants','U') Is Not Null
 Drop Table #InvPlants;
 Select * Into #InvPlants From(
Select iq2.MaterialNbr, Plant From(Select MaterialNbr, Count(*) as MultiplePlantCounter From(Select MaterialNbr, Plant, Count(*) as PlantDups From Bi.dbo.DailyInv Group by MaterialNbr, Plant) as iq1 Group by MaterialNbr) as iq2 inner join (Select Distinct MaterialNbr, Plant From Bi.dbo.DailyInv) as plantinfo on iq2.MaterialNbr = plantinfo.MaterialNbr Where MultiplePlantCounter = 1) as iq3

--Idk what this is used for
--1020-00_billings_rolling_monmths
 If OBJECT_ID('tempdb.dbo.#BillingsQtrs','U') Is Not Null
 Drop Table #BillingsQtrs;
Select * Into #BillingsQtrs From(
Select Material, 
Sum(Case When Bookbill.FyMnthNbr>=RDA.FyMthNbr-3 And Bookbill.FyMnthNbr<RDA.FyMthNbr+1 Then Billings Else 0 End) As BillingsQ1Val,
Sum(Case When Bookbill.FyMnthNbr>=RDA.FyMthNbr-6 And Bookbill.FyMnthNbr<RDA.FyMthNbr-3 Then Billings Else 0 End) As BillingsQ2Val,
Sum(Case When Bookbill.FyMnthNbr>=RDA.FyMthNbr-9 And Bookbill.FyMnthNbr<RDA.FyMthNbr-6 Then Billings Else 0 End) As BillingsQ3Val,
Sum(Case When Bookbill.FyMnthNbr>=RDA.FyMthNbr-12 And Bookbill.FyMnthNbr<RDA.FyMthNbr-9 Then Billings Else 0 End) As BillingsQ4Val,
Sum(Case When Bookbill.FyMnthNbr>=RDA.FyMthNbr-3 And Bookbill.FyMnthNbr<RDA.FyMthNbr+1 Then BillingsQty Else 0 End) As BillingsQ1Qty,
Sum(Case When Bookbill.FyMnthNbr>=RDA.FyMthNbr-6 And Bookbill.FyMnthNbr<RDA.FyMthNbr-3 Then BillingsQty Else 0 End) As BillingsQ2Qty,
Sum(Case When Bookbill.FyMnthNbr>=RDA.FyMthNbr-9 And Bookbill.FyMnthNbr<RDA.FyMthNbr-6 Then BillingsQty Else 0 End) As BillingsQ3Qty,
Sum(Case When Bookbill.FyMnthNbr>=RDA.FyMthNbr-12 And Bookbill.FyMnthNbr<RDA.FyMthNbr-9 Then BillingsQty Else 0 End) As BillingsQ4Qty
 From CentralDbs.dbo.BookBill cross join CentralDbs.dbo.RefDateAvnet as RDA Where Type = 'Billings' and Cast(DateDt as date) = Cast(GetDate() as date) Group by Material) as iq1

 --2100-03_ttl_billings_by_cust Branch
 If OBJECT_ID('tempdb.dbo.#Sales6MthsBranch','U') Is Not Null
 Drop Table #Sales6MthsBranch;
 Select * Into #Sales6MthsBranch From(
 Select Material, CustNbr, Sum(Case When Bookbill.FyMnthNbr>Rda.FyMthNbr-7 Then BillingsQty Else 0 End) as BillingsQty, SalesOffice, SalesOfficeKey, SalesGrp, SalesGrpKey, Sum(Case When TransDt>=Cast(GetDate()-120 as date) Then BillingsQty Else 0 End) as [120DaysBillingsQty] From CentralDbs.dbo.Bookbill cross join CentralDbs.dbo.RefDateAvnet as RDA Where Type = 'Billings' and Cast(DateDt as date) = Cast(GetDate() as date ) Group by Material, CustNbr, SalesOffice, SalesOfficeKey, SalesGrp, SalesGrpKey) as iq1 Where BillingsQty > 0

 --2100-04_tll_billings_by_parts Branch
  If OBJECT_ID('tempdb.dbo.#SalesTotalBillingsByPartBranch','U') Is Not Null
 Drop Table #SalesTotalBillingsByPartBranch;
 Select * Into #SalesTotalBillingsByPartBranch From(
 Select Material, Sum(BillingsQty) as BillingsQty From #Sales6MthsBranch Group by Material) as iq1

 --2100-05_sales_% Branch
   If OBJECT_ID('tempdb.dbo.#SalesPercentBranch','U') Is Not Null
 Drop Table #SalesPercentBranch;
 Select * Into #SalesPercentBranch From(
 Select S6M.*, STBP.BillingsQty As TotalBillingsQty, Cast(Case When STBP.BillingsQty <> 0 Then S6M.BillingsQty/(STBP.BillingsQty+0.00) Else 0 End as decimal(15,4)) As PercentOfBillings From #Sales6MthsBranch as S6M Inner Join #SalesTotalBillingsByPartBranch as STBP on S6M.Material = STBP.Material) as iq1

  --2000-03_ttl_billings_by_cust
 If OBJECT_ID('tempdb.dbo.#Sales6Mths','U') Is Not Null
 Drop Table #Sales6Mths;
 Select * Into #Sales6Mths From(
 Select Material, CustNbr, Sum(Case When Bookbill.FyMnthNbr>Rda.FyMthNbr-7 Then BillingsQty Else 0 End) as BillingsQty, Sum(Case When TransDt>=Cast(GetDate()-120 as date) Then BillingsQty Else 0 End) as [120DaysBillingsQty] From CentralDbs.dbo.Bookbill cross join CentralDbs.dbo.RefDateAvnet as RDA Where Type = 'Billings' and Cast(DateDt as date) = Cast(GetDate() as date ) Group by Material, CustNbr) as iq1 Where BillingsQty > 0

 --2000-04_tll_billings_by_parts
  If OBJECT_ID('tempdb.dbo.#SalesTotalBillingsByPart','U') Is Not Null
 Drop Table #SalesTotalBillingsByPart;
 Select * Into #SalesTotalBillingsByPart From(
 Select Material, Sum(BillingsQty) as BillingsQty From #Sales6Mths Group by Material) as iq1

 --2000-05_sales_%
   If OBJECT_ID('tempdb.dbo.#SalesPercent','U') Is Not Null
 Drop Table #SalesPercent;
 Select * Into #SalesPercent From(
 Select S6M.*, STBP.BillingsQty As TotalBillingsQty, Cast(Case When STBP.BillingsQty <> 0 Then S6M.BillingsQty/(STBP.BillingsQty+0.00) Else 0 End as decimal(15,4)) As PercentOfBillings From #Sales6Mths as S6M Inner Join #SalesTotalBillingsByPart as STBP on S6M.Material = STBP.Material) as iq1

   --2000-03_ttl_billings_by_cust
 If OBJECT_ID('tempdb.dbo.#Sales120Days','U') Is Not Null
 Drop Table #Sales120Days;
 Select * Into #Sales120Days From(
 Select Material, Sum(Case When TransDt>=Cast(GetDate()-120 as date) Then BillingsQty Else 0 End) as [120DaysBillingsQty] From CentralDbs.dbo.Bookbill cross join CentralDbs.dbo.RefDateAvnet as RDA Where Type = 'Billings' and Cast(DateDt as date) = Cast(GetDate() as date ) Group by Material, CustNbr) as iq1 Where [120DaysBillingsQty] > 0

--2000-06_Sc_Account
If OBJECT_ID('tempdb.dbo.#ScAcct','U') Is Not Null
 Drop Table #ScAcct;
 Select * Into #ScAcct From(
 Select CustNbr+0 As CustNbr, Max(ScmFl) As ScmFl from Sap.dbo.ZtqtcCmir Where CustNbr <> '          ' Group By CustNbr) as iq1 Where ScmFl = 'X'

 --Full Allocation Query
 Select SrDir, Pld, MatlMgr, MatlSpclst, IT.MaterialNbr, SPL.MfgPartNbr, SPL.Mfg, SPL.Pbg, SPL.PrcStgy, SPL.Tech, SPL.CC, SPL.Grp, Ncnr, LtPlanDlvry, SP.CustNbr, Case When SA.CustNbr IS Not Null Then 'Y' Else 'N' End as ScAcct, SapPartyNm01 As CustName, Case When BillingsQty is Null Then 0 Else BillingsQty End As BillingsQty,Case When TotalBillingsQty is Null Then 0 Else TotalBillingsQty End As TotalBillingsQty,
 Case When PercentOfBillings is Null Then 0 Else PercentOfBillings End As PercentOfBillings,Case When [90DayPoQty] is Null Then 0 Else [90DayPoQty] End As [90DayPoQty],Case When [90DaySoQty] is Null Then 0 Else [90DaySoQty] End As [90DaySoQty],Case When [120DaysBillingsQty] is Null Then 0 Else [120DaysBillingsQty] End As [120DaysBillingsQty],Case When It.TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End)<0 Then 0 Else It.TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End) End As ExcessInvQty, Case When It.TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End)<0 Then 0 Else (It.TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End))*MapPerUnit End As ExcessInvVal  From #InvTemp as IT Left Outer Join #MatAorTemp as MAT on IT.MaterialNbr = MAT.MatNbr Left Outer Join CentralDbs.dbo.SapPartsList as SPL on IT.MaterialNbr = SPL.MaterialNbr Left Outer Join #NcnrTemp as NT on IT.MaterialNbr = NT.MaterialNbr Left Outer Join #LtTemp as LT on Lt.MaterialNbr = IT.MaterialNbr Left Outer Join #SalesPercent as SP on IT.MaterialNbr = SP.Material Left Outer Join #ScAcct as SA on SA.CustNbr = SP.CustNbr Left Outer Join Mdm.dbo.CustNames on Sp.CustNbr = CustNames.SapPartyId Left Outer Join #POTemp as PT on PT.MaterialNbr = IT.MaterialNbr Left Outer Join #SalesTemp as ST on ST.MaterialNbr = IT.MaterialNbr Left Outer Join CentralDbs.dbo.Map on IT.MaterialNbr = Map.Material 

 --Part Total Query
 Select *, Case When TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End)<0 Then 0 Else TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End) End As ExcessInvQty, Case When TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End)<0 Then 0 Else (TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End))*MapPerUnit End As ExcessInvVal From(
 Select SrDir, Pld, MatlMgr, MatlSpclst, IT.MaterialNbr, SPL.MfgPartNbr, SPL.Mfg, SPL.Pbg, SPL.PrcStgy, SPL.Tech, SPL.CC, SPL.Grp, Ncnr, LtPlanDlvry, Case When [90DayPoQty] is Null Then 0 Else [90DayPoQty] End As [90DayPoQty],Case When [90DaySoQty] is Null Then 0 Else [90DaySoQty] End As [90DaySoQty], TtlStkQty, MapPerUnit, Sum(Case When [120DaysBillingsQty] is Null Then 0 Else [120DaysBillingsQty] End) As [120DaysBillingsQty]
 --,Case When It.TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End)<0 Then 0 Else It.TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End) End As ExcessInvQty, Case When It.TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End)<0 Then 0 Else (It.TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End))*MapPerUnit End As ExcessInvVal
   From #InvTemp as IT Left Outer Join #MatAorTemp as MAT on IT.MaterialNbr = MAT.MatNbr Left Outer Join CentralDbs.dbo.SapPartsList as SPL on IT.MaterialNbr = SPL.MaterialNbr Left Outer Join #NcnrTemp as NT on IT.MaterialNbr = NT.MaterialNbr Left Outer Join #LtTemp as LT on Lt.MaterialNbr = IT.MaterialNbr Left Outer Join #POTemp as PT on PT.MaterialNbr = IT.MaterialNbr Left Outer Join #SalesTemp as ST on ST.MaterialNbr = IT.MaterialNbr Left Outer Join CentralDbs.dbo.Map on IT.MaterialNbr = Map.Material Left Outer Join #Sales120Days as SD on IT.MaterialNbr = SD.Material Group by SrDir, Pld, MatlMgr, MatlSpclst, IT.MaterialNbr, SPL.MfgPartNbr, SPL.Mfg, SPL.Pbg, SPL.PrcStgy, SPL.Tech, SPL.CC, SPL.Grp, Ncnr, LtPlanDlvry, [90DaySoQty], [90DayPoQty], TtlStkQty, MapPerUnit)as iq1 


 --Top_Customer_By_Parts
  Select * From(
  Select SrDir, Pld, MatlMgr, MatlSpclst, IT.MaterialNbr, SPL.MfgPartNbr, SPL.Mfg, SPL.Pbg, SPL.PrcStgy, SPL.Tech, SPL.CC, SPL.Grp, Ncnr, LtPlanDlvry, SP.CustNbr, Case When SA.CustNbr IS Not Null Then 'Y' Else 'N' End as ScAcct, SapPartyNm01 As CustName, Case When BillingsQty is Null Then 0 Else BillingsQty End As BillingsQty,Case When TotalBillingsQty is Null Then 0 Else TotalBillingsQty End As TotalBillingsQty,
 Case When PercentOfBillings is Null Then 0 Else PercentOfBillings End As PercentOfBillings,Case When [90DayPoQty] is Null Then 0 Else [90DayPoQty] End As [90DayPoQty],Case When [90DaySoQty] is Null Then 0 Else [90DaySoQty] End As [90DaySoQty],Case When [120DaysBillingsQty] is Null Then 0 Else [120DaysBillingsQty] End As [120DaysBillingsQty],Case When It.TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End)<0 Then 0 Else It.TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End) End As ExcessInvQty, Case When It.TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End)<0 Then 0 Else (It.TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End))*MapPerUnit End As ExcessInvVal, Rank() Over(Partition by IT.MaterialNbr Order By IT.MaterialNbr, Case When PercentOfBillings is Null Then 0 Else PercentOfBillings End Desc) As TopCustomer From #InvTemp as IT Left Outer Join #MatAorTemp as MAT on IT.MaterialNbr = MAT.MatNbr Left Outer Join CentralDbs.dbo.SapPartsList as SPL on IT.MaterialNbr = SPL.MaterialNbr Left Outer Join #NcnrTemp as NT on IT.MaterialNbr = NT.MaterialNbr Left Outer Join #LtTemp as LT on Lt.MaterialNbr = IT.MaterialNbr Left Outer Join #SalesPercent as SP on IT.MaterialNbr = SP.Material Left Outer Join #ScAcct as SA on SA.CustNbr = SP.CustNbr Left Outer Join Mdm.dbo.CustNames on Sp.CustNbr = CustNames.SapPartyId Left Outer Join #POTemp as PT on PT.MaterialNbr = IT.MaterialNbr Left Outer Join #SalesTemp as ST on ST.MaterialNbr = IT.MaterialNbr Left Outer Join CentralDbs.dbo.Map on IT.MaterialNbr = Map.Material) as iq1 Where TopCustomer = 1 and CustNbr Is Not Null

 --Customer Rollup
 Select SP.CustNbr, SapPartyNm01 As CustName, Case When SA.CustNbr IS Not Null Then 'Y' Else 'N' End as ScAcct, Sum(Case When It.TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End)<0 Then 0 Else It.TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End) End) As ExcessInvQty, Sum(Case When It.TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End)<0 Then 0 Else (It.TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End))*MapPerUnit End) As ExcessInvVal  From #InvTemp as IT Left Outer Join #SalesPercent as SP on IT.MaterialNbr = SP.Material Left Outer Join #ScAcct as SA on SA.CustNbr = SP.CustNbr Left Outer Join Mdm.dbo.CustNames on Sp.CustNbr = CustNames.SapPartyId  Left Outer Join CentralDbs.dbo.Map on IT.MaterialNbr = Map.Material Group By Sp.CustNbr, CustNames.SapPartyNm01, SA.CustNbr


--Full Allocation Branch
 Select SrDir, Pld, MatlMgr, MatlSpclst, IT.MaterialNbr, SPL.MfgPartNbr, SPL.Mfg, SPL.Pbg, SPL.PrcStgy, SPL.Tech, SPL.CC, SPL.Grp, Ncnr, LtPlanDlvry, SP.CustNbr, Case When SA.CustNbr IS Not Null Then 'Y' Else 'N' End as ScAcct, SapPartyNm01 As CustName, SP.SalesOffice,Sp.SalesOfficeKey, Sp.SalesGrp ,Sp.SalesGrpKey, Case When BillingsQty is Null Then 0 Else BillingsQty End As BillingsQty,Case When TotalBillingsQty is Null Then 0 Else TotalBillingsQty End As TotalBillingsQty,
 Case When PercentOfBillings is Null Then 0 Else PercentOfBillings End As PercentOfBillings,Case When [90DayPoQty] is Null Then 0 Else [90DayPoQty] End As [90DayPoQty],Case When [90DaySoQty] is Null Then 0 Else [90DaySoQty] End As [90DaySoQty],Case When [120DaysBillingsQty] is Null Then 0 Else [120DaysBillingsQty] End As [120DaysBillingsQty],Case When It.TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End)<0 Then 0 Else It.TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End) End As ExcessInvQty, Case When It.TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End)<0 Then 0 Else (It.TtlStkQty-(Case When [120DaysBillingsQty] Is Null Then 0 Else [120DaysBillingsQty] End))*MapPerUnit End As ExcessInvVal,
 Case When BillingsQ1Qty is Null Then 0 Else BillingsQ1Qty End As BillingsQ1Qty
,Case When BillingsQ1Val is Null Then 0 Else BillingsQ1Val End As BillingsQ1Val
,Case When BillingsQ2Qty is Null Then 0 Else BillingsQ2Qty End As BillingsQ2Qty
,Case When BillingsQ2Val is Null Then 0 Else BillingsQ2Val End As BillingsQ2Val
,Case When BillingsQ3Qty is Null Then 0 Else BillingsQ3Qty End As BillingsQ3Qty
,Case When BillingsQ3Val is Null Then 0 Else BillingsQ3Val End As BillingsQ3Val
,Case When BillingsQ4Qty is Null Then 0 Else BillingsQ4Qty End As BillingsQ4Qty
,Case When BillingsQ4Val is Null Then 0 Else BillingsQ4Val End As BillingsQ4Val
 From #InvTemp as IT Left Outer Join #MatAorTemp as MAT on IT.MaterialNbr = MAT.MatNbr Left Outer Join CentralDbs.dbo.SapPartsList as SPL on IT.MaterialNbr = SPL.MaterialNbr Left Outer Join #NcnrTemp as NT on IT.MaterialNbr = NT.MaterialNbr Left Outer Join #LtTemp as LT on Lt.MaterialNbr = IT.MaterialNbr Left Outer Join #SalesPercentBranch as SP on IT.MaterialNbr = SP.Material Left Outer Join #ScAcct as SA on SA.CustNbr = SP.CustNbr Left Outer Join Mdm.dbo.CustNames on Sp.CustNbr = CustNames.SapPartyId Left Outer Join #POTemp as PT on PT.MaterialNbr = IT.MaterialNbr Left Outer Join #SalesTemp as ST on ST.MaterialNbr = IT.MaterialNbr Left Outer Join CentralDbs.dbo.Map on IT.MaterialNbr = Map.Material Left Outer Join #BillingsQtrs As BQ on Bq.Material = IT.MaterialNbr



