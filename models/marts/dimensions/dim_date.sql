select distinct
    date_id,
    date_id            as date_full,
    extract(year from date_id)  as year,
    extract(month from date_id) as month,
    extract(day from date_id)   as day,
    extract(hour from time_stamp) as hour
from {{ ref('stg_glamira_summary') }}
