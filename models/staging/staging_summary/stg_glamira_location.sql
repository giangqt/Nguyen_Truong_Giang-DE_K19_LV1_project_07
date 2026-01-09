select distinct
    store_id as location_id
from {{ ref('stg_glamira_store') }}
