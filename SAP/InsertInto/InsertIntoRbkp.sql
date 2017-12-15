USE NonHaImportTesting
GO


BEGIN
	UPDATE ImportRbkp
		SET [Column 0]=
			CASE 
				WHEN [Column 0]<>'100' THEN NULL
				ELSE [Column 0]
			END
		,[Column 4]=
			CASE
				WHEN TRY_CAST([Column 4] AS datetime2) IS NOT NULL AND LEN([Column 4])>=6 THEN CAST([Column 4] AS datetime2) 
				ELSE NULL
			END

		,[Column 5]=
			CASE
				WHEN TRY_CAST([Column 5] AS DATETIME2) IS NOT NULL AND LEN([Column 5])>=6 THEN CAST([Column 5] AS datetime2)
				ELSE NULL
			END
		,[Column 8]=
			CASE
				WHEN TRY_CAST([Column 8] AS DATETIME2) IS NOT NULL AND LEN([Column 8])>=6 THEN CAST([Column 8] AS datetime2)
				ELSE NULL
			END
		,[Column 9]=
			CASE
				WHEN TRY_CAST([Column 9] AS time) IS NOT NULL AND LEN([Column 9])>=6 THEN STUFF(STUFF([Column 9],3,0,':'),6,0,':')
				ELSE NULL
			END
		,[Column 67]=
			CASE
				WHEN TRY_CAST([Column 67] AS DATETIME2) IS NOT NULL AND LEN([Column 67])>=6 THEN CAST([Column 67] AS datetime2)
				ELSE NULL
			END
		,[Column 74]=
			CASE
				WHEN TRY_CAST([Column 74] AS DATETIME2) IS NOT NULL AND LEN([Column 74])>=6 THEN CAST([Column 74] AS datetime2)
				ELSE NULL
			END
		,[Column 116]=
			CASE
				WHEN TRY_CAST([Column 116] AS DATETIME2) IS NOT NULL AND LEN([Column 117])>=6 THEN CAST([Column 117] AS datetime2)
				ELSE NULL
			END
		,[Column 119]=
			CASE
				WHEN TRY_CAST([Column 119] AS DATETIME2) IS NOT NULL AND LEN([Column 120])>=6 THEN CAST([Column 120] AS datetime2)
				ELSE NULL
			END
	
		,[Column 132]=
			CASE
				WHEN TRY_CAST([Column 132] AS DATETIME2) IS NOT NULL AND LEN([Column 132])>=6 THEN CAST([Column 132] AS DATETIME2)
				ELSE NULL
			END
			,[Column 131]=
			CASE
				WHEN TRY_CAST([Column 131] AS DATETIME2) IS NOT NULL AND LEN([Column 131])>=6 THEN CAST([Column 131] AS datetime2)
				ELSE NULL
			END
		,[Column 141]=
			CASE
				WHEN TRY_CAST([Column 141] AS DATETIME2) IS NOT NULL AND LEN([Column 141])>=6 THEN CAST([Column 141] AS datetime2)
				ELSE NULL
			END	

END
GO


TRUNCATE TABLE Sap.dbo.Rbkp
GO

