{{ config(materialized='table') }}

WITH stg AS (
    SELECT DISTINCT 
        utm_source
        ,utm_medium
        ,referrer_url
    FROM {{ ref('stg_glamira__sales_order') }}
)

SELECT
    -- FIX: CAST columns to STRING before IFNULL to avoid type errors
    FARM_FINGERPRINT(CONCAT(
        IFNULL(CAST(utm_source AS STRING),''), 
        IFNULL(CAST(utm_medium AS STRING),'')
    )) AS traffic_id
    
    ,CAST(utm_source AS STRING) AS utm_source
    ,CAST(utm_medium AS STRING) AS utm_medium
    ,CAST(referrer_url AS STRING) AS referrer_url
FROM stg