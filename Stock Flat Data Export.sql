SELECT 
	   SOCMP.COMPANY_NAME AS CUSTOMER,
	   ROCMP.COMPANY_NAME AS RO_VENDOR,	   
	   POCMP.COMPANY_NAME AS PO_VENDOR,
	   INH.INVC_NUMBER,
	   CQH.CQ_NUMBER,
	   POH.PO_NUMBER,
	   ROH.RO_NUMBER,
	   SPN.SALESPERSON_NAME, 	   
       STM.CNC_AUTO_KEY, 
       PNM.IC_UDF_004                                       NSN_NUMBER, 
       INH.CMP_AUTO_KEY, 
       INH.POST_DATE                                        INVOICE_DATE, 
       STM.TAIL_NUMBER, 
       STM.IC_UDF_008,  
       IND.IND_AUTO_KEY, 
       STM.STM_AUTO_KEY, 
       CNC.CONSIGNMENT_CODE, 
       STM.CALIB_REF_MASTER, 
       PNM.PN, 
       PNM.DESCRIPTION, 
       NVL(STM.SERIAL_NUMBER, ST.SERIAL_NUMBER)             SERIAL_NUMBER, 
       PCC.CONDITION_CODE, 
       IND.UNIT_PRICE, 
       STM.OVHL_COST, 
       NVL(STR.QTY_INVOICED, IND.QTY_SHIP)                  QTY_SHIP, 
       SUR.USER_NAME                                        BUYER, 
       STM.REC_DATE, 
       CASE 
         WHEN IND.QTY_SHIP < 0 THEN ST.UNIT_COST 
         ELSE STM.UNIT_COST 
       END                                                  UNIT_COST, 
       CASE 
         WHEN IND.QTY_SHIP < 0 THEN 
         NVL(STR.QTY_INVOICED, IND.QTY_SHIP) * ST.UNIT_COST 
         ELSE NVL(STR.QTY_INVOICED, IND.QTY_SHIP) * IND.UNIT_PRICE 
       END                                                  EXT_PRICE, 
       IND.ROUTE_DESC, 
       STR.QTY_INVOICED, 
       NVL(STR.QTY_INVOICED, IND.QTY_SHIP) * STM.UNIT_COST  EXT_COST, 
       NVL(STR.QTY_INVOICED, IND.QTY_SHIP) * IND.UNIT_PRICE PRICE_INVOICED, 
       CASE 
         WHEN SOD.QTY_ORDERED < 0 THEN 'RETURN'
         ELSE 'SALE'
       END                  CUST_SALE      
FROM   CONSIGNMENT_CODES CNC, 
       STOCK STM, 
       PART_CONDITION_CODES PCC, 
       INVC_DETAIL IND, 
       INVC_HEADER INH, 
       STOCK_RESERVATIONS STR, 
       PARTS_MASTER PNM, 
       SALESPERSON SPN, 
       PO_DETAIL POD, 
       PO_HEADER POH, 
       SYS_USERS SUR, 
       STOCK ST,
       SO_DETAIL SOD,
       SO_HEADER SOH,
       RO_DETAIL ROD,
       RO_HEADER ROH,
       CQ_DETAIL CQD,
       CQ_HEADER CQH,
       EXCHANGE EXC,
       COMPANIES ROCMP,
       COMPANIES SOCMP,
       COMPANIES POCMP
WHERE  STM.POD_AUTO_KEY = POD.POD_AUTO_KEY (+) 
       AND POD.POH_AUTO_KEY = POH.POH_AUTO_KEY (+) 
       AND POH.SYSUR_AUTO_KEY = SUR.SYSUR_AUTO_KEY (+) 
       AND INH.SPN_AUTO_KEY = SPN.SPN_AUTO_KEY (+) 
       AND IND.INH_AUTO_KEY = INH.INH_AUTO_KEY 
       AND IND.PNM_AUTO_KEY = PNM.PNM_AUTO_KEY (+) 
       AND IND.IND_AUTO_KEY = STR.IND_AUTO_KEY (+) 
       AND STR.STM_AUTO_KEY = STM.STM_AUTO_KEY (+) 
       AND STM.PCC_AUTO_KEY = PCC.PCC_AUTO_KEY (+) 
       AND STM.CNC_AUTO_KEY = CNC.CNC_AUTO_KEY (+) 
       AND IND.IND_AUTO_KEY = ST.IND_AUTO_KEY (+)
       AND IND.SOD_AUTO_KEY = SOD.SOD_AUTO_KEY (+)
       AND SOD.SOH_AUTO_KEY = SOH.SOH_AUTO_KEY (+)
       AND SOD.ROD_AUTO_KEY = ROD.ROD_AUTO_KEY (+)
       AND ROD.ROH_AUTO_KEY = ROH.ROH_AUTO_KEY (+)
       AND SOD.CQD_AUTO_KEY = CQD.CQD_AUTO_KEY (+)
       AND CQD.CQH_AUTO_KEY = CQH.CQH_AUTO_KEY (+)
       AND SOD.SOD_AUTO_KEY = EXC.SOD_AUTO_KEY (+)
       AND ROH.CMP_AUTO_KEY = ROCMP.CMP_AUTO_KEY (+)
       AND SOH.CMP_AUTO_KEY = SOCMP.CMP_AUTO_KEY (+)
       AND POH.CMP_AUTO_KEY = POCMP.CMP_AUTO_KEY (+)


