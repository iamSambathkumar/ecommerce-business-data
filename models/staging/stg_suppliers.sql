WITH source AS (

    SELECT *
    FROM {{ source('raw_ecom_data', 'suppliers') }}

),

renamed AS (

    SELECT
        supplier_id,
        supplier_name,
        contact_name,
        email,
        phone,
        country,
        city,
        postal_code,
        rating,
        is_active,
        TO_TIMESTAMP_TZ(created_at) AS created_at,
        TO_TIMESTAMP_TZ(updated_at) AS updated_at
    FROM source

)

SELECT * FROM renamed
