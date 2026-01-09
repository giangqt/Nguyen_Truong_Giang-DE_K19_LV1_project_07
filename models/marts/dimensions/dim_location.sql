{{ config(materialized='table') }}

WITH stg AS (
    SELECT * FROM {{ ref('stg_glamira__location') }}
)

SELECT
    FARM_FINGERPRINT(ip_address) AS location_id
    ,country_short_name
    ,country_long_name
    ,region_name
    ,city_name
FROM stg