WITH source AS (

    SELECT *
    FROM {{ source('raw_ecom_data', 'customers') }}

),

ranked AS (

    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY TO_TIMESTAMP_TZ(created_at) DESC
        ) AS rn
    FROM source

),

deduped AS (

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
        address,
        customer_segment,
        acquisition_channel,
        TO_TIMESTAMP_TZ(created_at) AS created_at,
        CAST(lifetime_value AS NUMBER(12,2)) AS lifetime_value,
        is_active
    FROM ranked
    WHERE rn = 1

)

SELECT * FROM deduped
