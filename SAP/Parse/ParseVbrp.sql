UPDATE VBRPImport
Set [Column 139] =  LTRIM(RTRIM(CASE 
        WHEN [Column 139] like '%E-%' THEN CAST(CAST([Column 139] AS FLOAT) AS DECIMAL(18,18))
        WHEN [Column 139] like '%E+%' THEN CAST(CAST([Column 139] AS FLOAT) AS DECIMAL)
        ELSE [Column 139]
		END ))
		Where [Column 139] <> '';
UPDATE VBRPImport
Set [Column 141] =  LTRIM(RTRIM(CASE 
        WHEN [Column 141] like '%E-%' THEN CAST(CAST([Column 141] AS FLOAT) AS DECIMAL(18,18))
        WHEN [Column 141] like '%E+%' THEN CAST(CAST([Column 141] AS FLOAT) AS DECIMAL)
        ELSE [Column 141]
		END ))
		Where [Column 141] <> '';	
UPDATE VBRPImport
Set 
		[Column 6] = Replace([Column 6], '.', ''),
		[Column 7] = Replace([Column 7], '.', ''),
		[Column 255] = Replace([Column 255], '.', ''),
		[Column 256] = Replace([Column 256], '.', ''),
		[Column 1] = Replace([Column 1], ' ', ''),
		[Column 24] = Replace([Column 24], ' ', ''),
		[Column 27] = Replace([Column 27], ' ', ''),
		[Column 29] = Replace([Column 29], ' ', ''),
		[Column 30] = Replace([Column 30], ' ', ''),
		[Column 31] = Replace([Column 31], ' ', ''),
		[Column 32] = Replace([Column 32], ' ', ''),
		[Column 33] = Replace([Column 33], ' ', ''),
		[Column 34] = Replace([Column 34], ' ', ''),
		[Column 35] = Replace([Column 35], ' ', ''),
		[Column 36] = Replace([Column 36], ' ', ''),
		[Column 37] = Replace([Column 37], ' ', ''),
		[Column 38] = Replace([Column 38], ' ', ''),
		[Column 39] = Replace([Column 39], ' ', ''),
		[Column 40] = Replace([Column 40], ' ', '');

