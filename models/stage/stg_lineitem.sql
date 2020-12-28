with stg_lineitem as (
    select 
        {{ make_hashpk(['L_ORDERKEY','L_PARTKEY','L_SUPPKEY','L_LINENUMBER'], pkname='hash_lineitemkey') }},
        L_ORDERKEY as ORDERKEY,
        L_PARTKEY as PARTKEY,
        L_SUPPKEY as SUPPKEY,
        L_LINENUMBER as LINENUMBER,
        L_QUANTITY as QUANTITY,
        L_EXTENDEDPRICE as EXTENDEDPRICE,
        L_DISCOUNT as DISCOUNT,
        L_TAX as TAX,
        L_RETURNFLAG as RETURNFLAG,
        L_LINESTATUS as LINESTATUS,
        L_SHIPDATE as SHIPDATE,
        L_COMMITDATE as COMMITDATE,
        L_RECEIPTDATE as RECEIPTDATE,
        L_SHIPINSTRUCT as SHIPINSTRUCT,
        L_SHIPMODE as SHIPMODE,
        L_COMMENT as COMMENT,
        {{ make_hashdiff(['L_QUANTITY','L_EXTENDEDPRICE','L_DISCOUNT','L_TAX','L_RETURNFLAG','L_LINESTATUS','L_SHIPDATE','L_COMMITDATE','L_RECEIPTDATE','L_SHIPINSTRUCT','L_SHIPMODE','L_COMMENT']) }},
        {{ make_tracefields(source='raw_lineitem') }}
    from {{ ref('raw_lineitem') }}
)

select * from stg_lineitem