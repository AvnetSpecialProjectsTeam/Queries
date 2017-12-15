SELECT A3.Object1,A3.InternalChar1, A3.CharValue,A4.CharValue, A4.InternalChar1
FROM Ausp AS A3 LEFT JOIN (SELECT A1.Object1,A1.InternalChar1, A1.CharValue
FROM Ausp As A1 INNER JOIN Ausp AS A2 ON A1.Object1=A2.Object1
WHERE A1.InternalChar1=28 AND A2.InternalChar1=31) AS A4 ON A3.Object1=A4.Object1
WHERE A3.InternalChar1=31


SELECT A1.Object1,A1.InternalChar1, A1.CharValue,A2.CharValue, A2.InternalChar1
FROM Ausp As A1 INNER JOIN Ausp AS A2 ON A1.Object1=A2.Object1
WHERE A1.InternalChar1=28 AND A2.InternalChar1=31


SELECT A1.Object1,A1.InternalChar1, A1.CharValue
FROM Ausp As A1
WHERE Object1 like'%[a-z]%'
ORDER BY Object1


SELECT A1.Object1,A1.InternalChar1, A1.CharValue
FROM Ausp As A1
WHERE A1.CharValue LIKE 'H%'


SELECT A1.Object1,A1.InternalChar1, A1.CharValue
INTO #Ausp1
FROM Ausp As A1

SELECT A1.Object1,A1.InternalChar1, A1.CharValue, M.MaterialNbr
FROM Ausp As A1 INNER JOIN Mseg AS M ON A1.Object1=M.OrdNbr 
WHERE A1.CharValue IS NOT NULL

AND A1.Client=M.Client