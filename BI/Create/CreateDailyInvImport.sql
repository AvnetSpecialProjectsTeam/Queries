USE [BI]
GO

/****** Object:  Table [dbo].[ImportDailyInv]    Script Date: 9/27/2017 7:58:53 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
Drop table ImportDailyInv
CREATE TABLE [dbo].[ImportDailyInv](
	[log_dt] [varchar](max) NULL,
	[log_time] [varchar](max) NULL,
	[version_dt] [varchar](max) NULL,
	[material_nbr] [varchar](max) NULL,
	[mfg] [varchar](max) NULL,
	[mfg_part_nbr] [varchar](max) NULL,
	[material_type] [varchar](max) NULL,
	[pbg] [varchar](max) NULL,
	[prc_stgy] [varchar](max) NULL,
	[tech_cd] [varchar](max) NULL,
	[cc] [varchar](max) NULL,
	[grp] [varchar](max) NULL,
	[prod_hrchy] [varchar](max) NULL,
	[stk_prfl_plnt] [varchar](max) NULL,
	[stk_prfl_sls] [varchar](max) NULL,
	[abc] [varchar](max) NULL,
	[plant_nbr] [varchar](max) NULL,
	[storage_loc] [varchar](max) NULL,
	[mrp_cntrlr] [varchar](max) NULL,
	[demand_mgmt_fl] [varchar](max) NULL,
	[ncnr_fl] [varchar](max) NULL,
	[special_stk] [varchar](max) NULL,
	[cust_acct] [varchar](max) NULL,
	[cust_name] [varchar](max) NULL,
	[batch_nbr] [varchar](max) NULL,
	[purch_doc_nbr] [varchar](max) NULL,
	[created_on_dt] [varchar](max) NULL,
	[orig_goods_rcpt_dt] [varchar](max) NULL,
	[last_goods_rcpt_dt] [varchar](max) NULL,
	[blocked_stk] [varchar](max) NULL,
	[avl_stk_qty] [varchar](max) NULL,
	[ttl_stk_qty] [varchar](max) NULL,
	[ttl_stk_value] [varchar](max) NULL,
	[qit_stk_qty] [varchar](max) NULL,
	[moving_avg_price_calc] [varchar](max) NULL,
	[aged_days] [varchar](max) NULL,
	[profit_ctr] [varchar](max) NULL,
	[profit_ctr_desc] [varchar](max) NULL,
	[stock_type] [varchar](max) NULL,
	[total_stock_value] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO


