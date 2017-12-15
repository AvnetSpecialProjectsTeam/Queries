DROP Table CAWTest.dbo.LineItems

CREATE Table CAWtest.dbo.LineItems
(
	InvoiceID Int,
	LineItemNumber int,
	ProductID int null,
	Quantity int null,
	PRIMARY KEY(InvoiceID, LineItemNumber),
	CONSTRAINT fk_LineProd Foreign Key(ProductID)
	References CAWTest.dbo.Products(ProductID)
);