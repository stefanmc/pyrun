 SELECT a1.CUST_NO,b1.SEC_CODE FROM (
		SELECT CUST_NO,MARKET_CODE,b.NSL_NEW_STK_LIMIT FROM KS.HOLDER_ACC a
		LEFT JOIN KS.NEW_STK_LIMIT b
		ON a.HOLDER_ACC_NO = b.NSL_HOLDER_ACC_NO
		WHERE b.NSL_NEW_STK_LIMIT >= 1000
		)a1
		LEFT JOIN
		KS.XG_INFORMATION b1
		ON a1.MARKET_CODE = b1.MARKET_CODE
		WHERE CUST_NO NOT IN {} AND b1.MARKET_CODE IS NOT NULL  AND a1.MARKET_CODE = '{}' AND b1.SEC_CODE IN
		(SELECT SEC_CODE FROM KS.XG_INFORMATION WHERE SEC_CODE IN (SELECT SEC_CODE FROM KS.B_SEC_CODE WHERE SEC_TYPE = '{}' AND SEC_VARIETY = '{}' {}) )
		AND  a1.CUST_NO IN (

		SELECT D1.CUST_NO FROM KS.HOLDER_ACC D1 LEFT JOIN KS.CUST_BASE_INFO a ON D1.CUST_NO = a.CUST_NO
                    WHERE D1.HOLDER_ACC_NO !='' AND a.CUST_STATUS = '0'   AND D1.STATUS = '0'{}{} AND a.ATTRIBUTE = '0' {}{}AND a.CUST_NO NOT IN {} AND D1.HOLDER_TYPE IN ('00','04') )
	ORDER BY rand(), a1.NSL_NEW_STK_LIMIT DESC FETCH FIRST 1 ROWS ONLY WITH UR