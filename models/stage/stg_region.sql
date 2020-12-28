with stg_region as (
    select 
        {{ make_hashpk(['R_REGIONKEY'], pkname='hash_regionkey') }},
        R_REGIONKEY as REGIONKEY,
        R_NAME as NAME,
        R_COMMENT as COMMENT,
        {{ make_hashdiff(['R_NAME','R_COMMENT']) }},
        {{ make_tracefields(source='raw_region') }}
    from {{ ref('raw_region') }}
)

select * from stg_region