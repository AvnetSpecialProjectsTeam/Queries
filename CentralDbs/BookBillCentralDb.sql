
--IMPORT BILLINGS 
GO
INSERT INTO dbo.BookBill
(LogDt,LogTime,TransDt,BusDay99,WkNbr,FyMnthNbr,FyTagMnth,Material,Pbg,Mfg,PrcStgy,Cc,Grp,Tech,MfgPartNbr,SalesGrp,SalesGrpKey,SalesOffice,SalesOfficeKey,CustName,CustNbr,SalesDocTyp,RefBillingNbr,SalesDocNbr ,SalesDocLnItm,BillingsQty,Billings,Cogs,BillingsGp,BookingsQty,Bookings,BookingsCost,BookingsGp,Type)
SELECT DISTINCT log_dt, log_time, transact_dt, bus_day_99,wk_nbr, fy_mth_nbr,fy_tag_mth, material_nbr, pbg, mfg, prc_stgy, cc, grp, tech, mfg_part_nbr, sales_grp, sales_grp_key, sales_office, sales_office_key, cust_name, cust_nbr, sales_doc_type, ref_billing_nbr, sales_doc_nbr, CASE WHEN sales_doc_line_item = '#' Then null Else sales_doc_line_item end, billings_qty, billings_$, cogs, billings_gp_$, bookings_qty, bookings_$, bookings_cost_$, bookings_gp_$ ,'BILLINGS' AS Type
FROM NonHaImportTesting.dbo.bookbill_cust_detail_sales_doc;
GO


--IMPORT BOOKINGS 16
GO 
INSERT INTO dbo.BookBill
(LogDt,LogTime,TransDt,BusDay99,WkNbr,FyMnthNbr,FyTagMnth,Material,Pbg,Mfg,PrcStgy,Cc,Grp,Tech,MfgPartNbr,SalesGrp,SalesGrpKey,SalesOffice,SalesOfficeKey,CustName,CustNbr,SalesDocTyp,RefBillingNbr,SalesDocNbr,SalesDocLnItm,BillingsQty,Billings,Cogs,BillingsGp,BookingsQty,Bookings,BookingsCost,BookingsGp,Type)
SELECT DISTINCT log_dt,log_time,transact_dt,bus_day_99,wk_nbr,fy_mth_nbr,fy_tag_mth,material_nbr,pbg,mfg,prc_stgy,cc,grp,tech,mfg_part_nbr,'NULL' AS sales_grp,sales_grp_key,'NULL' AS sales_office,sales_office_key,'NULL' AS cust_name,cust_nbr,sales_doc_type,' ' AS ref_billing_nbr,sales_doc_nbr,CASE WHEN sales_doc_line_item = '#' Then null Else sales_doc_line_item end,'0' AS billings_qty,'0' AS billings_$,'0' AS cogs,'0' AS billings_gp_$,bookings_qty,bookings_$,bookings_cost_$,'0' AS bookings_gp_$,'BOOKINGS' AS Type
FROM NonHaImportTesting.dbo.Bookings_Cust_Detail_Master_FY16;
GO


--IMPORT BOOKINGS 17
GO 
INSERT INTO dbo.BookBill
(LogDt,LogTime,TransDt,BusDay99,WkNbr,FyMnthNbr,FyTagMnth,Material,Pbg,Mfg,PrcStgy,Cc,Grp,Tech,MfgPartNbr,SalesGrp,SalesGrpKey,SalesOffice,SalesOfficeKey,CustName,CustNbr,SalesDocTyp,RefBillingNbr,SalesDocNbr,SalesDocLnItm,BillingsQty,Billings,Cogs,BillingsGp,BookingsQty,Bookings,BookingsCost,BookingsGp,Type)
SELECT DISTINCT log_dt,log_time,transact_dt,bus_day_99,wk_nbr,fy_mth_nbr,fy_tag_mth,material_nbr,pbg,mfg,prc_stgy,cc,grp,tech,mfg_part_nbr,CASE WHEN sales_grp_key = '#' Then null Else sales_grp_key end,'NULL' AS sales_grp,'NULL' AS sales_office,sales_office_key,'NULL' AS cust_name,cust_nbr,sales_doc_type,' ' AS ref_billing_nbr,CASE WHEN sales_doc_nbr = '#' Then null Else sales_doc_nbr end,CASE WHEN sales_doc_line_item = '#' Then null Else sales_doc_line_item end,'0' AS billings_qty,'0' AS billings_$,'0' AS cogs,'0' AS billings_gp_$,bookings_qty,bookings_$,bookings_cost_$,'0' AS bookings_gp_$,'BOOKINGS' AS Type
FROM NonHaImportTesting.dbo.Bookings_Cust_Detail_Master_FY17;
GO


----IMPORT BOOKINGS 18
GO 
INSERT INTO dbo.BookBill
(LogDt,LogTime,TransDt,BusDay99,WkNbr,FyMnthNbr,FyTagMnth,Material,Pbg,Mfg,PrcStgy,Cc,Grp,Tech,MfgPartNbr,SalesGrp,SalesGrpKey,SalesOffice,SalesOfficeKey,CustName,CustNbr,SalesDocTyp,RefBillingNbr,SalesDocNbr,SalesDocLnItm,BillingsQty,Billings,Cogs,BillingsGp,BookingsQty,Bookings,BookingsCost,BookingsGp,Type)
SELECT DISTINCT log_dt,log_time,transact_dt,bus_day_99,wk_nbr,fy_mth_nbr,fy_tag_mth,material_nbr,pbg,mfg,prc_stgy,cc,grp,tech,mfg_part_nbr,CASE WHEN sales_grp_key = '#' Then null Else sales_grp_key end,'NULL' AS sales_grp,'NULL' AS sales_office,sales_office_key,'NULL' AS cust_name,cust_number,sales_doc_type,' ' AS ref_billing_nbr,CASE WHEN sales_doc_nbr = '#' Then null Else sales_doc_nbr end,CASE WHEN sales_doc_line_item = '#' Then null Else sales_doc_line_item end,'0' AS billings_qty,'0' AS billings_$,'0' AS cogs,'0' AS billings_gp_$,bookings_qty,bookings_$,bookings_cost_$,'0' AS bookings_gp_$,'BOOKINGS' AS Type
FROM NonHaImportTesting.dbo.Bookings_Cust_Detail_Master_FY18;
GO
