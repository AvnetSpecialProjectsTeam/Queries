USE Interfaces
GO

/****** Object:  Table [dbo].[PurchOrdItemComp]    Script Date: 11/2/2017 2:41:13 PM ******/
ALTER TABLE [dbo].[PurchOrdItemComp] SET ( SYSTEM_VERSIONING = OFF  )
GO

/****** Object:  Table [dbo].[PurchOrdItemComp]    Script Date: 11/2/2017 2:41:13 PM ******/
DROP TABLE [dbo].[PurchOrdItemComp]
GO

/****** Object:  Table [dbo].[PurchOrdItemCompHistory]    Script Date: 11/2/2017 2:41:13 PM ******/
DROP TABLE [dbo].[PurchOrdItemCompHistory]
GO

/****** Object:  Table [dbo].[PurchOrdItemCompHistory]    Script Date: 11/2/2017 2:41:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PurchOrdItemCompHistory](
	[PoNbr] [bigint] NOT NULL,
	[PoLine] [int] NOT NULL,
	[PoCmpIdLine] [bigint] NOT NULL,
	[ComponentQt] [int] NULL,
	[ApplCreateDt] [datetime2](7) NULL,
	[ApplUpdateDt] [datetime2](7) NULL,
	[ApplActiveFromDt] [datetime2](7) NULL,
	[ApplActiveThruDt] [datetime2](7) NULL,
	[SqlStartTime] [datetime2](7) NOT NULL,
	[SqlEndTime] [datetime2](7) NOT NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[PurchOrdItemComp]    Script Date: 11/2/2017 2:41:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PurchOrdItemComp](
	[PoNbr] [bigint] NOT NULL,
	[PoLine] [int] NOT NULL,
	[PoCmpIdLine] [bigint] NOT NULL,
	[ComponentQt] [int] NULL,
	[ApplCreateDt] [datetime2](7) NULL,
	[ApplUpdateDt] [datetime2](7) NULL,
	[ApplActiveFromDt] [datetime2](7) NULL,
	[ApplActiveThruDt] [datetime2](7) NULL,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PkPurchOrdItemComp] PRIMARY KEY CLUSTERED 
(
	[PoNbr] ASC,
	[PoLine] ASC,
	[PoCmpIdLine] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[PurchOrdItemCompHistory] )
)

GO


