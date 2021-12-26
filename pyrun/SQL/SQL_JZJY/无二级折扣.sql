 SELECT KS.STOCK.SEC_CODE ,KS.STOCK.CUST_NO FROM KS.STOCK  WHERE KS.STOCK.CUST_NO IN (
                        SELECT a1.CUST_NO FROM (
                            SELECT AA.CUST_NO,BB.THIS_BAL FROM
                                (SELECT A.CUST_NO,A.CUST_STATUS  FROM KS.CUST_BASE_INFO A
                                LEFT JOIN
                                (SELECT CUST_NO FROM KS.VIP_CUST_LIST)B
                                 ON A.CUST_NO = B.CUST_NO
                                 WHERE B.CUST_NO IS NULL AND A.ATTRIBUTE = '1' )
                             AA
                                 LEFT JOIN
                                 (SELECT D1.CUST_NO,a.THIS_BAL FROM KS.HOLDER_ACC D1 LEFT JOIN KS.FUND a ON D1.CUST_NO = a.CUST_NO WHERE D1.MARKET_CODE = '{}'AND
                                 D1.CUST_NO NOT IN {} AND D1.STATUS = '0' {}{} AND a.CUST_NO IS NOT NULL
                                 {}{}
                                 )
                             BB
                                 ON
                             AA.CUST_NO = BB.CUST_NO
                             WHERE BB.CUST_NO IS NOT NULL AND AA.CUST_STATUS = '0'
                        )
                        a1
                        LEFT JOIN (
                            SELECT a.CUST_NO FROM KS.CUST_BASE_INFO a
                            LEFT JOIN (
                            SELECT CUST_NO FROM KS.B_SECOND_FEE_DSCNT WHERE CUST_NO !='' OR CUST_TYPE !='' OR ROOM_NO !='')b
                            ON a.CUST_NO =b.CUST_NO
                            WHERE b.CUST_NO IS NULL  AND a.CUST_STATUS = '0' AND a.CUST_NO NOT IN {}
                            )
                        b1
                        ON a1.CUST_NO = b1.CUST_NO
                        ORDER BY a1.THIS_BAL DESC FETCH FIRST 100 ROWS ONLY WITH UR) AND KS.STOCK.SEC_TYPE = '{}' AND KS.STOCK.MARKET_CODE = '{}'