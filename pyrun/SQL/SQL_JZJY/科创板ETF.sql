 SELECT AAA.CUST_NO,AAA.SEC_CODE FROM (
		SELECT AA.CUST_NO,AA.SEC_CODE,AA.VOL_BAL FROM(
			  SELECT A.CUST_NO,A.SEC_CODE,A.VOL_BAL,A.HOLDER_ACC_NO FROM (

						 SELECT a.CUST_NO,a.SEC_CODE,a.HOLDER_ACC_NO,a.THIS_VOL_BAL-a.ABNORMAL_FRZN_VOL-a.SELL_FROZEN_VOL-a.ETF_FROZEN_VOL-a.NOT_CIRC_VOL AS VOL_BAL
							FROM KS.STOCK a
						 LEFT JOIN KS.B_SEC_CODE b ON a.MARKET_CODE = b.MARKET_CODE AND a.SEC_CODE = b.SEC_CODE
						 WHERE a.MARKET_CODE = '{}' AND a.SEC_TYPE = '{}' AND a.CUST_NO NOT IN {} AND b.SEC_VARIETY = '{}'
						 AND a.SEC_CODE LIKE '588%'
						 {}{}			   
						 AND a.CUR_BUY_VOL = '0' AND a.CUR_SELL_VOL = '0'
					   
				 ) A LEFT JOIN (
								SELECT HOLDER_ACC_NO
								FROM KS.REDUCE_STOCK_INFO
				 )B ON A.HOLDER_ACC_NO =B.HOLDER_ACC_NO
					WHERE A.CUST_NO NOT IN {} AND B.HOLDER_ACC_NO IS NULL
				 )AA LEFT JOIN (
								SELECT AA1.HOLDER_ACC_NO FROM KS.HOLDER_ACC AA1 LEFT JOIN KS.CUST_BASE_INFO BB1 ON AA1.CUST_NO = BB1.CUST_NO
								WHERE AA1.HOLDER_ACC_NO !='' AND BB1.CUST_STATUS = '0' AND AA1.STATUS = '0' AND BB1.ATTRIBUTE = '0' AND BB1.CUST_NO NOT IN {} AND AA1.HOLDER_TYPE IN ('00','04')
				 )BB ON AA.HOLDER_ACC_NO = BB.HOLDER_ACC_NO
						WHERE BB.HOLDER_ACC_NO IS NOT NULL
				   )AAA
					LEFT JOIN (
								SELECT CUST_NO  FROM KS.VIP_CUST_LIST) BBB
					ON AAA.CUST_NO = BBB.CUST_NO
						WHERE BBB.CUST_NO IS NULL
					ORDER BY AAA.VOL_BAL DESC FETCH FIRST 1 ROWS ONLY WITH UR