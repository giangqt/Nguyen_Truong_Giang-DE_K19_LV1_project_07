select distinct
    product_id,
    category_id,
    collection
from {{ ref('stg_glamira_summary') }}
where product_id is not null
