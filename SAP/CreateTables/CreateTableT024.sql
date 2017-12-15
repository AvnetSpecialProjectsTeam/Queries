CREATE TABLE T024 (
Client VARCHAR (4),
PurcGrp VARCHAR (4),
DescPurcGp VARCHAR (19),
TelNbrPurcGrpBuyGrp DECIMAL (12),
SpoolOutDev VARCHAR (5),
FaxNbrPurcBuyGrp DECIMAL (31),
TelDialCodeNbr DECIMAL (30),
TelExt DECIMAL (10),
EMailAdd VARCHAR (242),
PRIMARY KEY (Client, PurcGrp)
)