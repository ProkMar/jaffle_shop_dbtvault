{{
    config(
        enabled=True
    )
}}

select	
	scd.customer_hashdiff as scd_customer_hashdiff,
	null as scc_customer_hashdiff,
    max(scd.load_date) as scd_load_date
from {{ref('sat_customer_details')}} scd
group by 1,2
union all
select	
	null,
	scc.customer_hashdiff,
    max(scc.load_date)
from {{ref('sat_customers_crm')}} scc
group by 1,2