SELECT C.GlobEnter, CH5.Customer AS AccountNbr
FROM
	(SELECT B.GlobEnter, CH4.Customer, CH4.Hglvcust
	FROM
		(SELECT A.GlobEnter, CH3.Customer, CH3.Hglvcust
		FROM 
			(SELECT CH.Customer AS GlobEnter, CH.Hglvcust, CH.ValidFrom, CH.ValidTo
			FROM Knvh AS CH
			INNER JOIN Knvh AS CH2 ON CH.Customer=CH2.Hglvcust
			WHERE CH.ValidFrom<GETDATE() AND CH.ValidTo>GETDATE() AND CH.Hglvcust=' ') AS A
		INNER JOIN Knvh AS CH3 ON A.GlobEnter=CH3.Hglvcust) AS B
	INNER JOIN Knvh AS CH4 ON B.Customer=CH4.Hglvcust) AS C
INNER JOIN Knvh AS CH5 ON C.Customer=CH5.Hglvcust