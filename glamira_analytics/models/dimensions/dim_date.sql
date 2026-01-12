WITH dim_date__source AS (
    SELECT DISTINCT 
        DATE(time_stamp) AS full_date
    FROM {{ ref('stg_fact_sales_order_tt') }}
    WHERE time_stamp IS NOT NULL
)

, dim_date__format AS (
    SELECT
        CAST(FORMAT_DATE('%Y%m%d', full_date) AS INT64) AS date_key
        ,full_date AS date_day
        ,FORMAT_DATE('%A', full_date) AS day_name
        ,CASE
            WHEN FORMAT_DATE('%A', full_date) IN ('Saturday', 'Sunday') THEN TRUE
            ELSE FALSE
        END AS is_weekend
        ,CAST(FORMAT_DATE('%d', full_date) AS INT64) AS day_of_month
        ,FORMAT_DATE('%Y-%m', full_date) AS year_month
        ,CAST(FORMAT_DATE('%m', full_date) AS INT64) AS month_of_year
        ,CAST(FORMAT_DATE('%j', full_date) AS INT64) AS day_of_year
        ,CAST(FORMAT_DATE('%W', full_date) AS INT64) AS week_of_year
        ,CAST(FORMAT_DATE('%Q', full_date) AS INT64) AS quarter_of_year
        ,CAST(FORMAT_DATE('%Y', full_date) AS INT64) AS year_number
    FROM dim_date__source
)

SELECT 
    *
FROM dim_date__format
ORDER BY date_key