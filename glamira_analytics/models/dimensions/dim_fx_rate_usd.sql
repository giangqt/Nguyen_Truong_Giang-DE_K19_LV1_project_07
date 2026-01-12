WITH stg_fx AS (
    SELECT *
    FROM {{ ref('stg_fx_rate') }}
)

SELECT
    currency_code AS from_currency_code
    ,'USD' AS to_currency_code
    ,rate_to_usd
    ,rate_timestamp
FROM stg_fx