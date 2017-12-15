use sap 
go

CREATE TABLE #temp(
	[FcstParty] [bigint] NOT NULL,
	[SalesOrg] [varchar](5) NOT NULL,
	[DistrChannel] [int] NOT NULL,
	[CustMat] [varchar](36) NOT NULL,
	[Material] [bigint] NOT NULL,
	[Week] [int] NOT NULL,
	[FcastReceivedDt] [datetime2](7) NOT NULL,
	[Time] [time](7) NOT NULL,
	[FcastReceived] [decimal](15, 3) NULL,
	[FcastOverwrite] [int] NULL,
	[FcastAmendedFig] bigint null
PRIMARY KEY CLUSTERED 
(
	[FcstParty] ASC,
	[SalesOrg] ASC,
	[DistrChannel] Asc,
	[CustMat] ASC,
	[Material] ASC,
	[Week] ASC,
	[FcastReceivedDt] ASC,
	[Time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE #temp2(
	[FcstParty] [bigint] NOT NULL,
	[SalesOrg] [varchar](5) NOT NULL,
	[DistrChannel] [int] NOT NULL,
	[CustMat] [varchar](36) NOT NULL,
	[Material] [bigint] NOT NULL,
	[Week] [int] NOT NULL,
	[FyMthNbr] [int] Not Null,
	[FyTagMth] varchar(15) Not Null,
	[FcastReceivedDt] [datetime2](7) NOT NULL,
	[Time] [time](7) NOT NULL,
	[FcastReceived] [decimal](15, 3) NULL,
	[FcastOverwrite] [int] NULL,
	[FcastAmendedFig] bigint null
PRIMARY KEY CLUSTERED 
(
	[FcstParty] ASC,
	[SalesOrg] ASC,
	[DistrChannel] Asc,
	[CustMat] ASC,
	[Material] ASC,
	[Week] ASC,
	[FyMthNbr] ASC,
	[FcastReceivedDt] ASC,
	[Time] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- Version 4, Rank Over Partition For Lastest At A Week Level Before Join
Truncate Table #temp
Truncate Table #temp2
--Runtime of 6 minutes 41 seconds
Insert Into #temp 
Select  FcstParty, SalesOrg, DistrChannel, CustMat, Material,Week, FcastReceivedDt, [Time], FcastReceived, FcastOverwrite, FcastAmendFig
From Sap.dbo.ZfcUploadLog 
Where FcastReceivedDt > '2016-04-01 00:00:00.000' AND (SalesOrg = 'U001' OR  SalesOrg = 'C001' OR SalesOrg = 'P001')

--Grabbing Latest Forecast Each Week
--Runtime of 9 minutes and 40 seconds
Insert Into #temp2 
Select FcstParty, SalesOrg, DistrChannel, CustMat, Material,Week, RefDateAvnetWkMthRelation.FyMthNbr, FyTagMth, FcastReceivedDt, [Time], FcastReceived, FcastOverwrite, FcastAmendedFig From (
	Select * From( 
		Select  FcstParty, SalesOrg, DistrChannel, CustMat, Material,Week, FcastReceivedDt, [Time], FcastReceived, FcastOverwrite, FcastAmendedFig,
		Rank() Over(Partition By FcstParty, CustMat, Material, Week, FyMthNbr Order by  FcstParty, CustMat, Material,Week, FyMthNbr, [FcastReceivedDt] Desc, [Time] Desc) as ForecastRank1
		From #temp 
		left outer join 
		(Select FyMthNbr, DateDt
		from CentralDbs.dbo.RefDateAvnet) as RefDateAvnetWeekNbr on DateDt = FcastReceivedDt) as iq1 
	Where ForecastRank1 = 1) as iq2 
	Inner join 
		(Select Distinct FyMthNbr,FyTagMth, CalWkNbr, Rank() Over( Partition By CalWkNbr Order by CalWkNbr, FyMthNbr Asc) as Rank1 
		from CentralDbs.dbo.RefDateAvnet) as RefDateAvnetWkMthRelation 
	on iq2.Week = RefDateAvnetWkMthRelation.CalWkNbr 
	Where Rank1 = 1
 

Select * Into #Map From(Select Material, Map/PriceUnitItm As MapPerUnit, Rank() Over(Partition by Material Order by Material, ValArea Asc) as MinPlant from CentralDbs.dbo.MapPlant) as iq1 Where MinPlant=1

Truncate Table #temp
Truncate Table CentralDbs.dbo.LastFcstMth 
--Grabbing Latest Forecast Each Month for each week
--Runtime of 57 seconds
--Drop Table CentralDbs.dbo.LastFcstMth
--Select * Into CentralDbs.dbo.LastFcstMth From(
Insert Into CentralDbs.dbo.LastFcstMth 
Select FcstParty, SapPartyNm01 As FcstPartyNm, SalesOrg, DistrChannel as DistChnl, CustMat as CustMat, iq1.Material, Mfg, MfgPartNbr, Cast(FcastReceivedDt as date) as FcstRecvDt, Cast(Time as time) as FcstRecvTime, Cast(FcastReceived as int) as RawFcstQty, FcastOverwrite as ScrubPrcnt, FcastAmendedFig As ScrubFcstQty, Cast(MapPerUnit as decimal(15,6)) as Map, RDA.FyMthNbr as FcstRecFyMthNbr, RDA.FyTagMth as FcstRecFyMthTag, Week as FcstTrgtWk, iq1.FyMthNbr as FcstTrgtFyMthNbr, iq1.FyTagMth as FcstTrgtFyMthTag From(
	Select  FcstParty, SalesOrg, DistrChannel, CustMat, Material, Week, FyMthNbr,FyTagMth, FcastReceivedDt, [Time], FcastReceived, FcastOverwrite, FcastAmendedFig From #temp2) as iq1
	left outer join #Map on iq1.Material = #Map.Material
	left outer join CentralDbs.dbo.RefDateAvnet as RDA on Cast(RDA.DateDt as date) = Cast(FcastReceivedDt as date)
	left outer join Mdm.dbo.CustNames on Cast(FcstParty as bigint) = Cast(SapPartyId as bigint)
	left outer join CentralDbs.dbo.SapPartsList on iq1.Material = SapPartsList.MaterialNbr
	Where SapPartsList.MatHubState<>-1 and SendToSapFl = 'Y'
	--) as iq2

	Truncate Table CentralDbs.dbo.FcstByMthRaw 

	Insert Into CentralDbs.dbo.FcstByMthRaw 
	Select FcstParty, FcstPartyNm, SalesOrg, DistChnl, CustMat, Material, Mfg, MfgPartNbr, Sum(RawFcstQty) as RawFcstQty, Map, FcstRecFyMthNbr, FcstRecFyMthTag, FcstTrgtFyMthNbr, FcstTrgtFyMthTag From CentralDbs.dbo.LastFcstMth
	Where FcstRecFyMthNbr+1=FcstTrgtFyMthNbr
	Group by FcstParty, FcstPartyNm, SalesOrg, DistChnl, CustMat, Material, Mfg, MfgPartNbr, ScrubPrcnt, Map, FcstRecFyMthNbr, FcstRecFyMthTag, FcstTrgtFyMthNbr, FcstTrgtFyMthTag