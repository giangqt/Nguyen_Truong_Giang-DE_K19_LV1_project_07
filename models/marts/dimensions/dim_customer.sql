{{ config(materialized='table') }}

select distinct
    farm_fingerprint(cast(user_id as string)) as customer_key,
    user_id as customer_id,
    email_address
from {{ ref('stg_glamira_summary') }}
where user_id is not null
