SELECT SAP.dbo.ZfcCustomer.FcstParty, SAP.dbo.ZfcCustomer.RespUser, ContactFirstNm, ContactLastNm, SapPartyNm01, Position, FormattedNameofEmployeeorApplicant, SupervisorArea
FROM     SAP.dbo.ZfcCustomer 
		INNER JOIN
					SAP.dbo.ZtqtcCmir ON CAST(SAP.dbo.ZtqtcCmir.CustNbr AS bigint) = SAP.dbo.ZfcCustomer.FcstParty
		Left Outer JOIN
					Mdm.dbo.EmplNames on EmplNames.SapPartyId = Cast(RespUser as int)
		Left Outer Join Sap.dbo.Pa0001 on Cast(PersonnelNumber as bigint) = Cast(RespUser as bigint)
WHERE  (SAP.dbo.ZfcCustomer.RespUser <> '003089') AND (SAP.dbo.ZtqtcCmir.ScmFl = 'X') AND (SAP.dbo.ZfcCustomer.RespUser <> 'CMRUN') AND (SAP.dbo.ZfcCustomer.RespUser <> 'C14951') AND (ZfcCustomer.SalesOrg = 'U001' Or ZfcCustomer.SalesOrg = 'C001') AND (Pa0001.EndDate = '9999-12-31 00:00:00.0000000')
GROUP BY SAP.dbo.ZfcCustomer.FcstParty, SAP.dbo.ZfcCustomer.RespUser, ContactFirstNm, ContactLastNm, SapPartyNm01, Position, FormattedNameofEmployeeorApplicant, SupervisorArea

SELECT Employee.Personnelnumber As EmployeeAvnetId, EmployeePositionText.PositShortTxt As EmployeePosition, Employee.FormattedNameofEmployeeorApplicant as EmployeeName, Supervisor.Personnelnumber AS SupervisorAvnetId, 
                  SupervisorPositionText.PositShortTxt AS SupervisorPosition, Supervisor.FormattedNameofEmployeeorApplicant AS SupervisorName, Leadership.Personnelnumber AS LeadershipAvnetId, 
                  LeadershipPositionText.PositShortTxt AS LeadershipPosition, Leadership.FormattedNameofEmployeeorApplicant AS LeadershipName
FROM     SAP.dbo.Pa0001 AS Employee LEFT OUTER JOIN
                  SAP.dbo.Pa0001 AS Supervisor ON Cast(Employee.SupervisorArea as bigint) = Cast(Supervisor.Personnelnumber as bigint) LEFT OUTER JOIN
                  SAP.dbo.Pa0001 AS Leadership ON Cast(Supervisor.SupervisorArea as bigint) = Cast(Leadership.Personnelnumber as bigint) LEFT OUTER JOIN
                  SAP.dbo.T528T AS EmployeePositionText ON EmployeePositionText.Position = Employee.Position LEFT OUTER JOIN
                  SAP.dbo.T528T AS SupervisorPositionText ON SupervisorPositionText.Position = Supervisor.Position LEFT OUTER JOIN
                  SAP.dbo.T528T AS LeadershipPositionText ON LeadershipPositionText.Position = Leadership.Position
WHERE  (Employee.EndDate = '9999-12-31 00:00:00.0000000') AND (Supervisor.EndDate = '9999-12-31 00:00:00.0000000' OR
                  Supervisor.EndDate IS NULL) AND (Leadership.EndDate = '9999-12-31 00:00:00.0000000' OR
                  Leadership.EndDate IS NULL) AND Employee.Personnelnumber Like '00%'


 
