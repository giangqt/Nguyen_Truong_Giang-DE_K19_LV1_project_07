WITH dim_store__source AS (
    SELECT DISTINCT 
        store_id
    FROM `stone-album-475912-b9`.`analytics_dev_staging`.`stg_fact_sales_order_tt`
    WHERE store_id IS NOT NULL
)

, dim_store__add_key AS (
    SELECT
        FARM_FINGERPRINT(CAST(store_id AS STRING)) AS store_key
        ,CAST(store_id AS STRING) AS store_id
        ,CONCAT('Store ', CAST(store_id AS STRING)) AS store_name
    FROM dim_store__source 
)

SELECT 
    *
FROM dim_store__add_key
ORDER BY store_id