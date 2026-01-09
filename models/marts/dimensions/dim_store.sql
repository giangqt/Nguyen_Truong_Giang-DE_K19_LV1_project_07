{{ config(materialized='table') }}

select distinct
    farm_fingerprint(cast(store_id as string)) as store_key,
    store_id
from {{ ref('stg_glamira_summary') }}
where store_id is not null
