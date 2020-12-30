-- Creacion de la tabla por primera vez.
with hub_part as (
    select
		hash_partkey,
        {{ make_tracefields(source='stg_part') }},
        PARTKEY
    from {{ ref('stg_part') }}
)

select * from hub_part
