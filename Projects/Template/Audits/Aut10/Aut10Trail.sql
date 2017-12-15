SELECT DISTINCT
  Aut10Trail.LogDt
  ,Aut10Trail.LogTime
  ,Aut10Trail.ChgdBy
  ,Aut10Trail.EmpName
  ,T528T.PositShortTxt
  ,CASE WHEN T528T.PositShortTxt Like '%Supply Chain%' THEN 'Supply Chain'
  WHEN T528T.PositShortTxt Like '%Distribution Center%' THEN 'Supply Chain'
  WHEN T528T.PositShortTxt Like '%Specialist Customer Field%' THEN 'Supply Chain'
  WHEN T528T.PositShortTxt Like '%Clerical Associate%' THEN 'Supply Chain'
  WHEN T528T.PositShortTxt Like '%Manager Inplant Store - O%' THEN 'Supply Chain'
  WHEN T528T.PositShortTxt Like '%Product Manager%' THEN 'PS'
  WHEN T528T.PositShortTxt Like '%Specialist Product%' THEN 'PS'
  WHEN T528T.PositShortTxt Like '%Manager Product Pricing%' THEN 'PS'
  WHEN T528T.PositShortTxt Like '%Prod Materials Special%' THEN 'Materials'
  WHEN T528T.PositShortTxt Like '%Material Specialist%' THEN 'Materials'
  WHEN T528T.PositShortTxt Like '%Specialist Material%' THEN 'Materials'
  WHEN T528T.PositShortTxt Like '%Manager Materials%' THEN 'Materials'
  WHEN T528T.PositShortTxt Like '%Customer Serv%' THEN 'CSR'
  WHEN T528T.PositShortTxt Like '%Specialist Customer Suppo%' THEN 'ISR'
  WHEN T528T.PositShortTxt Like '%Sales & Market%' THEN 'ISR'
  WHEN T528T.PositShortTxt Like '%Manager Regional Brand%' THEN 'ISR'
  WHEN T528T.PositShortTxt Like '%Inside Sales%' THEN 'ISR'
  WHEN T528T.PositShortTxt Like '%Representative Sales &%' THEN 'ISR'
  WHEN T528T.PositShortTxt Like '%Sales%' THEN 'Sales'
  WHEN T528T.PositShortTxt Like '%Account Manager%' THEN 'Sales'
  WHEN T528T.PositShortTxt Like 'Manager Design%' THEN 'ADS'
  WHEN T528T.PositShortTxt Like '%Analyst Business%' THEN 'DP'
  WHEN T528T.PositShortTxt Like 'Supervisor Customer Opera%' THEN 'DP'
  WHEN T528T.PositShortTxt Like '% Specialist Internation%' THEN 'DPC'
  WHEN T528T.PositShortTxt Like '%Customer Solutions Progra%' THEN 'Embedded'
  WHEN T528T.PositShortTxt Like '%Customer Warranty Program%' THEN 'Embedded'
  WHEN T528T.PositShortTxt Like '%Peï¿½ï¿½o%' THEN 'Embedded'
  WHEN T528T.PositShortTxt Like '%Production Planner%' THEN 'Embedded'
  WHEN T528T.PositShortTxt Like 'Specialist Sol Suppor%' THEN 'Embedded'
  WHEN T528T.PositShortTxt Like '%Specialist Solution%' THEN 'Embedded'
  WHEN T528T.PositShortTxt Like '%Consultant Solutions Tech%' THEN 'Embedded'
  WHEN T528T.PositShortTxt Like '%Director Non-Franchised M%' THEN 'Embedded'
  WHEN T528T.PositShortTxt Like '%Rep. Return Support I%' THEN 'Embedded'
  WHEN T528T.PositShortTxt Like '%Specialist Return Support%' THEN 'Embedded'
  WHEN T528T.PositShortTxt Like '%Sr. Customer Solutions Pr%' THEN 'Embedded'
  WHEN T528T.PositShortTxt Like '%Sr. Manager Customer Prog%' THEN 'Embedded'
  WHEN T528T.PositShortTxt Like '%Account Relationship%' THEN 'Logistics'
  WHEN T528T.PositShortTxt Like 'Specialist Quote%' THEN 'QBS'
  WHEN T528T.PositShortTxt Like 'Specialist Billing Suppor%' THEN 'Sales Ops'
  WHEN T528T.PositShortTxt Like 'Supervisor Billing Suppor%' THEN 'Sales Ops'
  WHEN T528T.PositShortTxt Like 'Global Operations Manager%' THEN 'Velocity'
  WHEN T528T.PositShortTxt Like 'Manager Customer Oper%' THEN 'Velocity'
  WHEN T528T.PositShortTxt Like 'Global Program Manager%' THEN 'Velocity'
  WHEN T528T.PositShortTxt Like 'Manager Enterprise Data M%' THEN 'Velocity'
  WHEN T528T.PositShortTxt Like 'Sr. Manager Customer Oper%' THEN 'Velocity'
  WHEN T528T.PositShortTxt Like 'Gross Profit Audit Admini%' THEN 'GPA'
  WHEN T528T.PositShortTxt Like 'Manager Gross Profit Admi%' THEN 'GPA'
  WHEN T528T.PositShortTxt Like 'Specialist Gross Profit A%' THEN 'GPA'
  WHEN T528T.PositShortTxt Like 'Customer Buyer/Planner%' THEN 'Def Planner'
  WHEN T528T.PositShortTxt Like '%Rep. Inventory%' THEN 'Logistics'
  WHEN T528T.PositShortTxt Like 'Rep. RMA %' THEN 'Logistics'
  WHEN T528T.PositShortTxt Like 'Specialist Field Warehous%' THEN 'Logistics'
  WHEN T528T.PositShortTxt Like 'Finance Operations Man%' THEN 'Global'
  WHEN T528T.PositShortTxt Like 'Specialist Profit Control%' THEN 'SPC'
  WHEN T528T.PositShortTxt Like '%Default%' THEN 'Other'
  WHEN T528T.PositShortTxt Like '%Intern%' THEN 'Other'
  WHEN T528T.PositShortTxt Like '%Manager Corporate Product%' THEN 'Other'
  WHEN T528T.PositShortTxt Like '%Peï¿½ï¿½o%' THEN 'Embedded'
  WHEN T528T.PositShortTxt Like '%Program Manager%' THEN 'Other'
  WHEN T528T.PositShortTxt Like '%PROM Operator%' THEN 'Other'
  WHEN T528T.PositShortTxt Like '%Rep. Account Relationship%' THEN 'Other'
  WHEN T528T.PositShortTxt Like 'Specialist Inplant Store%' THEN 'Other'
  WHEN T528T.PositShortTxt Like 'Specialist Online Custom%' THEN 'Other'
  WHEN T528T.PositShortTxt Like '%Unknown%' THEN 'Other'
  ELSE 'N/A-Unknown'
  END AS [Role]
  --,PositionRole.[Role]
  ,Aut10Trail.TableField
  ,Aut10Trail.FieldLabel
  ,Aut10Trail.OldVal
  ,Aut10Trail.NewVal
  ,Aut10Trail.ObjVal
  ,Aut10Trail.ChgNbr
  ,Aut10Trail.DataRecord
  ,Aut10FieldRef.Type
  ,Aut10Trail.SqlStartTime
FROM Aut10Trail
	LEFT JOIN PA0001 ON CONCAT('00',Aut10Trail.ChgdBy) = PA0001.Personnelnumber
	LEFT JOIN T528T ON PA0001.Position=T528T.Position
	--INNER JOIN PositionRole ON T528T.PositShortTxt=PositionRole.RowLabels
	INNER JOIN Aut10FieldRef ON Aut10Trail.FieldLabel=Aut10FieldRef.FieldLabel
WHERE Aut10Trail.DataRecord='changed' AND PA0001.EndDate>CAST(GETDATE() AS DATE) AND PA0001.StartDate<=CAST(GETDATE() AS DATE)
ORDER BY PositShortTxt, [Role]