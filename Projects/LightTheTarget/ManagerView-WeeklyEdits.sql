 select * into #Ltt from(select a1.*,a2.Aged_0_7_Days,a3.Aged_7_14_Days,a4.Aged_14_21_Days,
        a5.Aged_21_30_Days,a6.Aged_30_Plus_Days from
  (select distinct EmployeeNbr,CustNbr from ActionsList) as a1
  left join
 ( select EmployeeNbr,CustNbr,count(*) as Aged_0_7_Days from LightTheTarget..ActionsList
  where DaysonFile <= 7
   group by EmployeeNbr,CustNbr) as a2
   on a1.EmployeeNbr = a2.EmployeeNbr and a1.CustNbr=a2.CustNbr
   left join
   ( select EmployeeNbr,CustNbr,count(*) as Aged_7_14_Days from LightTheTarget..ActionsList
  where DaysonFile > 7 and DaysonFile <=14
   group by EmployeeNbr,CustNbr) as a3
   on a1.EmployeeNbr =a3.EmployeeNbr and a1.CustNbr =a3.CustNbr
   left join
   ( select EmployeeNbr,CustNbr,count(*) as Aged_14_21_Days from LightTheTarget..ActionsList
  where DaysonFile > 14 and DaysonFile <=21
   group by EmployeeNbr,CustNbr) as a4
   on a1.EmployeeNbr =a4.EmployeeNbr and a1.CustNbr =a4.CustNbr
    left join
   ( select EmployeeNbr,CustNbr,count(*) as Aged_21_30_Days from LightTheTarget..ActionsList
  where DaysonFile > 21 and DaysonFile <=30
   group by EmployeeNbr,CustNbr) as a5
   on a1.EmployeeNbr =a5.EmployeeNbr and a1.CustNbr =a5.CustNbr
    left join
   ( select EmployeeNbr,CustNbr,count(*) as Aged_30_Plus_Days from LightTheTarget..ActionsList
  where DaysonFile > 30
   group by EmployeeNbr,CustNbr) as a6
   on a1.EmployeeNbr =a6.EmployeeNbr and a1.CustNbr =a6.CustNbr) as qry

   Update #Ltt
   Set Aged_0_7_Days = 0
   where Aged_0_7_Days is null

   Update #Ltt
   Set Aged_7_14_Days = 0
   where Aged_7_14_Days is null

   Update #Ltt
   Set Aged_14_21_Days = 0
   where Aged_14_21_Days is null

   Update #Ltt
   Set Aged_21_30_Days = 0
   where Aged_21_30_Days is null

   Update #Ltt
   Set Aged_30_Plus_Days = 0
   where Aged_30_Plus_Days is null

   truncate table LightTheTarget..ManagerReporting
   insert into LightTheTarget..ManagerReporting 
   select b2.EmployeeName,b2.SupervisorName,B2.LeadershipName,b1.CustNbr,
   Sum(b1.Aged_0_7_Days) as Aged_0_7_Days, 
   sum(b1.Aged_7_14_Days) as Aged_7_14_Days,
   sum(b1.Aged_14_21_Days) as Aged_14_21_Days,
   sum(b1.Aged_21_30_Days) as Aged_21_30_Days,
   sum(b1.Aged_30_Plus_Days) as Aged_30_Plus_Days from
  (select * from #Ltt)  as b1
   left join
   (Select REPLACE(LTRIM(REPLACE(EmployeeAvnetId, '0', ' ')), ' ', '0') as EmpId,
   EmployeeName,SupervisorName,LeadershipName from CentralDbs..EmployeeHierarchy) as b2
   on REPLACE(LTRIM(REPLACE(b1.EmployeeNbr, '0', ' ')), ' ', '0') = b2.EmpId
   group by
   b2.EmployeeName,b2.SupervisorName,B2.LeadershipName,b1.CustNbr

  