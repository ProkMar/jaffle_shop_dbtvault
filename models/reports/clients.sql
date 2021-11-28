{{
    config(
        enabled=True
    )
}}

{% set relation = api.Relation.create(schema='dbt', identifier='sat_customer_details') %}

select
    first_name,
    last_name,
    email,    
    max(effective_from)

from {{ relation.schema + '.' + relation.identifier }}
group by 1, 2, 3