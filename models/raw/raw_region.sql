with region as (
    select
        R_REGIONKEY,
        R_NAME,
        R_COMMENT
    from {{ source ('TPCH_SF1','region') }}

)
select * from region