INSERT INTO Sap.dbo.Rbkp 
(
Client,
AcctDocNbr,
FY,
DocTyp,
DocDt,
DocPostingDt,
UserName,
TransCd,
EnteredOnDt,
EnteredAtTime,
TransactEventTyp,
RefDocNbr,
CoCd,
Vendor,
OrderCurr,
ExchangeRate,
GrossInvAmt,
UnplandDlvryCosts,
TaxAmountWithSign,
TaxCd1,
NotInUse,
NbrtInUse,
PayTerms,
DiscountDays1,
DiscountPct1,
DiscountDays2,
DiscountPct2,
PmtPeriod,
DiscountAmt,
PostInvoiceId,
DocHeaderTxt,
SapRelease,
LogSys,
CalcTax,
ReversedWith,
FiscYrReverseDoc,
TaxCd2,
TaxJur2,
IvCat,
SevTaxCdsId,
InvVerTyp,
InvStat,
DocCond,
VendorCond,
InvReduction,
TaxInvReduction,
ManAccpdNetAmt,
TaxAccptdManual,
VendErrorNet,
TaxVendError,
AutoAcceptedId,
IsrSubscribeNbr,
IsrCheckDigit,
IsrRefNbr,
WTaxBase,
WTaxExempt,
WTaxCd,
SvcId,
SupplCntry,
ScbId,
RateForTaxes,
Payer,
PartBankTyp,
HouseBank,
AssignNbr,
PmtBlock,
PmtMethod,
BaselineDt,
PmtRef,
InvoiceRef,
FYInvoice,
InvestId,
ReportingCntry,
EuTriangDealId,
TaxReportDt,
NotaFiscalTyp,
BranchNbr,
EntryProfile,
SectionCd,
Name1,
Name2,
Name3,
Name4,
PostalCd,
City,
DestCountry,
StreetAddress,
PoBox,
PoBoxPostalCd,
PostBankNbr,
BankAcctNbr,
BankNbr,
BankCountryKey,
TaxNbr1,
TaxNbr2,
VatLiability,
EqualizationTaxId,
Region,
BankControlKey,
InstructionKey,
DMEId,
[Language],
OneTimeAcctId,
PayeeCd,
TaxTyp,
TaxNbrTyp,
NaturalPerson,
TaxNbr3,
TaxNbr4,
RefBankDetail,
RepsName,
TypBus,
TypIdustry,
Title,
VatRegNbr,
EnteredByExtSysUser,
InvRecptDt,
PmtMethSupl,
PlanLvl,
PlanDt,
FixedPmtTerms,
RelId,
EnteredBy,
BusPlace,
AcctNbrBranch,
BusArea,
LotNbr,
Txt,
PrePmtStatus,
InvoiceNbr,
AssignTestInvoice,
NextAssignTest,
EndAssignTestPeriod,
OriginInvoiceDocNbr,
FYOriginInvoice,
CopiedInvoiceDocNbr,
FyInvCopy,
CreatorOfCopy,
GLAcct,
TransLogInvoiceVerify,
MdExchangeRate,
TranslationDt,
RefKeyLineItm,
Billback


	)
SELECT 
[Column 0],
[Column 1],
[Column 2],
[Column 3],
[Column 4],
[Column 5],
[Column 6],
[Column 7],
[Column 8],
[Column 9],
[Column 10],
[Column 11],
[Column 12],
[Column 13],
[Column 14],
[Column 15],
[Column 16],
[Column 17],
[Column 18],
[Column 19],
[Column 20],
[Column 21],
[Column 22],
[Column 23],
[Column 24],
[Column 25],
[Column 26],
[Column 27],
[Column 28],
[Column 29],
[Column 30],
[Column 31],
[Column 32],
[Column 33],
[Column 34],
[Column 35],
[Column 36],
[Column 37],
[Column 38],
[Column 39],
[Column 40],
[Column 41],
[Column 42],
[Column 43],
[Column 44],
[Column 45],
[Column 46],
[Column 47],
[Column 48],
[Column 49],
[Column 50],
[Column 51],
[Column 52],
[Column 53],
[Column 54],
[Column 55],
[Column 56],
[Column 57],
[Column 58],
[Column 59],
[Column 60],
[Column 61],
[Column 62],
[Column 63],
[Column 64],
[Column 65],
[Column 66],
[Column 67],
[Column 68],
[Column 69],
[Column 70],
[Column 71],
[Column 72],
[Column 73],
[Column 74],
[Column 75],
[Column 76],
[Column 77],
[Column 78],
[Column 79],
[Column 80],
[Column 81],
[Column 82],
[Column 83],
[Column 84],
[Column 85],
[Column 86],
[Column 87],
[Column 88],
[Column 89],
[Column 90],
[Column 91],
[Column 92],
[Column 93],
[Column 94],
[Column 95],
[Column 96],
[Column 97],
[Column 98],
[Column 99],
[Column 100],
[Column 101],
[Column 102],
[Column 103],
[Column 104],
[Column 105],
[Column 106],
[Column 107],
[Column 108],
[Column 109],
[Column 110],
[Column 111],
[Column 112],
[Column 113],
[Column 114],
[Column 115],
[Column 116],
[Column 117],
[Column 118],
[Column 119],
[Column 120],
[Column 121],
[Column 122],
[Column 123],
[Column 124],
[Column 125],
[Column 126],
[Column 127],
[Column 128],
[Column 129],
[Column 130],
[Column 131],
[Column 132],
[Column 133],
[Column 134],
[Column 135],
[Column 136],
[Column 137],
[Column 138],
[Column 139],
[Column 140],
[Column 141],
[Column 142],
[Column 143]
FROM ImportRbkp
WHERE [Column 0] Is Not Null AND [Column 0]<>''