SELECT
    supplier_id,
    supplier_name,
    country,
    city,
    rating,
    is_active
FROM {{ ref('stg_suppliers') }}
