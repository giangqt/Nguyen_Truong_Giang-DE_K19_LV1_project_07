{{ config(materialized='table') }}

SELECT DISTINCT
    FARM_FINGERPRINT(CAST(product_id AS STRING)) as product_key,
    product_id
FROM {{ ref('stg_glamira_summary') }}
WHERE product_id IS NOT NULL