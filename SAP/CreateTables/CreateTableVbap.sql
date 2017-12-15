USE [SAP]
GO

DROP TABLE sap.dbo.vbap

CREATE TABLE [dbo].[Vbap](
	[Client] [varchar](6) NULL,
	[SaleDoc] [bigint] NOT NULL,
	[SaleDocItm] [bigint] NOT NULL,
	[MatNbr] [bigint] NULL,
	[MatEnt] [varchar](21) NULL,
	[PricRefMat] [varchar](21) NULL,
	[BatchNbr] [varchar](37) NULL,
	[MatGrp] [varchar](37) NULL,
	[ShrtTxtSaleOrdItm] [varchar](52) NULL,
	[SaleDocItmCat] [varchar](7) NULL,
	[ItmTyp] [varchar](6) NULL,
	[ItmRelDel] [varchar](4) NULL,
	[RelBil] [varchar](4) NULL,
	[HighLvlItmBillMatStruc] [int] NULL,
	[ItmItmAlt] [int] NULL,
	[ReaRejQuotSaleOrd] [varchar](5) NULL,
	[ProdHier] [varchar](21) NULL,
	[TrgtValOutAgrDocCur] [money] NULL,
	[TrgtQtySaleUnt] [decimal](14, 3) NULL,
	[TrgtQtyUoM] [varchar](6) NULL,
	[FacConSaleUntbaseUnt1] [int] NULL,
	[FacConSaleUntBaseUnt2] [int] NULL,
	[BaseUntMeas] [varchar](6) NULL,
	[ScalQtyBaseUntMeas] [decimal](14, 3) NULL,
	[RndQtyDel] [decimal](14, 3) NULL,
	[RecDateAgrdCumQty] [datetime2](7) NULL,
	[AllDevQtyAbs] [decimal](14, 3) NULL,
	[ItmNbrUndPurcOrd] [decimal](10, 2) NULL,
	[AllDevQtyPerc] [decimal](4, 0) NULL,
	[DayQtyShif] [decimal](4, 0) NULL,
	[RepProcClasItm] [varchar](6) NULL,
	[UseInd] [varchar](6) NULL,
	[DelGrpItm] [int] NULL,
	[QtyFix] [varchar](4) NULL,
	[UnlOvrAll] [varchar](4) NULL,
	[OvrTolLmt] [decimal](4, 1) NULL,
	[UndTolLmt] [decimal](4, 1) NULL,
	[BilBlckItm] [varchar](5) NULL,
	[RepPrt] [varchar](4) NULL,
	[MetBilCOPPCOrd] [varchar](5) NULL,
	[Div] [varchar](5) NULL,
	[BizArea] [varchar](7) NULL,
	[NetValOrdItmDocCur] [money] NULL,
	[SDDocCur] [varchar](8) NULL,
	[MaxNbrPartDelAllPerItm] [int] NULL,
	[PartDelItmLvl] [varchar](4) NULL,
	[BatchSplitAll] [varchar](4) NULL,
	[CumOrdQtySaleUnt] [decimal](16, 3) NULL,
	[CumReqDelQty] [decimal](16, 3) NULL,
	[CumConQtySaleUnt] [decimal](16, 3) NULL,
	[CumConQtyBaseUnt] [decimal](16, 3) NULL,
	[SaleUnt] [varchar](6) NULL,
	[NbrFacConSaleQtySKU] [int] NULL,
	[DenDivConSaleQtySKU] [int] NULL,
	[GrossWghtItm] [decimal](16, 3) NULL,
	[NetWghtItm] [decimal](16, 3) NULL,
	[WghtUnt] [varchar](6) NULL,
	[VolItm] [decimal](16, 3) NULL,
	[VolUnt] [varchar](6) NULL,
	[OriDoc] [varchar](13) NULL,
	[OriItm] [int] NULL,
	[DocNbrRefDoc] [bigint] NULL,
	[ItmNbrRefItm] [int] NULL,
	[ComRefInd] [varchar](4) NULL,
	[UpdIndSaleDocFlow] [varchar](4) NULL,
	[ComRuleQuotCont] [varchar](4) NULL,
	[DelPrior] [int] NULL,
	[PlntOwnExt] [int] NULL,
	[StorLoc] [varchar](7) NULL,
	[ShipPtRecPt] [int] NULL,
	[Route] [varchar](9) NULL,
	[OriBillMat] [varchar](4) NULL,
	[KeyDateBillMat] [datetime2](7) NULL,
	[BillMat] [varchar](11) NULL,
	[BilMatItmNbrVBAP] [int] NULL,
	[OrdProbItm] [int] NULL,
	[DateRecCrt] [datetime2](7) NULL,
	[NamPersCrtObj] [varchar](15) NULL,
	[EntTime] [varchar](9) NULL,
	[TaxClasMat1] [varchar](4) NULL,
	[TaxClasMat2] [varchar](4) NULL,
	[TaxClasMat3] [varchar](4) NULL,
	[TaxClasMat4] [varchar](4) NULL,
	[TaxClasMat5] [varchar](4) NULL,
	[TaxClasMat6] [varchar](4) NULL,
	[TaxClasMat7] [varchar](4) NULL,
	[TaxClasMat8] [varchar](4) NULL,
	[TaxClasMat9] [varchar](4) NULL,
	[FixShipProcTimeDay] [decimal](6, 2) NULL,
	[VarShipProcTimeDay] [decimal](6, 2) NULL,
	[PreDocResRef] [varchar](4) NULL,
	[NetPric] [money] NULL,
	[ConPricUnt] [decimal](6, 0) NULL,
	[ConUnt] [varchar](6) NULL,
	[RetItm] [varchar](4) NULL,
	[CashDisInd] [varchar](4) NULL,
	[ChckGrpAvailChck] [varchar](5) NULL,
	[SumUpReq] [varchar](4) NULL,
	[MatPricGrp] [varchar](5) NULL,
	[AccAssGrpMat] [varchar](5) NULL,
	[VolRebGrp] [varchar](5) NULL,
	[ComGrp] [varchar](5) NULL,
	[EAN] [bigint] NULL,
	[PricOK] [varchar](4) NULL,
	[ValTyp] [varchar](13) NULL,
	[IndSepVal] [varchar](4) NULL,
	[BatchManReqInd] [varchar](4) NULL,
	[BatchManInd] [varchar](4) NULL,
	[MinDelQtyDelNoteProc] [decimal](14, 3) NULL,
	[UpdGrpStatUpd] [varchar](9) NULL,
	[CostDocCur] [money] NULL,
	[Sub1PricProcCon] [money] NULL,
	[Sub2PricProcCon] [money] NULL,
	[Sub3PricProcCon] [money] NULL,
	[Sub4PricProcCon] [money] NULL,
	[Sub5PricProcCon] [money] NULL,
	[Sub6PricProcCon] [money] NULL,
	[ExcRateStat] [decimal](10, 5) NULL,
	[ChanOn] [datetime2](7) NULL,
	[IntArtNbrEANUPC] [bigint] NULL,
	[DelDateQtyFix] [varchar](4) NULL,
	[ProfCntr] [bigint] NULL,
	[DesWin] [varchar](6) NULL,
	[SpecHand] [varchar](6) NULL,
	[SmOrdStrat] [varchar](6) NULL,
	[ComCode1] [varchar](6) NULL,
	[ESDFlag] [varchar](6) NULL,
	[ComQty] [decimal](14, 3) NULL,
	[ReaMatSub] [varchar](7) NULL,
	[SpecStoInd] [varchar](4) NULL,
	[AllInd] [varchar](4) NULL,
	[ProfSegNbrCOPA] [bigint] NULL,
	[WBSEle] [int] NULL,
	[OrdNbr] [bigint] NULL,
	[PlanMat] [varchar](21) NULL,
	[PlanPlnt] [varchar](7) NULL,
	[BaseUntMeasProdGrp] [int] NULL,
	[ConFacQty] [varchar](11) NULL,
	[AccAssCat] [varchar](4) NULL,
	[ConPost] [varchar](4) NULL,
	[BOMExpNbr] [int] NULL,
	[ObjNbrItmLvl] [varchar](22) NULL,
	[ResAnalKey] [int] NULL,
	[ReqTyp] [varchar](7) NULL,
	[ItmCredPric1] [money] NULL,
	[IDParRelOrdItmCredBlck] [varchar](4) NULL,
	[IDItmActCredFuncRelCred] [varchar](4) NULL,
	[CredDataExcRateReqDelDate] [decimal](10, 5) NULL,
	[Conf] [varchar](21) NULL,
	[IntObjNbrBatchClas] [bigint] NULL,
	[StatExpPric] [varchar](4) NULL,
	[ConUpd] [varchar](4) NULL,
	[SerNbrProf] [varchar](12) NULL,
	[NbrSerNbr] [int] NULL,
	[CustPostGoodRec] [varchar](4) NULL,
	[MatGrpPacMats] [varchar](7) NULL,
	[StatManPricChan] [varchar](4) NULL,
	[DocCatPreSDDoc] [varchar](4) NULL,
	[IDMatDet] [varchar](4) NULL,
	[IDHighLvlItmUse] [varchar](4) NULL,
	[CostEstNbrCostEstWOQtyStruc] [bigint] NULL,
	[CostVar] [varchar](7) NULL,
	[BOMItmNbr] [varchar](12) NULL,
	[StatVals] [varchar](4) NULL,
	[StatDate] [datetime2](7) NULL,
	[BizTranTypForTrad] [varchar](5) NULL,
	[PrefIndExpImp] [varchar](4) NULL,
	[NbrConRecBatchDet] [bigint] NULL,
	[IntClasNbr] [bigint] NULL,
	[BatExitQtyProp] [int] NULL,
	[BOMCat] [varchar](4) NULL,
	[BOMItmNodeNbr] [int] NULL,
	[IntCnt] [int] NULL,
	[IncConf] [varchar](4) NULL,
	[Ovrhdkey] [varchar](9) NULL,
	[CostSheet] [varchar](9) NULL,
	[CostVrnt] [varchar](7) NULL,
	[ProdAllDetProc] [varchar](21) NULL,
	[PricRefMatMainItm] [varchar](21) NULL,
	[MatPricGrpMainItm] [varchar](5) NULL,
	[MatFrghtGrp] [varchar](11) NULL,
	[PlanDelSchedIns] [varchar](7) NULL,
	[KANBANSeqNbr] [bigint] NULL,
	[ItmCredPric2] [decimal](36, 18) NULL,
	[FormPayGuar] [varchar](5) NULL,
	[GuarFac01] [decimal](20, 15) NULL,
	[CFOPCodeExt] [varchar](13) NULL,
	[TaxLawICMS] [varchar](6) NULL,
	[TaxLawIPI] [varchar](6) NULL,
	[SDTaxCode] [varchar](5) NULL,
	[ValContNo] [varchar](13) NULL,
	[ValContItm] [int] NULL,
	[AssMod] [varchar](21) NULL,
	[ValSpecSto] [varchar](4) NULL,
	[MatGrpHier1] [varchar](21) NULL,
	[MatGrpHier2] [varchar](21) NULL,
	[Promo] [varchar](13) NULL,
	[SaleDeal1] [varchar](13) NULL,
	[IDLeadUntMeasCompTran] [varchar](4) NULL,
	[FreeGoodDelCont] [varchar](4) NULL,
	[ParVarStanVar] [varchar](15) NULL,
	[TaxAmntDocCur] [money] NULL,
	[MRPArea] [varchar](13) NULL,
	[ProfCntrBil] [varchar](13) NULL,
	[LogSys] [varchar](13) NULL,
	[ISSTaxLaw] [varchar](6) NULL,
	[COFINSTaxLaw] [varchar](6) NULL,
	[PISTaxLaw] [varchar](6) NULL,
	[FirstInvManLoc] [varchar](23) NULL,
	[TypFirstInvManLoc] [varchar](7) NULL,
	[RetRea] [varchar](6) NULL,
	[RetRefCode] [varchar](6) NULL,
	[AppBlck] [varchar](4) NULL,
	[ConRecNbr] [bigint] NULL,
	[RiskRelSale] [varchar](5) NULL,
	[ReqSeg] [varchar](19) NULL,
	[LocPhyHndvrGood] [varchar](13) NULL,
	[HndvrDateHndvrLoc] [datetime2](7) NULL,
	[HndvrTimeHndvrLoc] [varchar](9) NULL,
	[TaxCodeAutoDet] [varchar](5) NULL,
	[ManTaxCodeRea] [varchar](5) NULL,
	[TaxIncTyp] [varchar](7) NULL,
	[TaxSubSubTri] [varchar](4) NULL,
	[IncID] [varchar](7) NULL,
	[NotFiscSpecCaseCFOPDet] [int] NULL,
	[AnalReaRej] [varchar](5) NULL,
	[RoutNbrOperOrd1] [bigint] NULL,
	[IntCount1] [int] NULL,
	[RegInd] [varchar](7) NULL,
	[CostCntr] [varchar](13) NULL,
	[Fund] [varchar](13) NULL,
	[FundCntr] [varchar](19) NULL,
	[FuncArea] [varchar](19) NULL,
	[GrantNbr] [varchar](23) NULL,
	[FMBudPer] [varchar](13) NULL,
	[IUIDRelCust] [varchar](4) NULL,
	[GlobItm] [int] NULL,
	[EngMgmtObjNbr] [bigint] NULL,
	[StanWBSEleProjIncepSD] [int] NULL,
	[WrkPerIntRep] [int] NULL,
	[TreasAccSym] [varchar](33) NULL,
	[BizEveTypCode] [varchar](13) NULL,
	[ModAll] [varchar](4) NULL,
	[CanAll] [varchar](4) NULL,
	[ListPayMetCon] [varchar](13) NULL,
	[BizPartNbr] [int] NULL,
	[RepFreq] [varchar](6) NULL,
	[UntStatFedGovField] [varchar](25) NULL,
	[TradPartBizArea] [varchar](7) NULL,
	[RoutNbrOperOrd2] [bigint] NULL,
	[IntCount2] [int] NULL,
	[NbrResRepReq] [bigint] NULL,
	[ItmNbrResDepReq] [int] NULL,
	[ClaimItmNbr] [bigint] NULL,
	[VistSub01] [money] NULL,
	[VistSub02] [money] NULL,
	[VistSub03] [money] NULL,
	[VistSub04] [money] NULL,
	[VistSub05] [money] NULL,
	[VistSub06] [money] NULL,
	[VistSub07] [money] NULL,
	[VistSub08] [money] NULL,
	[VistSub09] [money] NULL,
	[VistSub10] [money] NULL,
	[ListPric] [money] NULL,
	[ListPricAdj] [money] NULL,
	[Cost] [money] NULL,
	[CostPO] [money] NULL,
	[CostAdj] [money] NULL,
	[CostAct] [money] NULL,
	[ResProp] [money] NULL,
	[Markup] [money] NULL,
	[Resale] [money] NULL,
	[FrghtEstd] [money] NULL,
	[FrghtAct] [money] NULL,
	[AppBaseLine] [money] NULL,
	[AvnSub13] [money] NULL,
	[AvnSub14] [money] NULL,
	[AvnSub15] [money] NULL,
	[ActGPCost] [money] NULL,
	[CustMatDesRegNbr] [varchar](27) NULL,
	[ReqPricStatSpecPric] [varchar](4) NULL,
	[CustMatProjNbr] [varchar](27) NULL,
	[CustMatProjNbrAtt] [varchar](27) NULL,
	[XABC] [varchar](6) NULL,
	[CostTyp1] [varchar](6) NULL,
	[SchedLineDate] [datetime2](7) NULL,
	[CustExpFlag] [varchar](4) NULL,
	[DateCodeSaleItmWeek] [varchar](6) NULL,
	[ResPritimeStam] [varchar](17) NULL,
	[SerNbrSoftLic] [bigint] NULL,
	[PlanDelTimeDay] [int] NULL,
	[SaleDeal2] [varchar](13) NULL,
	[ITARMat] [varchar](4) NULL,
	[TopDownBotUpPricTyp] [varchar](5) NULL,
	[AuthQty1] [decimal](14, 3) NULL,
	[AuthQty2] [decimal](14, 3) NULL,
	[AuthQty3] [decimal](14, 3) NULL,
	[AuthQty4] [decimal](14, 3) NULL,
	[AuthQty5] [decimal](14, 3) NULL,
	[AuthQty6] [decimal](14, 3) NULL,
	[XLR8QtNo1] [varchar](23) NULL,
	[XLR8QtNo2] [varchar](23) NULL,
	[XLR8QtNo3] [varchar](23) NULL,
	[XLR8QtNo4] [varchar](23) NULL,
	[XLR8QtNo5] [varchar](23) NULL,
	[XLR8QtNo6] [varchar](23) NULL,
	[CustLineItm] [varchar](13) NULL,
	[NbrMan1] [varchar](27) NULL,
	[EndCustPartNbr] [varchar](52) NULL,
	[SCMFlag] [varchar](4) NULL,
	[CustDraw] [varchar](53) NULL,
	[CustDrawRev] [varchar](10) NULL,
	[CustPartNbr] [varchar](52) NULL,
	[CustPartRevNbr] [varchar](37) NULL,
	[GovCont] [varchar](47) NULL,
	[PrioCode] [varchar](22) NULL,
	[DescCoupn] [varchar](23) NULL,
	[SerNbr] [varchar](7) NULL,
	[SinDateCode] [varchar](4) NULL,
	[AddLotCharg1] [money] NULL,
	[AddLotCharg2] [money] NULL,
	[AddUntCharg] [money] NULL,
	[AddUntCost] [money] NULL,
	[AddLotCost] [money] NULL,
	[ReaCode1] [varchar](33) NULL,
	[ReaCode2] [varchar](33) NULL,
	[ReaCode3] [varchar](33) NULL,
	[AddCost1] [money] NULL,
	[AddCost2] [money] NULL,
	[AddCost3] [money] NULL,
	[CostTyp2] [decimal](13, 5) NULL,
	[PricStrat] [varchar](12) NULL,
	[HandCharg] [varchar](4) NULL,
	[AgrmntTyp1] [varchar](4) NULL,
	[AgrmntTyp2] [varchar](4) NULL,
	[AgrmntTyp3] [varchar](4) NULL,
	[AgrmntTyp4] [varchar](4) NULL,
	[AgrmntTyp5] [varchar](4) NULL,
	[AgrmntTyp6] [varchar](4) NULL,
	[FASerNbr] [varchar](27) NULL,
	[EndUserPoNbr] [varchar](27) NULL,
	[MarkIns] [varchar](4) NULL,
	[IQtNbr] [varchar](17) NULL,
	[IQtLineItm] [varchar](12) NULL,
	[MarkCamIDCoup] [varchar](18) NULL,
	[RatCode] [varchar](7) NULL,
	[DateCode1] [varchar](5) NULL,
	[HAZMAT] [varchar](5) NULL,
	[BilSpecHandCharg] [varchar](4) NULL,
	[FuelSurc] [varchar](4) NULL,
	[ResSrc] [varchar](11) NULL,
	[CostSrcVal] [varchar](11) NULL,
	[BufTyp] [varchar](5) NULL,
	[ProdBizGrp] [varchar](7) NULL,
	[ProcStrat] [varchar](6) NULL,
	[TechCode] [varchar](6) NULL,
	[ComCode2] [varchar](6) NULL,
	[GrpCode] [varchar](6) NULL,
	[UntPric] [decimal](15, 5) NULL,
	[ResPric] [money] NULL,
	[SaleCost] [money] NULL,
	[ShipDebStat1] [varchar](5) NULL,
	[ShipDebStat2] [varchar](10) NULL,
	[ShipDebStat3] [varchar](5) NULL,
	[ShipDebStat4] [varchar](5) NULL,
	[ShipDebStat5] [varchar](5) NULL,
	[ShipDebStat6] [varchar](5) NULL,
	[ReqAgrmnt] [varchar](13) NULL,
	[CustInsInst] [varchar](9) NULL,
	[ShcModFlag] [varchar](4) NULL,
	[DateTimeStam] [varchar](17) NULL,
	[FASerNbrStat] [varchar](7) NULL,
	[RejRepCode] [varchar](4) NULL,
	[AOG] [varchar](13) NULL,
	[CustfldSaleOrdCustPlntLoc] [varchar](33) NULL,
	[CustSaleOrdfldInvCelLoc] [varchar](33) NULL,
	[CustSaleOrdFldIntLocCode] [varchar](33) NULL,
	[SerNbrSofLic] [varchar](27) NULL,
	[ValFroDate] [datetime2](7) NULL,
	[ValTo] [datetime2](7) NULL,
	[AirGrnd] [varchar](13) NULL,
	[RemQty] [decimal](16, 3) NULL,
	[LastConPromDate] [datetime2](7) NULL,
	[MulConDateExst] [varchar](4) NULL,
	[ATPDate] [datetime2](7) NULL,
	[MulATPDateExst] [varchar](4) NULL,
	[LineItmStat] [varchar](23) NULL,
	[BlckRea] [varchar](4) NULL,
	[DelBlck] [varchar](4) NULL,
	[CredBlck] [varchar](4) NULL,
	[ProgBlck] [varchar](4) NULL,
	[PricBlck] [varchar](4) NULL,
	[ShipDebBlck] [varchar](4) NULL,
	[ExtRes] [money] NULL,
	[MatGP] [money] NULL,
	[HazCodeMat] [varchar](4) NULL,
	[ShipComOrd] [varchar](4) NULL,
	[DRActStat] [varchar](4) NULL,
	[NbrMan2] [varchar](52) NULL,
	[RegID1] [varchar](67) NULL,
	[ConfID] [varchar](23) NULL,
	[ConfExpDate] [datetime2](7) NULL,
	[AgrmntID] [varchar](37) NULL,
	[RefData1] [varchar](43) NULL,
	[PricPromoCode1] [varchar](28) NULL,
	[PricPromoCode2] [varchar](28) NULL,
	[PricPromoCode3] [varchar](28) NULL,
	[PricPromoCode4] [varchar](28) NULL,
	[OSIFlag] [varchar](4) NULL,
	[SerTyp] [varchar](5) NULL,
	[SupQtRef] [varchar](23) NULL,
	[AnnDate] [datetime2](7) NULL,
	[EndUseBandLvl] [varchar](6) NULL,
	[FacSeal] [varchar](4) NULL,
	[IntegratedFl] [varchar](4) NULL,
	[Liab] [varchar](4) NULL,
	[Disp] [varchar](7) NULL,
	[RMAExpDate] [datetime2](7) NULL,
	[ItmPricAppBlck] [varchar](5) NULL,
	[LOIFlag] [varchar](4) NULL,
	[B2BPOFlag] [varchar](4) NULL,
	[SupContNo] [varchar](43) NULL,
	[FileAttID] [varchar](33) NULL,
	[PricPromoCode5] [varchar](28) NULL,
	[PricPromoCode6] [varchar](28) NULL,
	[ProgID1] [varchar](7) NULL,
	[ProgID2] [varchar](7) NULL,
	[ProgID3] [varchar](7) NULL,
	[ProgID4] [varchar](7) NULL,
	[ProgID5] [varchar](7) NULL,
	[ProgID6] [varchar](7) NULL,
	[AuthNbr] [varchar](47) NULL,
	[ShipDebAuth2] [varchar](28) NULL,
	[ShipDebAuth3] [varchar](28) NULL,
	[ShipDebAuth4] [varchar](28) NULL,
	[ShipDebAuth5] [varchar](28) NULL,
	[ShipDebAuth6] [varchar](28) NULL,
	[Exp1] [datetime2](7) NULL,
	[Exp2] [datetime2](7) NULL,
	[Exp3] [datetime2](7) NULL,
	[Exp4] [datetime2](7) NULL,
	[Exp5] [datetime2](7) NULL,
	[Exp6] [datetime2](7) NULL,
	[EndUseContVar] [varchar](13) NULL,
	[EUGenBizCode] [varchar](23) NULL,
	[SRVStarDate] [datetime2](7) NULL,
	[SRVEndDate] [datetime2](7) NULL,
	[BilFreq] [varchar](5) NULL,
	[ItmLvlRef] [varchar](18) NULL,
	[CustPurOrdTyp] [varchar](7) NULL,
	[OSINbr] [varchar](27) NULL,
	[AliVarID] [varchar](18) NULL,
	[EndUseSiteID] [varchar](13) NULL,
	[EndUseContID] [varchar](13) NULL,
	[EUISUCode] [varchar](5) NULL,
	[EUISUSubCode] [varchar](5) NULL,
	[EleNbr] [bigint] NULL,
	[SolID] [varchar](23) NULL,
	[FirstComDate] [datetime2](7) NULL,
	[RegID2] [varchar](23) NULL,
	[DRNbr] [varchar](52) NULL,
	[RegStat] [int] NULL,
	[MatchTyp] [varchar](7) NULL,
	[DateCode2] [int] NULL,
	[BufOrdQty] [decimal](16, 3) NULL,
	[TapeReel] [varchar](4) NULL,
	[AvnFCCalTypIndCustResFor] [varchar](4) NULL,
	[NCNRFlag] [varchar](4) NULL,
	[SHCCIIIns] [int] NULL,
	[LiaChckENQTC308] [varchar](4) NULL,
	[WebOrdNbr] [bigint] NULL,
	[IncHeadItm] [varchar](4) NULL,
	[KITPARTNbr] [varchar](42) NULL,
	[KITQty] [decimal](16, 3) NULL,
	[KITDes] [varchar](43) NULL,
	[SinCharInd] [varchar](4) NULL,
	[MatNbrUsedCust] [varchar](52) NULL
) ON [PRIMARY]

GO


