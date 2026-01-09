WITH source AS (
    SELECT * FROM {{ source('glamira_raw', 'summary') }}
)

SELECT
    order_id
    ,product_id
    -- Fix Null Users: If user_id is null, call it '0' (Guest)
    ,COALESCE(CAST(user_id_db AS STRING), '0') AS user_id
    
    ,store_id
    ,ip AS ip_address
    ,device_id AS device_original_id
    ,user_agent
    ,resolution
    ,utm_source
    ,utm_medium
    ,referrer_url
    ,CAST(local_time AS TIMESTAMP) AS event_timestamp
    ,CAST(REPLACE(price, ',', '') AS NUMERIC) AS total_price
    ,CAST(1 AS INT64) AS quantity
FROM source
WHERE collection = 'checkout_success'
  -- Fix Null Products: Remove rows that have no product info
  AND product_id IS NOT NULL