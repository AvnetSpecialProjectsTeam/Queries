--Remove previous comments from nascar to avoid comment getting too big for column
update t1
set t1.COMMENTS =  SUBSTRING(t1.COMMENTS, 1, CHARINDEX('~', t1.COMMENTS) - 1)
from
(select REPLACE(LTRIM(REPLACE(RIGHT(SOLD_TO_CUST,10), 0, ' ')), ' ', 0)  as SOLD_TO_CUST,
REPLACE(LTRIM(REPLACE(RIGHT(SHIP_TO_CUST,10), 0, ' ')), ' ', 0)  as SHIP_TO_CUST,
REPLACE(LTRIM(REPLACE(SAP_MATERIAL_ID, 0, ' ')), ' ', 0)  as MaterialNbr,
COMMENTS
 from NascarExportLineFinal) as t1
 inner join (SELECT SapAgreement, AgreementCreatedBy,AuthorizationNbr,ValidFrom,ValidTo,SoldToParty, ShipToParty,REPLACE(LTRIM(REPLACE(MaterialNbr, 0, ' ')), ' ', 0)  as MaterialNbr, Rate,RemainingQtyVistex,AvnetResale
FROM NascarOpenShipDebit
GROUP BY SapAgreement, AgreementCreatedBy, AuthorizationNbr, ValidFrom, ValidTo, SoldToParty, ShipToParty,MaterialNbr,Rate,RemainingQtyVistex,AvnetResale) as t2 
 on t1.SOLD_TO_CUST=t2.SoldToParty and t1.SHIP_TO_CUST = t2.ShipToParty and t1.MaterialNbr = t2.MaterialNbr

--add information from open shit and debit to nascar 
update t1
set t1.COMMENTS = concat(t1.COMMENTS,'| ~NASCAR: ','AuthNo:',t2.AuthorizationNbr,', ValidTo:',t2.ValidTo,', Rate:',t2.Rate,', Qty:',t2.RemainingQtyVistex,', Resale:',t2.AvnetResale)
from
(select REPLACE(LTRIM(REPLACE(RIGHT(SOLD_TO_CUST,10), 0, ' ')), ' ', 0)  as SOLD_TO_CUST,
REPLACE(LTRIM(REPLACE(RIGHT(SHIP_TO_CUST,10), 0, ' ')), ' ', 0)  as SHIP_TO_CUST,
REPLACE(LTRIM(REPLACE(SAP_MATERIAL_ID, 0, ' ')), ' ', 0)  as MaterialNbr,
COMMENTS
 from NascarExportLineFinal) as t1
 inner join (SELECT SapAgreement, AgreementCreatedBy,AuthorizationNbr,ValidFrom,ValidTo,SoldToParty, ShipToParty,REPLACE(LTRIM(REPLACE(MaterialNbr, 0, ' ')), ' ', 0)  as MaterialNbr, Rate,RemainingQtyVistex,AvnetResale
FROM NascarOpenShipDebit
GROUP BY SapAgreement, AgreementCreatedBy, AuthorizationNbr, ValidFrom, ValidTo, SoldToParty, ShipToParty,MaterialNbr,Rate,RemainingQtyVistex,AvnetResale) as t2 
 on t1.SOLD_TO_CUST=t2.SoldToParty and t1.SHIP_TO_CUST = t2.ShipToParty and t1.MaterialNbr = t2.MaterialNbr


