Insert into [dbo].[NascarQty]([MaterialNbr] 
      ,[SapPlantCd] 
      ,[SAPPurchasingOrgCD] 
      ,[SupplierMinPackageQt] 
      ,[SupplierMinOrderQt] 
      ,[SalesMinimumOrderQt] 
      ,[LT_plan_dlvry] 
      ,[LT_manual] 
      ,[LT_override_fl])
SELECT ViewSapQty2570.MaterialNbr, ViewSapQty2570.SapPlantCd, ViewSapQty2570.SAPPurchasingOrgCD, ViewSapQty2570.SupplierMinPackageQt, ViewSapQty2570.SupplierMinOrderQt, ViewSapQty2570.SalesMinimumOrderQt, ViewSapQty2570.LT_plan_dlvry, ViewSapQty2570.LT_manual, ViewSapQty2570.LT_override_fl
FROM ViewSapQty2570
GROUP BY ViewSapQty2570.MaterialNbr, ViewSapQty2570.SapPlantCd, ViewSapQty2570.SAPPurchasingOrgCD, ViewSapQty2570.SupplierMinPackageQt, ViewSapQty2570.SupplierMinOrderQt, ViewSapQty2570.SalesMinimumOrderQt, ViewSapQty2570.LT_plan_dlvry, ViewSapQty2570.LT_manual, ViewSapQty2570.LT_override_fl;

create table NascarQty( 
[MaterialNbr] [BIGINT] not null
      ,[SapPlantCd] [varchar](4) NOT NULL
      ,[SAPPurchasingOrgCD] [varchar](4) NOT NULL
      ,[SupplierMinPackageQt] [BIGINT]
      ,[SupplierMinOrderQt] [BIGINT]
      ,[SalesMinimumOrderQt] [BIGINT]
      ,[LT_plan_dlvry] [BIGINT]
      ,[LT_manual] [BIGINT]
      ,[LT_override_fl] [varchar](1))