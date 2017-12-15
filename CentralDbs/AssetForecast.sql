Create Table ##MaterialFilterList(
Material bigint Not Null
PRIMARY KEY CLUSTERED 
(
	Material ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

--Takes 7 Seconds
Insert Into ##MaterialFilterList
Select Distinct cast(Material as varchar(25)) As Material From CentralDbs.dbo.Bookbill cross join (Select FyMthNbr From CentralDbs.dbo.RefDateAvnet Where cast(DateDt as date) = cast(Getdate() as date)) as CalendarToday Where Type = 'Billings' AND Bookbill.FyMnthNbr >= CalendarToday.FyMthNbr-12
Union
Select Distinct cast(MaterialNbr as varchar(25)) As Material From Bi.dbo.DailyInv
Union
Select Distinct cast(MaterialNbr as varchar(25)) As Material From Bi.dbo.BIPoBacklog
Union
Select Distinct cast(MaterialNbr as varchar(25)) As Material From Bi.dbo.SoBacklog


Select * Into ##InventoryTemp from(	
	Select MaterialNbr, Sum(BlockedStk) As BlockedStk, Sum(AvlStkQty) As AvlStkQty, Sum(TtlStkQty) As TtlStkQty, Sum(TtlStkValue) As TtlStkValue, Sum(Case When Plant = 1300 Then AvlStkQty Else 0 End) As [1300Qas],  sum(Case When Plant = 1300 Then TtlStkQty Else 0 End) As [1300Qoh], Sum(Case When Plant = 1300 Then AvlStkQty Else 0 End) As [1300TtlStkValue], Sum(Case When SpecialStk = 'W' Then TtlStkQty Else 0 End) As ConsignedQty
	From Bi.dbo.DailyInv Group by MaterialNbr) as InvSum


Select * Into ##PoTemp from(
	Select Material, Sum(delinquient_sched_PO_qty) as delinquient_sched_PO_qty, Sum(schedlineValue) As SchedExtCost, Sum(SumOfScheduled_Qty) As SumOfScheduled_Qty, Sum(sched_PO_qty_mth_0) As sched_PO_qty_mth_0,Sum(sched_PO_qty_mth_1) As sched_PO_qty_mth_1,Sum(sched_PO_qty_mth_2) As sched_PO_qty_mth_2,Sum(sched_PO_qty_mth_3) As sched_PO_qty_mth_3,Sum(sched_PO_qty_mth_4) As sched_PO_qty_mth_4,Sum(sched_PO_qty_mth_5) as sched_PO_qty_mth_5,Sum(sched_PO_qty_mth_6) as sched_PO_qty_mth_6,Sum([sched_PO_qty_mth_>6]) as [sched_PO_qty_mth_>6], Sum(PoRemainingValue)/Sum(SumOfScheduled_Qty) As PoCost
	From(
		Select Material, scheduled_qty as SumOfScheduled_Qty, schedlineValue,
		Case When compare_date < date_dt Then scheduled_qty Else 0 End as delinquient_sched_PO_qty, PoRemainingValue, 
		Case When compare_date >= date_dt AND FyMthNbr = fy_mth_nbr_today Then scheduled_qty Else 0 End As sched_PO_qty_mth_0, 
		Case When compare_date >= date_dt AND FyMthNbr-1 = fy_mth_nbr_today Then scheduled_qty Else 0 End As sched_PO_qty_mth_1, 
		Case When compare_date >= date_dt AND FyMthNbr-2 = fy_mth_nbr_today Then scheduled_qty Else 0 End As sched_PO_qty_mth_2, 
		Case When compare_date >= date_dt AND FyMthNbr-3 = fy_mth_nbr_today Then scheduled_qty Else 0 End As sched_PO_qty_mth_3, 
		Case When compare_date >= date_dt AND FyMthNbr-4 = fy_mth_nbr_today Then scheduled_qty Else 0 End As sched_PO_qty_mth_4, 
		Case When compare_date >= date_dt AND FyMthNbr-5 = fy_mth_nbr_today Then scheduled_qty Else 0 End As sched_PO_qty_mth_5, 
		Case When compare_date >= date_dt AND FyMthNbr-6 = fy_mth_nbr_today Then scheduled_qty Else 0 End As sched_PO_qty_mth_6, 
		Case When compare_date >= date_dt AND FyMthNbr-6 > fy_mth_nbr_today Then scheduled_qty Else 0 End As [sched_PO_qty_mth_>6] 
		From(
			Select Material, scheduled_qty,schedlineValue,PoRemainingValue, compare_date, PoBacklog2.FyMthNbr,Cast(Rda.DateDt as date) As date_dt, Rda.FyMthNbr as fy_mth_nbr_today 
			From(
				Select *, RefDateAvnet.DateDt as date_dt From( 
					Select  MaterialNbr As Material, PoOpenQty as scheduled_qty, schedlineValue, PoRemainingValue,
					Case When [ConfDlvryDt] Is Null then [SchedlineDeliveryDt] Else [ConfDlvryDt] End As [compare_date]
					 From Bi.dbo.BiPoBacklog Where GenericPoType = 'External') as PoBacklog 
					 inner join CentralDbs.dbo.RefDateAvnet on RefDateAvnet.DateTxt = PoBacklog.compare_date) as PoBacklog2, CentralDbs.dbo.RefDateAvnet as RDA Where Rda.DateDt = Cast(GetDate() as date)) as PoBacklog3) as PoBacklog4 Group by Material) as PoSum

