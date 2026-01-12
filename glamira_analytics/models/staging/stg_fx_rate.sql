WITH source AS (
    SELECT *
    FROM {{ ref('exchange_rate_usd') }}
)

, renamed AS (
    SELECT
        CAST(currency AS STRING) AS currency_code
        ,CAST(rate_to_usd AS NUMERIC) AS rate_to_usd
        ,CAST(as_of_gmt AS TIMESTAMP) AS rate_timestamp
    FROM source
)

SELECT * FROM renamed