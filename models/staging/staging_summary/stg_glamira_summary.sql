{{ config(materialized='view') }}

select
    -- IDs
    order_id,
    user_id_db          as user_id,
    product_id,
    store_id,
    device_id,

    -- Time
    safe_cast(local_time as timestamp)        as local_time,
    timestamp_seconds(time_stamp)             as time_stamp,
    date(timestamp_seconds(time_stamp))       as date_id,

    -- Product
    cat_id               as category_id,
    collection,
    price                as unit_price,
    currency,

    -- Traffic
    utm_source,
    utm_medium,
    referrer_url,
    key_search,

    -- Device
    resolution,
    user_agent,

    -- Customer
    email_address

from {{ source('raw_layer', 'summary') }}
