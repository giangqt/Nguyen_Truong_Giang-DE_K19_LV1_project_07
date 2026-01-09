{{ config(materialized='table') }}

select distinct
    farm_fingerprint(cast(device_id as string)) as device_key,
    device_id,
    user_agent,
    resolution
from {{ ref('stg_glamira_summary') }}
where device_id is not null
