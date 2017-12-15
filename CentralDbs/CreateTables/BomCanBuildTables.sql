
--BOM CAN BUILD CREATE TABLES STATEMENTS - OWNER KRISTA CROSS 

USE CentralDbs
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
DROP TABLE [dbo].[BomComponents]
GO
CREATE TABLE [dbo].[BomComponents](
	[PrcStgyTla] [nvarchar](12) NULL,
	[MfgPartNbrTla] [nvarchar](160) NULL,
	[MatNbrTla] [nvarchar](15) NULL,
	[Bom] [int] NULL,
	[CompMatNbr] [nvarchar](225) NULL,
	[CompMfgPartNbr] [nvarchar](160) NULL,
	[CompPrcStgy] [nvarchar](12) NULL,
	[MatPricGrp] [nvarchar](2) NULL,
	[Grp] [nvarchar](12) NULL,
	[MatTyp] [nvarchar](16) NULL,
	[Abc] [nvarchar](12) NULL,
	[StkProfile] [nvarchar](12) NULL,
	[LeadTime] [int] NULL,
	[Qty] [decimal](38, 5) NULL,
	[Qas] [bigint] NULL,
	[Qoh] [bigint] NULL,
	[Map] [decimal](38, 5) NULL,
	[BookCost] [decimal](38, 5) NULL,
	[LaborCost] [decimal](38, 5) NULL,
	[BestReplCostQty] [bigint] NULL,
	[ExtCompCost] [decimal](38, 5) NULL,
	[BestReplCost$] [decimal](38, 5) NULL
) ON [PRIMARY]


USE [CentralDbs]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP TABLE [dbo].[BomCanBuild]
GO

CREATE TABLE [dbo].[BomCanBuild](
	[PrcStgy] [nvarchar](12) NULL,
	[MfgPartNbr] [nvarchar](160) NULL,
	[MatNbrTla] [nvarchar](15) NULL,
	[Bom] [int] NULL,
	[Qty] [decimal](38, 5) NULL,
	[StkProfile] [nvarchar](12) NULL,
	[abc] [nvarchar](3) NULL,
	[MatPricGrp] [nvarchar](2) NULL,
	[LeadTime] [int] NULL,
	[BookCost] [decimal](38, 5) NULL,
	[Map] [decimal](38, 5) NULL,
	[ExtCompCost] [decimal] (38, 5) NULL,
	[BestReplCost$] [decimal](38, 5) NULL,
	[LaborCost] [decimal](38, 5) NULL,
    [MissingCost] [nvarchar] (10) NULL,
	[CanBuild] [decimal](38, 5) NULL,
	[grp] [nvarchar](12) NULL
) ON [PRIMARY]

GO


	