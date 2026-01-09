{{ config(materialized='table') }}

SELECT
    FARM_FINGERPRINT(CAST(device_id AS STRING)) as device_key,
    device_id,
    user_agent,
    resolution
FROM {{ ref('stg_glamira_summary') }}
WHERE device_id IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY device_id ORDER BY time_stamp DESC) = 1