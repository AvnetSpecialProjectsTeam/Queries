
TRUNCATE TABLE SAP.dbo.Ztptp384ForMat


INSERT INTO SAP.dbo.Ztptp384ForMat
	(
		[Client]
      ,[Plant]
      ,[MaterialNbr]
      ,[ForecastModel]
      ,[CreatedOnDt]
      ,[CreatedTime]
      ,[Msg]
	  )
  SELECT 
		[Column 0]
      ,[Column 1]
      ,[Column 2]
      ,[Column 3]
      ,[Column 4]
      ,STUFF(STUFF([Column 5],5,0,':'),3,0,':')
	  ,[Column 6]
  FROM [NonHaImportTesting].[dbo].[ImportZtptp384ForMat]

  TRUNCATE TABLE [NonHaImportTesting].[dbo].[ImportZtptp384ForMat]