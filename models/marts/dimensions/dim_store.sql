{{ config(materialized='table') }}

WITH stg AS (
    SELECT * FROM {{ ref('stg_glamira__store') }}
)

SELECT
    FARM_FINGERPRINT(store_original_id) AS store_id
    ,store_name
FROM stg