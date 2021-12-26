SELECT CUST_NO FROM KS.ENTRUST 
where CUST_NO not in ('00002303','00002306') and ENTRUST_DATE=to_char(CURRENT TIMESTAMP,'yyyymmdd') and BS < '10' 
GROUP BY  CUST_NO  ORDER BY count(1) desc fetch first 1 rows only