Select * Into ##SalesTemp From(
	Select MaterialNbr, Sum(Case When CompareDt < DateDt Then RemainingQty Else 0 End) As DelinquentQtySoBacklog, Sum(Case When CompareDt>=DateDt And FyMthNbr=TodayFyMthNbr Then RemainingQty Else 0 End) As RemainingQtySoMth00, Sum(Case When FyMthNbr-1=TodayFyMthNbr Then RemainingQty Else 0 End) As RemainingQtySoMth01, Sum(Case When FyMthNbr-2=TodayFyMthNbr Then RemainingQty Else 0 End) As RemainingQtySoMth02, Sum(Case When FyMthNbr-3=TodayFyMthNbr Then RemainingQty Else 0 End) As RemainingQtySoMth03, Sum(Case When FyMthNbr-4=TodayFyMthNbr Then RemainingQty Else 0 End) As RemainingQtySoMth04, Sum(Case When FyMthNbr-5=TodayFyMthNbr Then RemainingQty Else 0 End) As RemainingQtySoMth05, Sum(Case When FyMthNbr-6=TodayFyMthNbr Then RemainingQty Else 0 End) As RemainingQtySoMth06, Sum(Case When FyMthNbr-6>TodayFyMthNbr Then RemainingQty Else 0 End) As [RemainingQtySoMth>06] From(
		Select MaterialNbr, CustReqDockDt, LastConfPromDt, RemainingQty, RefDateAvnet.FyMthNbr, TodayAvnetCalendar.FyMthNbr As TodayFyMthNbr,
		Case When LastConfPromDt Is Null Then CustReqDockDt Else LastConfPromDt End As CompareDt, cast(GetDate() as Date) as DateDt
		From Bi.dbo.SoBacklog 
		inner join CentralDbs.dbo.RefDateAvnet on LastConfPromDt = DateDt 
		cross join CentralDbs.dbo.RefDateAvnet as TodayAvnetCalendar 
		Where SalesDocType = 'ZOR' and TodayAvnetCalendar.DateDt = Cast(GetDate() as date)) as SolDc --Sales Order Line Date Comparison
		Group by MaterialNbr) as SalesSum

		Select * Into ##BufferTemp From(
		Select MaterialNbr, Sum(RemainingQty) As CustBufferQty From Bi.dbo.SoBacklog Where SalesDocType = 'ZSB' Group by MaterialNbr) as BufferSum

		Select * Into ##ForecastTemp From(
		Select MaterialNbr, Sum(Case When CompareDt>=DateDt And FyMthNbr=TodayFyMthNbr Then RemainingQty Else 0 End) As RemainingQtySoFcstMth00, Sum(Case When FyMthNbr-1=TodayFyMthNbr Then RemainingQty Else 0 End) As RemainingQtySoFcstMth01, Sum(Case When FyMthNbr-2=TodayFyMthNbr Then RemainingQty Else 0 End) As RemainingQtySoFcstMth02, Sum(Case When FyMthNbr-3=TodayFyMthNbr Then RemainingQty Else 0 End) As RemainingQtySoFcstMth03, Sum(Case When FyMthNbr-4=TodayFyMthNbr Then RemainingQty Else 0 End) As RemainingQtySoFcstMth04, Sum(Case When FyMthNbr-5=TodayFyMthNbr Then RemainingQty Else 0 End) As RemainingQtySoFcstMth05, Sum(Case When FyMthNbr-6=TodayFyMthNbr Then RemainingQty Else 0 End) As RemainingQtySoFcstMth06, Sum(Case When FyMthNbr-6>TodayFyMthNbr Then RemainingQty Else 0 End) As [RemainingQtySoFcstMth>06] From(
		Select MaterialNbr, CustReqDockDt, LastConfPromDt, RemainingQty, RefDateAvnet.FyMthNbr, TodayAvnetCalendar.FyMthNbr As TodayFyMthNbr,
		Case When LastConfPromDt Is Null Then CustReqDockDt Else LastConfPromDt End As CompareDt, cast(GetDate() as Date) as DateDt
		From Bi.dbo.SoBacklog 
		inner join CentralDbs.dbo.RefDateAvnet on LastConfPromDt = DateDt 
		cross join CentralDbs.dbo.RefDateAvnet as TodayAvnetCalendar 
		Where SalesDocType = 'ZFC' and TodayAvnetCalendar.DateDt = Cast(GetDate() as date)) as SolDc --Sales Order Line Date Comparison
		Group by MaterialNbr) as ForecastSum

		

		Select * Into ##CostResaleTemp From(
		Select  MaterialNbr As MAterial, UnitBookCost, UnitSpecialCost From CentralDbs.dbo.CostResale) As CostResaleTbl

		Select * Into ##FlagsCodesTemp From(
		Select MaterialNbr, Plant, Ncnr, AbcCd, XStatus, SapStockingProfile, 1 As Dups From(Select MaterialNbr, SapPlantCd As Plant, Ncnr, AbcCd, XStatus, SapStockingProfile, RANK() Over(Partition By MaterialNbr Order By MaterialNbr Asc, SapPlantCd Asc) As MinPlant From CentralDbs.dbo.SapFlagsCodes) as FlagCodesMinPlant Where MinPlant = 1) As FlagsCodesMinPlant

		Select * into ##MapTemp From(
		Select * From CentralDbs.dbo.Map) as MovingAveragePrice

		Select * Into ##QuantitiesTemp From (
		Select MaterialNbr, Plant, LtPlanDlvry From(Select MaterialNbr, Plant, LtPlanDlvry, RANK() Over(Partition By MaterialNbr Order By MaterialNbr Asc, Plant Asc) As MinPlant From CentralDbs.dbo.SapQuantities) as FlagCodesMinPlant Where MinPlant = 1) As QuantitiesMinPlant

		Select * Into ##MarcTemp From(
		Select * From(Select Material, Plant, SchedMarginKeyFloats, Rank() Over(Partition By Material Order By Material Asc, Plant Asc) As Rank1 From Sap.dbo.Marc) As MarcMinPlant Where Rank1 = 1) As MarcMinPlant

		Select * Into ##SapPartsListTemp From(
		Select Distinct MaterialNbr, MfgPartNbr, Pbg, Mfg, PrcStgy, Tech, Cc, Grp From CentralDbs.dbo.SapPartsList) As SapPartsListTbl

		Select MFL.*, SPLT.Mfg, SPLT.MfgPartNbr, SPLT.CC, FCT.Ncnr, FCT.SapStockingProfile, FCT.AbcCd, FCT.Xstatus, QT.LtPlanDlvry, MT.SchedMarginKeyFloats, CRT.UnitBookCost As ZdcCost, ##MapTemp.MapPerUnit,IT.BlockedStk, IT.ConsignedQty, BT.CustBufferQty, IT.AvlStkQty, IT.TtlStkQty, It.TtlStkValue, ##ForecastTemp.RemainingQtySoFcstMth00,##ForecastTemp.RemainingQtySoFcstMth01,##ForecastTemp.RemainingQtySoFcstMth02,##ForecastTemp.RemainingQtySoFcstMth03,##ForecastTemp.RemainingQtySoFcstMth04,##ForecastTemp.RemainingQtySoFcstMth05,##ForecastTemp.RemainingQtySoFcstMth06,##ForecastTemp.[RemainingQtySoFcstMth>06],St.DelinquentQtySoBacklog, St.RemainingQtySoMth00, St.RemainingQtySoMth01, St.RemainingQtySoMth02, St.RemainingQtySoMth03, St.RemainingQtySoMth04, St.RemainingQtySoMth05, St.RemainingQtySoMth06, St.[RemainingQtySoMth>06], ##PoTemp.delinquient_sched_PO_qty, ##PoTemp.sched_PO_qty_mth_0, ##PoTemp.sched_PO_qty_mth_1, ##PoTemp.sched_PO_qty_mth_2, ##PoTemp.sched_PO_qty_mth_3, ##PoTemp.sched_PO_qty_mth_4, ##PoTemp.sched_PO_qty_mth_5, ##PoTemp.sched_PO_qty_mth_6, ##PoTemp.[sched_PO_qty_mth_>6],##PoTemp.PoCost, CRT.UnitSpecialCost, SPLT.Pbg, SPLT.PrcStgy, SPLT.Grp, IT.[1300Qas], IT.[1300Qoh], IT.[1300TtlStkValue]   From ##MaterialFilterList As MFL Left Outer Join ##SapPartsListTemp As SPLT on SPLT.MaterialNbr = MFL.Material Left Outer Join ##MarcTemp as MT On Mt.Material = MFL.Material Left Outer Join ##QuantitiesTemp as QT On Qt.MaterialNbr = MFL.Material LEFT OUTER JOIN ##MapTemp on ##MapTemp.Material = MFL.Material LEFT OUTER JOIN ##FlagsCodesTemp as FCT on FCT.MaterialNbr = MFL.Material LEFT OUTER JOIN ##CostResaleTemp as CRT on CRT.MAterial = MFL.Material LEFT OUTER JOIN ##BufferTemp AS BT on Bt.MaterialNbr = MFL.Material LEFT OUTER JOIN ##ForecastTemp ON ##ForecastTemp.MaterialNbr = MFL.Material LEFT OUTER JOIN ##SalesTemp as ST on St.MaterialNbr = MFL.Material LEFT OUTER JOIN ##PoTemp on ##PoTemp.Material = MFL.Material LEFT OUTER JOIN ##InventoryTemp As IT ON IT.MaterialNbr = MFL.Material


		Select Material, SchedExtCost, SumOfScheduled_Qty, PoCost From ##POTemp Where Material = '103895542' 
		Select (736725.00/13395000)

