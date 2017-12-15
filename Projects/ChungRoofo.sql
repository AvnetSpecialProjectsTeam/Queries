USE SAP
SELECT 
	A.InvDocNbr,
	A.FiscalYear1,
	A.DocumentType,
	A.UserName,
	A.TransactionCode,
	A.EnteredAt,
	A.TransactnType,
	A.Reference1,
	A.CompanyCode,
	A.InvoicingPty,
	A.DocumentDate,
	A.PostingDate,
	A.EnteredOn,
	A.Currency,
	SUM(B.Qty1) AS QTY,
	A.GrossInvAmnt/NULLIF(SUM(B.QTY1),0) AS UnitCost,
	A.ExchangeRate,
	A.GrossInvAmnt,
	A.[Text],
	B.MaterialNbr,
	B.ValTyp
--INTO rPoMatchPoe
FROM SAP.dbo.Rbkp AS A
	INNER JOIN SAP.dbo.Rseg AS B
	ON A.InvDocNbr=B.AccDocNbr1 AND A.FiscalYear1=B.FiscYr
WHERE A.[Text]='POE'
GROUP BY 
	A.InvDocNbr,
	A.FiscalYear1,
	A.DocumentType,
	A.UserName,
	A.TransactionCode,
	A.EnteredAt,
	A.TransactnType,
	A.Reference1,
	A.CompanyCode,
	A.InvoicingPty,
	A.DocumentDate,
	A.PostingDate,
	A.EnteredOn,
	A.Currency,
	A.ExchangeRate,
	A.GrossInvAmnt,
	A.ExchangeRate,
	A.[Text],
	B.MaterialNbr,
	B.ValTyp
	ORDER BY A.InvDocNbr