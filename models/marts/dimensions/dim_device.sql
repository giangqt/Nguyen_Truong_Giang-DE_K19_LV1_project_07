select
    device_id,
    user_agent,
    resolution
from {{ ref('stg_glamira_device') }}
