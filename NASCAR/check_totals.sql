select * from NascarProd.dbo.NascarImportLineArchive as t1
inner join NascarProd.dbo.NascarImportHeaderArchive as t2
on t1.NASCAR_BATCH_IMPORT_ID = t2.NASCAR_BATCH_IMPORT_ID
where t2.IMPORT_DT <= '2017-10-13 14:55:00.1800000' 
order by t2.IMPORT_DT asc

select * from NascarExportLineFinalArchive
where SAP_MATERIAL_ID like '%6474541%' and NASCAR_EXP_DT >= '2017-10-13 14:55:21.0000000'

select * from NascarExportLineFinalArchive where COMMENTS like '%NASCAR_OVERRIDE%'
select * from NascarMaterialThresholdValue where MaterialNbr like '%2233676%'
