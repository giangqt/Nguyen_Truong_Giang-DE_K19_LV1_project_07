WITH source AS (
    SELECT * FROM {{ source('glamira_raw', 'summary') }}
)

SELECT DISTINCT
    CAST(store_id AS STRING) AS store_original_id
    -- Placeholder name since raw only has ID. 
    ,CONCAT('Store ', store_id) AS store_name 
FROM source
WHERE store_id IS NOT NULL