 SELECT KS.STOCK.CUST_NO, KS.STOCK.SEC_CODE  FROM KS.STOCK WHERE KS.STOCK.CUST_NO IN (
                        SELECT aaa.CUST_NO FROM (
                        SELECT AA.CUST_NO,BB.THIS_BAL FROM
                            (SELECT A.CUST_NO,A.CUST_STATUS FROM KS.CUST_BASE_INFO A
                            LEFT JOIN
                            (SELECT CUST_NO FROM KS.VIP_CUST_LIST)B
                             ON A.CUST_NO = B.CUST_NO
                             WHERE B.CUST_NO IS NULL AND A.ATTRIBUTE = '1' )
                         AA
                             LEFT JOIN
                             (SELECT D1.CUST_NO,a.THIS_BAL FROM KS.HOLDER_ACC D1 LEFT JOIN KS.FUND a ON D1.CUST_NO = a.CUST_NO WHERE  D1.MARKET_CODE = '{}'
                             AND D1.CUST_NO NOT IN {} AND D1.STATUS = '0' {}{} AND a.CUST_NO IS NOT NULL
                             {}{}
                             )
                         BB
                             ON
                         AA.CUST_NO = BB.CUST_NO
                         WHERE BB.CUST_NO IS NOT NULL AND AA.CUST_STATUS = '0'
                        )aaa
                        LEFT JOIN
                        KS.B_SECOND_FEE_DSCNT
                        bbb
                        ON
                        aaa.CUST_NO = bbb.CUST_NO
                        WHERE bbb.CUST_NO IS NOT NULL AND  bbb.ENTRUST_METHOD = '5' AND bbb.DISCOUNT_RATE != '1'  AND bbb.END_DATE >'20290101'
                        ORDER BY aaa.THIS_BAL DESC FETCH FIRST 100 ROWS ONLY WITH UR
                        ) AND KS.STOCK.SEC_TYPE = '{}' AND KS.STOCK.MARKET_CODE = '{}' 
						AND (KS.STOCK.THIS_VOL_BAL-KS.STOCK.ABNORMAL_FRZN_VOL-KS.STOCK.SELL_FROZEN_VOL-KS.STOCK.ETF_FROZEN_VOL-KS.STOCK.NOT_CIRC_VOL)> 1000
                          FETCH FIRST 1 ROWS ONLY WITH UR