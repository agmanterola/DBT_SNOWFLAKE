with  sat_lineitem as (
    select * from {{ ref('sat_lineitem') }} s
    where dbt_valid_to is null
),

sat_partupp as (
    select * from {{ ref('sat_partsupp')}} s
    where dbt_valid_to is null 
),

sat_orders as (
    select * from {{ ref('sat_orders')}} s
    where dbt_valid_to is null 
),

lnk_lineitem as (
    select HASH_LINEITEMKEY from {{ ref('lnk_lineitem')}} l
    where last_seen = TO_NUMBER(TO_CHAR(SYSDATE(),'YYYYMMDD'))
),

lnk_partsupp as (
    select HASH_PARTSUPPKEY from {{ ref('lnk_partsupp')}} l
    where last_seen = TO_NUMBER(TO_CHAR(SYSDATE(),'YYYYMMDD'))
),

hub_orders as (
    select HASH_ORDERKEY from {{ ref('hub_orders')}} l
    where last_seen = TO_NUMBER(TO_CHAR(SYSDATE(),'YYYYMMDD'))
),


ref_dates as (
    select * from {{ ref('ref_dates') }}
),

partsupp as (
 select * 
 from lnk_partsupp l
 inner join sat_partupp s
    on l.HASH_PARTSUPPKEY = s.HASH_PARTSUPPKEY
),

lineitem as (
 select  *
 from lnk_lineitem l
 inner join sat_lineitem s
    on l.HASH_LINEITEMKEY = s.HASH_LINEITEMKEY
),

orders as (
 select  *
 from hub_orders h
 inner join sat_orders s
    on h.HASH_ORDERKEY = s.HASH_ORDERKEY
)

select 
l.ORDERKEY as ORDERKEY,
l.PARTKEY as PARTKEY,
l.SUPPKEY as SUPPKEY,
l.LINENUMBER as LINENUMBER,
o.CUSTKEY as CUSTOMERKEY,
l.QUANTITY as QUANTITY,
l.EXTENDEDPRICE as EXTENDEDPRICE,
l.DISCOUNT as DISCOUNT,
l.TAX as TAX,
l.RETURNFLAG as RETURNFLAG,
l.LINESTATUS as LINESTATUS,
p.AVAILQTY as AVAILQTY,
p.SUPPLYCOST as SUPPLYCOST,
order_refdates.DAYKEY as ORDERDATE,
o.ORDERPRIORITY as ORDERPRIORITY,
o.SHIPPRIORITY as SHIPPRIORITY,
o.TOTALPRICE as ORDTOTALPRICE,
ship_refdates.DAYKEY as SHIPDATE,
commit_refdates.DAYKEY as COMMITDATE,
receipt_refdates.DAYKEY as RECEIPTDATE,
l.SHIPINSTRUCT,
l.SHIPMODE
from lineitem l
inner join partsupp p on (l.PARTKEY = p.PARTKEY AND l.SUPPKEY = p.SUPPKEY)
inner join orders o on (l.ORDERKEY = o.ORDERKEY)
inner join ref_dates ship_refdates on TO_NUMBER(TO_CHAR(l.SHIPDATE,'YYYYMMDD'))= ship_refdates.DAYKEY
inner join ref_dates commit_refdates on TO_NUMBER(TO_CHAR(l.COMMITDATE,'YYYYMMDD'))= commit_refdates.DAYKEY
inner join ref_dates receipt_refdates on TO_NUMBER(TO_CHAR(l.RECEIPTDATE,'YYYYMMDD'))= receipt_refdates.DAYKEY
inner join ref_dates order_refdates on TO_NUMBER(TO_CHAR(o.ORDERDATE,'YYYYMMDD'))= order_refdates.DAYKEY


