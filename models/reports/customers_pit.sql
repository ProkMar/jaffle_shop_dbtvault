{{
    config(
        enabled=True
    )
}}

select	
	scd.customer_pk as scd_customer_pk,
	null as scc_customer_pk,
    max(scd.load_date) as load_date
from {{ref('sat_customer_details')}} scd
group by 1,2
union all
select	
	null,
	scc.customer_pk,
    max(scc.load_date)
from {{ref('sat_customers_crm')}} scc
group by 1,2