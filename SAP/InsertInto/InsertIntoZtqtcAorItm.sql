DECLARE @cnt INT=0
DECLARE @sql NVARCHAR(1000)=
							'UPDATE ImportZtqtcAorItm
								SET [Column ' + CAST(@cnt AS VARCHAR)+']=
									CASE
										WHEN [Column ' + CAST(@cnt AS VARCHAR)+'] ='''' THEN NULL
										ELSE [Column ' + CAST(@cnt AS VARCHAR)+']
										END'
WHILE @cnt <22
BEGIN

EXEC(@sql)
	SET @cnt=@cnt+1
	SET @sql='UPDATE ImportZtqtcAorItm
				SET [Column ' + CAST(@cnt AS VARCHAR)+']=
					CASE
						WHEN [Column ' + CAST(@cnt AS VARCHAR)+'] ='''' THEN NULL
						ELSE [Column ' + CAST(@cnt AS VARCHAR)+']
						END'
END
			 

TRUNCATE TABLE SAP.dbo.ZtqtcAorItm
GO

INSERT INTO SAP.dbo.ZtqtcAorItm
SELECT * FROM ImportZtqtcAorItm
WHERE [COLUMN 0] IS NOT NULL AND [COLUMN 0] <> ''
GO

TRUNCATE TABLE ImportZtqtcAorItm