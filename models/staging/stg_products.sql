WITH source AS (

    SELECT *
    FROM {{ source('raw_ecom_data', 'products') }}

),

ranked AS (

    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY product_id
            ORDER BY TO_TIMESTAMP_TZ(created_at) DESC
        ) AS rn
    FROM source

),
deduped  AS (

    SELECT
        product_id,
        product_name,
        category,
        subcategory,
        supplier_id,
        CAST(unit_price AS NUMBER(10,2)) AS unit_price,
        CAST(cost AS NUMBER(10,2))       AS cost,
        sku,
        stock_quantity,
        reorder_level,
        discontinued,
        TO_TIMESTAMP_TZ(created_at) AS created_at,
        TO_TIMESTAMP_TZ(updated_at) AS updated_at
    FROM source

)

SELECT * FROM deduped 