ItmNumPartnSeg INT,
Plant VARCHAR (4), --- - 42
DepCnty VARCHAR (3),
RegPlntLoc VARCHAR (3),
CntyPlntLoc VARCHAR (3),
CityPlntLoc VARCHAR (4),
TaxClasMat VARCHAR (1),
TaxClas2Mat VARCHAR (1),
TaxClas3Mat VARCHAR (1),
TaxClas4Mat VARCHAR (1),
TaxClas5Mat VARCHAR (1),
TaxClas6Mat VARCHAR (1),
TaxClas7Mat VARCHAR (1),
TaxClas8Mat VARCHAR (1),
TaxClas9Mat VARCHAR (1),
StatVal VARCHAR (1),
CryOutPri VARCHAR (1),
CashDisInd VARCHAR (1),
AmtEliCashDisDocCurr MONEY,
MatPriGrp VARCHAR (2),
AccAssGrpMat VARCHAR (2),
CostCtr VARCHAR (10),
VolRebGrp VARCHAR (2),
ComGrp VARCHAR (2),
EANObs VARCHAR (13),
SaleGrp VARCHAR (3),
SaleOff VARCHAR (4),
DivOrdHdr VARCHAR (2),
RetItm VARCHAR (1),
NamPerCreObj VARCHAR (12),
DateRecCre DATE,
EntTime TIME (6),
ValType VARCHAR (10),
StrLoc VARCHAR (4),
UpdGrpStatUpd VARCHAR (6),
CostDocCurr1 MONEY,
Sub1PriProCon MONEY,
Sub2PriProCon MONEY,
Sub3PriProCon MONEY,
Sub4PriProCon MONEY,
Sub5PriProCon MONEY,
Sub6PriProCon MONEY,
ExcRateStaCre DECIMAL (9, 5),
IncResPri VARCHAR (1),
GenInc VARCHAR (1),
IntArtNum VARCHAR (18),
ProfCtr VARCHAR (10),
CustGrp1 VARCHAR (3),
CustGrp2 VARCHAR (3),
CustGrp3 VARCHAR (3),
CustGrp4 VARCHAR (3),
CustGrp5 VARCHAR (3),
MatGrp1 VARCHAR (3),
MatGrp2 VARCHAR (3),
MatGrp3 VARCHAR (3),
MatGrp4 VARCHAR (3),
MatGrp5 VARCHAR (3),
MatEnt VARCHAR (18),
RebBas1 MONEY,
ConArea VARCHAR (4),
ProfSegNum INT,
WBSE INT,
OrdNum VARCHAR (12),
TaxJur VARCHAR (15),
ItmCrdtPr MONEY,
IDItmActCrdt VARCHAR (1),
Config INT,
IntObjNumBatClas INT,
ConUpd VARCHAR (1),
HighLvlItmBtchSpltItm INT,
BatMgtInd VARCHAR (1),
ABRVWUseInd VARCHAR (3),
BOMExpNum VARCHAR (8),
SaleDisSaleOrd VARCHAR (6),
CustGrpSaleOrd VARCHAR (2),
PriGrpSaleOrd VARCHAR (2),
CntyDesSaleOrd VARCHAR (3),
StatManPriCha VARCHAR (1),
PriLstTypSaleOrd VARCHAR (2),
RegSaleOrd VARCHAR (3),
SaleOrgSaleOrd VARCHAR (4),
DistChanSaleOrd VARCHAR (2),
StrtAccSetPer DATE,
IDMatDet VARCHAR (1),
IDHighLvlItmUse VARCHAR (1),
SDDocCat VARCHAR (1),
StatDate DATE,
BilInvPlanNum VARCHAR (10),
ItmBilInvPlnPayCard INT,
Promo1 VARCHAR (10),
Promo2 VARCHAR (10),
SaleDeal1 VARCHAR (10),
PrefIndExpImp VARCHAR (1),
TaxAmtDocCurr MONEY,
OrdReason VARCHAR (3),
RuleBilInvPln VARCHAR (1),
PriRefMatMainItm VARCHAR (18),
MatPriGrpMainItm VARCHAR (2),
ItmCredPri DECIMAL (16, 16),
FormPayGuar VARCHAR (2),
Guar DECIMAL (16, 16),
ReasonZeroVAT VARCHAR (1),
RegStateProvCnty VARCHAR (3),
ActCodeGrosIncTax VARCHAR (2),
DistTypEmpTax VARCHAR (2),
TaxRelClass VARCHAR (10),
CFOPCodeExt VARCHAR (10),
TaxLawICMS VARCHAR (3),
TaxLawIPI VARCHAR (3),
SDTaxCode VARCHAR (2),
GrosValBilItmDocCurr MONEY,
ValConNo VARCHAR (10),
ValConItm INT,
PayCardPlnNumSaleDoc VARCHAR (10),
TransDate DATE,
MatGrpHier1 VARCHAR (18),
MatGrpHier2 VARCHAR (18),
CustCondGrp1 VARCHAR (2),
CustCondGrp2 VARCHAR (2),
CustCondGrp3 VARCHAR (2),
CustCondGrp4 VARCHAR (2),
CustCondGrp5 VARCHAR (2),
VKAUSUseInd VARCHAR (3),
InfIndx VARCHAR (5),
IndBaseDate DATE,
IDLeadUntMeasComTrans VARCHAR (1),
SaleTaxCode VARCHAR (2),
ConType VARCHAR (1),
ConNum VARCHAR (13),
ItmTxt VARCHAR (50),
AgrDelTime VARCHAR (3),
AccInd VARCHAR (2),
RevRecCat VARCHAR (1),
ExchRateLetCreditForTrade DECIMAL (9, 5),
ProdCatNum VARCHAR (10),
DocNumRefDoc2 VARCHAR (10),
ItmNumRefItm INT,
LogSys VARCHAR (10),
CatExtTransElem VARCHAR (3),
ISSTaxLaw VARCHAR (3),
COFINSTaxLaw VARCHAR (3),
PISTaxLaw VARCHAR (3),
Fund VARCHAR (10),
FundCntr VARCHAR (16),
FuncArea VARCHAR (16),
Grnt VARCHAR (20),
GenProjPlanGUID VARCHAR (16),
RoutNumOpOrd1 INT,
IntCntr1 INT,
PrdPerfStartDate DATE,
PrdPerfEndDate DATE,
PartProCntr VARCHAR (10),
TradPartBizArea VARCHAR (4),
AbbrCompReason VARCHAR (4),
ListPri MONEY,
LisTPriAdj MONEY,
Cost MONEY,
CostPO MONEY,
CostAdj MONEY,
CostAct MONEY,
ResaleProp MONEY,
Markup MONEY,
Resale MONEY,
FrgtEst MONEY,
FrgtAct MONEY,
AppBaseLine MONEY,
AvSub13 MONEY,
AvSub14 MONEY,
AvSub15 MONEY,
ActGPCost MONEY,
VisSub1 MONEY,
VisSub2 MONEY,
VisSub3 MONEY,
VisSub4 MONEY,
VisSub5 MONEY,
VisSub6 MONEY,
VisSub7 MONEY,
VisSub8 MONEY,
VisSub9 MONEY,
VisSub10 MONEY,
VenActShipDate DATE,
EndUseConID VARCHAR (10),
EUISUCode VARCHAR (2),
EUISUSubCode VARCHAR (2),
EndUseSiteID VARCHAR (10),
EndUseConVar VARCHAR (10),
EUGenBusCode VARCHAR (20),
ProcIdNum VARCHAR (10),
RetRefCode VARCHAR (3),
RetReason VARCHAR (3),
ConRecNum VARCHAR (10),
ConVal1 MONEY,
DispCase VARCHAR (16),
FundUseItm VARCHAR (16),
ClaimTax VARCHAR (1),
TransDt DATE,
DownPayChainNum VARCHAR (10),
TransNum INT,
SeqNumAccDocTrans INT,
FMBudPer VARCHAR (10),
WorkPerIntRep INT,
RoutNumOpOrd2 INT,
IntCntr2 INT,
ConfigID VARCHAR (20),
RevAccType VARCHAR (10),
ExtSDDocCatPrecDoc VARCHAR (4),
ReqSeg VARCHAR (16),
StoSeg VARCHAR (16),
CHARStatesFedGovFields VARCHAR (22),
CostDocCurr2 MONEY,
LocCurr MONEY,
ExcRateFIPost DECIMAL (9, 5),
CFAllPct DECIMAL (5, 2),
PriRevPct DECIMAL (5, 2),
RatFromCurrUnt FLOAT (9),
RatToCurrUnt FLOAT (9),
ActRate DECIMAL (9, 5),
CFAppInd1 VARCHAR (1),
CFAppInd VARCHAR (1),
CostType VARCHAR (3),
SaleMarInv MONEY,
CusMatProjNum VARCHAR (20),
CusMatDesRegNum VARCHAR (30),
CondVal1 MONEY,
CondVal2 MONEY,
CondVal3 MONEY,
CondVal4 MONEY,
CostAddOverAct VARCHAR (1),
SerNum VARCHAR (20),
ConVal2 MONEY,
ConVal3 MONEY,
DPAStepNum INT,
SaleDeal2 VARCHAR (10),
DRActStatus VARCHAR (1),
MatchType VARCHAR (4),