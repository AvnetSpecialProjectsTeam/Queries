--insert NASCAR_BATCH_EXPORT into NascarExportHeader
truncate table NascarExportHeader
insert into NascarExportHeader
select * from [AVE92]..[IQUOTE_OWN].[NASCAR_BATCH_EXPORT]
Where READ_FL = 'N';
--insert into NASCAR_BATCH_EXPORT_LINE from NascarExportHeader Header items 
truncate table NascarExportLine
insert into NascarExportLine
select t1.* FROM [AVE92]..[IQUOTE_OWN].[NASCAR_BATCH_EXPORT_LINE] AS t1
  INNER JOIN NascarExportHeader AS t2
  ON t1.NASCAR_BATCH_EXPORT_ID = t2.NASCAR_BATCH_EXPORT_ID ;


update [MDM].[dbo].[NascarExportHeader]
  set READ_FL='N';



 truncate table NascarExportLineFinal
insert into [NascarExportLineFinal] ([NASCAR_BATCH_EXPORT_ID]
      ,[QUOTE_ID]
      ,[LINE_ITEM_NO]
      ,[LINE_ITEM_STATUS]
      ,[SOLD_TO_CUST]
      ,[SHIP_TO_CUST]
      ,[CUST_PART]
      ,[CUST_REQ_MFG]
      ,[REQUESTED_PART]
      ,[MFG_CODE]
      ,[REQ_PART_DES]
      ,[QUOTED_MFG]
      ,[QUOTED_PART]
      ,[TLA_NO]
      ,[SAP_MATERIAL_ID]
      ,[REQUESTED_TLA]
      ,[TLA_TYPE_CD]
      ,[TLA_STATUS]
      ,[TLA_STATUS_DT]
      ,[MATERIAL_PLANNING_STRATEGY]
      ,[MODIFIED_MFG]
      ,[MATCH_SOURCE]
      ,[TARGET_PRICE]
      ,[ACTIVITY_UNIT]
      ,[QUANTITY_1]
      ,[QUANTITY_2]
      ,[QUANTITY_3]
      ,[QUOTED_RESALE_1]
      ,[QUOTED_RESALE_2]
      ,[QUOTED_RESALE_3]
      ,[APPROVED_RESALE_1]
      ,[APPROVED_RESALE_2]
      ,[APPROVED_RESALE_3]
      ,[AUTH_REQ]
      ,[BOOK_RESALE]
      ,[MATERIAL_GP]
      ,[RESALE_SOURCE]
      ,[QAS]
      ,[ATP_DT]
      ,[AFA_SERIAL_NO]
      ,[EXTENDED_LI_VALUE]
      ,[PRICING_STRATEGY]
      ,[COST_TYPE]
      ,[SALES_COST]
      ,[DISTI_COST]
      ,[DISTI_RESALE]
      ,[COST]
      ,[PRICE_TYPE_1]
      ,[PRICE_TYPE_2]
      ,[PRICE_TYPE_3]
      ,[SUPPLIER_LEAD_TIME]
      ,[APPROVED_LT_1]
      ,[APPROVED_LT_2]
      ,[APPROVED_LT_3]
      ,[QUOTED_LT]
      ,[SUPPLIER_QUOTE_NO]
      ,[APPROVED_MIN_1]
      ,[APPROVED_MIN_2]
      ,[APPROVED_MIN_3]
      ,[APPROVED_MULT_1]
      ,[APPROVED_MULT_2]
      ,[APPROVED_MULT_3]
      ,[SMPQ]
      ,[COMMODITY_CODE]
      ,[PART_HAZ_ATTR]
      ,[SOLE_SOURCE]
      ,[MATERIAL_LIFE_CYCLE]
      ,[NCNR]
      ,[CUSTOM_PRODUCT]
      ,[STOCK_PROFILE]
      ,[ABC_INDICATOR]
      ,[LAST_TIME_BUY_DT]
      ,[LAST_TIME_RETURN_DT]
      ,[LAST_TIME_SHIP_DT]
      ,[MATERIAL_PACKAGING_TYPE]
      ,[REGISTRABLE]
      ,[REGISTRATION_NO]
      ,[REGISTRATION_ID]
      ,[REGISTRATION_STATUS]
      ,[CUST_LAST_BUY_DT]
      ,[CUST_LAST_BUY_QT]
      ,[CUST_LAST_BUY_RES]
      ,[COMMENTS]
      ,[APPROVED_COST_1]
      ,[APPROVED_COST_2]
      ,[APPROVED_COST_3]
      ,[APPROVED_MO_1]
      ,[APPROVED_MO_2]
      ,[APPROVED_MO_3]
      ,[AGREEMENT_TYPE]
      ,[AUTHORIZATION_NO]
      ,[CONSIGNMENT_AUTH_NO]
      ,[AGREEMENT_COST_TYPE]
      ,[AGREEMENT_COST]
      ,[AGREEMENT_QTY]
      ,[AUTH_EXP_DATE]
      ,[AGREEMENT_ADJUSTED_COST]
      ,[END_CUSTOMER_ACCOUNT_NO]
      ,[END_CUSTOMER_LOCATION]
      ,[END_CUSTOMER_NAME]
      ,[END_USER_NAME_ACCOUNT_NO]
      ,[APPROVED_EXPIRATION_DT_1]
      ,[APPROVED_EXPIRATION_DT_2]
      ,[APPROVED_EXPIRATION_DT_3]
      ,[FOLLOW_UP_DT]
      ,[SHIP_TO_LOCATION]
      ,[INVENTORY_MESSAGE]
      ,[SALES_MESSAGE]
      ,[ADDITIONAL_UNIT_COST]
      ,[BEST_REPLACEMENT_COST]
      ,[BOOK_COST_1]
      ,[INTERNAL_PRICE]
      ,[GROUP_CD]
      ,[LATEST_REFRESH_DT]
      ,[REQ_SAP_MATERIAL_ID]
      ,[SOLD_AT_PREMIER]
      ,[BKN_SAP_MATERIAL]
      ,[ASSIGNED_TO]
      ,[SALES_COST_SRC]
      ,[SUB_PROD_CNT]
      ,[NASCAR_EXP_DT]
      ,[IMPORT_ERROR]
      ,[APPL_CREATE_DT]
      ,[WEB_RESALE]
      ,[MODIFIED_PART]
      ,[PART_MODIFIED_FL]
      ,[SMOQ]
	  ,[Val1]
	  ,[Val2]
	  ,[Val3]
	  ,[AUTH])
