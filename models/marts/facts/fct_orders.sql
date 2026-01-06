{{ config(
    materialized='incremental',
    unique_key='order_id'
) }}

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

{% if is_incremental() %}
WHERE created_at > (SELECT MAX(created_at) FROM {{ this }})
{% endif %}
