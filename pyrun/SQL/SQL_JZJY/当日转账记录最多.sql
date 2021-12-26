SELECT CUST_NO FROM KS.BANK_TRF_INTERFACE  
where CUST_NO not in ('00002303','00002306') GROUP BY CUST_NO order by count(1) desc fetch first 1 rows only