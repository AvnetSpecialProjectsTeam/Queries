select MaterialNbr, Sum(Cast(Replace(RemainingQty,',','') as int)) as RemainingQty  from bi.dbo.SalesOrderBacklog where salesdoctyp = 'ZKB1' group by MaterialNbr Order by RemainingQty