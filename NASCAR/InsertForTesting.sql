insert into NascarExportHeader(NASCAR_BATCH_EXPORT_ID,BATCH_STATUS_CD,EXPORT_DT,EXPORT_LINE_QT,READ_FL,APPL_CREATE_DT,APPL_UPDATE_DT)
values
	(11111,'R','2017-09-25 16:00:33.0000000',1,'N','2017-09-25 16:15:02.0000000','2017-09-25 22:15:00.0000000'),
	(21111,'R','2017-09-25 16:00:33.0000000',1,'N','2017-09-25 16:15:02.0000000','2017-09-25 22:15:00.0000000'),
	(31111,'R','2017-09-25 16:00:33.0000000',1,'N','2017-09-25 16:15:02.0000000','2017-09-25 22:15:00.0000000'),
	(41111,'R','2017-09-25 16:00:33.0000000',1,'N','2017-09-25 16:15:02.0000000','2017-09-25 22:15:00.0000000')
	

insert into NascarExportLineFinal(NASCAR_BATCH_EXPORT_ID,QUOTE_ID,SOLD_TO_CUST,SHIP_TO_CUST,LINE_ITEM_NO,SAP_MATERIAL_ID,LINE_ITEM_STATUS,AUTH_REQ,APPROVED_COST_1,APPROVED_LT_1,QUANTITY_1,BOOK_COST_1,SUPPLIER_LEAD_TIME,NASCAR_EXP_DT,IMPORT_ERROR,APPL_CREATE_DT,AUTH)
values
	(11111,211111,'1000000','50033654',1,'00010000123','P','DEL',NULL,NULL,1,.02,12,'2017-09-21 21:00:24.0000000',NULL,'2017-09-21 21:00:24.0000000','P'),
	(21111,211111,'1000000','TEST 00111111',1,'00000001000164','P','DEL',NULL,NULL,1,.01,12,'2017-09-21 21:00:24.0000000',NULL,'2017-09-21 21:00:24.0000000','P'),
	(31111,211111,'1000000','TEST 00111111',1,'000010008044','P','DEL',NULL,NULL,3,10000,12,'2017-09-21 21:00:24.0000000',NULL,'2017-09-21 21:00:24.0000000','P'),
	(41111,211111,'1000000','TEST 00111111',1,'000010008295','P','DEL',NULL,NULL,2,15000,12,'2017-09-21 21:00:24.0000000',NULL,'2017-09-21 21:00:24.0000000','P')

	select comments from NascarExportLineFinal

	Update NascarMaterialThresholdValue
	set ThresholdValue = 50000
	Where MaterialNbr = 9876 
truncate table NascarMaterialThresholdValue
truncate table NascarMaterialThresholdValueHistory 
Insert into NascarMaterialThresholdValue (MaterialNbr,ThresholdValue)
values(435222,0)
select * From NascarMaterialThresholdValue
select * from NascarExportLine
select * from NascarExportLineFinal
truncate table [Nascar].[dbo].NascarExportHeader
truncate table [Nascar].[dbo].NascarExportLine
truncate table [NascarProd].[dbo].NascarExportLineFinal

-- Check to see if current value for line is greater than Threshold Value. If it is greater than threshold value flag to product(EX. If threshold value is set to 0 and line item value is .003, flag that to product)
Update t1
SET t1.AUTH = 'P'
FROM (SELECT 
      REPLACE(LTRIM(REPLACE([SAP_MATERIAL_ID], '0', ' ')), ' ', '0') as SAP_MATERIAL_ID,
      AUTH,
	  Val1,
	  Val2,
	  Val3
  FROM [Nascar].[dbo].[NascarExportLineFinal]) as t1
inner join NascarMaterialThresholdValue as t2
on  t1.SAP_MATERIAL_ID = t2.MaterialNbr 
where t1.Val1 > t2.ThresholdValue

Update t1
SET t1.AUTH = 'N'
FROM NascarExportLineFinal as t1
inner join NascarMaterialThresholdValue as t2
on  t1.SAP_MATERIAL_ID = t2.MaterialNbr 
where t1.Val1 < t2.ThresholdValue


truncate table NascarExportHeader
truncate table NascarExportLine