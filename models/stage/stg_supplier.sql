with stg_supplier as (
    select 
        {{ make_hashpk(['S_SUPPKEY'], pkname='hash_supplierkey') }},
        S_SUPPKEY as SUPPKEY,
        S_NAME as NAME,
        S_ADDRESS as ADDRESS,
        S_NATIONKEY as NATIONKEY,
        S_PHONE as PHONE,
        S_ACCTBAL as ACCTBAL,
        S_COMMENT as COMMENT,
        {{ make_hashdiff(['S_NAME','S_ADDRESS','S_NATIONKEY','S_PHONE','S_ACCTBAL','S_COMMENT']) }},
        {{ make_tracefields(source='raw_supplier') }}
    from {{ ref('raw_supplier') }}
)

select * from stg_supplier