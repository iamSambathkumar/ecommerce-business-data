SELECT
    event_id,
    session_id,
    customer_id,
    event_type,
    event_timestamp,
    page_url,
    device_type,
    browser,
    country,
    city,
    event_properties
FROM {{ ref('stg_web_events') }}