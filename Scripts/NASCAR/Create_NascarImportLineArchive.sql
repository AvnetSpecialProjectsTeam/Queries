USE [NascarProd]
GO

/****** Object:  Table [dbo].[NascarImportLineArchive]    Script Date: 10/2/2017 3:08:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NascarImportLineArchive](
	[NASCAR_BATCH_IMPORT_ID] [float] NOT NULL,
	[QUOTE_ID] [float] NOT NULL,
	[LINE_ITEM_NO] [float] NOT NULL,
	[SAP_MATERIAL_ID] [nvarchar](50) NULL,
	[QUANTITY_1] [float] NULL,
	[QUANTITY_2] [float] NULL,
	[QUANTITY_3] [float] NULL,
	[PRICE_TYPE_1] [nvarchar](100) NULL,
	[PRICE_TYPE_2] [nvarchar](100) NULL,
	[PRICE_TYPE_3] [nvarchar](100) NULL,
	[APPROVED_LT_1] [float] NULL,
	[APPROVED_LT_2] [float] NULL,
	[APPROVED_LT_3] [float] NULL,
	[APPROVED_MIN_1] [float] NULL,
	[APPROVED_MIN_2] [float] NULL,
	[APPROVED_MIN_3] [float] NULL,
	[APPROVED_MULT_1] [float] NULL,
	[APPROVED_MULT_2] [float] NULL,
	[APPROVED_MULT_3] [float] NULL,
	[APPROVED_COST_1] [float] NULL,
	[APPROVED_COST_2] [float] NULL,
	[APPROVED_COST_3] [float] NULL,
	[APPROVED_MO_1] [float] NULL,
	[APPROVED_MO_2] [float] NULL,
	[APPROVED_MO_3] [float] NULL,
	[AUTH] [varchar](1) NOT NULL,
	[APPL_CREATE_DT] [datetime2](7) NOT NULL
) ON [PRIMARY]

GO


