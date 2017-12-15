USE [NascarStaging]
GO

/****** Object:  Table [dbo].[NascarExportHeaderStaging]    Script Date: 10/2/2017 11:39:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NascarExportHeaderStaging](
	[NASCAR_BATCH_EXPORT_ID] [float] NOT NULL,
	[BATCH_STATUS_CD] [nvarchar](5) NOT NULL,
	[EXPORT_DT] [datetime2](7) NOT NULL,
	[EXPORT_LINE_QT] [float] NOT NULL,
	[READ_FL] [nvarchar](1) NOT NULL,
	[APPL_CREATE_DT] [datetime2](7) NOT NULL,
	[APPL_UPDATE_DT] [datetime2](7) NOT NULL
) ON [PRIMARY]

GO


