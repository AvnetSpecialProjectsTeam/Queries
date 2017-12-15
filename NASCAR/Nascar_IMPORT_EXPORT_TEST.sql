USE [NascarTest]
GO

--insert NASCAR_BATCH_EXPORT into NascarExportHeader
truncate table [NascarTest].[dbo].NascarExportHeader
insert into [NascarTest].[dbo].NascarExportHeader
select * from [AVT92]..[IQUOTE_OWN].[NASCAR_BATCH_EXPORT]
Where READ_FL = 'N';
--insert into NASCAR_BATCH_EXPORT_LINE from NascarExportHeader Header items 
truncate table [NascarTest].[dbo].NascarExportLine
insert into [NascarTest].[dbo].NascarExportLine
select t1.* FROM [AVT92]..[IQUOTE_OWN].[NASCAR_BATCH_EXPORT_LINE] AS t1
  INNER JOIN [NascarTest].[dbo].NascarExportHeader AS t2
  ON t1.NASCAR_BATCH_EXPORT_ID = t2.NASCAR_BATCH_EXPORT_ID ;

  --Export Header data to archive for debugging purposes 
insert into NascarExportHeaderArchive select * from NascarExportHeader; 


update [NascarTest].[dbo].[NascarExportHeader]
  set READ_FL='N';



 truncate table [NascarTest].[dbo].NascarExportLineFinal
