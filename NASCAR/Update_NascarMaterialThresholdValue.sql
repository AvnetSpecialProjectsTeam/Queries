use [NascarProd]
go
select *
into ##NascarMaterialThersholdValueTemp
from(
select 
MaterialNbr,
iif((OverwriteFlag = 'x' or OverwriteFlag = 'X'),OverwriteThresholdValue,ThresholdValue) as ThresholdValue,
  WindowsUsername
from NascarFrontEnd) as temp

Merge NascarMaterialThresholdValue as TargetTbl
using ##NascarMaterialThersholdValueTemp as SourceTbl
On(TargetTbl.MaterialNbr=SourceTbl.MaterialNbr)
When Matched 
and TargetTbl.ThresholdValue <> SourceTbl.ThresholdValue
Then 
	Update set
	TargetTbl.ThresholdValue = SourceTbl.ThresholdValue,
	TargetTbl.WindowsUsername = SourceTbl.WindowsUserName

When not matched by target then
Insert (MaterialNbr,ThresholdValue,WindowsUsername)
Values(SourceTbl.MaterialNbr,SourceTbl.ThresholdValue,SourceTbl.WindowsUsername)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;

drop table ##NascarMaterialThersholdValueTemp;
