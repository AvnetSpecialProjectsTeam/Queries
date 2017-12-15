IF OBJECT_ID('tempdb..#DemandMgmtInvAccounts') IS NOT NULL DROP TABLE #DemandMgmtInvAccounts
Select * Into #DemandMgmtInvAccounts From(
Select DemandMgmtInvFcstParty.*,EmployeeName,SupervisorName,LeadershipName From(Select DemandMgmtInvParts.*,RespUser From(Select FcstParty, SalesOrg, DistrChannel, Plant  From Sap.dbo.ZfcCustMatSplit Where (SalesOrg = 'C001' Or SalesOrg ='U001')  and (Plant = 1340 or (Plant >=1390 And Plant<=1396))
Group by FcstParty, SalesOrg, DistrChannel,Plant) as DemandMgmtInvParts left outer join Sap.dbo.ZfcCustomer on DemandMgmtInvParts.FcstParty = ZfcCustomer.FcstParty Where RespUser <> '003089' and (Sap.dbo.ZfcCustomer.SalesOrg = 'U001' Or Sap.dbo.ZfcCustomer.SalesOrg = 'C001') Group by DemandMgmtInvParts.FcstParty, DemandMgmtInvParts.SalesOrg, DemandMgmtInvParts.DistrChannel,DemandMgmtInvParts.Plant,RespUser) as DemandMgmtInvFcstParty left outer join CentralDbs.dbo.DemandMgmtAor on DemandMgmtAor.FcstParty = DemandMgmtInvFcstParty.FcstParty) as iq1

IF OBJECT_ID('tempdb..#DemandMgmtInvParts') IS NOT NULL DROP TABLE #DemandMgmtInvParts
Select * Into #DemandMgmtInvParts From(
Select Cast(FcstPartyZZFPA as bigint) as FcstParty,CustMat From  Sap.dbo.ZfcCustMat Where FcstStatus <> 7 and ConsignFlag <> 'X' And (SalesOrg = 'U001' Or SalesOrg = 'C001') Group by FcstPartyZZFPA, CustMat)as iq1

IF OBJECT_ID('tempdb..#DemandMgmtInvAor') IS NOT NULL DROP TABLE #DemandMgmtInvAor
Select * Into #DemandMgmtInvAor From(
Select DMIA.FcstParty, SalesOrg, DistrChannel, Plant, CustMat, EmployeeName,SupervisorName,LeadershipName From #DemandMgmtInvAccounts as DMIA inner join #DemandMgmtInvParts as DMIP on (DMIA.FcstParty = DMIP.FcstParty)) as iq1 Group by FcstParty, SalesOrg, DistrChannel,Plant,EmployeeName,SupervisorName,LeadershipName, CustMAt


Select * From #DemandMgmtInvAor

Select FyMnthNbr, FyTagMnth, Material, CustNbr, SalesDocNbr, Cogs, PlntOwnExt, MatNbrUsedCust  From CentralDbs.dbo.Bookbill left outer join Sap.dbo.Vbap on SalesDocNbr = SaleDoc and SalesDocLnItm = SaleDocItm Where Type = 'Billings' and ((PlntOwnExt = 1340 and StorLoc = 'H357') or (PlntOwnExt>=1390 and PlntOwnExt<=1396))

Select * From NonHaImportTesting.dbo.ImportDailyInvHistory
