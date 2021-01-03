-- Creacion de la tabla por primera vez.

{{
    config(
        materialized='incremental',
        unique_key='hash_customerkey'
    )
}}

with hub_customer as (
    select
		hash_customerkey,
        {{ make_tracefields(source='stg_customer') }},
        CUSTKEY
    from {{ ref('stg_customer') }}
    /*{% if is_incremental() %}
        where hash_customerkey not in (select hash_customerkey from {{ this }})
    {% endif %}
    */

)

select * from hub_customer