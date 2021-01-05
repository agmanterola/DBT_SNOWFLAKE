with  sat_part as (
    select * from {{ ref('sat_part') }} s
    where dbt_valid_to is null
),

hub_part as (
    select HASH_PARTKEY from {{ ref('hub_part')}} h
    where load_date = TO_NUMBER(TO_CHAR(SYSDATE(),'YYYYMMDD'))
),


part as (
 select * 
 from hub_part h
 inner join sat_part s
    on h.HASH_PARTKEY = s.HASH_PARTKEY
)


select
    p.PARTKEY,
    p.NAME,
    p.MFGR,
    p.BRAND,
    p.TYPE,
    p.SIZE,
    p.CONTAINER,
    p.RETAILPRICE,
    p.COMMENT
from part p
