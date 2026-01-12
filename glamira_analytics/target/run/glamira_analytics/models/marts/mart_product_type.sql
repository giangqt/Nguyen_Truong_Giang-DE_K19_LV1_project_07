

  create or replace view `stone-album-475912-b9`.`analytics_dev`.`mart_product_type`
  OPTIONS()
  as WITH mart_product_type__fact AS (
    SELECT * FROM `stone-album-475912-b9`.`analytics_dev_dimensions`.`fact_sales_order_tt`
)

, mart_product_type__dim AS (
    SELECT * FROM `stone-album-475912-b9`.`analytics_dev_dimensions`.`dim_product`
)

, mart_product_type__joined AS (
    SELECT
        f.order_id,
        f.sales_amount,
        p.product_type
    FROM mart_product_type__fact f
    LEFT JOIN mart_product_type__dim p
        ON f.product_id = p.product_id
)

, mart_product_type__aggs AS (
    SELECT
        product_type,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(sales_amount) AS total_revenue
    FROM mart_product_type__joined
    GROUP BY 1
)

SELECT * FROM mart_product_type__aggs;

