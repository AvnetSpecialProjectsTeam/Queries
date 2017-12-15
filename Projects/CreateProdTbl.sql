Drop Table CAWTest.dbo.Products

Create table CAWTest.dbo.Products
(
	ProductID int identity Primary Key,
	OilType varchar(50) null,
	BottleSize Float null,
	BottleWeight Float null,
	Price Money null
);