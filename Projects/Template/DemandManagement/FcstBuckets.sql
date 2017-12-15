--FcstMthBuckets
Select FcstMthBucketsNoAor.*, CostStrategy1, EmployeeAvnetId, EmployeePosition, EmployeeName, SupervisorAvnetId, SupervisorPosition, SupervisorName, LeadershipAvnetId, LeadershipPosition, LeadershipName From(Select LFC.FcstParty, LFC.FcstPartyNm, SalesOrg, DistChnl, Material, Mfg, MfgPartNbr, CustMat, Sum(RawFcstQty) as RawFcstQty, Sum(ScrubFcstQty) as ScrubFcstQty, FcstTrgtFyMthNbr, FcstTrgtFyMthTag  From CentralDbs.dbo.LastFcstMth as LFC cross join CentralDbs.dbo.RefDateAvnet left outer join CentralDbs.dbo.DemandMgmtAor as DMA on DMA.FcstParty = LFC.FcstParty Where Cast(DateDt as date) = Cast(GetDate() as date) and FyMthNbr <= FcstTrgtFyMthNbr Group by LFC.FcstParty, LFC.FcstPartyNm, SalesOrg, DistChnl, Material, Mfg, MfgPartNbr, CustMat, FcstTrgtFyMthNbr, FcstTrgtFyMthTag, EmployeeAvnetId, EmployeePosition, EmployeeName, SupervisorAvnetId, SupervisorPosition, SupervisorName, LeadershipAvnetId, LeadershipPosition, LeadershipAvnetId) as FcstMthBucketsNoAor Left Outer Join CentralDbs.dbo.DemandMgmtAor as DMA on DMA.FcstParty = FcstMthBucketsNoAor.FcstParty left outer join CentralDbs.dbo.CostStrategy on CostStrategy.Material = FcstMthBucketsNoAor.Material

--FcstWeekBuckets
Select FcstWeekBucketsNoAor.*, CostStrategy1, EmployeeAvnetId, EmployeePosition, EmployeeName, SupervisorAvnetId, SupervisorPosition, SupervisorName, LeadershipAvnetId, LeadershipPosition, LeadershipName From(Select FcstParty, FcstPartyNm, SalesOrg, DistChnl, Material, Mfg, MfgPartNbr, CustMat, Sum(RawFcstQty) as RawFcstQty, Sum(ScrubFcstQty) as ScrubFcstQty, DayofWeek From CentralDbs.dbo.LastFcstMth cross join CentralDbs.dbo.RefDateAvnet as TRDA left outer join (Select Min(DateDt) as DayOfWeek, CalWkNbr From CentralDbs.dbo.RefDateAvnet Group by CalWKNbr) as FirstDtWeek on FirstDtWeek.CalWkNbr = FcstTrgtWk Where Cast(TRDA.DateDt as date) = Cast(GetDate() as date) and TRDA.FyMthNbr <= FcstTrgtFyMthNbr Group by FcstParty, FcstPartyNm, SalesOrg, DistChnl, LastFcstMth.Material, LastFcstMth.Mfg, LastFcstMth.MfgPartNbr, CustMat, DayofWeek) as FcstWeekBucketsNoAor Left Outer Join CentralDbs.dbo.DemandMgmtAor as DMA on DMA.FcstParty = FcstWeekBucketsNoAor.FcstParty left outer join CentralDbs.dbo.CostStrategy on CostStrategy.Material = FcstWeekBucketsNoAor.Material
