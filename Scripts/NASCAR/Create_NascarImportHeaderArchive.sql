USE [NascarProd]
GO

/****** Object:  Table [dbo].[NascarImportHeaderArchive]    Script Date: 10/2/2017 3:07:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NascarImportHeaderArchive](
	[NASCAR_BATCH_IMPORT_ID] [float] NOT NULL,
	[BATCH_STATUS_CD] [nvarchar](5) NOT NULL,
	[IMPORT_DT] [datetime2](7) NOT NULL,
	[EXPORT_LINE_QT] [float] NOT NULL,
	[READ_FL] [nvarchar](1) NOT NULL,
	[APPL_CREATE_DT] [datetime2](7) NOT NULL,
	[APPL_UPDATE_DT] [datetime2](7) NOT NULL
) ON [PRIMARY]

GO


