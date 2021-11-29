{{
    config(
        enabled=True
    )
}}

select 
	hc.customer_pk, 
	hc.customer_key, 	
	scd.first_name,
	scd.last_name,
	scd.email,	
    max(hc.load_date) as hub_load_date,
    max(scd.load_date) as scd_load_date    
from dbt.hub_customer hc
left join dbt.sat_customer_details scd 
on hc.customer_pk = scd.customer_pk 

group by 1,2,3,4,5