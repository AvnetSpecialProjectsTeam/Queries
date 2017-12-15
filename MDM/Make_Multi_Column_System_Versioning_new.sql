
select*
into ##MultiColumnTemp
from(
select
convert(bigint,[MDM].[dbo].[Nascar_1000].MaterialNbr) as MaterialNbr,
min(Nascar_1000.SAPPurchasingOrgCD) as PurchaseOrg,
convert(date,[MDM].[dbo].[Nascar_1000].ValidFromDt) as ValidFromDt,
convert(date,[MDM].[dbo].[Nascar_1000].ValidToDt) as ValidToDt,   
[MDM].[dbo].[Nascar_1000].SAPConditionTypeCD,
[MDM].[dbo].[Nascar_1000].SAPCurrencyCode,
[MDM].[dbo].[Nascar_1000].SendToSapFl,
convert(bigint,Sum(IIf([ConditionSqNo]=1,[MinConditionQt],0))) AS Col1Qty,
convert (decimal(20,5),Sum(IIf([ConditionSqNo]=1,[UnitPrice],0.00))) AS [Col1$],
convert(bigint,Sum(IIf([ConditionSqNo]=2,[MinConditionQt],0))) AS Col2Qty,
convert (decimal(20,5),Sum(IIf([ConditionSqNo]=2,[UnitPrice],0.00))) AS [Col2$],
convert(bigint,Sum(IIf([ConditionSqNo]=3,[MinConditionQt],0))) AS Col3Qty,
convert (decimal(20,5),Sum(IIf([ConditionSqNo]=3,[UnitPrice],0.00))) AS [Col3$],
convert(bigint,Sum(IIf([ConditionSqNo]=4,[MinConditionQt],0))) AS Col4Qty,
convert (decimal(20,5),Sum(IIf([ConditionSqNo]=4,[UnitPrice],0.00))) AS [Col4$],
convert(bigint,Sum(IIf([ConditionSqNo]=5,[MinConditionQt],0))) AS Col5Qty,
convert (decimal(20,5),Sum(IIf([ConditionSqNo]=5,[UnitPrice],0.00))) AS [Col5$],
convert(bigint,Sum(IIf([ConditionSqNo]=6,[MinConditionQt],0))) AS Col6Qty,
convert (decimal(20,5),Sum(IIf([ConditionSqNo]=6,[UnitPrice],0.00))) AS [Col6$],
convert(bigint,Sum(IIf([ConditionSqNo]=7,[MinConditionQt],0))) AS Col7Qty,
convert (decimal(20,5),Sum(IIf([ConditionSqNo]=7,[UnitPrice],0.00))) AS [Col7$],
convert(bigint,Sum(IIf([ConditionSqNo]=8,[MinConditionQt],0))) AS Col8Qty,
convert (decimal(20,5),Sum(IIf([ConditionSqNo]=8,[UnitPrice],0.00))) AS [Col8$],
convert(bigint,Sum(IIf([ConditionSqNo]=9,[MinConditionQt],0))) AS Col9Qty,
convert(decimal(20,5),Sum(IIf([ConditionSqNo]=9,[UnitPrice],0.00))) AS [Col9$],
convert(bigint,Sum(IIf([ConditionSqNo]=10,[MinConditionQt],0))) AS Col10Qty,
convert(decimal(20,5),Sum(IIf([ConditionSqNo]=10,[UnitPrice],0.00))) AS [Col10$]

FROM 
[MDM].[dbo].[Nascar_1000]
GROUP BY 
[MDM].[dbo].[Nascar_1000].MaterialNbr,
[MDM].[dbo].[Nascar_1000].SendToSapFl,
[MDM].[dbo].[Nascar_1000].SAPConditionTypeCD, 
[MDM].[dbo].[Nascar_1000].ValidFromDt,
[MDM].[dbo].[Nascar_1000].ValidToDt, 
[MDM].[dbo].[Nascar_1000].SAPCurrencyCode) as temp

