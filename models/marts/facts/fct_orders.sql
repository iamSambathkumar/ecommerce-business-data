SELECT
    order_id,
    customer_id,
    product_id,
    order_date,
    ship_date,
    quantity,
    unit_price,
    discount,
    tax,
    shipping_cost,
    total_amount,
    order_status,
    payment_method,
    created_at
FROM {{ ref('stg_orders') }}
