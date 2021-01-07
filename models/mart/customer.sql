with  sat_customer as (
    select * from {{ ref('sat_customer') }} s
    where dbt_valid_to is null
),

hub_customer as (
    select HASH_CUSTOMERKEY from {{ ref('hub_customer')}} h
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

customer as (
 select * 
 from hub_customer h
 inner join sat_customer s
    on h.HASH_CUSTOMERKEY = s.HASH_CUSTOMERKEY
)


select
    c.CUSTKEY,
    c.NAME,
    c.ADDRESS,
    n.NAME as NATION,
    r.NAME as REGION,
    c.PHONE,
    c.ACCTBAL,
    c.MKTSEGMENT,
    c.COMMENT
    from customer c
    inner join nation n on c.NATIONKEY = n.NATIONKEY
    inner join region r on n.REGIONKEY = r.REGIONKEY

