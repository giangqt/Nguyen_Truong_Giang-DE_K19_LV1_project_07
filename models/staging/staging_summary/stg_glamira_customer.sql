select distinct
    user_id,
    email_address
from {{ ref('stg_glamira_summary') }}
where user_id is not null
