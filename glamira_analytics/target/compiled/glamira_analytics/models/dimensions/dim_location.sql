WITH dim_location__source AS (
    SELECT *
    FROM `stone-album-475912-b9`.`analytics_dev_staging`.`stg_dim_location`
)

, dim_location__union_undefined AS (
    SELECT
        location_id,
        country_short_name,
        country_long_name,
        region_name,
        city_name
    FROM dim_location__source

    UNION ALL

    SELECT
        -1 AS location_id,
        'Undefined' AS country_short_name,
        'Undefined' AS country_long_name,
        'Undefined' AS region_name,
        'Undefined' AS city_name
)

SELECT * FROM dim_location__union_undefined