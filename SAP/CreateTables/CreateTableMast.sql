USE SAP
GO

DROP TABLE Mast



CREATE TABLE [dbo].[Mast](
	[Client] [varchar](4) ,
	[Material] [decimal](18, 0),
	[Plant] [varchar](5),
	[BomUsage] [varchar](2),
	[Bom] [varchar](9),
	[BomAlt] [varchar](3),
	[FromLotSize] [decimal](13, 3) ,
	[ToLotSize] [decimal](13, 3) ,
	[CreatedOn] [varchar](9) ,
	[CreatedBy] [varchar](13) ,
	[ChangedOn] [varchar](9) ,
	[ChangedBy] [varchar](13) ,
	[ConfigMat] [varchar](2) ,
PRIMARY KEY CLUSTERED 
(
	[Client] ASC,
	[Material] ASC,
	[Plant] ASC,
	[BomUsage] ASC,
	[BOM] ASC,
	[BomAlt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