(SELECT  [NASCAR_BATCH_EXPORT_ID]
      ,[QUOTE_ID]
      ,[LINE_ITEM_NO]
      ,[LINE_ITEM_STATUS]
      ,[SOLD_TO_CUST]
      ,[SHIP_TO_CUST]
      ,[CUST_PART]
      ,[CUST_REQ_MFG]
      ,[REQUESTED_PART]
      ,[MFG_CODE]
      ,[REQ_PART_DES]
      ,[QUOTED_MFG]
      ,[QUOTED_PART]
      ,[TLA_NO]
      ,[SAP_MATERIAL_ID]
      ,[REQUESTED_TLA]
      ,[TLA_TYPE_CD]
      ,[TLA_STATUS]
      ,[TLA_STATUS_DT]
      ,[MATERIAL_PLANNING_STRATEGY]
      ,[MODIFIED_MFG]
      ,[MATCH_SOURCE]
      ,[TARGET_PRICE]
      ,[ACTIVITY_UNIT]
      ,[QUANTITY_1]
      ,[QUANTITY_2]
      ,[QUANTITY_3]
      ,[QUOTED_RESALE_1]
      ,[QUOTED_RESALE_2]
      ,[QUOTED_RESALE_3]
      ,[APPROVED_RESALE_1]
      ,[APPROVED_RESALE_2]
      ,[APPROVED_RESALE_3]
      ,[AUTH_REQ]
      ,[BOOK_RESALE]
      ,[MATERIAL_GP]
      ,[RESALE_SOURCE]
      ,[QAS]
      ,[ATP_DT]
      ,[AFA_SERIAL_NO]
      ,[EXTENDED_LI_VALUE]
      ,[PRICING_STRATEGY]
      ,[COST_TYPE]
      ,[SALES_COST]
      ,[DISTI_COST]
      ,[DISTI_RESALE]
      ,[COST]
      ,[PRICE_TYPE_1]
      ,[PRICE_TYPE_2]
      ,[PRICE_TYPE_3]
      ,[SUPPLIER_LEAD_TIME]
      ,[APPROVED_LT_1]
      ,[APPROVED_LT_2]
      ,[APPROVED_LT_3]
      ,[QUOTED_LT]
      ,[SUPPLIER_QUOTE_NO]
      ,[APPROVED_MIN_1]
      ,[APPROVED_MIN_2]
      ,[APPROVED_MIN_3]
      ,[APPROVED_MULT_1]
      ,[APPROVED_MULT_2]
      ,[APPROVED_MULT_3]
      ,[SMPQ]
      ,[COMMODITY_CODE]
      ,[PART_HAZ_ATTR]
      ,[SOLE_SOURCE]
      ,[MATERIAL_LIFE_CYCLE]
      ,[NCNR]
      ,[CUSTOM_PRODUCT]
      ,[STOCK_PROFILE]
      ,[ABC_INDICATOR]
      ,[LAST_TIME_BUY_DT]
      ,[LAST_TIME_RETURN_DT]
      ,[LAST_TIME_SHIP_DT]
      ,[MATERIAL_PACKAGING_TYPE]
      ,[REGISTRABLE]
      ,[REGISTRATION_NO]
      ,[REGISTRATION_ID]
      ,[REGISTRATION_STATUS]
      ,[CUST_LAST_BUY_DT]
      ,[CUST_LAST_BUY_QT]
      ,[CUST_LAST_BUY_RES]
      ,[COMMENTS]
      ,[APPROVED_COST_1]
      ,[APPROVED_COST_2]
      ,[APPROVED_COST_3]
      ,[APPROVED_MO_1]
      ,[APPROVED_MO_2]
      ,[APPROVED_MO_3]
      ,[AGREEMENT_TYPE]
      ,[AUTHORIZATION_NO]
      ,[CONSIGNMENT_AUTH_NO]
      ,[AGREEMENT_COST_TYPE]
      ,[AGREEMENT_COST]
      ,[AGREEMENT_QTY]
      ,[AUTH_EXP_DATE]
      ,[AGREEMENT_ADJUSTED_COST]
      ,[END_CUSTOMER_ACCOUNT_NO]
      ,[END_CUSTOMER_LOCATION]
      ,[END_CUSTOMER_NAME]
      ,[END_USER_NAME_ACCOUNT_NO]
      ,[APPROVED_EXPIRATION_DT_1]
      ,[APPROVED_EXPIRATION_DT_2]
      ,[APPROVED_EXPIRATION_DT_3]
      ,[FOLLOW_UP_DT]
      ,[SHIP_TO_LOCATION]
      ,[INVENTORY_MESSAGE]
      ,[SALES_MESSAGE]
      ,[ADDITIONAL_UNIT_COST]
      ,[BEST_REPLACEMENT_COST]
      ,[BOOK_COST_1]
      ,[INTERNAL_PRICE]
      ,[GROUP_CD]
      ,[LATEST_REFRESH_DT]
      ,[REQ_SAP_MATERIAL_ID]
      ,[SOLD_AT_PREMIER]
      ,[BKN_SAP_MATERIAL]
      ,[ASSIGNED_TO]
      ,[SALES_COST_SRC]
      ,[SUB_PROD_CNT]
      ,[NASCAR_EXP_DT]
      ,[IMPORT_ERROR]
      ,[APPL_CREATE_DT]
      ,[WEB_RESALE]
      ,[MODIFIED_PART]
      ,[PART_MODIFIED_FL]
      ,[SMOQ]
	  ,([QUANTITY_1]*[APPROVED_COST_1])/1000 as Val1
	  ,([QUANTITY_2]*[APPROVED_COST_2])/1000 as Val2
	  ,([QUANTITY_3]*[APPROVED_COST_3])/1000 as Val3
	  ,IIF(([QUANTITY_1]*[APPROVED_COST_1])/1000>250 OR ([QUANTITY_2]*[APPROVED_COST_2])/1000>250 OR ([QUANTITY_3]*[APPROVED_COST_3])/1000>250,'P','N') As AUTH
  FROM [MDM].[dbo].[NascarExportLine]) ;

  update NascarExportLineFinal 
  Set AUTH = 'P'
  where SAP_MATERIAL_ID is null;

    update NascarExportLineFinal 
  Set AUTH = 'P'
  where Val1 is null AND Val2 is null AND Val3 is null;

     update NascarExportLineFinal 
  Set AUTH = 'P'
  where COMMENTS like '%NASCAR_OVERRIDE%';







