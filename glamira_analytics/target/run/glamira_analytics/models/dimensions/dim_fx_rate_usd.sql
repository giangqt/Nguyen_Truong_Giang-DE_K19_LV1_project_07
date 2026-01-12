
  
    

    create or replace table `stone-album-475912-b9`.`analytics_dev_dimensions`.`dim_fx_rate_usd`
      
    
    

    
    OPTIONS()
    as (
      WITH stg_fx AS (
    SELECT *
    FROM `stone-album-475912-b9`.`analytics_dev_staging`.`stg_fx_rate`
)

SELECT
    currency_code AS from_currency_code
    ,'USD' AS to_currency_code
    ,rate_to_usd
    ,rate_timestamp
FROM stg_fx
    );
  