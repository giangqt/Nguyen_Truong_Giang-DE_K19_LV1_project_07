{{ config(materialized='table') }}

WITH stg AS (
    SELECT * FROM {{ ref('stg_glamira__product') }}
)

SELECT
    FARM_FINGERPRINT(CAST(product_original_id AS STRING)) AS product_id
    ,product_original_id
    ,category_id -- This now contains 'category_name' (e.g., 'Rings')
    ,collection_id
    ,CAST(price AS NUMERIC) AS list_price
FROM stg