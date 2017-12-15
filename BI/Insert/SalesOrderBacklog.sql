USE BI 
GO 

Select * From BIImportSalesOrderBacklog Where [Column 18] <> '0IT' AND [Column 18] <> '0ST'  Group By [Column 18] 
----
Truncate Table SalesOrderBacklog
----
Insert Into SalesOrderBacklog
Select * from BIImportSalesOrderBacklog Where [Column 0] <> ' '
----
Truncate Table BIImportSalesOrderBacklog
-----