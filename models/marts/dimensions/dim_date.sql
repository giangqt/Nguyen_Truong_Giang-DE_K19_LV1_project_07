{{ config(materialized='table') }}

select distinct
    date(time_stamp) as date_key,
    extract(year  from date(time_stamp)) as year,
    extract(month from date(time_stamp)) as month,
    extract(day   from date(time_stamp)) as day,
    format_date('%A', date(time_stamp)) as day_name
from {{ ref('stg_glamira_summary') }}
where time_stamp is not null
