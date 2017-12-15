USE Interfaces
GO

/****** Object:  Table [dbo].[LinQtc305Comments]    Script Date: 11/2/2017 2:43:46 PM ******/
ALTER TABLE [dbo].[LinQtc305Comments] SET ( SYSTEM_VERSIONING = OFF  )
GO

/****** Object:  Table [dbo].[LinQtc305Comments]    Script Date: 11/2/2017 2:43:46 PM ******/
DROP TABLE [dbo].[LinQtc305Comments]
GO

/****** Object:  Table [dbo].[LinQtc305CommentsHistory]    Script Date: 11/2/2017 2:43:46 PM ******/
DROP TABLE [dbo].[LinQtc305CommentsHistory]
GO

/****** Object:  Table [dbo].[LinQtc305CommentsHistory]    Script Date: 11/2/2017 2:43:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LinQtc305CommentsHistory](
	[CommentId] [int] NOT NULL,
	[CommentTx] [varchar](max) NOT NULL,
	[CommentTypeId] [int] NOT NULL,
	[CreateDt] [datetime2](7) NOT NULL,
	[CreateUserId] [varchar](30) NULL,
	[PurchaseOrderId] [int] NULL,
	[PurchaseOrderLineNbr] [int] NULL,
	[QuoteId] [int] NULL,
	[QuoteLineNbr] [int] NULL,
	[ApplCreateDt] [datetime2](7) NOT NULL,
	[ApplUpdateDt] [datetime2](7) NOT NULL,
	[ApplActiveFromDt] [datetime2](7) NOT NULL,
	[ApplActiveThruDt] [datetime2](7) NOT NULL,
	[SqlStartTime] [datetime2](7) NOT NULL,
	[SqlEndTime] [datetime2](7) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

/****** Object:  Table [dbo].[LinQtc305Comments]    Script Date: 11/2/2017 2:43:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[LinQtc305Comments](
	[CommentId] [int] NOT NULL,
	[CommentTx] [varchar](max) NOT NULL,
	[CommentTypeId] [int] NOT NULL,
	[CreateDt] [datetime2](7) NOT NULL,
	[CreateUserId] [varchar](30) NULL,
	[PurchaseOrderId] [int] NULL,
	[PurchaseOrderLineNbr] [int] NULL,
	[QuoteId] [int] NULL,
	[QuoteLineNbr] [int] NULL,
	[ApplCreateDt] [datetime2](7) NOT NULL,
	[ApplUpdateDt] [datetime2](7) NOT NULL,
	[ApplActiveFromDt] [datetime2](7) NOT NULL,
	[ApplActiveThruDt] [datetime2](7) NOT NULL,
	[SqlStartTime] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[SqlEndTime] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [PkLinQtc305Comments] PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([SqlStartTime], [SqlEndTime])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[LinQtc305CommentsHistory] )
)

GO


