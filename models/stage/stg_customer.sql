with stg_customer as (
    select 
        {{ make_hashpk(['C_CUSTKEY'], pkname='hash_customerkey') }},
        C_CUSTKEY as CUSTKEY,
        C_NAME as NAME,
        C_ADDRESS as ADDRESS,
        C_NATIONKEY as NATIONKEY,
        C_PHONE as PHONE,
        C_ACCTBAL as ACCTBAL,
        C_MKTSEGMENT as MKTSEGMENT,
        C_COMMENT as COMMENT,
        {{ make_hashdiff(['C_NAME','C_ADDRESS','C_NATIONKEY','C_PHONE','C_ACCTBAL','C_MKTSEGMENT','C_COMMENT']) }},
        {{ make_tracefields(source='raw_customer') }}
    from {{ ref('raw_customer') }}
)

select * from stg_customer