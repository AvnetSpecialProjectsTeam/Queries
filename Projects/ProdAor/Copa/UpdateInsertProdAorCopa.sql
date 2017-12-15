--USE BI
--GO

--BEGIN

--UPDATE ProdAorCopaImport
--	SET [Orig Sales Ord Num]=
--		CASE WHEN [Orig Sales Ord Num] LIKE '%[a-z,!@#$^&()]%' THEN REPLACE([Orig Sales Ord Num], '#','')
--		ELSE [Orig Sales Ord Num]
--		END
--	,[Original Billing document]=
--		CASE WHEN [Original Billing document] LIKE '%[a-z,!@#$^&()]%' THEN REPLACE([Original Billing document], '#','')
--		ELSE [Original Billing document]
--		END
--	,[group code text]=
--		CASE WHEN [group code text] LIKE '%[a-z,!@#$^&()"]%' THEN REPLACE([group code text], '"','')
--		ELSE [group code text]
--		END
--END
--GO


INSERT INTO BI.dbo.ProdAorCopaUpdate
	(
	[PostingDate]
      ,[OriginalBillingDocDateTd]
      ,[OrigSalesOrdNum]
      ,[Co-PaSalesOrderNumber]
      ,[SalesOrdLiItem]
      ,[OriginalBillingDocument]
      ,[BillLiItem]
      ,[BillingType]
      ,[SalesDocumentType]
      ,[SalesDocText]
      ,[ResaleSource]
      ,[CostSourceValue]
      ,[CustomerHierarchy1]
      ,[CustomerNumber]
      ,[CustomerText]
      ,[Co-PaManufacturer]
      ,[MfrText]
      ,[Material]
      ,[MaterialText]
      ,[DrActiveStatus]
      ,[DrStatusText]
      ,[ProdHier(3)Pbg]
      ,[ProdHierText]
      ,[SalesOrganization]
      ,[SalesOrgText]
      ,[SalesGroup]
      ,[SalesGroupText]
      ,[SalesOffice]
      ,[SalesOfficeText]
      ,[Co-PaPlant]
      ,[PlantText]
      ,[ProcurementStrategy]
      ,[ProcurementText]
      ,[TechnologyCode]
      ,[TechCodeText]
      ,[CommodityCode]
      ,[CommCodeText]
      ,[GroupCode]
      ,[GroupCodeText]
      ,[ItemCategory]
      ,[InvoiceQty]
      ,[FinanceResale]
      ,[FinanceCost]
      ,[Ship&DebitValueFrom50003]
      ,[FinanceGpMargin]
      ,[FinanceGp%]
      ,[SalesResale]
      ,[SalesCost]
      ,[SalesGpMargin]
      ,[SalesGp%]
      ,[Gp%Variance]
      ,[SalesUnitResale(So)]
      ,[FinanceUnitResale]
      ,[UnitResaleDifference]
      ,[SalesUnitCost(So)]
      ,[FinanceUnitCost]
      ,[UnitCostDifference]
	)
SELECT [Posting date]
      ,[Original Billing Doc date  TD ]
      ,CASE WHEN [Orig Sales Ord Num] LIKE '%[a-z,!@#$^&()]%' THEN REPLACE([Orig Sales Ord Num], '#','')
		ELSE [Orig Sales Ord Num]
		END
      ,[CO-PA  Sales Order Number]
      ,[Sales Ord LI Item]
      ,CASE WHEN [Original Billing document] LIKE '%[a-z,!@#$^&()]%' THEN REPLACE([Original Billing document], '#','')
		ELSE [Original Billing document]
		END
      ,[Bill LI Item]
      ,[Billing Type]
      ,[Sales document type]
      ,[sales doc text]
      ,[Resale Source]
      ,[Cost Source Value]
      ,[Customer Hierarchy 1]
      ,[Customer number]
      ,[customer text]
      ,[CO-PA  Manufacturer]
      ,[MFR text]
      ,[Material]
      ,[Material text]
      ,[DR Active Status]
      ,[DR status text]
      ,[Prod Hier(3) PBG]
      ,[Prod hier text]
      ,[Sales Organization]
      ,[sales org text]
      ,[Sales group]
      ,[sales group text]
      ,[Sales Office]
      ,[sales office text]
      ,[CO-PA  Plant]
      ,[Plant text]
      ,[Procurement Strategy]
      ,[procurement text]
      ,[Technology Code]
      ,[tech code text]
      ,[Commodity Code]
      ,[comm code text]
      ,[Group Code]
      ,CASE WHEN [group code text] LIKE '%[a-z,!@#$^&()"]%' THEN REPLACE([group code text], '"','')
		ELSE [group code text]
		END
      ,[Item category]
      ,[Invoice Qty]
      ,[Finance Resale]
      ,[Finance Cost]
      ,[Ship&Debit Value from 50003]
      ,[Finance GP Margin]
      ,[Finance GP%]
      ,[Sales Resale]
      ,[Sales Cost]
      ,[Sales GP Margin]
      ,[Sales GP%]
      ,[GP% Variance]
      ,[Sales Unit Resale ( SO)]
      ,[Finance Unit Resale]
      ,[Unit Resale Difference]
      ,[Sales Unit Cost (SO)]
      ,[Finance Unit Cost]
      ,[Unit Cost Difference]
  FROM NonHaImportTesting.[dbo].[ImportProdAorCopa]

  TRUNCATE TABLE NonHaImportTesting.[dbo].[ImportProdAorCopa]

