SELECT CUST_NO FROM KS.his_done 
where CUST_NO not in ('00002303','00002306')AND OCCUR_DATE BETWEEN '20210501' AND '20210601'
 GROUP BY CUST_NO order by count(1) desc fetch first 1 rows only