-- Creacion de la tabla por primera vez.

{{
    config(
        materialized='incremental',
        unique_key='hash_lineitemkey'
    )
}}

with lnk_lineitem as (
    select
		hash_lineitemkey,
        {{ make_tracefields(source='stg_lineitem') }},
        ORDERKEY,
        PARTKEY,
        SUPPKEY,
        LINENUMBER
    from {{ ref('stg_lineitem') }}
    /*{% if is_incremental() %}
        where hash_lineitemkey not in (select hash_lineitemkey from {{ this }})
    {% endif %}
    */

)

select * from lnk_lineitem