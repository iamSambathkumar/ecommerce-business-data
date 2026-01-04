WITH source AS (

    SELECT *
    FROM {{ source('raw_ecom_data', 'orders') }}

),

renamed AS (

    SELECT
        order_id,
        customer_id,
        product_id,
        TO_DATE(order_date) AS order_date,
        TO_DATE(ship_date)  AS ship_date,
        quantity,
        CAST(unit_price AS NUMBER(10,2)) AS unit_price,
        CAST(discount AS NUMBER(5,2))    AS discount,
        CAST(tax AS NUMBER(10,2))         AS tax,
        CAST(shipping_cost AS NUMBER(10,2)) AS shipping_cost,
        CAST(total_amount AS NUMBER(12,2)) AS total_amount,
        order_status,
        payment_method,
        shipping_address,
        TO_TIMESTAMP_TZ(created_at) AS created_at
    FROM source

)

SELECT * FROM renamed WHERE customer_id IN (
  SELECT customer_id FROM {{ ref('stg_customers') }}
)

