with  sat_supplier as (
    select * from {{ ref('sat_supplier') }} s
    where dbt_valid_to is null
),

hub_supplier as (
    select HASH_SUPPLIERKEY from {{ ref('hub_supplier')}} h
    where last_seen = TO_NUMBER(TO_CHAR(SYSDATE(),'YYYYMMDD'))
),

region as (
    select s.REGIONKEY,s.NAME
    from {{ ref('hub_region')}} h
        inner join {{ ref('sat_region')}} s on h.HASH_REGIONKEY = s.HASH_REGIONKEY
        where h.last_seen = TO_NUMBER(TO_CHAR(SYSDATE(),'YYYYMMDD'))
        and s.dbt_valid_to is null
),

nation as (
    select s.NATIONKEY,s.NAME, s.REGIONKEY
    from {{ ref('hub_nation')}} h
        inner join {{ ref('sat_nation')}} s on h.HASH_NATIONKEY = s.HASH_NATIONKEY
        where h.last_seen = TO_NUMBER(TO_CHAR(SYSDATE(),'YYYYMMDD'))
        and s.dbt_valid_to is null
),

supplier as (
 select * 
 from hub_supplier h
 inner join sat_supplier s
    on h.HASH_SUPPLIERKEY = s.HASH_SUPPLIERKEY
)


select
    s.SUPPKEY,
    s.NAME,
    s.ADDRESS,
    n.NAME as NATION,
    r.NAME as REGION,
    s.PHONE,
    s.ACCTBAL,
    s.COMMENT
    from supplier s
    inner join nation n on s.NATIONKEY = n.NATIONKEY
    inner join region r on n.REGIONKEY = r.REGIONKEY

