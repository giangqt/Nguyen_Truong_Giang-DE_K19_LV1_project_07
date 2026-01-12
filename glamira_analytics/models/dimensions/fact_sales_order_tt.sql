WITH fact_sales_order_tt__source AS (
    SELECT *
    FROM {{ ref('stg_fact_sales_order_tt') }}
)

, dim_product AS (
    SELECT product_id FROM {{ ref('dim_product') }}
)

, fact_sales_order_tt__check_integrity AS (
    SELECT
        f.order_id,
        
        -- FIX: If product doesn't exist in Dim, map to -1
        CASE 
            WHEN p.product_id IS NULL THEN -1
            ELSE f.product_id 
        END AS product_id,
        
        f.user_id,
        f.store_id,
        f.location_id,
        f.time_stamp,
        f.local_time,
        f.currency_code,
        f.quantity,
        f.line_total AS sales_amount,
        f.line_total AS gross_revenue
    FROM fact_sales_order_tt__source f
    LEFT JOIN dim_product p
        ON f.product_id = p.product_id
)

SELECT * FROM fact_sales_order_tt__check_integrity