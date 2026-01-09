WITH source AS (
    SELECT * FROM {{ source('glamira_raw', 'summary') }}
),

distinct_users AS (
    -- Deduplicate users: If a user has 2 emails, pick one.
    SELECT 
        CAST(user_id_db AS STRING) AS user_original_id,
        -- Aggregating to ensure 1 row per user
        MAX(email_address) AS email_address
    FROM source
    WHERE user_id_db IS NOT NULL
    GROUP BY 1
)

SELECT * FROM distinct_users

UNION ALL

-- Manually creating a "Guest" customer so Fact table links work
SELECT 
    '0' AS user_original_id,
    'guest@example.com' AS email_address