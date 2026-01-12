WITH stg_dim_location__source AS (
    SELECT 
        DISTINCT *
    FROM `stone-album-475912-b9`.`raw_layer`.`ip_location`
)

, stg_dim_location__rename AS (
    SELECT
        -- Removed ip_address to ensure uniqueness by City
        CAST(country_code AS STRING) AS country_short_name,
        CAST(country_code AS STRING) AS country_long_name,
        CAST(region AS STRING) AS region_name,
        CAST(city AS STRING) AS city_name
    FROM stg_dim_location__source
    WHERE country_code <> '-' 
      AND country_code IS NOT NULL
)

, stg_dim_location__distinct AS (
    SELECT DISTINCT
        country_short_name,
        country_long_name,
        region_name,
        city_name
    FROM stg_dim_location__rename
)

, stg_dim_location__gen_key AS (
    SELECT
        FARM_FINGERPRINT(country_short_name || region_name || city_name) AS location_id,
        country_short_name,
        country_long_name,
        region_name,
        city_name
    FROM stg_dim_location__distinct
)

SELECT * FROM stg_dim_location__gen_key