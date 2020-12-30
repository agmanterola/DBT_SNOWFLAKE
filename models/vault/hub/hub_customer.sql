-- Creacion de la tabla por primera vez.
with hub_customer as (
    select
		hash_customerkey,
        {{ make_tracefields(source='stg_customer') }},
        CUSTKEY
    from {{ ref('stg_customer') }}
)

select * from hub_customer
