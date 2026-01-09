{{ config(materialized='table') }}

select distinct
    farm_fingerprint(cast(store_id as string)) as location_key,
    store_id as location_id
from {{ ref('stg_glamira_summary') }}
where store_id is not null
