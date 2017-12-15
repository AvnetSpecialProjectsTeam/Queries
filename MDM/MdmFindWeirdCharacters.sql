Select * 
From OpenQuery(AVR80,'Select  
A.SAP_MATERIAL_ID, 
''MANUFACT_FAMILY_PART_NO'' as "Field", 
A.MANUFACT_FAMILY_PART_NO as "Value" 
From GOLDEN.C_BO_MATERIAL A  
Where Length(A.MANUFACT_FAMILY_PART_NO) <> LengthB(A.MANUFACT_FAMILY_PART_NO) 
AND A.HUB_STATE_IND <> (''-1'') 
')