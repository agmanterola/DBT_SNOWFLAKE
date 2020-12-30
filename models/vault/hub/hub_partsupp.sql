-- Creacion de la tabla por primera vez.
with hub_partsupp as (
    select
		hash_partsuppkey,
        {{ make_tracefields(source='stg_partsupp') }},
        PARTKEY,
        SUPPKEY
    from {{ ref('stg_partsupp') }}
)

select * from hub_partsupp
