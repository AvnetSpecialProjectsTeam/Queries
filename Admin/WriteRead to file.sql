USE AdminDb




--Procedure to write date to Run Log File
CREATE PROC RunLog @JobName VARCHAR(50)
AS
Begin
DECLARE @date AS DATETIME2 = GETDATE()
DECLARE @String AS NVARCHAR(1000)
SET @STRING='echo ' + CAST(@date AS nvarchar(30))+ '>> \\corpshare\sss\Materials_Reporting\Reports_HQ\Run_Log_Files\'+@JobName+'.txt'

exec master..xp_cmdshell @String
END;

EXEC AdminDb.dbo.RunLog 'SapZtptp384ForMat'



--DROP PROC RunLog

--Procedure to Check if RunLog File was modified today
Create Proc CheckRunLog @RunLogFileName Varchar(50)
As
Begin
Declare @string as nvarchar(1000)
Declare @command as nvarchar(500)
Set @command =  'dir \\CORPSHARE\EMgroups\SSS\Materials_Reporting\Reports_HQ\Run_Log_Files\' + @RunLogFileName + '.txt'

CREATE TABLE #tmp(StrData VARCHAR(1000))
INSERT INTO #tmp exec xp_cmdshell @command
SELECT * FROM #tmp WHERE StrData LIKE '%/%/%'
exec (@String)

IF EXISTS (SELECT * FROM #tmp WHERE StrData LIKE '%/%/%' and StrData LIKE Cast(Format(getDate(),'MM/dd/yyyy','en-US') as varchar(10)) + '%')
BEGIN
Select 'Win'
End
Else
Begin
raiserror('Oh no a fatal error', 20, -1) with log
End
End

--Procedure to Check if Trigger File was modified today
Create Proc CheckTriggerFile @TriggerFileName Varchar(50)
As
Begin
Declare @string as nvarchar(1000)
Declare @command as nvarchar(500)
Set @command =  'dir \\cap024prot\EM_SSS\FTP\' + @TriggerFileName + '.txt'

CREATE TABLE #tmp(StrData VARCHAR(1000))
INSERT INTO #tmp exec xp_cmdshell @command
SELECT * FROM #tmp WHERE StrData LIKE '%/%/%'
exec (@String)

IF EXISTS (SELECT * FROM #tmp WHERE StrData LIKE '%/%/%' and StrData LIKE Cast(Format(getDate(),'MM/dd/yyyy','en-US') as varchar(10)) + '%')
BEGIN
Select 'Win'
End
Else
Begin
raiserror('Oh no a fatal error', 20, -1) with log
End
End


exec AdminDb.dbo.CheckTriggerFile 'DBA.PTP.AUFK_TRIGGER'

exec AdminDb.dbo.CheckRunLog 'cdbnmi'


Declare @string as nvarchar(1000)
Declare @command as nvarchar(500)
Set @command =  'dir \\CORPSHARE\EMgroups\SSS\Materials_Reporting\Reports_HQ\Run_Log_Files\' + @TriggerFileName + '.txt'

CREATE TABLE #tmp(StrData VARCHAR(1000))
INSERT INTO #tmp exec xp_cmdshell @command
SELECT * FROM #tmp WHERE StrData LIKE '%/%/%'
exec (@String)
