-- Creacion de la tabla por primera vez.

{{
    config(
        materialized='incremental',
        unique_key='hash_regionkey'
    )
}}

with hub_region as (
    select
		hash_regionkey,
        {{ make_tracefields(source='stg_region') }},
        REGIONKEY
    from {{ ref('stg_region') }}
    /*{% if is_incremental() %}
        where hash_regionkey not in (select hash_regionkey from {{ this }})
    {% endif %}
    */

)

select * from hub_region