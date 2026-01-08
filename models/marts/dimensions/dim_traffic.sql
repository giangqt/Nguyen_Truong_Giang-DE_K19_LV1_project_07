select
    traffic_id,
    utm_source,
    utm_medium,
    referrer_url,
    key_search
from {{ ref('stg_glamira_traffic') }}
