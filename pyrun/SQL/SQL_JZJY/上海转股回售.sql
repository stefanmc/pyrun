SELECT AAA.CUST_NO,AAA.SEC_CODE FROM (
	 SELECT AA.CUST_NO,AA.SEC_CODE,AA.VOL_BAL FROM(

					  SELECT a.CUST_NO,a.SEC_CODE,a.HOLDER_ACC_NO,
				a.THIS_VOL_BAL-a.ABNORMAL_FRZN_VOL-a.SELL_FROZEN_VOL-a.ETF_FROZEN_VOL-a.NOT_CIRC_VOL-a.MANUAL_FROZEN_VOL AS VOL_BAL
				FROM KS.STOCK a
             LEFT JOIN KS.B_SEC_CODE b ON a.MARKET_CODE = b.MARKET_CODE AND a.SEC_CODE = b.SEC_CODE
             WHERE a.MARKET_CODE = '{}' AND a.SEC_TYPE = '{}' AND a.CUST_NO NOT IN {} AND b.SEC_VARIETY = '{}' {}
             {}{}
             AND a.CUR_BUY_VOL = '0' AND a.CUR_SELL_VOL = '0'

			 )AA LEFT JOIN (
							SELECT D1.HOLDER_ACC_NO FROM KS.HOLDER_ACC D1 LEFT JOIN KS.CUST_BASE_INFO BB1 ON D1.CUST_NO = BB1.CUST_NO
							WHERE D1.HOLDER_ACC_NO !='' AND BB1.CUST_STATUS = '0' AND D1.STATUS = '0' {}{} AND BB1.CUST_NO NOT IN {} AND D1.HOLDER_TYPE IN ('00','04')
			 )BB ON AA.HOLDER_ACC_NO = BB.HOLDER_ACC_NO
					WHERE BB.HOLDER_ACC_NO IS NOT NULL
					 )AAA
			LEFT JOIN (SELECT sec_code FROM KS.BOND_UNTRADE_INFO WHERE BS  ='{}') BBB
			ON AAA.sec_code = BBB.sec_code
				WHERE BBB.sec_code is　not  NULL
			ORDER BY rand(), AAA.VOL_BAL DESC  FETCH FIRST 1 ROWS ONLY WITH UR


