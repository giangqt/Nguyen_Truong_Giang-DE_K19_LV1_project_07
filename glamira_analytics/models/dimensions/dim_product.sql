WITH dim_product__source AS (
    SELECT *
    FROM {{ ref('stg_dim_product') }}
)

, dim_product__null_handle AS (
    SELECT
        product_id,
        COALESCE(product_name, 'Undefined') AS product_name,
        COALESCE(product_url, 'Undefined') AS product_url,
        COALESCE(product_sku, 'Undefined') AS product_sku,
        COALESCE(product_type, 'Undefined') AS product_type,
        COALESCE(NULLIF(TRIM(category_name), ''), 'Undefined') AS category_name, 
        COALESCE(NULLIF(TRIM(collection_name), ''), 'Undefined') AS collection_name,
        min_price,
        max_price
    FROM dim_product__source 
)

, dim_product__add_key AS (
    SELECT
        FARM_FINGERPRINT(CAST(product_id AS STRING)) AS product_key,
        *
    FROM dim_product__null_handle
)

, dim_product__union_undefined AS (
    SELECT 
        * FROM dim_product__add_key

    UNION ALL

    SELECT 
        -1 AS product_key,
        -1 AS product_id,
        'Undefined' AS product_name,
        'Undefined' AS product_url,
        'Undefined' AS product_sku,
        'Undefined' AS product_type,
        'Undefined' AS category_name,
        'Undefined' AS collection_name,
        0 AS min_price,
        0 AS max_price
)

SELECT * FROM dim_product__union_undefined