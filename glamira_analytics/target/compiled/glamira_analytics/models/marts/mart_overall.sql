WITH mart_overall__source AS (
    SELECT *
    FROM `stone-album-475912-b9`.`analytics_dev_dimensions`.`fact_sales_order_tt`
)

, mart_overall__aggs AS (
    SELECT
        DATE(time_stamp) AS date_day,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(sales_amount) AS total_revenue,
        SUM(quantity) AS total_items_sold
    FROM mart_overall__source
    GROUP BY 1
)

SELECT * FROM mart_overall__aggs