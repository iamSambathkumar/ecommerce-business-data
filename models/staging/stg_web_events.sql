WITH source AS (

    SELECT *
    FROM {{ source('raw_ecom_data', 'web_events') }}

),

renamed AS (

    SELECT
        event_id,
        session_id,
        customer_id,
        event_type,
        TO_TIMESTAMP_TZ(event_timestamp) AS event_timestamp,
        page_url,
        referrer_url,
        device_type,
        browser,
        ip_address,
        country,
        city,
        event_properties,        -- keep JSON as-is
        TO_TIMESTAMP_TZ(created_at) AS created_at
    FROM source

)

SELECT * FROM renamed
