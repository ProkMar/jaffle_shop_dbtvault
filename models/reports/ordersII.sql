{{
    config(
        enabled=True
    )
}}

{% set relation = api.Relation.create(schema='dbt', identifier='sat_order_details') %}

select
    to_char(order_date, 'IYYY-IW') as week_of_year, 
    status as status, 
    count(*) as number_of_orders,
    max(effective_from),
rank() over (
	partition by to_char(order_date, 'IYYY-IW'), status 
	order by to_char(order_date, 'IYYY-IW') asc)
from {{ relation.schema + '.' + relation.identifier }}
group by to_char(order_date, 'IYYY-IW') , status