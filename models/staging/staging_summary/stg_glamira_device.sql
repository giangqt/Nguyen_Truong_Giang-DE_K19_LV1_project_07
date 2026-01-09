select distinct
    device_id,
    user_agent,
    resolution
from {{ ref('stg_glamira_summary') }}
where device_id is not null
