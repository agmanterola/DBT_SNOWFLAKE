-- Creacion de la tabla por primera vez.

{{
    config(
        materialized='incremental',
        unique_key='hash_partkey'
    )
}}

with hub_part as (
    select
		hash_partkey,
        {{ make_tracefields(source='stg_part') }},
        PARTKEY
    from {{ ref('stg_part') }}
    /*{% if is_incremental() %}
        where hash_partkey not in (select hash_partkey from {{ this }})
    {% endif %}
    */

)

select * from hub_part
