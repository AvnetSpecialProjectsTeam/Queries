/****** Script for SelectTopNRows command from SSMS  ******/
update t1
set t1.COMMENTS = concat(t1.COMMENTS,'|N-BILL: ','SO#:',t2.SalesDoc,', Qty',t2.Qty,', Value:',t2.OrderValue,', ExtResale:',t2.ExtResale,', ExtCost:',t2.ExtCost,', EndCust:',t2.EndCust)
from
(select REPLACE(LTRIM(REPLACE(RIGHT(SOLD_TO_CUST,10), 0, ' ')), ' ', 0)  as SOLD_TO_CUST,
REPLACE(LTRIM(REPLACE(RIGHT(SHIP_TO_CUST,10), 0, ' ')), ' ', 0)  as SHIP_TO_CUST,
REPLACE(LTRIM(REPLACE(SAP_MATERIAL_ID, 0, ' ')), ' ', 0)  as MaterialNbr,
COMMENTS
 from NascarExportLineFinal) as t1
 inner join (SELECT *
FROM NascarBillings) as t2 
 on t1.SOLD_TO_CUST=t2.SoldToParty and  t1.MaterialNbr = t2.MaterialNbr

 select * from NascarExportLineFinal