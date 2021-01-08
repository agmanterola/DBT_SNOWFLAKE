-- Creacion de la tabla por primera vez.

{{
    config(
        materialized='incremental',
        unique_key='hash_partsuppkey'
    )
}}

with lnk_partsupp as (
    select
		hash_partsuppkey,
        {{ make_tracefields(source='stg_partsupp') }},
        PARTKEY,
        SUPPKEY
    from {{ ref('stg_partsupp') }}
    /*{% if is_incremental() %}
        where hash_partsuppkey not in (select hash_partsuppkey from {{ this }})
    {% endif %}
    */

)

select * from lnk_partsupp