DROP Table CAWTest.dbo.Invoices
Go

CREATE TABLE cawtest.dbo.Invoices
(
	InvoiceID Int Identity Primary Key,
	InvoiceDate date null,
	CustomerID int null Foreign Key References CAWtest.dbo.Customers(CustomerID),
	MethodOfPayment varchar(14) null Check (MethodOfPayment= 'Credit card' Or MethodOfPayment= 'Purchase Order')
);
