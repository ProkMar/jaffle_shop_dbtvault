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
    scc.country,
	scc.age
from {{ref('hub_customer')}} hc
inner join {{ref('sat_customer_details')}} scd 
on hc.customer_pk = scd.customer_pk
    inner join {{ref('customers_pit')}} as cp_scd
    on scd.customer_hashdiff = cp_scd.scd_customer_hashdiff

inner join {{ref('sat_customers_crm')}} scc 
on hc.customer_pk = scc.customer_pk 
    inner join {{ref('customers_pit')}} as cp_scc
    on scc.customer_hashdiff = cp_scc.scc_customer_hashdiff

