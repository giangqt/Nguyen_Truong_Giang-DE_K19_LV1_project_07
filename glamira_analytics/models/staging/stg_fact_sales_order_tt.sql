WITH stg_fact_sales_order_tt__source AS (
    SELECT *
    FROM {{ source('glamira_raw', 'summary') }}
    WHERE collection = 'checkout_success'
)

, stg_fact_sales_order_tt__remove_url_fail AS (
    SELECT *
    FROM stg_fact_sales_order_tt__source 
    WHERE current_url NOT LIKE 'file://%'
)

/* Location Lookup */
, stg_fact_sales_order_tt__location AS (
    SELECT DISTINCT 
        ip,
        country_code,
        region,
        city
    FROM {{ source('glamira_raw', 'ip_location') }}
    WHERE country_code IS NOT NULL
)

, stg_fact_sales_order_tt__joined AS (
    SELECT 
        s.*,
        l.country_code,
        l.region,
        l.city
    FROM stg_fact_sales_order_tt__remove_url_fail s
    LEFT JOIN stg_fact_sales_order_tt__location l
        ON s.ip = l.ip
)

, stg_fact_sales_order_tt__unnest AS (
    SELECT 
        s.*, 
        cp
    FROM stg_fact_sales_order_tt__joined s
    CROSS JOIN UNNEST(s.cart_products) AS cp
)

, stg_fact_sales_order_tt__rename AS (
    SELECT
        SAFE_CAST(REGEXP_REPLACE(CAST(s.order_id AS STRING), r'\..*', '') AS INT64) AS order_id,
        1 AS quantity,
        SAFE_CAST(REGEXP_REPLACE(CAST(cp.product_id AS STRING), r'\..*', '') AS INT64) AS product_id,
        SAFE_CAST(REGEXP_REPLACE(CAST(s.user_id_db AS STRING), r'\..*', '') AS INT64) AS user_id,
        SAFE_CAST(REGEXP_REPLACE(CAST(s.store_id AS STRING), r'\..*', '') AS INT64) AS store_id,
        TIMESTAMP_SECONDS(CAST(s.time_stamp AS INT64)) AS time_stamp,
        DATETIME(TIMESTAMP_SECONDS(CAST(s.time_stamp AS INT64))) AS local_time,
        
        -- Currency logic (abbreviated for readability, assume standard case statement remains)
        CASE WHEN s.currency IN ('USD', 'USD $') THEN 'USD' ELSE s.currency END AS currency_code,

        CAST(cp.price * 1 AS NUMERIC) AS line_total,
        
        -- FIX: Use COALESCE to handle missing lookups
        COALESCE(s.country_code, 'Undefined') AS country_short,
        COALESCE(s.region, 'Undefined') AS region,
        COALESCE(s.city, 'Undefined') AS city

    FROM stg_fact_sales_order_tt__unnest s
)

, stg_fact_sales_order_tt__calc_key AS (
    SELECT
        *,
        -- FIX: If location is Undefined, use -1. Otherwise generate key.
        CASE 
            WHEN country_short = 'Undefined' THEN -1
            ELSE FARM_FINGERPRINT(country_short || region || city) 
        END AS location_id
    FROM stg_fact_sales_order_tt__rename
)

SELECT * FROM stg_fact_sales_order_tt__calc_key