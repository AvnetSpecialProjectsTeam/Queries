use NascarProd
go
drop table NascarOpenShipDebitArchive
create table NascarOpenShipDebitArchive
	(
	LogDt date,
	SapAgreement varchar(20),
	AuthorizationNbr varchar(20),
	ValidFrom date,
	ValidTo date,
	SoldToParty varchar(15),
	ShipToParty varchar(15),
	EndCustomer varchar(15),
	MaterialNbr varchar(20),
	Rate float (9),
	RemainingQtyVistex bigint,
	AvnetResale float (9)
	)
