DROP TABLE CAWTest.dbo.Customers
GO

CREATE Table CAWTest.dbo.Customers
(
	CustomerID int IDENTITY PRIMARY KEY,
	FirstName varchar(50) not null,
	LastName varchar(50) not null,
	BillingAddress varchar(100) null,
	BillingCity varchar(50) null,
	BillingState Varchar(2) null,
	BillingZip varchar(5) null
);
GO