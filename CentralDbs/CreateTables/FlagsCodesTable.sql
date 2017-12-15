USE [CentralDbs]
GO

/****** Object:  Table [dbo].[SapFlagsCodes]    Script Date: 9/26/2017 1:26:12 PM ******/
DROP TABLE [dbo].[SapFlagsCodes]
GO

/****** Object:  Table [dbo].[SapFlagsCodes]    Script Date: 9/26/2017 1:26:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SapFlagsCodes](
	RowIdObject [bigint] NOT NULL,
	MaterialNbr [bigint] NOT NULL,
	SapPlantCd [varchar](16) NOT NULL,
	Ecomm [varchar](4) NULL,
	WebSellable [varchar](4) NULL,
	Xstatus [varchar](8) NULL,
	AbcCd [varchar](12) NULL,
	SapStockingProfile [varchar](12) NULL,
	Ncnr [varchar](4) NULL
) ON [PRIMARY]

GO


ALTER TABLE SapFlagsCodes
ADD CONSTRAINT PkMatNbrPlnt PRIMARY KEY (MaterialNbr,SapPlantCd)

