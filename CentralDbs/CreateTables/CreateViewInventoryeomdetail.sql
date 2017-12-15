USE CentralDbs
go

drop view CentralDbs.CentralDbs.InventoryEomDetailBuckets
go

Create View CentralDbs.dbo.InventoryEomDetailBuckets As(
Select  innerquery1.MaterialNbr, innerquery1.MfgPartNbr, 
                  innerquery1.Pbg, innerquery1.Mfg, innerquery1.PrcStgy, innerquery1.TechCd, innerquery1.Cc, 
                 innerquery1.Grp
,sum(Mth00Qty) as Mth00Qty
,sum(Mth01Qty) as Mth01Qty
,sum(Mth02Qty) as Mth02Qty
,sum(Mth03Qty) as Mth03Qty
,sum(Mth04Qty) as Mth04Qty
,sum(Mth05Qty) as Mth05Qty
,sum(Mth06Qty) as Mth06Qty
,sum(Mth07Qty) as Mth07Qty
,sum(Mth08Qty) as Mth08Qty
,sum(Mth09Qty) as Mth09Qty
,sum(Mth10Qty) as Mth10Qty
,sum(Mth11Qty) as Mth11Qty
,sum(Mth12Qty) as Mth12Qty
,sum(Mth13Qty) as Mth13Qty
,sum(Mth14Qty) as Mth14Qty
,sum(Mth15Qty) as Mth15Qty
,sum(Mth16Qty) as Mth16Qty
,sum(Mth17Qty) as Mth17Qty
,sum(Mth18Qty) as Mth18Qty
,sum(Mth19Qty) as Mth19Qty
,sum(Mth20Qty) as Mth20Qty
,sum(Mth21Qty) as Mth21Qty
,sum(Mth22Qty) as Mth22Qty
,sum(Mth23Qty) as Mth23Qty
,sum(Mth24Qty) as Mth24Qty
,sum(Mth00Val) as Mth00Val
,sum(Mth01Val) as Mth01Val
,sum(Mth02Val) as Mth02Val
,sum(Mth03Val) as Mth03Val
,sum(Mth04Val) as Mth04Val
,sum(Mth05Val) as Mth05Val
,sum(Mth06Val) as Mth06Val
,sum(Mth07Val) as Mth07Val
,sum(Mth08Val) as Mth08Val
,sum(Mth09Val) as Mth09Val
,sum(Mth10Val) as Mth10Val
,sum(Mth11Val) as Mth11Val
,sum(Mth12Val) as Mth12Val
,sum(Mth13Val) as Mth13Val
,sum(Mth14Val) as Mth14Val
,sum(Mth15Val) as Mth15Val
,sum(Mth16Val) as Mth16Val
,sum(Mth17Val) as Mth17Val
,sum(Mth18Val) as Mth18Val
,sum(Mth19Val) as Mth19Val
,sum(Mth20Val) as Mth20Val
,sum(Mth21Val) as Mth21Val
,sum(Mth22Val) as Mth22Val
,sum(Mth23Val) as Mth23Val
,sum(Mth24Val) as Mth24Val
 From(SELECT dbo.InventoryEomDetail.MaterialNbr, dbo.InventoryEomDetail.MfgPartNbr, 
                  dbo.InventoryEomDetail.Pbg, dbo.InventoryEomDetail.Mfg, dbo.InventoryEomDetail.PrcStgy, dbo.InventoryEomDetail.TechCd, dbo.InventoryEomDetail.Cc, 
                  dbo.InventoryEomDetail.Grp, CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 0 THEN Qty ELSE 0 END AS Mth00Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 1 THEN Qty ELSE 0 END AS Mth01Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 2 THEN Qty ELSE 0 END AS Mth02Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 3 THEN Qty ELSE 0 END AS Mth03Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 4 THEN Qty ELSE 0 END AS Mth04Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 5 THEN Qty ELSE 0 END AS Mth05Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 6 THEN Qty ELSE 0 END AS Mth06Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 7 THEN Qty ELSE 0 END AS Mth07Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 8 THEN Qty ELSE 0 END AS Mth08Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 9 THEN Qty ELSE 0 END AS Mth09Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 10 THEN Qty ELSE 0 END AS Mth10Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 11 THEN Qty ELSE 0 END AS Mth11Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 12 THEN Qty ELSE 0 END AS Mth12Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 13 THEN Qty ELSE 0 END AS Mth13Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 14 THEN Qty ELSE 0 END AS Mth14Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 15 THEN Qty ELSE 0 END AS Mth15Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 16 THEN Qty ELSE 0 END AS Mth16Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 17 THEN Qty ELSE 0 END AS Mth17Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 18 THEN Qty ELSE 0 END AS Mth18Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 19 THEN Qty ELSE 0 END AS Mth19Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 20 THEN Qty ELSE 0 END AS Mth20Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 21 THEN Qty ELSE 0 END AS Mth21Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 22 THEN Qty ELSE 0 END AS Mth22Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 23 THEN Qty ELSE 0 END AS Mth23Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 24 THEN Qty ELSE 0 END AS Mth24Qty, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 0 THEN Val ELSE 0 END AS Mth00Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 1 THEN Val ELSE 0 END AS Mth01Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 2 THEN Val ELSE 0 END AS Mth02Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 3 THEN Val ELSE 0 END AS Mth03Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 4 THEN Val ELSE 0 END AS Mth04Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 5 THEN Val ELSE 0 END AS Mth05Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 6 THEN Val ELSE 0 END AS Mth06Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 7 THEN Val ELSE 0 END AS Mth07Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 8 THEN Val ELSE 0 END AS Mth08Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 9 THEN Val ELSE 0 END AS Mth09Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 10 THEN Val ELSE 0 END AS Mth10Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 11 THEN Val ELSE 0 END AS Mth11Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 12 THEN Val ELSE 0 END AS Mth12Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 13 THEN Val ELSE 0 END AS Mth13Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 14 THEN Val ELSE 0 END AS Mth14Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 15 THEN Val ELSE 0 END AS Mth15Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 16 THEN Val ELSE 0 END AS Mth16Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 17 THEN Val ELSE 0 END AS Mth17Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 18 THEN Val ELSE 0 END AS Mth18Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 19 THEN Val ELSE 0 END AS Mth19Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 20 THEN Val ELSE 0 END AS Mth20Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 21 THEN Val ELSE 0 END AS Mth21Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 22 THEN Val ELSE 0 END AS Mth22Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 23 THEN Val ELSE 0 END AS Mth23Val, 
                  CASE WHEN dbo.InventoryEomDetail.FyMthNbr = dbo.RefDateAvnet.FyMthNbr - 24 THEN Val ELSE 0 END AS Mth24Val, RANK() OVER(PARTITION BY InventoryEomDetail.FyMthNbr ORDER BY InventoryEomDetail.FyMthNbr, InventoryEomDetail.VersionDt Asc) AS Rank1
FROM     dbo.InventoryEomDetail CROSS JOIN
                  dbo.RefDateAvnet
WHERE  (CAST(dbo.RefDateAvnet.DateDt AS Date) = CAST(GETDATE() AS DATE))) as innerquery1 
where rank1 = 1
group by innerquery1.MaterialNbr, innerquery1.MfgPartNbr, 
                  innerquery1.Pbg, innerquery1.Mfg, innerquery1.PrcStgy, innerquery1.TechCd, innerquery1.Cc, 
                 innerquery1.Grp) 

				 select * from InventoryEomDetailBuckets

			