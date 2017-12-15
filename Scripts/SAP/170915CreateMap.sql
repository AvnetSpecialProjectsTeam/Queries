USE [SAP]
GO

/****** Object:  Table [dbo].[Map]    Script Date: 9/15/2017 9:06:16 AM ******/
DROP TABLE [dbo].[Map]
GO

/****** Object:  Table [dbo].[Map]    Script Date: 9/15/2017 9:06:16 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Map](
	[MatNbr] [bigint] NOT NULL,
	[Map] [numeric](15, 5) NULL,
PRIMARY KEY CLUSTERED 
(
	[MatNbr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


