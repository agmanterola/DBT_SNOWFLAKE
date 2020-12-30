-- Creacion de la tabla por primera vez.
with hub_nation as (
    select
		HASH_NATIONKEY,
        {{ make_tracefields(source='stg_nation') }},
        NATIONKEY
    from {{ ref('stg_nation') }}
)

select * from hub_nation
