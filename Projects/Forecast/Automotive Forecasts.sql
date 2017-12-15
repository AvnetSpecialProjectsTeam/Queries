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
	[FcastReceived] [decimal](15, 3) NULL
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
	ForecastRank int
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
Go

-- Version 4, Rank Over Partition For Lastest At A Week Level Before Join
Truncate Table #temp
Truncate Table #temp2
--Runtime of 6 minutes 41 seconds
Insert Into #temp 
Select  FcstParty, SalesOrg, DistrChannel, CustMat, Material,Week, FcastReceivedDt, [Time], FcastReceived
From Sap.dbo.ZfcUploadLog 
Where FcastReceivedDt > '2016-04-01 00:00:00.000' AND (SalesOrg = 'U001' OR  SalesOrg = 'C001' OR SalesOrg = 'P001')

--Grabbing Latest Forecast and 2nd Latest Forecast By Key (FcstParty, CustMat, Material)
--Select * Into CentralDbs.dbo.LastTwoFcst From( 
Truncate Table CentralDbs.dbo.LastTwoFcst
Insert Into CentralDbs.dbo.LastTwoFcst
Select FcstParty, SalesOrg, DistrChannel, CustMat, Material,Week, FyMthNbr, FyTagMth, FcastReceivedDt, [Time], FcastReceived, ForecastRank1 From (
	Select * From( 
		Select  FcstParty, SalesOrg, DistrChannel, CustMat, Material,Week, FcastReceivedDt, [Time], FcastReceived,
		Rank() Over(Partition By FcstParty, CustMat, Material, Week Order by  FcstParty, CustMat, Material, Week, [FcastReceivedDt] Desc, [Time] Desc) as ForecastRank1
		From #temp) as iq1 
	Where (ForecastRank1 = 1 or ForecastRank1  = 2) and Week > 201616) as iq2 
	Inner join 
		(Select Distinct FyMthNbr,FyTagMth, CalWkNbr, Rank() Over( Partition By CalWkNbr Order by CalWkNbr, FyMthNbr Asc) as Rank1 
		from CentralDbs.dbo.RefDateAvnet Where Cast(DateDt as date) >= Cast(GetDate() as date)) as RefDateAvnetWkMthRelation 
	on iq2.Week = RefDateAvnetWkMthRelation.CalWkNbr 
	Where Rank1 = 1
	--) as iq3


	Select Count(*) from #temp2

 Select CurrentForecast.FcstParty, SapPartyNm01 As FcstNm, CurrentForecast.SalesOrg, CurrentForecast.DistrChannel, CurrentForecast.CustMat, CurrentForecast.Material, Mfg, MfgPartNbr, CurrentForecast.Week, CurrentForecast.FyTagMth, CurrentForecast.FcastReceived As [Current], Case When LastForecast.FcastReceived Is Null Then 0 Else LastForecast.FcastReceived End As [Last] From CentralDbs.dbo.LastTwoFcst as CurrentForecast Left Outer Join CentralDbs.dbo.LastTwoFcst as LastForecast on (CurrentForecast.FcstParty = LastForecast.FcstParty and CurrentForecast.CustMat = LastForecast.CustMat and CurrentForecast.Material = LastForecast.Material and LastForecast.ForecastRank1-1 = CurrentForecast.ForecastRank1 and CurrentForecast.Week = LastForecast.Week) Left Outer Join Mdm.dbo.CustNames on CurrentForecast.FcstParty = CustNames.SapPartyid Left Outer Join CentralDbs.dbo.SapPartsList on SapPartsList.MaterialNbr = CurrentForecast.Material cross join CentralDbs.dbo.RefDateAvnet as RDAT Where CAst(RDAT.DateDt as date)= Cast(GetDate() as date) and RDAT.FyMthNbr+12>=CurrentForecast.FyMthNbr



