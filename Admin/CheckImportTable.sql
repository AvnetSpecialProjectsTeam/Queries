USE [AdminDb]
GO
Create Proc [dbo].[CheckImportTable] @ImportTableName Varchar(50)
As
Begin
DECLARE @cmd NVARCHAR (255)
SET @cmd = 'If (SELECT COUNT(*) From NonHaImportTesting.dbo.' + @ImportTableName + ') = 0  THROW 50000, ''Import Table Was Blank, BAD BAD BAD'', 1'
EXEC sp_executesql @cmd
End

EXEC CheckImportTable 'TableName'


USE [AdminDb]
GO
Create Proc [dbo].[CheckBiImportTable] @ImportTableName Varchar(50)
As
Begin
DECLARE @cmd NVARCHAR (255)
SET @cmd = 'If (SELECT COUNT(*) From Bi.dbo.' + @ImportTableName + ') = 0  THROW 50000, ''Import Table Was Blank, BAD BAD BAD'', 1'
EXEC sp_executesql @cmd
End

EXEC CheckBiImportTable 'TableName'