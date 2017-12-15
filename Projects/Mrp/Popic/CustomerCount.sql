SELECT Material ,COUNT(DISTINCT TRY_CAST(CustNbr AS BIGINT)) CountOfCustomers
--INTO #A
FROM CentralDbs.dbo.BookBill AS Bb
	INNER JOIN 
		(
		SELECT DISTINCT Rda.FyMthNbr
		FROM CentralDbs.dbo.RefDateAvnet AS Rda
			INNER JOIN 
			(SELECT DISTINCT FyMthNbr
			FROM CentralDbs.dbo.RefDateAvnet AS Rda
			WHERE CAST(rda.DateDt AS DATE)= CAST(GETDATE() AS DATE)) AS Rda1
			ON Rda.FyMthNbr>=Rda1.FyMthNbr-6 AND Rda.FyMthNbr<=rda1.FyMthNbr-1
		) AS Rda
		ON Bb.FyMnthNbr=Rda.FyMthNbr
GROUP BY Material
ORDER BY COUNT(DISTINCT TRY_CAST(CustNbr AS BIGINT)) Desc

SELECT *
FROM #A
	LEFT JOIN
		(SELECT MaterialNbr, SUM(SchedLineValue) AS PoVal
		FROM BI.dbo.BIPoBacklog AS Pobl
		GROUP BY MaterialNbr) AS Pobl
		ON #A.Material=Pobl.MaterialNbr
	LEFT JOIN
		(SELECT MaterialNbr, SUM(TtlOrderValue) AS SoVal
		FROM Bi.dbo.SoBacklog AS Sobl
		GROUP BY MaterialNbr) AS Sobl
		ON #A.Material=Sobl.MaterialNbr
	LEFT JOIN 
		(SELECT Di.MaterialNbr, SUM(Di.TtlStkValue) AS invVal
		FROM Bi.dbo.DailyInv AS Di
		WHERE Di.TtlStkValue>0
		GROUP BY Di.MaterialNbr
		) AS DI
	ON #A.Material=Di.MaterialNbr
ORDER BY CountOfCustomers DESC

