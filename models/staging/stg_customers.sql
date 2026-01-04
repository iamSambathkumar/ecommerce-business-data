WITH source AS (

    SELECT *
    FROM {{ source('raw_ecom_data', 'customers') }} 

),

renamed AS (

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
        TO_TIMESTAMP_TZ(created_at)     AS created_at,
        TRY_CAST(lifetime_value AS NUMBER(12,2)) AS lifetime_value,
        is_active
    FROM source  WHERE email IS NOT NULL

)

SELECT * FROM renamed 
