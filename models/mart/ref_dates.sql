{{ config (
    materialized="table"
)}}

with initial_dates as (
{{ dbt_utils.date_spine(
    datepart="day",
    start_date="cast('1992-01-01' as date)",
    end_date="cast('2021-02-01' as date)"
   )
}}
)

select 
    TO_NUMBER(TO_CHAR(DATE_DAY,'YYYYMMDD')) as DAYKEY,
    DATE_DAY,
    TO_NUMBER(TO_CHAR(DATE_DAY,'DD')) as DAY,
    TO_NUMBER(TO_CHAR(DATE_DAY,'MM')) as MONTH,
    TO_NUMBER(TO_CHAR(DATE_DAY,'YYYY')) as YEAR,
    WEEKOFYEAR(DATE_DAY) as week_of_year,
    DAYOFWEEKISO(DATE_DAY) as day_of_week,
    QUARTER(DATE_DAY) as Quarter,
    CONCAT(TO_CHAR(DATE_DAY,'YYYY'),'-Q',QUARTER(DATE_DAY))as QYEAR
from initial_dates