USE Interfaces
GO

/****** Object:  Table [dbo].[PurchOrdItemSched]    Script Date: 11/2/2017 2:42:49 PM ******/
ALTER TABLE [dbo].[PurchOrdItemSched] SET ( SYSTEM_VERSIONING = OFF  )
GO

/****** Object:  Table [dbo].[PurchOrdItemSched]    Script Date: 11/2/2017 2:42:49 PM ******/
DROP TABLE [dbo].[PurchOrdItemSched]
GO

/****** Object:  Table [dbo].[PurchOrdItemSchedHistory]    Script Date: 11/2/2017 2:42:49 PM ******/
DROP TABLE [dbo].[PurchOrdItemSchedHistory]
GO

/****** Object:  Table [dbo].[PurchOrdItemSchedHistory]    Script Date: 11/2/2017 2:42:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PurchOrdItemSchedHistory](
	[PoNbr] [bigint] NOT NULL,
	[PoLine] [int] NOT NULL,
	[PoSchedLine] [int] NOT NULL,
	[DeliveryDt] [datetime2](7) NULL,
	[ScheduleDt] [datetime2](7) NULL,
	[ScheduleQt] [decimal](15, 3) NULL,
	[ApplCreateDt] [datetime2](7) NULL,
	[ApplUpdateDt] [datetime2](7) NULL,
	[ApplActiveFromDt] [datetime2](7) NULL,
	[ApplActiveThruDt] [datetime2](7) NULL,
	[GoodsReceiptProcessDayQt] [int] NULL,
	[ItemQt] [decimal](15, 3) NULL,
	[GrQt] [decimal](15, 3) NULL,
	[GiQt] [decimal](15, 3) NULL,
	[OpenQt] [decimal](15, 3) NULL,
	[SqlStartTime] [datetime2](7) NOT NULL,
	[SqlEndTime] [datetime2](7) NOT NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[PurchOrdItemSched]    Script Date: 11/2/2017 2:42:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PurchOrdItemSched](
	[PoNbr] [bigint] NOT NULL,
	[PoLine] [int] NOT NULL,
	[PoSchedLine] [int] NOT NULL,
	[DeliveryDt] [datetime2](7) NULL,
	[ScheduleDt] [datetime2](7) NULL,
	[ScheduleQt] [decimal](15, 3) NULL,
	[ApplCreateDt] [datetime2](7) NULL,
	[ApplUpdateDt] [datetime2](7) NULL,
	[ApplActiveFromDt] [datetime2](7) NULL,
	[ApplActiveThruDt] [datetime2](7) NULL,
	[GoodsReceiptProcessDayQt] [int] NULL,
	[ItemQt] [decimal](15, 3) NULL,
	[GrQt] [decimal](15, 3) NULL,
	[GiQt] [decimal](15, 3) NULL,
	[OpenQt] [decimal](15, 3) NULL,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PkPurchOrdItemSched] PRIMARY KEY CLUSTERED 
(
	[PoNbr] ASC,
	[PoLine] ASC,
	[PoSchedLine] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[PurchOrdItemSchedHistory] )
)

GO


