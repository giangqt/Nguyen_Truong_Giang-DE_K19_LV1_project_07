select
    product_id,
    category_id,
    collection as collection_name,
    unit_price as list_price
from {{ ref('stg_glamira_summary') }}
group by 1,2,3,4
