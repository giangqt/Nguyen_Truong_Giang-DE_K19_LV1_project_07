{{ config(materialized='table') }}

WITH stg AS (
    SELECT DISTINCT 
        device_original_id
        ,user_agent
        ,ip_address
        ,resolution
    FROM {{ ref('stg_glamira__sales_order') }}
)

SELECT
    -- Hash device_id if present, else user_agent
    FARM_FINGERPRINT(IFNULL(device_original_id, user_agent)) AS device_id
    ,device_original_id
    ,ip_address
    ,user_agent
    ,resolution
FROM stg