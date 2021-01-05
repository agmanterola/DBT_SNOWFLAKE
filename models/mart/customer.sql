with  sat_customer as (
    select * from {{ ref('sat_customer') }} s
    where dbt_valid_to is null
),

hub_customer as (
    select HASH_CUSTOMERKEY from {{ ref('hub_customer')}} l
    where load_date = TO_NUMBER(TO_CHAR(SYSDATE(),'YYYYMMDD'))
),

customer as (
 select * 
 from hub_customer h
 inner join sat_customer s
    on h.HASH_CUSTOMERKEY = s.HASH_CUSTOMERKEY
)

select * from customer
