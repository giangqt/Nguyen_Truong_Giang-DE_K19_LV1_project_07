

  create or replace view `stone-album-475912-b9`.`analytics_dev_staging`.`stg_fx_rate`
  OPTIONS()
  as WITH source AS (
    SELECT *
    FROM `stone-album-475912-b9`.`analytics_dev`.`exchange_rate_usd`
)

, renamed AS (
    SELECT
        CAST(currency AS STRING) AS currency_code
        ,CAST(rate_to_usd AS NUMERIC) AS rate_to_usd
        ,CAST(as_of_gmt AS TIMESTAMP) AS rate_timestamp
    FROM source
)

SELECT * FROM renamed;

