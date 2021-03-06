/****** Script for SelectTopNRows command from SSMS  ******/





SELECT M.SapMaterialId, B.SapPlantCd, MPH.SapProductBusGroupCd, MPH.SapProcureStrategyCd, MPH.SapTechnologyCd, MPH.SapCommodityCd, MPH.SapProductGroupCd, B.SAP_MRP_CONTROLLER_CD, B.SAP_MRP_CONTROLLER_NM
FROM Material AS M INNER JOIN 
								(SELECT MP.MdmMaterialId
								  ,MP.SapPlantCd
								  ,MP.[SapMrpTypeCd]
								  ,MP.[SapMixedMrpCd]
								  ,MP.[SapMrpGroupCd]
								  ,MP.[SapMrpControllerCd]
								  ,MP.HubStateInd
								  ,A.SAP_MRP_CONTROLLER_CD
								  ,RIGHT(A.SAP_MRP_CONTROLLER_NM,len(A.SAP_MRP_CONTROLLER_NM)-CHARINDEX(' ', A.SAP_MRP_CONTROLLER_NM)) + ', ' + LEFT(A.SAP_MRP_CONTROLLER_NM,CHARINDEX(' ',A.SAP_MRP_CONTROLLER_NM)-1) AS SAP_MRP_CONTROLLER_NM
								FROM MaterialPlant AS MP INNER JOIN (SELECT *
																	FROM OPENQUERY(AVR80,'SELECT *
																	FROM GOLDEN.C_BT_MRP_CONTROLLER
																	WHERE HUB_STATE_IND<>-1') WHERE CHARINDEX(' ', SAP_MRP_CONTROLLER_NM)<>0
								)  AS A ON MP.SapMrpControllerCd=A.[ROWID_OBJECT]) AS B 
							ON M.RowIdObject=B.MdmMaterialId INNER JOIN MaterialProdHier AS MPH ON M.MaterialProdHierarchyId=MPH.RowIdObject
							WHERE B.HubStateInd<>-1 AND M.HubStateInd<>-1 AND M.SendToSapFl='Y' AND MPH.HubStateInd<>-1 AND (MPH.SapProductBusGroupCd='0ST' OR MPH.SapProductBusGroupCd='0IT')
