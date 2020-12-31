-- Creacion de la tabla por primera vez.

{{
    config(
        materialized='incremental',
    )
}}

with hub_orders as (
    select
		hash_orderkey,
        {{ make_tracefields(source='stg_orders') }},
        ORDERKEY,
        ORDERDATE
    from {{ ref('stg_orders') }}
    {% if is_incremental() %}
        where ORDERDATE >= (select max(ORDERDATE) from {{ this }})
    {% endif %}

)

select * from hub_orders