MERGE MultiColumnCost AS TargetTbl
USING ##MultiColumnTemp AS SourceTbl
ON (TargetTbl.MaterialNbr=SourceTbl.MaterialNbr AND TargetTbl.PurchaseOrg=SourceTbl.PurchaseOrg AND TargetTbl.ValidFromDt=SourceTbl.ValidFromDt AND TargetTbl.ValidToDt=SourceTbl.ValidToDt AND TargetTbl.SAPConditionTypeCD=SourceTbl.SAPConditionTypeCD AND TargetTbl.SAPCurrencyCode=SourceTbl.SAPCurrencyCode)
WHEN MATCHED 
	AND TargetTbl.Col1Qty <> SourceTbl.Col1Qty
	OR TargetTbl.Col1$ <> SourceTbl.Col1$
	OR TargetTbl.Col2Qty <> SourceTbl.Col2Qty
	OR TargetTbl.Col2$ <> SourceTbl.Col2$
	OR TargetTbl.Col3Qty <> SourceTbl.Col3Qty
	OR TargetTbl.Col3$ <> SourceTbl.Col3$
	OR TargetTbl.Col4Qty <> SourceTbl.Col4Qty
	OR TargetTbl.Col4$ <> SourceTbl.Col4$
	OR TargetTbl.Col5Qty <> SourceTbl.Col5Qty
	OR TargetTbl.Col5$ <> SourceTbl.Col5$
	OR TargetTbl.Col6Qty <> SourceTbl.Col6Qty
	OR TargetTbl.Col6$ <> SourceTbl.Col6$
	OR TargetTbl.Col7Qty <> SourceTbl.Col7Qty
	OR TargetTbl.Col7$ <> SourceTbl.Col7$
	OR TargetTbl.Col8Qty <> SourceTbl.Col8Qty
	OR TargetTbl.Col8$ <> SourceTbl.Col8$
	OR TargetTbl.Col9Qty <> SourceTbl.Col9Qty
	OR TargetTbl.Col9$ <> SourceTbl.Col9$
	OR TargetTbl.Col10Qty <> SourceTbl.Col10Qty
	OR TargetTbl.Col10$ <> SourceTbl.Col10$

THEN
	UPDATE SET
		TargetTbl.Col1Qty = SourceTbl.Col1Qty
		,TargetTbl.Col1$ = SourceTbl.Col1$
		,TargetTbl.Col2Qty = SourceTbl.Col2Qty
		,TargetTbl.Col2$ = SourceTbl.Col2$
		,TargetTbl.Col3Qty = SourceTbl.Col3Qty
		,TargetTbl.Col3$ = SourceTbl.Col3$
		,TargetTbl.Col4Qty = SourceTbl.Col4Qty
		,TargetTbl.Col4$ = SourceTbl.Col4$
		,TargetTbl.Col5Qty = SourceTbl.Col5Qty
		,TargetTbl.Col5$ = SourceTbl.Col5$
		,TargetTbl.Col6Qty = SourceTbl.Col6Qty
		,TargetTbl.Col6$ = SourceTbl.Col6$
		,TargetTbl.Col7Qty = SourceTbl.Col7Qty
		,TargetTbl.Col7$ = SourceTbl.Col7$
		,TargetTbl.Col8Qty = SourceTbl.Col8Qty
		,TargetTbl.Col8$ = SourceTbl.Col8$
		,TargetTbl.Col9Qty = SourceTbl.Col9Qty
		,TargetTbl.Col9$ = SourceTbl.Col9$
		,TargetTbl.Col10Qty = SourceTbl.Col10Qty
		,TargetTbl.Col10$ = SourceTbl.Col10$

WHEN NOT MATCHED BY TARGET THEN
INSERT(
MaterialNbr,
PurchaseOrg,
ValidFromDt,
ValidToDt,
SAPConditionTypeCD,
SAPCurrencyCode,
SendToSapFl,
Col1Qty,Col1$,
Col2Qty,Col2$,
Col3Qty,Col3$,
Col4Qty,Col4$,
Col5Qty,Col5$,
Col6Qty,Col6$,
Col7Qty,Col7$,
Col8Qty,Col8$,
Col9Qty,Col9$,
Col10Qty,Col10$
)
VALUES(
	MaterialNbr,
PurchaseOrg,
ValidFromDt,
ValidToDt,
SAPConditionTypeCD,
SAPCurrencyCode,
SendToSapFl,
Col1Qty,Col1$,
Col2Qty,Col2$,
Col3Qty,Col3$,
Col4Qty,Col4$,
Col5Qty,Col5$,
Col6Qty,Col6$,
Col7Qty,Col7$,
Col8Qty,Col8$,
Col9Qty,Col9$,
Col10Qty,Col10$)
WHEN NOT MATCHED BY SOURCE THEN
DELETE;
Drop Table ##MultiColumnTemp;