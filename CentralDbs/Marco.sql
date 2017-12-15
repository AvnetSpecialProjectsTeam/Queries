select a2.*,a1.Qty from

(select * from MarcoAvxMfgPn) as a1
left join
(select z1.*,z2.MinCost as AcquisitionCost from
(select s1.*,s2.Ncnr from
(select t1.*,t2.SupplierMinOrderQt as SMOQ,t2.SupplierMinPackageQt as SMPQ from
(select MaterialNbr,MfgPartNbr from SapPartsList) as t1
inner join
(select MaterialNbr,SupplierMinPackageQt,SupplierMinOrderQt  from SapQuantities)as t2
on t1.MaterialNbr =t2.MaterialNbr

group by t1.MaterialNbr, t1.MfgPartNbr,t2.SupplierMinOrderQt,t2.SupplierMinPackageQt) as s1
inner join 
(select MaterialNbr, Ncnr from SapFlagsCodes) as s2
on s1.MaterialNbr = s2.MaterialNbr
group by s1.MaterialNbr, s1.MfgPartNbr,s1.SMOQ,s1.SMPQ,s2.Ncnr) as z1
inner join
(select Materialnbr, MinCost from CostResale) as z2
on z1.MaterialNbr = z2.MaterialNbr
group by z1.MaterialNbr,z1.MfgPartNbr,z1.Ncnr,z1.SMOQ,z1.SMPQ,z2.MinCost) as a2
on  a1.MfgPartNo = a2.MfgPartNbr
group by a2.MaterialNbr,a2.MfgPartNbr,a2.SMOQ,a2.Ncnr,a2.SMPQ,a2.AcquisitionCost,a1.Qty




---------- remove duplication
select e1.*,sum(e2.AvlStkQty) as QAS from
(select d1.*,d2.MinCost from
(select c1.*,c2.Ncnr from
(select b1.MaterialNbr,b1.MfgPartNo,b1.QTY,b2.SupplierMinOrderQt as SMOQ, b2.SupplierMinPackageQt as SMPQ from
(select  a1.MfgPartNo,sum(Qty) as QTY, Max(a2.MaterialNbr) as MaterialNbr from
(select * from MarcoAvxMfgPn) as a1
left join
(select MaterialNbr,MfgPartNbr from SapPartsList) as a2
on a1.MfgPartNo = a2.MfgPartNbr
group by a1.MfgPartNo,a1.Qty) as b1
left join 
(select MaterialNbr,SupplierMinPackageQt,SupplierMinOrderQt  from SapQuantities)as b2
on b1.MaterialNbr =b2.MaterialNbr
group by b1.MaterialNbr,b1.MfgPartNo,b1.QTY,b2.SupplierMinOrderQt, b2.SupplierMinPackageQt) as c1
left join 
(select MaterialNbr, Ncnr from SapFlagsCodes) as c2
on c1.MaterialNbr = c2.MaterialNbr
group by c1.MaterialNbr,c1.MfgPartNo,c1.QTY,c1.SMOQ,c1.SMPQ,c2.Ncnr) as d1
left join
(select Materialnbr, MinCost from CostResale) as d2
on d1.MaterialNbr = d2.MaterialNbr
group by d1.MaterialNbr,d1.MfgPartNo,d1.Ncnr,d1.QTY,d1.SMOQ,d1.SMPQ,d2.MinCost) as e1
left join
(select MaterialNbr, AvlStkQty from BI.dbo.DailyInv) as e2
on e1.MaterialNbr = e2.MaterialNbr 
group by e1.MaterialNbr,e1.MfgPartNo,e1.MinCost,e1.Ncnr,e1.QTY,e1.SMOQ,e1.SMPQ
order by e1.QTY desc

