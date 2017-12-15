MERGE Popic.dbo.ZmassPo AS TargetTbl
USING NonHaImportTesting.dbo.ImportZmassPo AS SourceTbl
ON (TargetTbl.[PoNbr]=SourceTbl.[PO Number] AND TargetTbl.[PoItem]=SourceTbl.[PO item] AND TargetTbl.[SchedLineNbr]=SourceTbl.[Schedule line no])
		
WHEN NOT MATCHED BY TARGET THEN
	INSERT(
		[PoNbr]
		,[PoItem]
		,[SchedLineNbr]
		,[Status]
		,ActionType
		)
	VALUES(
		[PO Number]
		,[PO item]
		,[Schedule line no]
		,'Success'
		,'STO'
		)
WHEN NOT MATCHED BY SOURCE AND TargetTbl.[Status]='Success' AND TargetTbl.ActionType='STO' THEN
DELETE;

MERGE Popic.dbo.ZmassPo AS TargetTbl
USING NonHaImportTesting.dbo.ImportZmassPo AS SourceTbl
ON (TargetTbl.[PoNbr]=SourceTbl.[PO Number] AND TargetTbl.[PoItem]=SourceTbl.[PO item] AND TargetTbl.[SchedLineNbr]=SourceTbl.[Schedule line no])
		
WHEN NOT MATCHED BY TARGET THEN
	INSERT(
		[PoNbr]
		,[PoItem]
		,[SchedLineNbr]
		,[Status]
		,ActionType
		)
	VALUES(
		[PO Number]
		,[PO item]
		,[Schedule line no]
		,'Failure'
		,'STO'
		)
WHEN NOT MATCHED BY SOURCE AND TargetTbl.[Status]='Failure' AND TargetTbl.ActionType='STO' THEN
DELETE;



MERGE Popic.dbo.ZmassPo AS TargetTbl
USING NonHaImportTesting.dbo.ImportZmassPo AS SourceTbl
ON (TargetTbl.[PoNbr]=SourceTbl.[PoNbr] AND TargetTbl.[PoItem]=SourceTbl.[PoItem] AND TargetTbl.[SchedLineNbr]=SourceTbl.[SchedLineNbr])
		
WHEN NOT MATCHED BY TARGET THEN
	INSERT(
		[PoNbr]
		,[PoItem]
		,[SchedLineNbr]
		,[Status]
		,ActionType
		)
	VALUES(
		[PoNbr]
		,[PoItem]
		,[SchedLineNbr]
		,'Success'
		,'EDI'
		)
WHEN NOT MATCHED BY SOURCE AND TargetTbl.[Status]='Success' AND TargetTbl.ActionType='EDI' THEN
DELETE;



MERGE Popic.dbo.ZmassPo AS TargetTbl
USING NonHaImportTesting.dbo.ImportZmassPo AS SourceTbl
ON (TargetTbl.[PoNbr]=SourceTbl.[PO Number] AND TargetTbl.[PoItem]=SourceTbl.[PO item] AND TargetTbl.[SchedLineNbr]=SourceTbl.[Schedule line no])
		
WHEN NOT MATCHED BY TARGET THEN
	INSERT(
		[PoNbr]
		,[PoItem]
		,[SchedLineNbr]
		,[Status]
		,ActionType
		)
	VALUES(
		[PO Number]
		,[PO item]
		,[Schedule line no]
		,'Failure'
		,'EDI'
		)
WHEN NOT MATCHED BY SOURCE AND TargetTbl.[Status]='Failure' AND TargetTbl.ActionType='EDI' THEN
DELETE;

