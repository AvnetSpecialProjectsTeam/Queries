USE SAP
GO

UPDATE ImportMBEW
Set [Column 105] = Replace([Column 105], '.', ''),
[Column 10] = Replace([Column 10], '.', ''),
[Column 18] = Replace([Column 18], '.', ''),
[Column 26] = Replace([Column 26], '.', ''),
[Column 36] = Replace([Column 36], '.', '');

UPDATE IMportMBEW
SET [Column 36] = STUFF(STUFF(STUFF([Column 36],13,0,':'),11,0,':'),9,0,' ');