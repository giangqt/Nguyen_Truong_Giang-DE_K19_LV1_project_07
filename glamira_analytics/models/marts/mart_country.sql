WITH mart_country__fact AS (
    SELECT * FROM {{ ref('fact_sales_order_tt') }}
)

, mart_country__dim AS (
    SELECT * FROM {{ ref('dim_location') }}
)

, mart_country__joined AS (
    SELECT
        f.order_id,
        f.sales_amount,
        l.country_short_name,
        l.country_long_name,
        l.region_name,
        l.city_name
    FROM mart_country__fact f
    LEFT JOIN mart_country__dim l
        -- FIX: Casting both to STRING ensures they match regardless of data type
        ON CAST(f.location_id AS STRING) = CAST(l.location_id AS STRING)
)

, mart_country__aggs AS (
    SELECT
        country_short_name,
        country_long_name,
        region_name,
        city_name,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(sales_amount) AS total_revenue
    FROM mart_country__joined
    GROUP BY 1, 2, 3, 4
)

SELECT * FROM mart_country__aggs