USE [AdminDb]
GO

/****** Object:  Table [dbo].[JobHistory]    Script Date: 11/17/2017 7:33:08 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[JobHistory](
	[JobNm] [varchar](50) NOT NULL,
	[TableNm] [varchar](50) NOT NULL,
	[StepNm] [varchar](50) NOT NULL,
	[StartDt] [datetime2](7) NOT NULL,
	[EndDt] [datetime2](7) NULL,
	[Duration]  AS (case when [EndDt]>CONVERT([datetime2],'2016-01-01 00:00:00.0000000') then datediff(minute,[StartDt],[EndDt])  end),
	[RecordCount] [bigint] NULL,
	[Size] [bigint] NULL,
	[Status] [varchar](50) NULL,
 CONSTRAINT [PK_JobHistory] PRIMARY KEY CLUSTERED 
(
	[JobNm] ASC,
	[TableNm] ASC,
	[StepNm] ASC,
	[StartDt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[JobHistory]  WITH CHECK ADD  CONSTRAINT [Status_Values] CHECK  (([Status]='Error' OR [Status]='Success'))
GO

ALTER TABLE [dbo].[JobHistory] CHECK CONSTRAINT [Status_Values]
GO


