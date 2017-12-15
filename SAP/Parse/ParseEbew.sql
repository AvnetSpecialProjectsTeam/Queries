USE SAP
GO
Update ImportEBEW
Set [Column 12] = Replace([Column 12], '.', ''),
[Column 20] = Replace([Column 20], '.', ''),
[Column 28] = Replace([Column 28], '.', ''),
[Column 38] = Replace([Column 38], '.', '');

Update ImportEBEW
Set [Column 38] = STUFF(STUFF(STUFF([Column 38],13,0,':'),11,0,':'),9,0,' ');