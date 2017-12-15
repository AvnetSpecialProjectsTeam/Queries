--Creator: Robert Kebert

USE AdminDb

--DROP PROC RunLog

--Procedure to write date to Run Log File
CREATE PROC RunLog @JobName VARCHAR(50)
AS
Begin
DECLARE @date AS DATETIME2 = GETDATE()
DECLARE @String AS NVARCHAR(1000)
--Creates a string of the command echo Date to a file location
--Will write the current date and time to the file location of the stored procedure parameter
SET @STRING='echo ' + CAST(@date AS nvarchar(30))+ '>> \\corpshare\sss\Materials_Reporting\Reports_HQ\Run_Log_Files\'+@JobName+'.txt'

exec master..xp_cmdshell @String
END;

--Test of the RunLog Stored Procedure
EXEC AdminDb.dbo.RunLog 'SapZtptp384ForMat'




--Procedure to Check if RunLog File was modified today
Create Proc CheckRunLog @RunLogFileName Varchar(50)
As
Begin
Declare @string as nvarchar(1000)
Declare @command as nvarchar(500)
--Creates a string of the directory of the file to check if it was modified today
Set @command =  'dir \\CORPSHARE\EMgroups\SSS\Materials_Reporting\Reports_HQ\Run_Log_Files\' + @RunLogFileName + '.txt'

--Creates a temp table to store the file information of the stored procedure paramater
CREATE TABLE #tmp(StrData VARCHAR(1000))
INSERT INTO #tmp exec xp_cmdshell @command
--Only select the record with /'s which has the date information
SELECT * FROM #tmp WHERE StrData LIKE '%/%/%'
exec (@String)

--If it finds a record with a valid date, then it returns success, otherwise returns an error
IF EXISTS (SELECT * FROM #tmp WHERE StrData LIKE '%/%/%' and StrData LIKE Cast(Format(getDate(),'MM/dd/yyyy','en-US') as varchar(10)) + '%')
BEGIN
Select 'Works'
End
Else
Begin
raiserror('Oh no a fatal error', 20, -1) with log
End
End

exec AdminDb.dbo.CheckRunLog 'SqlPopicExport'


--Procedure to Check if Trigger File was modified today
Create Proc CheckTriggerFile @TriggerFileName Varchar(50)
As
Begin
Declare @string as nvarchar(1000)
Declare @command as nvarchar(500)
--Creates a string of the directory of the file to check if it was modified today
Set @command =  'dir \\CORPSHARE\EMgroups\SSS\Materials_Reporting\Reports_HQ\Run_Log_Files\' + @TriggerFileName + '.txt'

--Creates a temp table to store the file information of the stored procedure paramater
CREATE TABLE #tmp(StrData VARCHAR(1000))
INSERT INTO #tmp exec xp_cmdshell @command
--Only select the record with /'s which has the date information
SELECT * FROM #tmp WHERE StrData LIKE '%/%/%'
exec (@String)

--If it finds a record with a valid date, then it returns success, otherwise returns an error
IF EXISTS (SELECT * FROM #tmp WHERE StrData LIKE '%/%/%' and StrData LIKE Cast(Format(getDate(),'MM/dd/yyyy','en-US') as varchar(10)) + '%')
BEGIN
Select 'Win'
End
Else
Begin
raiserror('Oh no a fatal error', 20, -1) with log
End
End

--Test to see if CheckTriggerFile stored procedure worked
exec AdminDb.dbo.CheckTriggerFile 'cdbnmi'




--Creator: Chris Weston
--============================Check if file was modified today==================================
ALTER Proc CheckFile @FilePath Varchar(200), @LoopTimes INT=20, @WaitMinutes INT=5
As
Begin
	Declare @string as nvarchar(1000)
	Declare @command as nvarchar(500)
	DECLARE @Cnt AS INT=0
	DECLARE @WaitTime VARCHAR(10)=''+REPLICATE('0',2-LEN(CAST((@WaitMinutes/60) AS VARCHAR(2))))+CAST((@WaitMinutes/60) AS VARCHAR(2))  + ':' + REPLICATE('0',2-LEN(CAST((@WaitMinutes % 60) AS VARCHAR(2)))) + CAST((@WaitMinutes % 60) AS VARCHAR(2)) + ':00'

	Set @command =  'dir '+ @FilePath

	CREATE TABLE #tmp(StrData VARCHAR(1000))
	INSERT INTO #tmp exec xp_cmdshell @command
	SELECT * FROM #tmp WHERE StrData LIKE '%/%/%'
	exec (@String)

		WHILE @Cnt<@LoopTimes
		BEGIN
			IF EXISTS (SELECT * FROM #tmp WHERE StrData LIKE '%/%/%' and StrData LIKE Cast(Format(getDate(),'MM/dd/yyyy','en-US') as varchar(10)) + '%')
				BEGIN
					Select 'Win'
					BREAK
				END
			ELSE
				WAITFOR DELAY @WaitTime
			SET @cnt=@cnt+1
			IF @cnt=@LoopTimes
				Begin
					raiserror('Oh no a fatal error', 20, -1) with log
				End
		END
End

exec AdminDb.dbo.CheckFile '\\corpshare\sss\Materials_Reporting\Reports_HQ\Run_Log_Files\SqlPopicExport1.txt', 1, 1


