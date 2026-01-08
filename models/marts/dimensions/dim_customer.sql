select
    user_id,
    email_address
from {{ ref('stg_glamira_customer') }}
