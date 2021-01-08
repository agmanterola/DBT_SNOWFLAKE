with supplier as (
    select
        S_SUPPKEY,
        S_NAME,
        S_ADDRESS,
        S_NATIONKEY,
        S_PHONE,
        S_ACCTBAL,
        S_COMMENT
    from {{ source ('TPCH_SF1','supplier') }}

)
select * from supplier