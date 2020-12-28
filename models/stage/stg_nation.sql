with stg_nation as (
    select 
        {{ make_hashpk(['N_NATIONKEY'], pkname='hash_nationkey') }},
        N_NATIONKEY as NATION,
        N_NAME as NAME,
        N_REGIONKEY as REGIONKEY,
        N_COMMENT as COMMENT,
        {{ make_hashdiff(['N_NAME','N_REGIONKEY','N_COMMENT']) }},
        {{ make_tracefields(source='raw_nation') }}
    from {{ ref('raw_nation') }}
)

select * from stg_nation