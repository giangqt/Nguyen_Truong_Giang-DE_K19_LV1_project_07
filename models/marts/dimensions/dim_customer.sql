{{ config(materialized='table') }}

SELECT
    FARM_FINGERPRINT(CAST(user_id AS STRING)) as customer_key,
    user_id as customer_id,
    email_address
FROM {{ ref('stg_glamira_summary') }}
WHERE user_id IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY time_stamp DESC) = 1