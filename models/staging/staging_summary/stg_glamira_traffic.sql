{{ config(materialized='view') }}

select distinct
    to_hex(md5(concat(
        cast(utm_source as string),
        cast(utm_medium as string),
        cast(referrer_url as string),
        cast(key_search as string)
    ))) as traffic_id,

    cast(utm_source as string)     as utm_source,
    cast(utm_medium as string)     as utm_medium,
    cast(referrer_url as string)   as referrer_url,
    cast(key_search as string)     as key_search

from {{ ref('stg_glamira_summary') }}
