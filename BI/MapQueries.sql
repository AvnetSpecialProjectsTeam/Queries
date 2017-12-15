
INSERT INTO OPENQUERY(AVD12,'SELECT MaterialNbr, Map FROM EVOLVE.Moving_Average_price')
(MaterialNbr, [Map])
SELECT[MatNbr] AS MaterialNbr
		,CAST([Map] AS NUMERIC(15,5)) AS Map
FROM [SAP].[dbo].[Map]


SELECT*
FROM
OPENQUERY(AVD12,'SELECT MaterialNbr, Map FROM EVOLVE.Moving_Average_price')



EXEC ('BEGIN EVOLVE.MOV_AVG_TRUNCATE(); end;') AT AVD12
