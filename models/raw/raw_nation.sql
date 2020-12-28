with nation as (
    select
        N_NATIONKEY,
        N_NAME,
        N_REGIONKEY,
        N_COMMENT
    from {{ source ('TPCH_SF1','nation') }}

)
select * from nation