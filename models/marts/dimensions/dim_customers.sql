SELECT
    customer_id,
    first_name,
    last_name,
    email,
    phone,
    country,
    state,
    city,
    postal_code,
    customer_segment,
    acquisition_channel,
    created_at,
    lifetime_value,
    is_active
FROM {{ ref('stg_customers') }}
