-- Creacion de la tabla por primera vez.
with hub_supplier as (
    select
		hash_supplierkey,
        {{ make_tracefields(source='stg_supplier') }},
        SUPPKEY
    from {{ ref('stg_supplier') }}
)

select * from hub_supplier
