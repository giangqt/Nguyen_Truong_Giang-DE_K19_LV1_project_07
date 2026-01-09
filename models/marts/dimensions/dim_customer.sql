{{ config(materialized='table') }}

WITH stg AS (
    SELECT * FROM {{ ref('stg_glamira__customer') }}
)

SELECT
    FARM_FINGERPRINT(user_original_id) AS user_id
    ,user_original_id
    ,email_address
FROM stg