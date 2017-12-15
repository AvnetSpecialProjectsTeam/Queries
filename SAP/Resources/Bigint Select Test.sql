--Robert's Code 
--Use with Caution

Select [Column 34], Try_cast([Column 34] as bigint), Count(*) From NonHaImportTesting.dbo.ImportBsik
Where Try_cast([Column 34] as bigint) is null 
Group by [Column 34] 



Select [Column 138], Try_cast([Column 138] as bigint), Count(*) From NonHaImportTesting.dbo.ImportEban Where Try_cast([Column 138] as bigint) is null Group by [Column 138] 




