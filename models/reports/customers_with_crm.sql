{{
    config(
        enabled=True
    )
}}

select

    t.customer_pk,
    t.customer_key,
    t.first_name,
    t.last_name,
    t.email,
    t.country,
    t.age
from
(select 
	hc.customer_pk, 
	hc.customer_key, 	
	coalesce(scd.first_name, '') as first_name,
	coalesce(scd.last_name, '') as last_name,
	coalesce(scd.email, '') as email,
    null as country,
	null as age
from {{ref('hub_customer')}} hc
left join {{ref('sat_customer_details')}} scd 
on hc.customer_pk = scd.customer_pk
    inner join {{ref('customers_pit')}} as cp_scd
    on scd.customer_pk = cp_scd.scd_customer_pk
    and scd.load_date = cp_scd.load_date

union all

select 
	hc.customer_pk, 
	hc.customer_key, 	
	null,
	null,
	null,
    coalesce(scc.country, ''),
	coalesce(scc.age, 0)
from {{ref('hub_customer')}} hc
left join {{ref('sat_customers_crm')}} scc 
on hc.customer_pk = scc.customer_pk 
    inner join {{ref('customers_pit')}} as cp_scc
    on scc.customer_pk = cp_scc.scc_customer_pk
    and scc.load_date = cp_scc.load_date) as t

group by 1,2,3,4,5,6,7