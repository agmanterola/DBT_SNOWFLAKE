-- Creacion de la tabla por primera vez.

{{
    config(
        materialized='incremental',
        unique_key='hash_nationkey'
    )
}}

with hub_nation as (
    select
		hash_nationkey,
        {{ make_tracefields(source='stg_nation') }},
        NATIONKEY
    from {{ ref('stg_nation') }}
    /*{% if is_incremental() %}
        where hash_nationkey not in (select hash_nationkey from {{ this }})
    {% endif %}
    */

)

select * from hub_nation