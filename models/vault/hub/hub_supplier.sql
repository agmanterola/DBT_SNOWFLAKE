-- Creacion de la tabla por primera vez.

{{
    config(
        materialized='incremental',
        unique_key='hash_supplierkey'
    )
}}

with hub_supplier as (
    select
		hash_supplierkey,
        {{ make_tracefields(source='stg_supplier') }},
        SUPPKEY
    from {{ ref('stg_supplier') }}
    /*{% if is_incremental() %}
        where hash_supplierkey not in (select hash_supplierkey from {{ this }})
    {% endif %}
    */

)

select * from hub_supplier