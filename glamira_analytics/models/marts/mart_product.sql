WITH mart_product__fact AS (
    SELECT * FROM {{ ref('fact_sales_order_tt') }}
)

, mart_product__dim AS (
    SELECT * FROM {{ ref('dim_product') }}
)

, mart_product__joined AS (
    SELECT
        f.order_id,
        f.sales_amount,
        f.quantity,
        f.time_stamp,
        p.product_name,
        p.category_name,
        p.collection_name
    FROM mart_product__fact f
    LEFT JOIN mart_product__dim p
        ON f.product_id = p.product_id
)

, mart_product__aggs AS (
    SELECT
        product_name,
        category_name,
        collection_name,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(sales_amount) AS total_revenue,
        SUM(quantity) AS total_quantity_sold
    FROM mart_product__joined
    GROUP BY 1, 2, 3
)

SELECT * FROM mart_product__aggs