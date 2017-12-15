USE SAP 
GO


DROP TABLE ZtcCrmSupplySrv

CREATE TABLE ZtcCrmSupplySrv (
Client VARCHAR (4),
SoldToPartyId BIGINT,
SupplyChainServModel VARCHAR (2),
SupplyChainServ VARCHAR (2),
ReplenishCd VARCHAR (2),
)