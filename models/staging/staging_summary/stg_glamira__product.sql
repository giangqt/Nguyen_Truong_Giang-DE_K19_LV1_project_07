WITH source AS (
    SELECT * FROM {{ source('glamira_raw', 'product') }}
)

SELECT
    product_id AS product_original_id
    ,name AS product_name  -- FIX: Source column is 'name'
    ,CAST(min_price AS NUMERIC) AS price
    ,category_name AS category_id
    ,collection AS collection_id
FROM source
WHERE product_id IS NOT NULL