select
    {{ dbt_utils.generate_surrogate_key([
        "cast(order_id as string)",
        "cast(product_id as string)",
        "cast(user_id as string)"
    ]) }} as sk_fact_sales,

    order_id,
    product_id,
    user_id,
    store_id,
    store_id as location_id,
    date_id,
    device_id,

    to_hex(md5(concat(
        coalesce(cast(utm_source as string), ''),
        coalesce(cast(utm_medium as string), ''),
        coalesce(cast(referrer_url as string), ''),
        coalesce(cast(key_search as string), '')
    ))) as traffic_id,

    local_time,
    time_stamp,

    1 as quantity,
    currency,
    unit_price,
    unit_price as line_total

from {{ ref('stg_glamira_summary') }}