insert into [NascarTest].[dbo].[NascarExportLineFinal] ([NASCAR_BATCH_EXPORT_ID]
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
      ,iif((([QUANTITY_1] is not NULL AND BOOK_COST_1 is not null) OR ([QUANTITY_1] is not null AND APPROVED_COST_1 is  not Null)), '7',NULL) as [PRICE_TYPE_1]

      ,iif((([QUANTITY_2] is not NULL AND BOOK_COST_1 is not null) OR ([QUANTITY_2] is not null AND APPROVED_COST_2 is  not Null)), '7',NULL) as [PRICE_TYPE_2]

      ,iif((([QUANTITY_3] is not NULL AND BOOK_COST_1 is not null) OR ([QUANTITY_3] is not null AND APPROVED_COST_3 is  not Null)), '7',NULL) as [PRICE_TYPE_3]

      ,[SUPPLIER_LEAD_TIME]

      ,iif(((SUPPLIER_LEAD_TIME is not null and SUPPLIER_LEAD_TIME<> 0) and QUANTITY_1 is not null),[SUPPLIER_LEAD_TIME],iif((APPROVED_LT_1 is not null and QUANTITY_1 is not null), APPROVED_LT_1, NULL)) as APPROVED_LT_1

      ,iif(((SUPPLIER_LEAD_TIME is not null and SUPPLIER_LEAD_TIME<> 0) and QUANTITY_2 is not null),[SUPPLIER_LEAD_TIME],iif((APPROVED_LT_2 is not null and QUANTITY_2 is not null), APPROVED_LT_2, NULL)) as APPROVED_LT_2

      ,iif(((SUPPLIER_LEAD_TIME is not null and SUPPLIER_LEAD_TIME<> 0) and QUANTITY_3 is not null),[SUPPLIER_LEAD_TIME],iif((APPROVED_LT_3 is not null and QUANTITY_3 is not null), APPROVED_LT_3, NULL)) as APPROVED_LT_3

      ,[QUOTED_LT]
      ,[SUPPLIER_QUOTE_NO]

      ,round(iif(((SMOQ is not null and SMOQ <>0) and QUANTITY_1 is not null),SMOQ,iif(((APPROVED_MIN_1 is not null and APPROVED_MIN_1 <>0) and QUANTITY_1 is not null), APPROVED_MIN_1, NULL)),5) as APPROVED_MIN_1

      ,round(iif(((SMOQ is not null and SMOQ <>0) and QUANTITY_2 is not null),SMOQ,iif(((APPROVED_MIN_2 is not null and APPROVED_MIN_2 <>0) and QUANTITY_2 is not null), APPROVED_MIN_2, NULL)),5) as APPROVED_MIN_2

     ,round(iif(((SMOQ is not null and SMOQ <>0) and QUANTITY_3 is not null),SMOQ,iif(((APPROVED_MIN_3 is not null and APPROVED_MIN_3 <>0) and QUANTITY_3 is not null), APPROVED_MIN_3, NULL)),5) as APPROVED_MIN_3

      ,round(iif(((SMPQ is not null and SMPQ <> 0) and QUANTITY_1 is not null),[SMPQ],iif(((APPROVED_MULT_1 is not null and APPROVED_MULT_1 <> 0) and QUANTITY_1 is not null), APPROVED_MULT_1, NULL)),5) as APPROVED_MULT_1

    ,round(iif(((SMPQ is not null and SMPQ <> 0) and QUANTITY_2 is not null),[SMPQ],iif(((APPROVED_MULT_2 is not null and APPROVED_MULT_2 <> 0) and QUANTITY_2 is not null), APPROVED_MULT_2, NULL)),5) as APPROVED_MULT_2

      ,round(iif(((SMPQ is not null and SMPQ <> 0) and QUANTITY_3 is not null),[SMPQ],iif(((APPROVED_MULT_3 is not null and APPROVED_MULT_3 <> 0) and QUANTITY_3 is not null), APPROVED_MULT_3, NULL)),5) as APPROVED_MULT_3

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

      ,iif(([QUANTITY_1] is not null AND ([BOOK_COST_1] is not null AND [BOOK_COST_1]<>0)),BOOK_COST_1,iif(([QUANTITY_1] is not null AND ([APPROVED_COST_1] is not null and APPROVED_COST_1 <> 0)),[APPROVED_COST_1],NULL)) as APPROVED_COST_1

      ,iif(([QUANTITY_2] is not null AND ([BOOK_COST_1] is not null AND [BOOK_COST_1]<>0)),BOOK_COST_1,iif(([QUANTITY_2] is not null AND ([APPROVED_COST_2] is not null and APPROVED_COST_2 <> 0)),[APPROVED_COST_2],NULL)) as APPROVED_COST_2

      ,iif(([QUANTITY_3] is not null AND ([BOOK_COST_1] is not null AND [BOOK_COST_1]<>0)),BOOK_COST_1,iif(([QUANTITY_3] is not null AND ([APPROVED_COST_3] is not null and APPROVED_COST_3 <> 0)),[APPROVED_COST_3],NULL)) as APPROVED_COST_3

      ,round(iif(((SMPQ is not null and SMPQ <>0) and (BOOK_COST_1 is not null and BOOK_COST_1<>0) and (QUANTITY_1 is not null and QUANTITY_1 <>0)),SMPQ*BOOK_COST_1,iif(((SMOQ is not null and SMOQ <>0) and (BOOK_COST_1 is not null and BOOK_COST_1<>0) and (QUANTITY_1 is not null and QUANTITY_1 <>0)),SMOQ*BOOK_COST_1,null)),5) as [APPROVED_MO_1]

       ,round(iif(((SMPQ is not null and SMPQ <>0) and (BOOK_COST_1 is not null and BOOK_COST_1<>0) and (QUANTITY_2 is not null and QUANTITY_2 <>0)),SMPQ*BOOK_COST_1,iif(((SMOQ is not null and SMOQ <>0) and (BOOK_COST_1 is not null and BOOK_COST_1<>0) and (QUANTITY_2 is not null and QUANTITY_2 <>0)),SMOQ*BOOK_COST_1,null)),5) as [APPROVED_MO_2]

     ,round(iif(((SMPQ is not null and SMPQ <>0) and (BOOK_COST_1 is not null and BOOK_COST_1<>0) and (QUANTITY_3 is not null and QUANTITY_3 <>0)),SMPQ*BOOK_COST_1,iif(((SMOQ is not null and SMOQ <>0) and (BOOK_COST_1 is not null and BOOK_COST_1<>0) and (QUANTITY_3 is not null and QUANTITY_3 <>0)),SMOQ*BOOK_COST_1,null)),5) as [APPROVED_MO_3]

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
	   ,IIF((([BOOK_COST_1] is not null and BOOK_COST_1 <> 0) and QUANTITY_1 is not null),([QUANTITY_1]*[BOOK_COST_1]),iif((APPROVED_COST_1 is not null and APPROVED_COST_1 <> 0), ([QUANTITY_1]*[APPROVED_COST_1]),NULL)) as val1

	  ,IIF((([BOOK_COST_1] is not null and BOOK_COST_1 <> 0) and QUANTITY_2 is not null),([QUANTITY_2]*[BOOK_COST_1]),iif((APPROVED_COST_2 is not null and APPROVED_COST_2 <> 0), ([QUANTITY_2]*[APPROVED_COST_2]),NULL)) as val2

	  ,IIF((([BOOK_COST_1] is not null and BOOK_COST_1 <> 0) and QUANTITY_3 is not null),([QUANTITY_3]*[BOOK_COST_1]),iif((APPROVED_COST_3 is not null and APPROVED_COST_3 <> 0), ([QUANTITY_3]*[APPROVED_COST_3]),NULL)) as val3
	  ,'N' As AUTH
  FROM [NascarTest].[dbo].[NascarExportLine]) ;


