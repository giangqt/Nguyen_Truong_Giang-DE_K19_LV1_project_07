select
    location_id,
    null as country_short_name,
    null as country_long_name,
    null as region_name,
    null as city_name
from {{ ref('stg_glamira_location') }}
