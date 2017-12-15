use nascar 
go

select * from nascarmaterialthresholdvalue
insert into NascarMaterialThresholdValue (MaterialNbr, ThresholdValue,PowerAppField) Values (346, 40000,345)


Update NascarMaterialThresholdValue Set
PowerAppField = MaterialNbr

alter table NascarMaterialThresholdValue
alter column powerappfield varchar(15);

create table NascarPrcStgyUpdate(
PrcStgy varchar(3),
Grp varchar(3),
Cc varchar(3),
ThresholdValue bigint)

Select * from NascarPrcStgyUpdate

insert into NascarPrcStgyUpdate Values ('AVT', 'BOM','0TL',87)

Truncate Table NascarFrontEnd

alter table NascarFrontEnd
ADD CONSTRAINT PK_MaterialNbr PRIMARY KEY (MaterialNbrText);

Alter table NascarFrontEnd
Alter column MaterialNbrText Varchar(25) not null

alter table NascarFrontEnd
Drop CONSTRAINT PK_MaterialNbr

alter table NascarFrontEnd
ADD  MaterialNbrText varchar(25)

alter table NascarFrontEnd
ADD  WindowsUsername varchar(25)

Insert into NascarFrontEnd (MaterialNbr, PrcStgy,Grp,Cc,ThresholdValue,OverwriteThresholdValue, OverwriteFlag,MaterialNbrText,WindowsUsername)
Select Distinct SPL.MaterialNbr, SPL.PrcStgy, SPL.Grp, SPL.CC, 250 As ThresholdValue, 0 As OverwriteThresholdValue, ' ' As OverwriteFlag, Cast(SPL.MaterialNbr as varchar(25)),NUll from CentralDbs.dbo.SapPartsList As SPL where  SPL.MatHubState<>-1

Select * From NascarFrontEnd
Select Count(*), MatHubState, SPL.SendToSapFl from CentralDbs.dbo.SapPartsList as SPL Group by MatHubState, SendToSapFl

Update NascarFrontEnd Set OverwriteFlag = ''
Where OverwriteFlag = ' '