INSERT INTO [AVE92]..[IQUOTE_OWN].[NASCAR_BATCH_IMPORT]
([NASCAR_BATCH_IMPORT_ID]
      ,[BATCH_STATUS_CD]
      ,[IMPORT_DT]
      ,[IMPORT_LINE_QT]
      ,[READ_FL]
      ,[APPL_CREATE_DT]
      ,[APPL_UPDATE_DT]
)
select [MDM].[dbo].[NascarExportHeader].[NASCAR_BATCH_EXPORT_ID] AS [NASCAR_BATCH_IMPORT_ID]
      ,[MDM].[dbo].[NascarExportHeader].[BATCH_STATUS_CD]
      ,GETDATE() as IMPORT_DT 
      ,[MDM].[dbo].[NascarExportHeader].[EXPORT_LINE_QT]
      ,[MDM].[dbo].[NascarExportHeader].[READ_FL]
      ,[MDM].[dbo].[NascarExportHeader].[APPL_CREATE_DT]
      ,[MDM].[dbo].[NascarExportHeader].[APPL_UPDATE_DT]
from NascarExportHeader;

INSERT INTO [AVE92]..[IQUOTE_OWN].[NASCAR_BATCH_IMPORT_LINE]
(
	[NASCAR_BATCH_IMPORT_ID]
      ,[QUOTE_ID]
      ,[LINE_ITEM_NO]
      ,[QUOTED_SAP_MATERIAL_ID]
      ,[QUANTITY_1]
      ,[QUANTITY_2]
      ,[QUANTITY_3]
      ,[APPROVED_RESALE_1]
      ,[APPROVED_RESALE_2]
      ,[APPROVED_RESALE_3]
      ,[PRICE_TYPE_1]
      ,[PRICE_TYPE_2]
      ,[PRICE_TYPE_3]
      ,[APPROVED_LT_1]
      ,[APPROVED_LT_2]
      ,[APPROVED_LT_3]
      ,[APPROVED_MIN_1]
      ,[APPROVED_MIN_2]
      ,[APPROVED_MIN_3]
      ,[APPROVED_MULT_1]
      ,[APPROVED_MULT_2]
      ,[APPROVED_MULT_3]
      ,[SUPPLIER_QUOTE_NO]
      ,[COMMENTS]
      ,[APPROVED_COST_1]
      ,[APPROVED_COST_2]
      ,[APPROVED_COST_3]
      ,[APPROVED_MO_1]
      ,[APPROVED_MO_2]
      ,[APPROVED_MO_3]
      ,[AUTH_COMPLETE]
      ,[APPL_CREATE_DT]
	  ,[ASSIGNED_TO]

)
 select  [MDM].[dbo].[NascarExportLineFinal].[NASCAR_BATCH_EXPORT_ID]  AS [NASCAR_BATCH_IMPORT_ID]
      ,[MDM].[dbo].[NascarExportLineFinal].[QUOTE_ID]
      ,[MDM].[dbo].[NascarExportLineFinal].[LINE_ITEM_NO]
	  ,[MDM].[dbo].[NascarExportLineFinal].[SAP_MATERIAL_ID]
	  ,[MDM].[dbo].[NascarExportLineFinal].[QUANTITY_1]
      ,[MDM].[dbo].[NascarExportLineFinal].[QUANTITY_2]
      ,[MDM].[dbo].[NascarExportLineFinal].[QUANTITY_3]
	  ,[MDM].[dbo].[NascarExportLineFinal].[APPROVED_RESALE_1]
      ,[MDM].[dbo].[NascarExportLineFinal].[APPROVED_RESALE_2]
      ,[MDM].[dbo].[NascarExportLineFinal].[APPROVED_RESALE_3]
	  ,[MDM].[dbo].[NascarExportLineFinal].[PRICE_TYPE_1]
      ,[MDM].[dbo].[NascarExportLineFinal].[PRICE_TYPE_2]
      ,[MDM].[dbo].[NascarExportLineFinal].[PRICE_TYPE_3]
	  ,[MDM].[dbo].[NascarExportLineFinal].[APPROVED_LT_1]
      ,[MDM].[dbo].[NascarExportLineFinal].[APPROVED_LT_2]
      ,[MDM].[dbo].[NascarExportLineFinal].[APPROVED_LT_3]
	  ,[MDM].[dbo].[NascarExportLineFinal].[APPROVED_MIN_1]
      ,[MDM].[dbo].[NascarExportLineFinal].[APPROVED_MIN_2]
      ,[MDM].[dbo].[NascarExportLineFinal].[APPROVED_MIN_3]
      ,[MDM].[dbo].[NascarExportLineFinal].[APPROVED_MULT_1]
      ,[MDM].[dbo].[NascarExportLineFinal].[APPROVED_MULT_2]
      ,[MDM].[dbo].[NascarExportLineFinal].[APPROVED_MULT_3]
	  ,[MDM].[dbo].[NascarExportLineFinal].[SUPPLIER_QUOTE_NO]
	  ,[MDM].[dbo].[NascarExportLineFinal].[COMMENTS]
	  ,[MDM].[dbo].[NascarExportLineFinal].[APPROVED_COST_1]
      ,[MDM].[dbo].[NascarExportLineFinal].[APPROVED_COST_2]
      ,[MDM].[dbo].[NascarExportLineFinal].[APPROVED_COST_3]
      ,[MDM].[dbo].[NascarExportLineFinal].[APPROVED_MO_1]
      ,[MDM].[dbo].[NascarExportLineFinal].[APPROVED_MO_2]
      ,[MDM].[dbo].[NascarExportLineFinal].[APPROVED_MO_3]
	  ,[MDM].[dbo].[NascarExportLineFinal].[AUTH]
	  ,[MDM].[dbo].[NascarExportLineFinal].[APPL_CREATE_DT]
	  ,[MDM].[dbo].[NascarExportLineFinal].[ASSIGNED_TO]
	  from [MDM].[dbo].[NascarExportLineFinal];
 
 UPDATE t1
  SET t1.READ_FL = 'Y'
  FROM [AVE92]..[IQUOTE_OWN].[NASCAR_BATCH_EXPORT] AS t1
  INNER JOIN NascarExportHeader AS t2
  ON t1.NASCAR_BATCH_EXPORT_ID = t2.NASCAR_BATCH_EXPORT_ID;
