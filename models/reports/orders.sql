{{
    config(
        enabled=True
    )
}}

select
    to_char(order_date, 'IYYY-IW') as week_of_year, 
    status as status, 
    count(*) as number_of_orders,
rank() over (
	partition by to_char(order_date, 'IYYY-IW'), status 
	order by to_char(order_date, 'IYYY-IW') asc)
from {{ source('src', 'source_orders') }}
group by to_char(order_date, 'IYYY-IW') , status