--if MaterialNbr is null flag to product
  update [NascarTest].[dbo].NascarExportLineFinal 
  Set AUTH = 'P'
  where SAP_MATERIAL_ID is null;


--if value of quote is null flag to product, indicates the price is null 
    update [NascarTest].[dbo].NascarExportLineFinal 
  Set AUTH = 'P'
  where Val1 is null AND Val2 is null AND Val3 is null;


-- if line value is more than 250 flag to product
      update [NascarTest].[dbo].NascarExportLineFinal 
  Set AUTH = 'P'
  where Val1 > 250 OR Val2 > 250 OR Val3 > 250;

-- if overwrite flag is entered flag to product
     update [NascarTest].[dbo].NascarExportLineFinal 
  Set AUTH = 'P'
  where COMMENTS like '%NASCAR_OVERRIDE%';


  -- Flag to P where AUTH_REQ is PT and SAP_Material_ID is null or APPROVED COST is null or APPROVED_LT is null
       update [NascarTest].[dbo].NascarExportLineFinal 
  Set AUTH = 'P'
  where AUTH_REQ like '%PT%'  AND ((QUOTED_MFG is null or QUOTED_PART is null) or (APPROVED_COST_1 is null and APPROVED_COST_2 is null and APPROVED_COST_3 is null) or (APPROVED_LT_1 is null and APPROVED_LT_2 is null and APPROVED_LT_3 is null)) ;
   
   --Flag to product wher AUTH_REQ is set to DEL and approved lead time is null
    
	update [NascarTest].[dbo].NascarExportLineFinal
  Set AUTH = 'P'
   where AUTH_REQ like '%DEL%'  AND  (APPROVED_LT_1 is null and APPROVED_LT_2 is null and APPROVED_LT_3 is null) ;
   --Flag to product wher AUTH_REQ is set to PR and there is no approved Cost and No price type
       
	    update [NascarTest].[dbo].NascarExportLineFinal 
  Set AUTH = 'P'
  where AUTH_REQ like '%PR%'  and  ((APPROVED_COST_1 is null and APPROVED_COST_2 is null and APPROVED_COST_3 is null) or (PRICE_TYPE_1 is null AND PRICE_TYPE_2 is null AND PRICE_TYPE_1 is null))  ;

  --insert into archive from ExportLine final. For debugging purposes when Nascar Goes live
  insert into NascarExportLineFinalArchive select * from NascarExportLineFinal





INSERT INTO [AVT92]..[IQUOTE_OWN].[NASCAR_BATCH_IMPORT]
([NASCAR_BATCH_IMPORT_ID]
      ,[BATCH_STATUS_CD]
      ,[IMPORT_DT]
      ,[IMPORT_LINE_QT]
      ,[READ_FL]
      ,[APPL_CREATE_DT]
      ,[APPL_UPDATE_DT]
)
select [NascarTest].[dbo].[NascarExportHeader].[NASCAR_BATCH_EXPORT_ID] AS [NASCAR_BATCH_IMPORT_ID]
      ,[NascarTest].[dbo].[NascarExportHeader].[BATCH_STATUS_CD]
      ,GETDATE() as IMPORT_DT 
      ,[NascarTest].[dbo].[NascarExportHeader].[EXPORT_LINE_QT]
      ,[NascarTest].[dbo].[NascarExportHeader].[READ_FL]
      ,[NascarTest].[dbo].[NascarExportHeader].[APPL_CREATE_DT]
      ,[NascarTest].[dbo].[NascarExportHeader].[APPL_UPDATE_DT]
from NascarExportHeader;

--insert into NascarImportHeaderArchive for debugging purposes 
insert into NascarImportHeaderArchive ( [NASCAR_BATCH_IMPORT_ID]
      ,[BATCH_STATUS_CD]
      , [IMPORT_DT] 
      ,[EXPORT_LINE_QT]
      ,[READ_FL]
      ,[APPL_CREATE_DT]
      ,[APPL_UPDATE_DT])   
	  select [NascarTest].[dbo].[NascarExportHeader].[NASCAR_BATCH_EXPORT_ID] AS [NASCAR_BATCH_IMPORT_ID]
      ,[NascarTest].[dbo].[NascarExportHeader].[BATCH_STATUS_CD]
      ,GETDATE() as IMPORT_DT 
      ,[NascarTest].[dbo].[NascarExportHeader].[EXPORT_LINE_QT]
      ,[NascarTest].[dbo].[NascarExportHeader].[READ_FL]
      ,[NascarTest].[dbo].[NascarExportHeader].[APPL_CREATE_DT]
      ,[NascarTest].[dbo].[NascarExportHeader].[APPL_UPDATE_DT]
