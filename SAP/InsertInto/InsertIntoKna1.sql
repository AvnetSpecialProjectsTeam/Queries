Truncate Table sap.dbo.KNA1


-- Format 'DateonWhichtheChangesWereConfirmed'
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 136] = STUFF(STUFF([Column 136],5,0,'/'),8,0,'/') 
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 136] = Null Where [Column 136] = '0000/00/00'

-- Format 'TimeofLastChangeConfirmation'
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 137] = STUFF(STUFF([Column 137],3,0,'/'),6,0,'/') 
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 137] = Null Where [Column 137] = '00/00/00'

-- Format 'RGIssueDt'
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 145] = STUFF(STUFF([Column 145],5,0,'/'),8,0,'/') 
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 145] = Null Where [Column 145] = '0000/00/00'

-- Format 'RNEIssueDt'
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 148] = STUFF(STUFF([Column 148],5,0,'/'),8,0,'/') 
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 148] = Null Where [Column 148] = '0000/00/00'

-- Format 'PlantShutdownStartDt'
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 215] = STUFF(STUFF([Column 215],5,0,'/'),8,0,'/') 
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 215] = Null Where [Column 215] = '0000/00/00'

-- Format 'PlantShutdownEndDt'
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 216] = STUFF(STUFF([Column 216],5,0,'/'),8,0,'/') 
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 216] = Null Where [Column 216] = '0000/00/00'

-- Format 'SoldToDt'
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 217] = STUFF(STUFF([Column 217],5,0,'/'),8,0,'/') 
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 217] = Null Where [Column 217] = '0000/00/00'

-- Format 'StateofAssuranceOriginalAttachmentDt'
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 227] = STUFF(STUFF([Column 227],5,0,'/'),8,0,'/') 
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 227] = Null Where [Column 227] = '0000/00/00'

-- Format 'AttachmentDt'
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 228] = STUFF(STUFF([Column 228],5,0,'/'),8,0,'/')
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 228] = Null Where [Column 228] = '0000/00/00'

-- Format 'AttachmentDt1'
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 231] = STUFF(STUFF([Column 231],5,0,'/'),8,0,'/') 
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 231] = Null Where [Column 231] = '0000/00/00'

-- Format 'AttachmentDt2'
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 234] = STUFF(STUFF([Column 234],5,0,'/'),8,0,'/') 
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 234] = Null Where [Column 234] = '0000/00/00'

-- Format 'AttachmentDt3'
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 237] = STUFF(STUFF([Column 237],5,0,'/'),8,0,'/') 
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 237] = Null Where [Column 237] = '0000/00/00'

-- Format 'AttachmentDt4'
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 240] = STUFF(STUFF([Column 240],5,0,'/'),8,0,'/') 
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 240] = Null Where [Column 240] = '0000/00/00'

-- Format 'CustSince'
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 261] = STUFF(STUFF([Column 261],5,0,'/'),8,0,'/') 
Update NonHaImportTesting.[dbo].[ImportKNA1] Set [Column 261] = Null Where [Column 261] = '0000/00/00'

Insert Into sap.dbo.Kna1 Select * From [NonHaImportTesting].[dbo].[ImportKNA1] Where [Column 0] <>  ' ' AND [Column 0] Is Not Null

Truncate Table NonHaImportTesting.[dbo].[ImportKNA1];
