{{ 
  config(
    materialized = 'table',
    partition_by = {
      "field": "event_date",
      "data_type": "date"
    }
  ) 
}}

WITH source AS (
    SELECT * FROM {{ ref('stg_glamira_summary') }}
    WHERE order_id IS NOT NULL
)

SELECT
    -- Surrogate key
    FARM_FINGERPRINT(
        CONCAT(
            COALESCE(CAST(order_id AS STRING), ''), '|',
            COALESCE(CAST(product_id AS STRING), '-1'), '|',
            COALESCE(CAST(user_id AS STRING), 'GUEST')
        )
    ) AS sk_fact_sales

    -- Foreign Keys
    ,FARM_FINGERPRINT(CAST(store_id AS STRING)) AS store_key
    ,FARM_FINGERPRINT(CAST(product_id AS STRING)) AS product_key
    ,FARM_FINGERPRINT(CAST(user_id AS STRING)) AS customer_key
    ,FARM_FINGERPRINT(CAST(device_id AS STRING)) AS device_key
    ,FARM_FINGERPRINT(
        CONCAT(
            COALESCE(CAST(utm_source   AS STRING), ''), '|',
            COALESCE(CAST(utm_medium   AS STRING), ''), '|',
            COALESCE(CAST(referrer_url AS STRING), ''), '|',
            COALESCE(CAST(key_search   AS STRING), '')
        )
    ) AS traffic_key

    -- Natural Keys & Measures
    ,order_id
    ,product_id
    ,user_id
    ,store_id
    ,device_id
    ,DATE(time_stamp) AS event_date
    ,time_stamp       AS event_ts
    ,1 AS quantity
    ,unit_price
    ,unit_price AS line_total
    ,currency

FROM source

-- FIXED: Cast IDs to STRING inside the partition logic
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY CAST(order_id AS STRING), CAST(product_id AS STRING), CAST(user_id AS STRING) 
    ORDER BY time_stamp DESC
) = 1