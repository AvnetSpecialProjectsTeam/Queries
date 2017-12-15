USE BI
GO

TRUNCATE TABLE DailyInv

DECLARE @cnt INT=0

WHILE @cnt<2
	BEGIN
		UPDATE ImportDailyInv
			SET total_stock_value=
				CASE
					WHEN total_stock_value LIKE '%[$]%' THEN REPLACE(total_stock_value,'$','')
					WHEN total_stock_value LIKE '%[()]%' THEN CONCAT('-',REPLACE(REPLACE(total_stock_value,'(',''),')',''))
					ELSE total_stock_value
				END
			,[ttl_stk_value]=
				CASE
					WHEN [ttl_stk_value] LIKE '%[$]%' THEN REPLACE([ttl_stk_value],'$','')
					WHEN [ttl_stk_value] LIKE '%[()]%' THEN CONCAT('-',REPLACE(REPLACE([ttl_stk_value],'(',''),')',''))
					ELSE [ttl_stk_value]
				END
			,[moving_avg_price_calc]=
				CASE
					WHEN [moving_avg_price_calc] LIKE '%[$]%' THEN REPLACE([moving_avg_price_calc],'$','')
					WHEN [moving_avg_price_calc] LIKE '%[()]%' THEN CONCAT('-',REPLACE(REPLACE([moving_avg_price_calc],'(',''),')',''))
					ELSE [moving_avg_price_calc]
				END
			,profit_ctr=
				CASE
					WHEN profit_ctr LIKE '%[.]%' THEN NULL
					ELSE profit_ctr
				END
		SET @cnt=@cnt+1
	END
GO



INSERT INTO DailyInv(
	 [LogDt]
	,[LogTime]
	,[VersionDt]
	,[MaterialNbr]
	,[Mfg]
	,[MfgPartNbr]
	,[MaterialType]
	,[Pbg]
	,[PrcStgy]
	,[TechCd]
	,[Cc]
	,[Grp]
	,[StkPrflPlnt]
	,[StkPrflSls]
	,[Abc]
	,[Plant]
	,[StorageLoc]
	,[MrpCntrlr]
	,[NcnrFl]
	,[SpecialStk]
	,[CustAcct]
	,[CustName]
	,[BatchNbr]
	,[PurchDocNbr]
	,[CreatedOnDt]
	,[OrigGoodsRcptDt]
	,[LastGoodsRcptDt]
	,[BlockedStk]
	,[AvlStkQty]
	,[TtlStkQty]
	,[TtlStkValue]
	,[QitStkQty]
	,[MovingAvgPriceCalc]
	,[AgedDays]
	,[ProfitCtr]
	,[ProfitCtrDesc]
	,[StockType]
	,[TotalStockValue]
)
SELECT
	[log_dt]
    ,[log_time]
    ,[version_dt]
    ,[material_nbr]
    ,[mfg]
    ,[mfg_part_nbr]
    ,[material_type]
    ,[pbg]
    ,[prc_stgy]
    ,[tech_cd]
    ,[cc]
    ,[grp]
    ,[stk_prfl_plnt]
    ,[stk_prfl_sls]
    ,[abc]
    ,[plant_nbr]
    ,[storage_loc]
    ,[mrp_cntrlr]
    ,[ncnr_fl]
    ,[special_stk]
    ,[cust_acct]
    ,[cust_name]
    ,[batch_nbr]
    ,[purch_doc_nbr]
    ,[created_on_dt]
    ,[orig_goods_rcpt_dt]
    ,[last_goods_rcpt_dt]
    ,CAST([blocked_stk] AS FLOAT)
    ,CAST([avl_stk_qty] AS FLOAT)
    ,CAST([ttl_stk_qty] AS FLOAT)
    ,[ttl_stk_value]
    ,CAST([qit_stk_qty] AS FLOAT) 
    ,[moving_avg_price_calc]
    ,CAST([aged_days] AS FLOAT)
    ,[profit_ctr]
    ,[profit_ctr_desc]
    ,[stock_type]
    ,[total_stock_value]
FROM ImportDailyInv


TRUNCATE TABLE ImportZsbBacklog