select t1.*,t2.SqlStartTime from (select Nascar_Batch_Export_Id, QUOTE_ID, line_item_no,REPLACE(LTRIM(REPLACE(SAP_MATERIAL_ID, 0, ' ')), ' ', 0)  as MaterialNbr, NASCAR_EXP_DT from NascarExportLineFinalArchive) as t1
inner join
(select * from NascarMaterialThresholdValue where ThresholdValue = 0) as t2
on t1.MaterialNbr = t2.MaterialNbr 
where t2.sqlstarttime < t1.nascar_exp_dt