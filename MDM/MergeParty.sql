SELECT *
INTO #AvrPTemp
FROM OPENQUERY(AVR80, 'SELECT *
FROM GOLDEN.C_BO_PARTY
WHERE (((LAST_UPDATE_DATE) > SYSDATE-10))')

USE MDM
GO


MERGE Party AS TargetTbl
USING #AvrPTemp AS SourceTbl
ON (TargetTbl.RowIdObject=SourceTbl.ROWID_OBJECT)
WHEN MATCHED 
	AND TargetTbl.LastUpdateDate <> SourceTbl.LAST_UPDATE_DATE

THEN
	UPDATE SET
	TargetTbl.UpdatedBy = SourceTbl.UPDATED_BY
	,TargetTbl.LastUpdateDate = SourceTbl.LAST_UPDATE_DATE
	,TargetTbl.ConsolidationInd = SourceTbl.CONSOLIDATION_IND
	,TargetTbl.DeletedInd = SourceTbl.DELETED_IND
	,TargetTbl.DeletedBy = SourceTbl.DELETED_BY
	,TargetTbl.DeletedDate = SourceTbl.DELETED_DATE
	,TargetTbl.LastRowidSystem = SourceTbl.LAST_ROWID_SYSTEM
	,TargetTbl.DirtyInd = SourceTbl.DIRTY_IND
	,TargetTbl.InteractionId = SourceTbl.INTERACTION_ID
	,TargetTbl.HubStateInd = SourceTbl.HUB_STATE_IND
	,TargetTbl.CmDirtyInd = SourceTbl.CM_DIRTY_IND
	,TargetTbl.SapCustAcctGroupCd = SourceTbl.SAP_CUST_ACCT_GROUP_CD
	,TargetTbl.SearchTermTx01 = SourceTbl.SEARCH_TERM_TX_01
	,TargetTbl.SapCreateDt = SourceTbl.SAP_CREATE_DT
	,TargetTbl.SapBillBlockReasonCd = SourceTbl.SAP_BILL_BLOCK_REASON_CD
	,TargetTbl.SapDelivBlockReasonCd = SourceTbl.SAP_DELIV_BLOCK_REASON_CD
	,TargetTbl.SapTaxJurisdictionCd = SourceTbl.SAP_TAX_JURISDICTION_CD
	,TargetTbl.AnnualSalesAm = SourceTbl.ANNUAL_SALES_AM
	,TargetTbl.AnnualSalesYr = SourceTbl.ANNUAL_SALES_YR
	,TargetTbl.SapFiscalYearVariantCd = SourceTbl.SAP_FISCAL_YEAR_VARIANT_CD
	,TargetTbl.SapSalesBlockReasonCd = SourceTbl.SAP_SALES_BLOCK_REASON_CD
	,TargetTbl.DeactivationFl = SourceTbl.DEACTIVATION_FL
	,TargetTbl.SapDeactivationReasonCd = SourceTbl.SAP_DEACTIVATION_REASON_CD
	,TargetTbl.SapCustomerPartyTypeCd = SourceTbl.SAP_CUSTOMER_PARTY_TYPE_CD
	,TargetTbl.AvnetLogoPrintFl = SourceTbl.AVNET_LOGO_PRINT_FL
	,TargetTbl.InsuranceChargeFl = SourceTbl.INSURANCE_CHARGE_FL
	,TargetTbl.SapFuelSurchargeCd = SourceTbl.SAP_FUEL_SURCHARGE_CD
	,TargetTbl.SapHandlingChargeCd = SourceTbl.SAP_HANDLING_CHARGE_CD
	,TargetTbl.VertexNo = SourceTbl.VERTEX_NO
	,TargetTbl.SapAltCountryNameCd = SourceTbl.SAP_ALT_COUNTRY_NAME_CD
	,TargetTbl.SapHazmatCd = SourceTbl.SAP_HAZMAT_CD
	,TargetTbl.HpVarNo = SourceTbl.HP_VAR_NO
	,TargetTbl.IbmCustomerContractNo = SourceTbl.IBM_CUSTOMER_CONTRACT_NO
	,TargetTbl.SapDeniedPartyStatusCd = SourceTbl.SAP_DENIED_PARTY_STATUS_CD
	,TargetTbl.DeniedPartyStatusDt = SourceTbl.DENIED_PARTY_STATUS_DT
	,TargetTbl.ItarRestrictedFl = SourceTbl.ITAR_RESTRICTED_FL
	,TargetTbl.ForeignGovernmentFl = SourceTbl.FOREIGN_GOVERNMENT_FL
	,TargetTbl.SapCustGrowthTypeCd = SourceTbl.SAP_CUST_GROWTH_TYPE_CD
	,TargetTbl.CustomerSinceDt = SourceTbl.CUSTOMER_SINCE_DT
	,TargetTbl.RelatedPartyFl = SourceTbl.RELATED_PARTY_FL
	,TargetTbl.SmallDisadvantagedBusFl = SourceTbl.SMALL_DISADVANTAGED_BUS_FL
	,TargetTbl.SapCustomerUserTypeCd = SourceTbl.SAP_CUSTOMER_USER_TYPE_CD
	,TargetTbl.SapRoutedCustomerCd = SourceTbl.SAP_ROUTED_CUSTOMER_CD
	,TargetTbl.SapDutyTaxLocationCd = SourceTbl.SAP_DUTY_TAX_LOCATION_CD
	,TargetTbl.DutyTaxCarrierAcctNo = SourceTbl.DUTY_TAX_CARRIER_ACCT_NO
	,TargetTbl.PlantShutdownStartDt = SourceTbl.PLANT_SHUTDOWN_START_DT
	,TargetTbl.PlantShutdownEndDt = SourceTbl.PLANT_SHUTDOWN_END_DT
	,TargetTbl.SoldToCreateDt = SourceTbl.SOLD_TO_CREATE_DT
	,TargetTbl.SapShipTypeCd = SourceTbl.SAP_SHIP_TYPE_CD
	,TargetTbl.SapCustomerEndUseCd = SourceTbl.SAP_CUSTOMER_END_USE_CD
	,TargetTbl.SapRemoteRegionCd = SourceTbl.SAP_REMOTE_REGION_CD
	,TargetTbl.RemoteRegionSapAccNo = SourceTbl.REMOTE_REGION_SAP_ACC_NO
	,TargetTbl.SapRemoteDivisionCd = SourceTbl.SAP_REMOTE_DIVISION_CD
	,TargetTbl.StmtOfAssureOrigAttDt = SourceTbl.STMT_OF_ASSURE_ORIG_ATT_DT
	,TargetTbl.CustBusPlanExistsFl = SourceTbl.CUST_BUS_PLAN_EXISTS_FL
	,TargetTbl.SapRiskClassCd = SourceTbl.SAP_RISK_CLASS_CD
	,TargetTbl.MdmPriPartyRoleTypeCd = SourceTbl.MDM_PRI_PARTY_ROLE_TYPE_CD
	,TargetTbl.SapPartyId = SourceTbl.SAP_PARTY_ID
	,TargetTbl.SapPartyNm01 = SourceTbl.SAP_PARTY_NM_01
	,TargetTbl.SapPartyNm02 = SourceTbl.SAP_PARTY_NM_02
	,TargetTbl.SapPartyNm03 = SourceTbl.SAP_PARTY_NM_03
	,TargetTbl.SapPartyNm04 = SourceTbl.SAP_PARTY_NM_04
	,TargetTbl.SapBusPtnerFuncCd = SourceTbl.SAP_BUS_PTNER_FUNC_CD
	,TargetTbl.MdmPartyNm = SourceTbl.MDM_PARTY_NM
	,TargetTbl.BoClassCode = SourceTbl.BO_CLASS_CODE
	,TargetTbl.ShipToRowid = SourceTbl.SHIP_TO_ROWID
	,TargetTbl.CentralPurchBlockFl = SourceTbl.CENTRAL_PURCH_BLOCK_FL
	,TargetTbl.SapLanguageCd = SourceTbl.SAP_LANGUAGE_CD
	,TargetTbl.SapDmndCreatClsCd = SourceTbl.SAP_DMND_CREAT_CLS_CD
	,TargetTbl.SapCustAddrSrcCd = SourceTbl.SAP_CUST_ADDR_SRC_CD
	,TargetTbl.ImportTaxId = SourceTbl.IMPORT_TAX_ID
	,TargetTbl.ExportTaxId = SourceTbl.EXPORT_TAX_ID
	,TargetTbl.SapDndPtyDuplSuggCd = SourceTbl.SAP__DND_PTY_DUPL_SUGG_CD
	,TargetTbl.SapTitleCd = SourceTbl.SAP_TITLE_CD
	,TargetTbl.SapCommunicationTypeCd = SourceTbl.SAP_COMMUNICATION_TYPE_CD
	,TargetTbl.SearchTermTx02 = SourceTbl.SEARCH_TERM_TX_02
	,TargetTbl.VendorNoteTx = SourceTbl.VENDOR_NOTE_TX
	,TargetTbl.ContactDescription = SourceTbl.CONTACT_DESCRIPTION
	,TargetTbl.CrmContactId = SourceTbl.CRM_CONTACT_ID
	,TargetTbl.ContactFirstNm = SourceTbl.CONTACT_FIRST_NM
	,TargetTbl.ContactLastNm = SourceTbl.CONTACT_LAST_NM
	,TargetTbl.LegacyContactId = SourceTbl.LEGACY_CONTACT_ID
	,TargetTbl.ContactNickNm = SourceTbl.CONTACT_NICK_NM
	,TargetTbl.SapContactCdFk = SourceTbl.SAP_CONTACT_CD_FK
	,TargetTbl.SapContactVipCdFk = SourceTbl.SAP_CONTACT_VIP_CD_FK
	,TargetTbl.JobTitleTx = SourceTbl.JOB_TITLE_TX
	,TargetTbl.SapVendorAcctGroupCd = SourceTbl.SAP_VENDOR_ACCT_GROUP_CD
	,TargetTbl.SapBlockFuncReasonCd = SourceTbl.SAP_BLOCK_FUNC_REASON_CD
	,TargetTbl.PartySubRoleTypCd = SourceTbl.PARTY_SUB_ROLE_TYP_CD
	,TargetTbl.SapContactVipCd = SourceTbl.SAP_CONTACT_VIP_CD
	,TargetTbl.SapContactFunctionCd = SourceTbl.SAP_CONTACT_FUNCTION_CD
	,TargetTbl.InSapFl = SourceTbl.IN_SAP_FL
	,TargetTbl.ManualConsolidatinInd = SourceTbl.MANUAL_CONSOLIDATIN_IND
	,TargetTbl.SapAnnualSalesCurrCd = SourceTbl.SAP_ANNUAL_SALES_CURR_CD
	,TargetTbl.LegacySourceSystem = SourceTbl.LEGACY_SOURCE_SYSTEM
	,TargetTbl.TaxExemptionFl = SourceTbl.TAX_EXEMPTION_FL
	,TargetTbl.DeactivationDate = SourceTbl.DEACTIVATION_DATE

WHEN NOT MATCHED BY TARGET THEN
INSERT
(
	RowidObject , Creator , CreateDate , UpdatedBy , LastUpdateDate , ConsolidationInd , DeletedInd , DeletedBy , DeletedDate , LastRowidSystem , DirtyInd , InteractionId , HubStateInd , CmDirtyInd , SapCustAcctGroupCd , SearchTermTx01 , SapCreateDt , SapBillBlockReasonCd , SapDelivBlockReasonCd , SapTaxJurisdictionCd , AnnualSalesAm , AnnualSalesYr , SapFiscalYearVariantCd , SapSalesBlockReasonCd , DeactivationFl , SapDeactivationReasonCd , SapCustomerPartyTypeCd , AvnetLogoPrintFl , InsuranceChargeFl , SapFuelSurchargeCd , SapHandlingChargeCd , VertexNo , SapAltCountryNameCd , SapHazmatCd , HpVarNo , IbmCustomerContractNo , SapDeniedPartyStatusCd , DeniedPartyStatusDt , ItarRestrictedFl , ForeignGovernmentFl , SapCustGrowthTypeCd , CustomerSinceDt , RelatedPartyFl , SmallDisadvantagedBusFl , SapCustomerUserTypeCd , SapRoutedCustomerCd , SapDutyTaxLocationCd , DutyTaxCarrierAcctNo , PlantShutdownStartDt , PlantShutdownEndDt , SoldToCreateDt , SapShipTypeCd , SapCustomerEndUseCd , SapRemoteRegionCd , RemoteRegionSapAccNo , SapRemoteDivisionCd , StmtOfAssureOrigAttDt , CustBusPlanExistsFl , SapRiskClassCd , MdmPriPartyRoleTypeCd , SapPartyId , SapPartyNm01 , SapPartyNm02 , SapPartyNm03 , SapPartyNm04 , SapBusPtnerFuncCd , MdmPartyNm , BoClassCode , ShipToRowid , CentralPurchBlockFl , SapLanguageCd , SapDmndCreatClsCd , SapCustAddrSrcCd , ImportTaxId , ExportTaxId , SapDndPtyDuplSuggCd , SapTitleCd , SapCommunicationTypeCd , SearchTermTx02 , VendorNoteTx , ContactDescription , CrmContactId , ContactFirstNm , ContactLastNm , LegacyContactId , ContactNickNm , SapContactCdFk , SapContactVipCdFk , JobTitleTx , SapVendorAcctGroupCd , SapBlockFuncReasonCd , PartySubRoleTypCd , SapContactVipCd , SapContactFunctionCd , InSapFl , ManualConsolidatinInd , SapAnnualSalesCurrCd , LegacySourceSystem , TaxExemptionFl , DeactivationDate
)
VALUES(  ROWID_OBJECT, CREATOR, CREATE_DATE, UPDATED_BY, LAST_UPDATE_DATE, CONSOLIDATION_IND, DELETED_IND, DELETED_BY, DELETED_DATE, LAST_ROWID_SYSTEM, DIRTY_IND, INTERACTION_ID, HUB_STATE_IND, CM_DIRTY_IND, SAP_CUST_ACCT_GROUP_CD, SEARCH_TERM_TX_01, SAP_CREATE_DT, SAP_BILL_BLOCK_REASON_CD, SAP_DELIV_BLOCK_REASON_CD, SAP_TAX_JURISDICTION_CD, ANNUAL_SALES_AM, ANNUAL_SALES_YR, SAP_FISCAL_YEAR_VARIANT_CD, SAP_SALES_BLOCK_REASON_CD, DEACTIVATION_FL, SAP_DEACTIVATION_REASON_CD, SAP_CUSTOMER_PARTY_TYPE_CD, AVNET_LOGO_PRINT_FL, INSURANCE_CHARGE_FL, SAP_FUEL_SURCHARGE_CD, SAP_HANDLING_CHARGE_CD, VERTEX_NO, SAP_ALT_COUNTRY_NAME_CD, SAP_HAZMAT_CD, HP_VAR_NO, IBM_CUSTOMER_CONTRACT_NO, SAP_DENIED_PARTY_STATUS_CD, DENIED_PARTY_STATUS_DT, ITAR_RESTRICTED_FL, FOREIGN_GOVERNMENT_FL, SAP_CUST_GROWTH_TYPE_CD, CUSTOMER_SINCE_DT, RELATED_PARTY_FL, SMALL_DISADVANTAGED_BUS_FL, SAP_CUSTOMER_USER_TYPE_CD, SAP_ROUTED_CUSTOMER_CD, SAP_DUTY_TAX_LOCATION_CD, DUTY_TAX_CARRIER_ACCT_NO, PLANT_SHUTDOWN_START_DT, PLANT_SHUTDOWN_END_DT, SOLD_TO_CREATE_DT, SAP_SHIP_TYPE_CD, SAP_CUSTOMER_END_USE_CD, SAP_REMOTE_REGION_CD, REMOTE_REGION_SAP_ACC_NO, SAP_REMOTE_DIVISION_CD, STMT_OF_ASSURE_ORIG_ATT_DT, CUST_BUS_PLAN_EXISTS_FL, SAP_RISK_CLASS_CD, MDM_PRI_PARTY_ROLE_TYPE_CD, SAP_PARTY_ID, SAP_PARTY_NM_01, SAP_PARTY_NM_02, SAP_PARTY_NM_03, SAP_PARTY_NM_04, SAP_BUS_PTNER_FUNC_CD, MDM_PARTY_NM, BO_CLASS_CODE, SHIP_TO_ROWID, CENTRAL_PURCH_BLOCK_FL, SAP_LANGUAGE_CD, SAP_DMND_CREAT_CLS_CD, SAP_CUST_ADDR_SRC_CD, IMPORT_TAX_ID, EXPORT_TAX_ID, SAP__DND_PTY_DUPL_SUGG_CD, SAP_TITLE_CD, SAP_COMMUNICATION_TYPE_CD, SEARCH_TERM_TX_02, VENDOR_NOTE_TX, CONTACT_DESCRIPTION, CRM_CONTACT_ID, CONTACT_FIRST_NM, CONTACT_LAST_NM, LEGACY_CONTACT_ID, CONTACT_NICK_NM, SAP_CONTACT_CD_FK, SAP_CONTACT_VIP_CD_FK, JOB_TITLE_TX, SAP_VENDOR_ACCT_GROUP_CD, SAP_BLOCK_FUNC_REASON_CD, PARTY_SUB_ROLE_TYP_CD, SAP_CONTACT_VIP_CD, SAP_CONTACT_FUNCTION_CD, IN_SAP_FL, MANUAL_CONSOLIDATIN_IND, SAP_ANNUAL_SALES_CURR_CD, LEGACY_SOURCE_SYSTEM, TAX_EXEMPTION_FL, DEACTIVATION_DATE
);

DROP TABLE #AvrPTemp