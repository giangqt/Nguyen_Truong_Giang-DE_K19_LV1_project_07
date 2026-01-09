{{ config(
    materialized='incremental',
    unique_key='sk_fact_sales' 
) }}

WITH stg_orders AS (
    SELECT * FROM {{ ref('stg_glamira__sales_order') }}
)

SELECT
    -- Fact Key
    FARM_FINGERPRINT(CONCAT(CAST(order_id AS STRING), CAST(product_id AS STRING))) AS sk_fact_sales
    
    -- Foreign Keys
    ,FARM_FINGERPRINT(CAST(product_id AS STRING)) AS product_id
    ,FARM_FINGERPRINT(CAST(user_id AS STRING)) AS user_id
    ,FARM_FINGERPRINT(CAST(store_id AS STRING)) AS store_id
    ,FARM_FINGERPRINT(CAST(ip_address AS STRING)) AS location_id
    
    -- Device ID (Safely handle nulls/types)
    ,FARM_FINGERPRINT(IFNULL(
        CAST(device_original_id AS STRING), 
        CAST(user_agent AS STRING)
    )) AS device_id
    
    -- Traffic ID (Safely handle nulls/types)
    ,FARM_FINGERPRINT(CONCAT(
        IFNULL(CAST(utm_source AS STRING),''), 
        IFNULL(CAST(utm_medium AS STRING),'')
    )) AS traffic_id
    
    ,CAST(FORMAT_DATE('%Y%m%d', DATE(event_timestamp)) AS INT64) AS date_id

    -- Natural Keys & Measures
    ,order_id
    ,event_timestamp AS local_time
    ,event_timestamp AS time_stamp
    ,quantity
    ,total_price AS line_total
    
FROM stg_orders