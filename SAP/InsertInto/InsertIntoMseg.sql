Use NonHaImportTesting
Go

TRUNCATE TABLE Sap.dbo.Mseg
Go


INSERT INTO Sap.dbo.Mseg (
Client
,MaterialDocNbr
,MatDocYearMJAHR
,MatDocItmZEILE
,DocLineId
,ParentId
,Level
,MovementTyp
,AutoCreated
,Material
,Plant
,StorLoc
,BatchNbr
,PostInspectStk
,BatchStatusKey
,BatchRestr
,SpecialStk
,Vendor
,SoldToPartyId
,SalesOrderNbr
,SalesOrderItm
,SalesOrderDlvrySched
,Dist
,Returns
,OrderCurrency
,AmtLocalCurr
,DlvryCostsLocalCurr
,AmountAltPriceCtrl
,DCIdReval
,RevaluationAmtBackPost
,ValTyp
,SchedQty
,UnitOfMeasure
,UnitOfEntryQty
,UnitOfEntry
,QtyPoPriceUnit
,OrderPriceUnit
,PoNbr
,PoItmNbr
,FYRefDoc
,RefDoc
,RefDocItm
,MatDocYear
,MatDoc
,MatDocItmSMBLP
,DlvryCompleteId
,EquipmentNbr
,Recipient
,UnloadingPoint
,BusArea
,CoArea
,TradingPartBusArea
,ClearingCoCd
,CostCenter
,NbrNotUse
,OrderNbr
,Asset
,AssetSubNbr
,CctPostingStatId
,OrderPostStatId
,ProjPostStatId
,PaPostStatId
,FY
,PostPrevPer
,PostTtlPrYearId
,CoCd
,AcctDocNbr1
,AcctDocLineItmNbr
,AcctDocNbr2
,LineItm
,Reservation
,ReservationItmBbr
,FinalIssue
,Qty2
,StatRelevant
,ReceivingMat1
,ReceivingIssuingPlant
,ReceivingStorLoc
,ReceivingIssuingBatch
,TransBatchStat
,TransBatchStatKey
,ValTypTransBatch
,SpIdStckTransBatch
,MvmtId
,Consumption
,ReceiptId
,NonValueGoodsReceipt
,NbrOfPallets
,WarehouseNbr
,StorTyp
,StorBin
,StkCat
,MvmtTyp
,TransReqNbr
,TransReqItm
,WarehousePostId
,IntStPstSrcId
,InterPostDest
,DynamicBin
,PostingChangeNbr
,TransPrior
,TransOrderNbr
,NbrGrSlips
,ReasonForMvmt
,ShippingInstruct
,ShipInstructCompliance
,RealEstateKey
,CostObject
,ProfitSegment
,ProfitCenter
,WbsElement
,Network
,PlanNbrOper
,InternalCounter
,OrderItmNbr
,PartnerAccNbr
,CommitmentItm
,GLAcct
,QtyOrderUnit
,PoUnitMeasure
,RevGrDespInv
,VendorSupplied
,ExtPostAmtLocalCurr
,SalValIncVat
,Promotion
,SeqNbrAccAss
,ShelfLifeExp
,IntObjNbrBatchClass2
,ExtEnteredSalesVal
,PartnerPc
,RecOrderTyp
,Fund
,FundsCenter
,StkMat
,ReceivingMat2
,QtyString
,ValString
,QtyUpdating
,ValUpDt
,TtlValStk
,ValTtlValStk
,PriceControl
,FunctionalArea
,ReferenceDtSettle1
,SalValWOVat
,ReferenceDtSettle2
,AutoPo
,DlvryNbrNoteQty
,DlvryNbrNoteUnit
,Valuation
,StatusGRDoc
,OrigLineMatDoc
,AltBaseAmnt
,TaxCd1
,TaxJur1
,MatNbrMfgPartNbr
,GoodsIssueReEvalPerformed
,TaxCd2
,DtMfg
,StagingId
,SalesOrderNbrStk
,SalesOrderItmStk
,SoWbsElement
,CalcOfValOpen
,AcctId
,BusProcess
,SupplVendor
,ActivityTyp
,VendorStkValId
,[Grant]
,StkTypMod
,GtsStkTyp
,ExciseDutyStatus
,UserName2
,ChangedOn
,SysTime
,NonDeductible
,Condkey1
,Condkey2
,Text
,EarmarkedFundsDocNbr
,EarmarkedFundsDocItm
,MultiAcctAssgt
,TransactEventTyp2
,DocPostingDt2
,EnteredOnDt2
,EnteredAtTime2
,UserName
,RefDocNbr
,TransactionCode3
,Delivery1
,DlvryItm2
,OwnerOfStk
,StkSegment
,RecStkSeg
)
SELECT
[Column 0]
, [Column 1]
, [Column 2]
, [Column 3]
, [Column 4]
, [Column 5]
, [Column 6]
, [Column 7]
, [Column 8]
, [Column 9]
, [Column 10]
, [Column 11]
, [Column 12]
, [Column 13]
, [Column 14]
, [Column 15]
, [Column 16]
, [Column 17]
, [Column 18]
, [Column 19]
, [Column 20]
, [Column 21]
, [Column 22]
, [Column 23]
, [Column 24]
, [Column 25]
, [Column 26]
, [Column 27]
, [Column 28]
, [Column 29]
, [Column 30]
, [Column 31]
, [Column 32]
, [Column 33]
, [Column 34]
, [Column 35]
, [Column 36]
, [Column 37]
, [Column 38]
, [Column 39]
, [Column 40]
, [Column 41]
, [Column 42]
, [Column 43]
, [Column 44]
, [Column 45]
, [Column 46]
, [Column 47]
, [Column 48]
, [Column 49]
, [Column 50]
, [Column 51]
, [Column 52]
, [Column 53]
, [Column 54]
, [Column 55]
, [Column 56]
, [Column 57]
, [Column 58]
, [Column 59]
, [Column 60]
, [Column 61]
, [Column 62]
, [Column 63]
, [Column 64]
, [Column 65]
, [Column 66]
, [Column 67]
, [Column 68]
, [Column 69]
, [Column 70]
, [Column 71]
, [Column 72]
, [Column 73]
, [Column 74]
, [Column 75]
, [Column 76]
, [Column 77]
, [Column 78]
, [Column 79]
, [Column 80]
, [Column 81]
, [Column 82]
, [Column 83]
, [Column 84]
, [Column 85]
, [Column 86]
, [Column 87]
, [Column 88]
, [Column 89]
, [Column 90]
, [Column 91]
, [Column 92]
, [Column 93]
, [Column 94]
, [Column 95]
, [Column 96]
, [Column 97]
, [Column 98]
, [Column 99]
, [Column 100]
, [Column 101]
, [Column 102]
, [Column 103]
, [Column 104]
, [Column 105]
, [Column 106]
, [Column 107]
, [Column 108]
, [Column 109]
, [Column 110]
, [Column 111]
, [Column 112]
, [Column 113]
, [Column 114]
, [Column 115]
, [Column 116]
, [Column 117]
, [Column 118]
, [Column 119]
, [Column 120]
, [Column 121]
, [Column 122]
, [Column 123]
, [Column 124]
, [Column 125]
, [Column 126]
, [Column 127]
, [Column 128]
, [Column 129]
, [Column 130]
, [Column 131]
, [Column 132]
, [Column 133]
, [Column 134]
, [Column 135]
, [Column 136]
, [Column 137]
, [Column 138]
, [Column 139]
, [Column 140]
, [Column 141]
, [Column 142]
, case when TRY_CAST(STUFF(STUFF(Replace(Replace([Column 143], ' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else STUFF(STUFF(Replace(Replace([Column 143], ' ',''),'/',''),5,0,'/'),8,0,'/') end
, [Column 144]
, case when TRY_CAST(STUFF(STUFF(Replace(Replace([Column 145], ' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else STUFF(STUFF(Replace(Replace([Column 145], ' ',''),'/',''),5,0,'/'),8,0,'/') end
, [Column 146]
, [Column 147]
, [Column 148]
, [Column 149]
, [Column 150]
, [Column 151]
, [Column 152]
, [Column 153]
, [Column 154]
, [Column 155]
, [Column 156]
, [Column 157]
, case when TRY_CAST(STUFF(STUFF(Replace(Replace([Column 158], ' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else STUFF(STUFF(Replace(Replace([Column 158], ' ',''),'/',''),5,0,'/'),8,0,'/') end
, [Column 159]
, [Column 160]
, [Column 161]
, [Column 162]
, [Column 163]
, [Column 164]
, [Column 165]
, [Column 166]
, [Column 167]
, [Column 168]
, [Column 169]
, [Column 170]
, [Column 171]
, [Column 172]
, [Column 173]
, case when TRY_CAST(STUFF(STUFF(Replace(Replace([Column 174], ' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else STUFF(STUFF(Replace(Replace([Column 174], ' ',''),'/',''),5,0,'/'),8,0,'/') end
, [Column 175]
, [Column 176]
, [Column 177]
, [Column 178]
, [Column 179]
, [Column 180]
, [Column 181]
, [Column 182]
, [Column 183]
, case when TRY_CAST(STUFF(STUFF(Replace(Replace([Column 184], ' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else STUFF(STUFF(Replace(Replace([Column 184], ' ',''),'/',''),5,0,'/'),8,0,'/') end
, case when TRY_CAST(STUFF(STUFF(Replace(Replace([Column 185], ' ',''),'/',''),5,0,'/'),8,0,'/') as datetime2) is null then null else STUFF(STUFF(Replace(Replace([Column 185], ' ',''),'/',''),5,0,'/'),8,0,'/') end
, [Column 186]
, [Column 187]
, [Column 188]
, [Column 189]
, [Column 190]
, [Column 191]
, [Column 192]
, [Column 193]
, [Column 194]
FROM ImportMseg
Where [Column 0] Is Not Null AND
[Column 0] <> ''
AND (IsNumeric([Column 2])=1 Or [Column 2] IS Null OR  [Column 2] = '')
AND (IsNumeric([Column 3])=1 Or [Column 3] IS Null OR  [Column 3] = '')
AND (IsNumeric([Column 4])=1 Or [Column 4] IS Null OR  [Column 4] = '')
AND (IsNumeric([Column 5])=1 Or [Column 5] IS Null OR  [Column 5] = '')
AND (IsNumeric([Column 6])=1 Or [Column 6] IS Null OR  [Column 6] = '')
AND (IsNumeric([Column 7])=1 Or [Column 7] IS Null OR  [Column 7] = '')
AND (IsNumeric([Column 10])=1 Or [Column 10] IS Null OR  [Column 10] = '')
AND (IsNumeric([Column 20])=1 Or [Column 20] IS Null OR  [Column 20] = '')
AND (IsNumeric([Column 21])=1 Or [Column 21] IS Null OR  [Column 21] = '')
AND (IsNumeric([Column 25])=1 Or [Column 25] IS Null OR  [Column 25] = '')
AND (IsNumeric([Column 26])=1 Or [Column 26] IS Null OR  [Column 26] = '')
AND (IsNumeric([Column 27])=1 Or [Column 27] IS Null OR  [Column 27] = '')
AND (IsNumeric([Column 29])=1 Or [Column 29] IS Null OR  [Column 29] = '')
AND (IsNumeric([Column 31])=1 Or [Column 31] IS Null OR  [Column 31] = '')
AND (IsNumeric([Column 33])=1 Or [Column 33] IS Null OR  [Column 33] = '')
AND (IsNumeric([Column 35])=1 Or [Column 35] IS Null OR  [Column 35] = '')
AND (IsNumeric([Column 38])=1 Or [Column 38] IS Null OR  [Column 38] = '')
AND (IsNumeric([Column 39])=1 Or [Column 39] IS Null OR  [Column 39] = '')
AND (IsNumeric([Column 41])=1 Or [Column 41] IS Null OR  [Column 41] = '')
AND (IsNumeric([Column 42])=1 Or [Column 42] IS Null OR  [Column 42] = '')
AND (IsNumeric([Column 44])=1 Or [Column 44] IS Null OR  [Column 44] = '')
AND (IsNumeric([Column 50])=1 Or [Column 50] IS Null OR  [Column 50] = '')
AND (IsNumeric([Column 57])=1 Or [Column 57] IS Null OR  [Column 57] = '')
AND (IsNumeric([Column 62])=1 Or [Column 62] IS Null OR  [Column 62] = '')
AND (IsNumeric([Column 67])=1 Or [Column 67] IS Null OR  [Column 67] = '')
AND (IsNumeric([Column 69])=1 Or [Column 69] IS Null OR  [Column 69] = '')
AND (IsNumeric([Column 71])=1 Or [Column 71] IS Null OR  [Column 71] = '')
AND (IsNumeric([Column 73])=1 Or [Column 73] IS Null OR  [Column 73] = '')
AND (IsNumeric([Column 87])=1 Or [Column 87] IS Null OR  [Column 87] = '')
AND (IsNumeric([Column 92])=1 Or [Column 92] IS Null OR  [Column 92] = '')
AND (IsNumeric([Column 94])=1 Or [Column 94] IS Null OR  [Column 94] = '')
AND (IsNumeric([Column 102])=1 Or [Column 102] IS Null OR  [Column 102] = '')
AND (IsNumeric([Column 103])=1 Or [Column 103] IS Null OR  [Column 103] = '')
AND (IsNumeric([Column 110])=1 Or [Column 110] IS Null OR  [Column 110] = '')
AND (IsNumeric([Column 114])=1 Or [Column 114] IS Null OR  [Column 114] = '')
AND (IsNumeric([Column 118])=1 Or [Column 118] IS Null OR  [Column 118] = '')
AND (IsNumeric([Column 122])=1 Or [Column 122] IS Null OR  [Column 122] = '')
AND (IsNumeric([Column 123])=1 Or [Column 123] IS Null OR  [Column 123] = '')
AND (IsNumeric([Column 125])=1 Or [Column 125] IS Null OR  [Column 125] = '')
AND (IsNumeric([Column 128])=1 Or [Column 128] IS Null OR  [Column 128] = '')
AND (IsNumeric([Column 139])=1 Or [Column 139] IS Null OR  [Column 139] = '')
AND (IsNumeric([Column 140])=1 Or [Column 140] IS Null OR  [Column 140] = '')
AND (IsNumeric([Column 144])=1 Or [Column 144] IS Null OR  [Column 144] = '')
AND (IsNumeric([Column 147])=1 Or [Column 147] IS Null OR  [Column 147] = '')
AND (IsNumeric([Column 151])=1 Or [Column 151] IS Null OR  [Column 151] = '')
AND (IsNumeric([Column 152])=1 Or [Column 152] IS Null OR  [Column 152] = '')
AND (IsNumeric([Column 161])=1 Or [Column 161] IS Null OR  [Column 161] = '')
AND (IsNumeric([Column 162])=1 Or [Column 162] IS Null OR  [Column 162] = '')
AND (IsNumeric([Column 176])=1 Or [Column 176] IS Null OR  [Column 176] = '')
AND (IsNumeric([Column 179])=1 Or [Column 179] IS Null OR  [Column 179] = '')
AND (IsNumeric([Column 181])=1 Or [Column 181] IS Null OR  [Column 181] = '')
AND (IsNumeric([Column 191])=1 Or [Column 191] IS Null OR  [Column 191] = '')
AND LEN([Column 0]) < 6
AND LEN([Column 8]) < 4
AND LEN([Column 11]) < 7
AND LEN([Column 12]) < 13
AND LEN([Column 13]) < 4
AND LEN([Column 14]) < 4
AND LEN([Column 15]) < 4
AND LEN([Column 16]) < 4
AND LEN([Column 17]) < 13
AND LEN([Column 18]) < 13
AND LEN([Column 22]) < 13
AND LEN([Column 23]) < 4
AND LEN([Column 24]) < 8
AND LEN([Column 28]) < 4
AND LEN([Column 30]) < 13
AND LEN([Column 32]) < 6
AND LEN([Column 34]) < 6
AND LEN([Column 36]) < 6
AND LEN([Column 37]) < 13
AND LEN([Column 43]) < 13
AND LEN([Column 45]) < 4
AND LEN([Column 46]) < 21
AND LEN([Column 47]) < 15
AND LEN([Column 48]) < 28
AND LEN([Column 49]) < 7
AND LEN([Column 51]) < 7
AND LEN([Column 52]) < 7
AND LEN([Column 53]) < 13
AND LEN([Column 54]) < 19
AND LEN([Column 58]) < 4
AND LEN([Column 59]) < 4
AND LEN([Column 60]) < 4
AND LEN([Column 61]) < 4
AND LEN([Column 63]) < 4
AND LEN([Column 64]) < 4
AND LEN([Column 65]) < 7
AND LEN([Column 66]) < 13
AND LEN([Column 68]) < 13
AND LEN([Column 72]) < 4
AND LEN([Column 74]) < 4
AND LEN([Column 75]) < 21
AND LEN([Column 76]) < 7
AND LEN([Column 77]) < 7
AND LEN([Column 78]) < 13
AND LEN([Column 79]) < 4
AND LEN([Column 80]) < 4
AND LEN([Column 81]) < 13
AND LEN([Column 82]) < 4
AND LEN([Column 83]) < 4
AND LEN([Column 84]) < 4
AND LEN([Column 85]) < 4
AND LEN([Column 86]) < 4
AND LEN([Column 88]) < 6
AND LEN([Column 89]) < 6
AND LEN([Column 90]) < 13
AND LEN([Column 91]) < 4
AND LEN([Column 95]) < 4
AND LEN([Column 96]) < 4
AND LEN([Column 97]) < 4
AND LEN([Column 98]) < 4
AND LEN([Column 100]) < 4
AND LEN([Column 104]) < 5
AND LEN([Column 105]) < 5
AND LEN([Column 106]) < 11
AND LEN([Column 107]) < 15
AND LEN([Column 111]) < 15
AND LEN([Column 115]) < 13
AND LEN([Column 116]) < 17
AND LEN([Column 119]) < 6
AND LEN([Column 120]) < 4
AND LEN([Column 121]) < 13
AND LEN([Column 124]) < 13
AND LEN([Column 126]) < 17
AND LEN([Column 127]) < 21
AND LEN([Column 130]) < 4
AND LEN([Column 131]) < 13
AND LEN([Column 132]) < 19
AND LEN([Column 133]) < 21
AND LEN([Column 134]) < 21
AND LEN([Column 135]) < 7
AND LEN([Column 136]) < 7
AND LEN([Column 137]) < 4
AND LEN([Column 138]) < 4
AND LEN([Column 141]) < 4
AND LEN([Column 142]) < 19
AND LEN([Column 143]) < 17
AND LEN([Column 145]) < 17
AND LEN([Column 146]) < 4
AND LEN([Column 148]) < 6
AND LEN([Column 149]) < 4
AND LEN([Column 150]) < 4
AND LEN([Column 153]) < 5
AND LEN([Column 154]) < 18
AND LEN([Column 155]) < 21
AND LEN([Column 156]) < 4
AND LEN([Column 157]) < 5
AND LEN([Column 158]) < 17
AND LEN([Column 159]) < 4
AND LEN([Column 163]) < 4
AND LEN([Column 164]) < 5
AND LEN([Column 165]) < 15
AND LEN([Column 166]) < 13
AND LEN([Column 167]) < 9
AND LEN([Column 168]) < 4
AND LEN([Column 169]) < 23
AND LEN([Column 170]) < 4
AND LEN([Column 171]) < 4
AND LEN([Column 172]) < 4
AND LEN([Column 173]) < 15
AND LEN([Column 174]) < 11
AND LEN([Column 175]) < 12
AND LEN([Column 177]) < 5
AND LEN([Column 178]) < 5
AND LEN([Column 180]) < 13
AND LEN([Column 182]) < 4
AND LEN([Column 183]) < 5
AND LEN([Column 184]) < 17
AND LEN([Column 185]) < 11
AND LEN([Column 186]) < 12
AND LEN([Column 187]) < 15
AND LEN([Column 188]) < 52
AND LEN([Column 189]) < 23
AND LEN([Column 190]) < 13
AND LEN([Column 192]) < 13
AND LEN([Column 193]) < 19
AND LEN([Column 194]) < 19

TRUNCATE TABLE ImportMseg