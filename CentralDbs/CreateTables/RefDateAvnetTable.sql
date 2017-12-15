USE [CentralDbs]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP TABLE  dbo.RefDateAvnet
GO

CREATE TABLE dbo.RefDateAvnet(
    [DateDt] [datetime2](7) NOT NULL,
	[DateTxt] [varchar](50) NULL,
	[DateTxt2] [varchar](50) NULL,
	[Dow] [varchar](50) NULL,
	[DayNbr] [int] NULL,
	[WkNbr] [int] NULL,
	[FyMthNbr] [int] NULL,
	[FyYyyy] [int] NULL,
	[FyYy] [varchar](50) NULL,
	[FyMth] [varchar](50) NULL,
	[FyEomDt] [datetime2](7) NULL,
	[FyTagYr] [varchar](255) NULL,
	[FyTagMth] [varchar](255) NULL,
	[BusDay] [int] NULL,
	[BusDay99] [int] NULL,
	[BusDayNbr] [int] NULL,
	[LastBusNbr] [int] NULL,
	[LastBusDt] [datetime2](7) NULL,
	[UsaEvent] [varchar](255) NULL,
	[FisWk] [int] NULL,
	[FyYyyyWw] [int] NULL,
	[FisWk2] [varchar](255) NULL,
	[FyYyyyMm] [int] NULL,
	[FyYyyyQtr] [int] NULL,
	[FyQtr] [int] NULL,
	[FyBomDt] [datetime2](7) NULL,
	[BowDt] [datetime2](7) NULL,
	[SapDt] [varchar](255) NULL,
	[DateTxt3] [varchar](255) NULL,
	[CalWkNbr] [int] NULL,
	[CalWktxt] [varchar](255) NULL,
	[FyMm] [varchar](255) NULL
 ) ON [PRIMARY]

GO