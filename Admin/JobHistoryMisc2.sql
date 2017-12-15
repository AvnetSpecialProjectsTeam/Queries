CREATE TABLE #tmpTableSizes
(
    tableName varchar(100),
    numberofRows varchar(100),
    reservedSize varchar(50),
    dataSize varchar(50),
    indexSize varchar(50),
    unusedSize varchar(50)
)
Declare @TableNm  varchar(50);
set @TableNm = 'ZfcUploadLog';
Declare @command1 as nvarchar(500)
--Set @command1 = '"EXEC sp_spaceused ''ZfcUploadLog''"'
--Set @command1 = '""EXEC sp_spaceused '''+ @TableNm + '''""'
Set @command1 = Concat('""" sp_spaceused ''', @TableNM, '''"""')
insert #tmpTableSizes
--EXEC sp_MSforeachtable @command1;
Exec @command1
Select * From #tmpTableSizes

insert #tmpTableSizes
--EXEC sp_MSforeachtable "EXEC sp_spaceused 'ZfcUploadLog'"
EXEC sp_spaceused 'ZfcUploadLog'
Select * From #tmpTableSizes