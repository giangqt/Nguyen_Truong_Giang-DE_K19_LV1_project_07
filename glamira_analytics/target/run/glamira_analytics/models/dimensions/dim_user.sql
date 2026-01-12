
  
    

    create or replace table `stone-album-475912-b9`.`analytics_dev_dimensions`.`dim_user`
      
    
    

    
    OPTIONS()
    as (
      WITH dim_user__source AS (
    SELECT *
    FROM `stone-album-475912-b9`.`analytics_dev_staging`.`stg_fact_sales_order_tt`
)

, dim_user__dedup AS (
    SELECT
        user_id,
        -- We select the most recent location for the user
        ARRAY_AGG(location_id ORDER BY time_stamp DESC LIMIT 1)[OFFSET(0)] AS location_id,
        MAX(time_stamp) AS last_active_at
    FROM dim_user__source
    WHERE user_id IS NOT NULL
    GROUP BY user_id
)

SELECT 
    user_id,
    location_id,
    last_active_at
FROM dim_user__dedup
    );
  