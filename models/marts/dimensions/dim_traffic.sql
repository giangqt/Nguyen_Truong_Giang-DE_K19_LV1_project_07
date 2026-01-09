{{ config(materialized='table') }}

SELECT DISTINCT
    FARM_FINGERPRINT(
      CONCAT(
        COALESCE(CAST(utm_source   AS STRING), ''), '|',
        COALESCE(CAST(utm_medium   AS STRING), ''), '|',
        COALESCE(CAST(referrer_url AS STRING), ''), '|',
        COALESCE(CAST(key_search   AS STRING), '')
      )
    ) as traffic_key,

    -- FIXED: Cast to STRING before coalescing to avoid "BOOL vs STRING" error
    COALESCE(CAST(utm_source   AS STRING), '') as utm_source,
    COALESCE(CAST(utm_medium   AS STRING), '') as utm_medium,
    COALESCE(CAST(referrer_url AS STRING), '') as referrer_url,
    COALESCE(CAST(key_search   AS STRING), '') as key_search

FROM {{ ref('stg_glamira_summary') }}