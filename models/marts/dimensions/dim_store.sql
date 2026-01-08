select
    store_id,
    cast(store_id as string) as store_name
from {{ ref('stg_glamira_store') }}
