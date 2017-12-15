Truncate Table Sap.dbo.Knvv

Insert Into Sap.dbo.Knvv(
Client--,[Column 0]
,CustNbr--,[Column 1]
,SalesOrg--,[Column 2]
,DistrChannel--,[Column 3]
,Division--,[Column 4]
,EnteredBy--,[Column 5]
,CreatedOn--,[Column 6]
,AuthorizationGrp--,[Column 7]
,CentralDeletionFlagForMasterRecord--,[Column 8]
,MaterialStatisticsGrp--,[Column 9]
,CentralOrderBlockForCust--,[Column 10]
,CustPriceProcedure--,[Column 11]
,TechnicalFeeForSvc--,[Column 12]
,SalesDistrict--,[Column 13]
,PriceGrpCust--,[Column 14]
,PriceListType--,[Column 15]
,SalesProb--,[Column 16]
,IncotermsPart1--,[Column 17]
,IncotermsPart2--,[Column 18]
,CentralDeliveryBlockForTheCust--,[Column 19]
,CompleteDeliveryDefinedForEachSalesOrder--,[Column 20]
,MaxNbrPartDelAllPerItm--,[Column 21]
,PartDelItmLvl--,[Column 22]
,OrderComboId--,[Column 23]
,BatchSplitAll--,[Column 24]
,DeliveryPriority--,[Column 25]
,AccountNbrAtCust--,[Column 26]
,ShippingConditions--,[Column 27]
,CentralBillingBlockForCust--,[Column 28]
,ManualInvoiceMantenance--,[Column 29]
,InvoiceDtsCalendarId--,[Column 30]
,InvoiceListSchedule--,[Column 31]
,CostEstimateInd--,[Column 32]
,CostEstimateLimit--,[Column 33]
,Currency--,[Column 34]
,CustClassABC--,[Column 35]
,AcctAssignmentGrpThisCust--,[Column 36]
,PmtKeyTerms--,[Column 37]
,DlvryPlant--,[Column 38]
,SaleGrp--,[Column 39]
,SalesOffice--,[Column 40]
,ItmProposal--,[Column 41]
,CustGrp1--,[Column 42]
,CustGrp2--,[Column 43]
,CustGrp3--,[Column 44]
,CustGrp4--,[Column 45]
,CustGrp5--,[Column 46]
,Rebate--,[Column 47]
,RebateIndex--,[Column 48]
,ExchangeRateType2--,[Column 49]
,PriceDetermin--,[Column 50]
,NcnrFlag--,[Column 51]
,LiquidtFlag--,[Column 52]
,CustomProduct--,[Column 53]
,SoftwareLicenseRequired--,[Column 54]
,NdaRequired--,[Column 55]
,DownloadableFlag--,[Column 56]
,DualMarkingId--,[Column 57]
,WaiverRequired--,[Column 58]
,GlobalInventory--,[Column 59]
,NaftaFlag--,[Column 60]
,CustPayGuaranteeProcedure--,[Column 61]
,CreditControlArea--,[Column 62]
,CentralSalesBlockForCust--,[Column 63]
,RoundingOff--,[Column 64]
,AgencyBusInd--,[Column 65]
,UntMeasGrp--,[Column 66]
,OvrTolLmt--,[Column 67]
,UndTolLmt--,[Column 68]
,UnlOvrAll--,[Column 69]
,CustProcedureProdProposal--,[Column 70]
,RelevantPODProcessing--,[Column 71]
,PODConfirmTimeframe--,[Column 72]
,BudgetaryLedgerId--,[Column 73]
,CarrierNotification--,[Column 74]
,PurposeCompleteInd--,[Column 75]
,DepositOnEmpties--,[Column 76]
,EmptiesUpdtInd--,[Column 77]
,ShipWindowEarly--,[Column 78]
,ShipWindowLate--,[Column 79]
,CutoffWeight--,[Column 80]
,FreightCdUnderCutoff--,[Column 81]
,FreightAcctUnderCutoff--,[Column 82]
,ShippingServiceLvlOverCutoff--,[Column 83]
,FreightCdOverCutoff--,[Column 84]
,FreightAcctOverCutoff--,[Column 85]
,SingleLotDtCd--,[Column 86]
,MaxDtCdAging--,[Column 87]
,FreightConsolidation--,[Column 88]
,Segment--,[Column 89]
,AcctTyp--,[Column 90]
,BillSpecialHandling--,[Column 91]
,RegistrationMatchHigher--,[Column 92]
,PayTermsException--,[Column 93]
,FreightOnBoard--,[Column 94]
,CustInspect--,[Column 95]
,InvoiceFlag--,[Column 96]
,XilinxSoldTo--,[Column 97]
,XilinxShipTo--,[Column 98]
,XilinxHubID--,[Column 99]
,ExemptFromATPOver--,[Column 100]
,SHC--,[Column 101]
,MinBusUnit--,[Column 102]
,TechFee--,[Column 103]
)
Select 
[Column 0]
,[Column 1]
,[Column 2]
,[Column 3]
,[Column 4]
,[Column 5]
,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 6],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) is null then null else Try_Cast(STUFF(STUFF(Replace(Replace([Column 6],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) End
,[Column 7]
,[Column 8]
,[Column 9]
,[Column 10]
,[Column 11]
,[Column 12]
,[Column 13]
,[Column 14]
,[Column 15]
,[Column 16]
,[Column 17]
,[Column 18]
,[Column 19]
,[Column 20]
,Replace([Column 21], '.','')
,[Column 22]
,[Column 23]
,[Column 24]
,[Column 25]
,[Column 26]
,[Column 27]
,[Column 28]
,[Column 29]
,[Column 30]
,[Column 31]
,[Column 32]
,[Column 33]
,[Column 34]
,[Column 35]
,[Column 36]
,[Column 37]
,[Column 38]
,[Column 39]
,[Column 40]
,[Column 41]
,[Column 42]
,[Column 43]
,[Column 44]
,[Column 45]
,[Column 46]
,[Column 47]
,Case When Try_Cast(STUFF(STUFF(Replace(Replace([Column 48],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) is null then null else Try_Cast(STUFF(STUFF(Replace(Replace([Column 48],'/',''),' ',''),5,0,'/'),8,0,'/') as datetime2) End
,[Column 49]
,[Column 50]
,[Column 51]
,[Column 52]
,[Column 53]
,[Column 54]
,[Column 55]
,[Column 56]
,[Column 57]
,[Column 58]
,[Column 59]
,[Column 60]
,[Column 61]
,[Column 62]
,[Column 63]
,[Column 64]
,[Column 65]
,[Column 66]
,[Column 67]
,[Column 68]
,[Column 69]
,[Column 70]
,[Column 71]
,Replace([Column 72],'.','')
,[Column 73]
,[Column 74]
,[Column 75]
,[Column 76]
,[Column 77]
,[Column 78]
,[Column 79]
,[Column 80]
,[Column 81]
,[Column 82]
,[Column 83]
,[Column 84]
,[Column 85]
,[Column 86]
,[Column 87]
,[Column 88]
,[Column 89]
,[Column 90]
,[Column 91]
,[Column 92]
,[Column 93]
,[Column 94]
,[Column 95]
,[Column 96]
,[Column 97]
,[Column 98]
,[Column 99]
,[Column 100]
,[Column 101]
,[Column 102]
,[Column 103]
From NonHaImportTesting.dbo.ImportKnvv
Where [Column 0] IS Not Null And [Column 0] <> '' 
AND (LEN([Column 0])<4 Or Len([Column 0]) IS Null)
AND (LEN([Column 1])<11 Or Len([Column 1]) IS Null)
AND (LEN([Column 2])<5 Or Len([Column 2]) IS Null)
AND (LEN([Column 3])<3 Or Len([Column 3]) IS Null)
AND (LEN([Column 4])<3 Or Len([Column 4]) IS Null)
AND (LEN([Column 5])<13 Or Len([Column 5]) IS Null)
AND (LEN([Column 7])<5 Or Len([Column 7]) IS Null)
AND (LEN([Column 8])<2 Or Len([Column 8]) IS Null)
AND (LEN([Column 9])<2 Or Len([Column 9]) IS Null)
AND (LEN([Column 10])<3 Or Len([Column 10]) IS Null)
AND (LEN([Column 11])<2 Or Len([Column 11]) IS Null)
AND (LEN([Column 12])<3 Or Len([Column 12]) IS Null)
AND (LEN([Column 13])<7 Or Len([Column 13]) IS Null)
AND (LEN([Column 14])<3 Or Len([Column 14]) IS Null)
AND (LEN([Column 15])<3 Or Len([Column 15]) IS Null)
AND (LEN([Column 17])<4 Or Len([Column 17]) IS Null)
AND (LEN([Column 18])<29 Or Len([Column 18]) IS Null)
AND (LEN([Column 19])<3 Or Len([Column 19]) IS Null)
AND (LEN([Column 20])<2 Or Len([Column 20]) IS Null)
AND (LEN([Column 22])<2 Or Len([Column 22]) IS Null)
AND (LEN([Column 23])<2 Or Len([Column 23]) IS Null)
AND (LEN([Column 24])<2 Or Len([Column 24]) IS Null)
AND (LEN([Column 26])<13 Or Len([Column 26]) IS Null)
AND (LEN([Column 27])<3 Or Len([Column 27]) IS Null)
AND (LEN([Column 28])<3 Or Len([Column 28]) IS Null)
AND (LEN([Column 29])<2 Or Len([Column 29]) IS Null)
AND (LEN([Column 30])<3 Or Len([Column 30]) IS Null)
AND (LEN([Column 31])<3 Or Len([Column 31]) IS Null)
AND (LEN([Column 32])<2 Or Len([Column 32]) IS Null)
AND (LEN([Column 34])<6 Or Len([Column 34]) IS Null)
AND (LEN([Column 35])<3 Or Len([Column 35]) IS Null)
AND (LEN([Column 36])<3 Or Len([Column 36]) IS Null)
AND (LEN([Column 37])<5 Or Len([Column 37]) IS Null)
AND (LEN([Column 38])<5 Or Len([Column 38]) IS Null)
AND (LEN([Column 39])<4 Or Len([Column 39]) IS Null)
AND (LEN([Column 40])<5 Or Len([Column 40]) IS Null)
AND (LEN([Column 41])<11 Or Len([Column 41]) IS Null)
AND (LEN([Column 42])<4 Or Len([Column 42]) IS Null)
AND (LEN([Column 43])<4 Or Len([Column 43]) IS Null)
AND (LEN([Column 44])<4 Or Len([Column 44]) IS Null)
AND (LEN([Column 45])<4 Or Len([Column 45]) IS Null)
AND (LEN([Column 46])<4 Or Len([Column 46]) IS Null)
AND (LEN([Column 47])<2 Or Len([Column 47]) IS Null)
AND (LEN([Column 49])<5 Or Len([Column 49]) IS Null)
AND (LEN([Column 50])<2 Or Len([Column 50]) IS Null)
AND (LEN([Column 51])<2 Or Len([Column 51]) IS Null)
AND (LEN([Column 52])<2 Or Len([Column 52]) IS Null)
AND (LEN([Column 53])<2 Or Len([Column 53]) IS Null)
AND (LEN([Column 54])<2 Or Len([Column 54]) IS Null)
AND (LEN([Column 55])<2 Or Len([Column 55]) IS Null)
AND (LEN([Column 56])<2 Or Len([Column 56]) IS Null)
AND (LEN([Column 57])<2 Or Len([Column 57]) IS Null)
AND (LEN([Column 58])<2 Or Len([Column 58]) IS Null)
AND (LEN([Column 59])<2 Or Len([Column 59]) IS Null)
AND (LEN([Column 60])<2 Or Len([Column 60]) IS Null)
AND (LEN([Column 61])<5 Or Len([Column 61]) IS Null)
AND (LEN([Column 62])<5 Or Len([Column 62]) IS Null)
AND (LEN([Column 63])<3 Or Len([Column 63]) IS Null)
AND (LEN([Column 64])<2 Or Len([Column 64]) IS Null)
AND (LEN([Column 65])<2 Or Len([Column 65]) IS Null)
AND (LEN([Column 66])<5 Or Len([Column 66]) IS Null)
AND (LEN([Column 69])<2 Or Len([Column 69]) IS Null)
AND (LEN([Column 70])<3 Or Len([Column 70]) IS Null)
AND (LEN([Column 71])<2 Or Len([Column 71]) IS Null)
AND (LEN([Column 73])<2 Or Len([Column 73]) IS Null)
AND (LEN([Column 74])<2 Or Len([Column 74]) IS Null)
AND (LEN([Column 75])<2 Or Len([Column 75]) IS Null)
AND (LEN([Column 76])<2 Or Len([Column 76]) IS Null)
AND (LEN([Column 77])<2 Or Len([Column 77]) IS Null)
AND (LEN([Column 81])<2 Or Len([Column 81]) IS Null)
AND (LEN([Column 82])<13 Or Len([Column 82]) IS Null)
AND (LEN([Column 83])<4 Or Len([Column 83]) IS Null)
AND (LEN([Column 84])<2 Or Len([Column 84]) IS Null)
AND (LEN([Column 85])<13 Or Len([Column 85]) IS Null)
AND (LEN([Column 86])<2 Or Len([Column 86]) IS Null)
AND (LEN([Column 88])<2 Or Len([Column 88]) IS Null)
AND (LEN([Column 89])<3 Or Len([Column 89]) IS Null)
AND (LEN([Column 90])<2 Or Len([Column 90]) IS Null)
AND (LEN([Column 91])<2 Or Len([Column 91]) IS Null)
AND (LEN([Column 92])<2 Or Len([Column 92]) IS Null)
AND (LEN([Column 93])<5 Or Len([Column 93]) IS Null)
AND (LEN([Column 94])<3 Or Len([Column 94]) IS Null)
AND (LEN([Column 95])<7 Or Len([Column 95]) IS Null)
AND (LEN([Column 96])<2 Or Len([Column 96]) IS Null)
AND (LEN([Column 97])<11 Or Len([Column 97]) IS Null)
AND (LEN([Column 98])<31 Or Len([Column 98]) IS Null)
AND (LEN([Column 99])<11 Or Len([Column 99]) IS Null)
AND (LEN([Column 100])<2 Or Len([Column 100]) IS Null)
AND (LEN([Column 101])<6 Or Len([Column 101]) IS Null)
AND (LEN([Column 103])<16 Or Len([Column 103]) IS Null)
AND (ISNUMERIC([Column 16])=1 or [Column 16] is null or [Column 16] = '')
AND (ISNUMERIC([Column 21])=1 or [Column 21] is null or [Column 21] = '')
AND (ISNUMERIC([Column 25])=1 or [Column 25] is null or [Column 25] = '')
AND (ISNUMERIC([Column 33])=1 or [Column 33] is null or [Column 33] = '')
AND (ISNUMERIC([Column 67])=1 or [Column 67] is null or [Column 67] = '')
AND (ISNUMERIC([Column 68])=1 or [Column 68] is null or [Column 68] = '')
AND (ISNUMERIC([Column 72])=1 or [Column 72] is null or [Column 72] = '')
AND (ISNUMERIC([Column 78])=1 or [Column 78] is null or [Column 78] = '')
AND (ISNUMERIC([Column 79])=1 or [Column 79] is null or [Column 79] = '')
AND (ISNUMERIC([Column 80])=1 or [Column 80] is null or [Column 80] = '')
AND (ISNUMERIC([Column 87])=1 or [Column 87] is null or [Column 87] = '')
AND (ISNUMERIC([Column 102])=1 or [Column 102] is null or [Column 102] = '')
