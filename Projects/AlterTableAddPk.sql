ALTER TABLE MDM.dbo.MDM_MATERIAL_PROD_Hrchy
Alter Column prod_hrchy_id int not null
go

ALTER TABLE MDM.dbo.MDM_MATERIAL_PROD_Hrchy
ADD PRIMARY KEY(prod_hrchy_id)



SELECT *
FROM dbo.MDM_Material_Prod_hrchy
