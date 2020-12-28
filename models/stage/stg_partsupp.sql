with stg_partsupp as (
    select 
        {{ make_hashpk(['PS_PARTKEY','PS_SUPPKEY'], pkname='hash_partsuppkey') }},
        PS_PARTKEY as _PARTKEY,
        PS_SUPPKEY as _SUPPKEY,
        PS_AVAILQTY as _AVAILQTY,
        PS_SUPPLYCOST as _SUPPLYCOST,
        PS_COMMENT as _COMMENT,
        {{ make_hashdiff(['PS_AVAILQTY','PS_SUPPLYCOST','PS_COMMENT']) }},
        {{ make_tracefields(source='raw_partsupp') }}
    from {{ ref('raw_partsupp') }}
)

select * from stg_partsupp