with stg_part as (
    select 
        {{ make_hashpk(['P_PARTKEY'], pkname='hash_partkey') }},
        P_PARTKEY as PARTKEY,
        P_NAME as NAME,
        P_MFGR as MFGR,
        P_BRAND as BRAND,
        P_TYPE as TYPE,
        P_SIZE as SIZE,
        P_CONTAINER as CONTAINER,
        P_RETAILPRICE as RETAILPRICE,
        P_COMMENT as COMMENT,
        {{ make_hashdiff(['P_NAME','P_MFGR','P_BRAND','P_TYPE','P_SIZE','P_CONTAINER','P_RETAILPRICE','P_COMMENT']) }},
        {{ make_tracefields(source='raw_part') }}
    from {{ ref('raw_part') }}
)

select * from stg_part