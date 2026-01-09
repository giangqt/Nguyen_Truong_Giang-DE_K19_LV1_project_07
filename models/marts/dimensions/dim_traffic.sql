{{ config(materialized='table') }}

select distinct
    farm_fingerprint(
      concat(
        cast(utm_source as string), '|',
        cast(utm_medium as string), '|',
        cast(referrer_url as string), '|',
        cast(key_search as string)
      )
    ) as traffic_key,

    utm_source,
    utm_medium,
    referrer_url,
    key_search
from {{ ref('stg_glamira_summary') }}
