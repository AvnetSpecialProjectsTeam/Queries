--CREATE MOVING AVERAGE PRICE --KRISA CROSS 



--SUM STOCK OF MBEW 
DROP TABLE #Map1SumStock
GO
USE SAP
GO
SELECT * INTO #Map1SumStock 
FROM (SELECT  dbo.Mbew.Material, Sum(dbo.Mbew.TtlValStk) AS TtlValStk, Sum(dbo.Mbew.ValTtlValStk) AS ValTtlValStk
FROM dbo.Mbew
GROUP BY dbo.Mbew.Material, dbo.Mbew.ValTtlValStk, dbo.Mbew.TtlValStk
HAVING (dbo.Mbew.TtlValStk<>0) AND (dbo.Mbew.ValTtlValStk<>0)) AS subquery1
GO


--MBEW MAP
DROP TABLE #Map2MbewMap
GO
USE CentralDbs
GO
SELECT * INTO #Map2MbewMap
FROM (SELECT Material, [ValTtlValStk]/[TtlValStk] AS Map
FROM #Map1SumStock) AS subquery2
Go


--EBEW STOCK SUM 
DROP TABLE #Map3SumEbew
GO
USE SAP
GO
SELECT * INTO centralDbs.dbo.#Map3SumEbew
FROM (SELECT DISTINCT dbo.Ebew.Material, Sum(dbo.Ebew.TtlValStk) AS TtlValStk, Sum(dbo.Ebew.ValTtlValStk) AS ValTtlValStk
FROM dbo.Ebew
GROUP BY dbo.Ebew.Material, dbo.Ebew.TtlValStk, dbo.Ebew.ValTtlValStk
HAVING (dbo.Ebew.TtlValStk<>0) AND (dbo.Ebew.ValTtlValStk<>0)) AS subquery3
Go


--EBEW MAP
DROP TABLE #Map4EbewMap
GO
USE CentralDbs
GO
SELECT * INTO  #Map4EbewMap
FROM (SELECT #Map3SumEbew.Material, [ValTtlValStK]/[TtlValStK] AS Map
FROM #Map3SumEbew) AS subquery4



--UNION MAP
TRUNCATE TABLE centraldbs.dbo.Map
GO
INSERT INTO centraldbs.dbo.Map(Material,Map)
SELECT * FROM #Map2MbewMap
UNION ALL select * FROM #Map4EbewMap;
GO



--CREATE MAP TABLE 
USE CentralDbs
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP TABLE centraldbs.dbo.Map
GO
CREATE TABLE centraldbs.dbo.Map(
	MaterialNbr Bigint,
	map money)
 ON [PRIMARY]

