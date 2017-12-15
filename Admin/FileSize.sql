Declare @string as nvarchar(1000)
Declare @command as nvarchar(500)
Set @command =  'dir \\cap024prot\EM_SSS\FTP\' + 'DBA.PTP.VEDA.LOAD' + '.txt'
IF Object_ID('tempdb.dbo.#tmp','U') IS Not Null
Drop Table #tmp
CREATE TABLE #tmp(StrData VARCHAR(1000))
INSERT INTO #tmp exec xp_cmdshell @command
SELECT Cast(Cast(Cast(Replace(Replace(Replace(Replace(StrData,' ',''),'1File(s)',''),'bytes',''),',','') as bigint)/1024.0/1024.0 as decimal(15,2)) as varchar(50)) + ' MB' FROM #tmp WHERE StrData LIKE '%bytes'
exec (@String)
