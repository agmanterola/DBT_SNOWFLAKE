with partsupp as (
    select
        PS_PARTKEY,
        PS_SUPPKEY,
        PS_AVAILQTY,
        PS_SUPPLYCOST,
        PS_COMMENT
    from {{ source ('TPCH_SF1','partsupp') }}

)
select * from partsupp