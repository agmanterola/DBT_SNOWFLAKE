with stg_orders as (
    select 
        {{ make_hashpk(['O_ORDERKEY'], pkname='hash_orderkey') }},
        O_ORDERKEY as ORDERKEY,
        O_CUSTKEY as CUSTKEY,
        O_ORDERSTATUS as ORDERSTATUS,
        O_TOTALPRICE as TOTALPRICE,
        O_ORDERDATE as ORDERDATE,
        O_ORDERPRIORITY as ORDERPRIORITY,
        O_CLERK as CLERK,
        O_SHIPPRIORITY as SHIPPRIORITY,
        O_COMMENT as COMMENT,
        {{ make_hashdiff(['O_ORDERSTATUS','O_TOTALPRICE','O_ORDERDATE','O_ORDERPRIORITY','O_CLERK','O_SHIPPRIORITY','O_COMMENT']) }},
        {{ make_tracefields(source='raw_orders') }}
    from {{ ref('raw_orders') }}
)

select * from stg_orders