from NascarExportHeader;

INSERT INTO [AVT92]..[IQUOTE_OWN].[NASCAR_BATCH_IMPORT_LINE]
(
	[NASCAR_BATCH_IMPORT_ID]
      ,[QUOTE_ID]
      ,[LINE_ITEM_NO]
	  ,[QUOTED_MFG]
	  ,[QUOTED_PART]
      ,[QUOTED_SAP_MATERIAL_ID]
      ,[QUANTITY_1]
      ,[QUANTITY_2]
      ,[QUANTITY_3]
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
      ,[APPROVED_COST_1]
      ,[APPROVED_COST_2]
      ,[APPROVED_COST_3]
      ,[AUTH_COMPLETE]
      ,[APPL_CREATE_DT]
	  

)
 select  [NascarTest].[dbo].[NascarExportLineFinal].[NASCAR_BATCH_EXPORT_ID]  AS [NASCAR_BATCH_IMPORT_ID]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[QUOTE_ID]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[LINE_ITEM_NO]
	  ,iif(AUTH_REQ like '%PT%',QUOTED_MFG,null) as QUOTED_MFG
	  ,iif(AUTH_REQ like '%PT%',QUOTED_PART,null) as QUOTED_PART
	  ,[NascarTest].[dbo].[NascarExportLineFinal].[SAP_MATERIAL_ID]
	  ,[NascarTest].[dbo].[NascarExportLineFinal].[QUANTITY_1]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[QUANTITY_2]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[QUANTITY_3]
	  ,[NascarTest].[dbo].[NascarExportLineFinal].[PRICE_TYPE_1]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[PRICE_TYPE_2]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[PRICE_TYPE_3]
	  ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_LT_1]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_LT_2]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_LT_3]
	  ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_MIN_1]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_MIN_2]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_MIN_3]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_MULT_1]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_MULT_2]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_MULT_3]
	  ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_COST_1]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_COST_2]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_COST_3]
	  ,[NascarTest].[dbo].[NascarExportLineFinal].[AUTH]
	  ,[NascarTest].[dbo].[NascarExportLineFinal].[APPL_CREATE_DT]
	  from [NascarTest].[dbo].[NascarExportLineFinal];


	  -- create importline archive for debugging purposes 
	 Insert Into [NascarTest].[dbo].NascarImportLineArchive ( NASCAR_BATCH_IMPORT_ID
     , [QUOTE_ID]
    ,[LINE_ITEM_NO]
	,[SAP_MATERIAL_ID]
	,[QUANTITY_1]
    ,[QUANTITY_2]
    ,[QUANTITY_3]
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
	,[APPROVED_COST_1]
    ,[APPROVED_COST_2]
    ,[APPROVED_COST_3]
    ,[APPROVED_MO_1]
    ,[APPROVED_MO_2]
    ,[APPROVED_MO_3]
	,[AUTH]
	,[APPL_CREATE_DT]) 
	select  [NascarTest].[dbo].[NascarExportLineFinal].[NASCAR_BATCH_EXPORT_ID]  AS [NASCAR_BATCH_IMPORT_ID]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[QUOTE_ID]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[LINE_ITEM_NO]
	  ,[NascarTest].[dbo].[NascarExportLineFinal].[SAP_MATERIAL_ID]
	  ,[NascarTest].[dbo].[NascarExportLineFinal].[QUANTITY_1]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[QUANTITY_2]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[QUANTITY_3]
	  ,[NascarTest].[dbo].[NascarExportLineFinal].[PRICE_TYPE_1]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[PRICE_TYPE_2]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[PRICE_TYPE_3]
	  ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_LT_1]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_LT_2]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_LT_3]
	  ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_MIN_1]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_MIN_2]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_MIN_3]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_MULT_1]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_MULT_2]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_MULT_3]
	  ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_COST_1]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_COST_2]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_COST_3]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_MO_1]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_MO_2]
      ,[NascarTest].[dbo].[NascarExportLineFinal].[APPROVED_MO_3]
	  ,[NascarTest].[dbo].[NascarExportLineFinal].[AUTH]
	  ,[NascarTest].[dbo].[NascarExportLineFinal].[APPL_CREATE_DT]
	  from [NascarTest].[dbo].[NascarExportLineFinal];
 
 UPDATE t1
  SET t1.READ_FL = 'Y'
  FROM [AVT92]..[IQUOTE_OWN].[NASCAR_BATCH_EXPORT] AS t1
  INNER JOIN [NascarTest].[dbo].NascarExportHeader AS t2
  ON t1.NASCAR_BATCH_EXPORT_ID = t2.NASCAR_BATCH_EXPORT_ID;




