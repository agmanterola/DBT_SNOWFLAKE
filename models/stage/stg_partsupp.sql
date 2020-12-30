with stg_partsupp as (
    select 
        {{ make_hashpk(['PS_PARTKEY','PS_SUPPKEY'], pkname='hash_partsuppkey') }},
        PS_PARTKEY as PARTKEY,
        PS_SUPPKEY as SUPPKEY,
        PS_AVAILQTY as AVAILQTY,
        PS_SUPPLYCOST as SUPPLYCOST,
        PS_COMMENT as COMMENT,
        {{ make_hashdiff(['PS_AVAILQTY','PS_SUPPLYCOST','PS_COMMENT']) }},
        {{ make_tracefields(source='raw_partsupp') }}
    from {{ ref('raw_partsupp') }}
)

select * from stg_partsupp