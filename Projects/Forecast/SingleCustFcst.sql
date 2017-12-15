Select * Into #SingleCustFcstTemp From(
	Select  Distinct FcstParty, Material,Week 
	From Sap.dbo.ZfcUploadLog 
	Where FcastReceivedDt > '2016-04-01 00:00:00.000') as iq1

--Single Forecast Materials 
	Select * Into #temp From(
				Select Distinct FcstParty, Material From #SingleCustFcstTemp 
				Inner Join  --Select First Day of the Week
					(Select CalWkNbr, Cast(DateDt as date) As DateDt From(
							--Selecting Days of Week and Ranking them Asc
							Select Distinct CalWkNbr, Rda.DateDt, Rank() Over( Partition By CalWkNbr Order by CalWkNbr, DateDt Asc) as Rank1 
							from CentralDbs.dbo.RefDateAvnet as RDA) as iq1 
						Where Rank1 = 1) as iq2
				on iq2.CalWkNbr = #SingleCustFcstTemp.Week
				Inner Join	--Date The Maxed Aged Part In Inventory was bought
					(Select *, dateadd(DD,-1*MaxedAged, cast(getdate() as date)) As InvPurchaseDt
					From --Max Aged Date Of Parts In Inventory
						(Select MaterialNbr, Max(AgedDays) As MaxedAged 
						from Bi.dbo.DailyInv Group by MaterialNbr) as iq3) 
						as iq4 On #SingleCustFcstTemp.Material = iq4.MaterialNbr
						Where DateDt >= InvPurchaseDt) as iq5

Truncate Table CentralDbs.dbo.SingleCustFcst 
--Query to Pull Material List with Individual Materials
 Insert Into CentralDbs.dbo.SingleCustFcst 
  		Select #temp.* From(
			Select Material, Sum(1) As Dups From #temp
			Group by Material) as iq1 inner join #temp on #temp.Material = iq1.Material
		Where Dups < 2

