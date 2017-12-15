
--CREATE CRM RMA TABLE IN CENTRAL DB'S --OWNER KRISTA CROSS 



--CREATE TABLE 
USE [CentralDbs]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP TABLE  dbo.CrmRmaData
GO

CREATE TABLE [dbo].[CrmRmaData](
	[CrmNbr] [bigint] NULL,
	[CrmCreateDt] [nvarchar](50) NULL,
	[RmaNbr] [bigint] NULL,
	[DocNbr] [bigint] NULL,
	[DocTyp] [nvarchar](50) NULL
) ON [PRIMARY]

GO




--INSERT INTO TABLE 
GO
INSERT INTO dbo.CrmRmaData
(CrmNbr, CrmCreateDt, RmaNbr, DocNbr, DocTyp)
SELECT DISTINCT crm_number, crm_create_date, rma_number, doc_number, doc_type
FROM NonHaImportTesting.dbo.CRM_RMA_Report;
GO


