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

    SELECT
        order_id
        ,product_id
        ,user_id
        ,store_id
        ,device_id
        ,utm_source
        ,utm_medium
        ,referrer_url
        ,key_search
        ,currency
        ,unit_price
        ,local_time
        ,time_stamp
    FROM {{ ref('stg_glamira_summary') }}
    WHERE order_id IS NOT NULL

)

SELECT
    -- Surrogate key
    FARM_FINGERPRINT(
        CONCAT(
            CAST(order_id AS STRING), '|',
            CAST(product_id AS STRING), '|',
            CAST(user_id AS STRING)
        )
    ) AS sk_fact_sales

    -- Natural keys
    ,order_id
    ,product_id
    ,user_id
    ,store_id
    ,device_id

    -- Traffic foreign key
    ,FARM_FINGERPRINT(
        CONCAT(
            COALESCE(CAST(utm_source   AS STRING), ''), '|',
            COALESCE(CAST(utm_medium   AS STRING), ''), '|',
            COALESCE(CAST(referrer_url AS STRING), ''), '|',
            COALESCE(CAST(key_search   AS STRING), '')
        )
    ) AS traffic_key

    ,DATE(time_stamp) AS event_date
    ,time_stamp       AS event_ts

    ,1 AS quantity
    ,unit_price
    ,unit_price AS line_total
    ,currency

FROM source
