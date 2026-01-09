{{ config(materialized='table') }}

SELECT
    FORMAT_DATE('%Y%m%d', d) AS date_id
    ,d AS date_full
    ,EXTRACT(YEAR FROM d) AS year
    ,EXTRACT(MONTH FROM d) AS month
    ,EXTRACT(DAY FROM d) AS day
FROM UNNEST(GENERATE_DATE_ARRAY('2020-01-01', '2025-12-31', INTERVAL 1 DAY)) AS d