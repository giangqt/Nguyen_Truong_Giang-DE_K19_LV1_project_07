select distinct
    store_id
from {{ ref('stg_glamira_summary') }}
where store_id is not null
