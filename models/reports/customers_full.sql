{{
    config(
        enabled=True
    )
}}

select 
	hc.customer_pk, 
	hc.customer_key, 	
	scd.first_name as first_name,
	scd.last_name as last_name,
	scd.email as email,
    scc.country as country,
	scc.age as age
from 
    {{ref('hub_customer')}} hc    

left join 

    (select 
        sc.customer_pk,
        sc.first_name,
        sc.last_name,
        sc.email
        from {{ref('sat_customer_details')}} sc
        inner join {{ref('customers_pit')}} as cp
        on sc.customer_pk = cp.scd_customer_pk
        and sc.load_date = cp.load_date
        ) as scd
        on hc.customer_pk = scd.customer_pk

left join 

    (select     
        sc.customer_pk,
        sc.country,
        sc.age
        from {{ref('sat_customers_crm')}} sc
        inner join {{ref('customers_pit')}} as cp
        on sc.customer_pk = cp.scc_customer_pk
        and sc.load_date = cp.load_date
        ) as scc
        on hc.customer_pk = scc.customer_pk
