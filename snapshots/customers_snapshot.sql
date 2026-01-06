
{% snapshot customers_snapshot %}

{{
  config(
    target_schema='snapshots',
    unique_key='customer_id',
    strategy='timestamp',
    updated_at='created_at'
  )
}}

SELECT
    customer_id,
    first_name,
    last_name,
    email,
    phone,
    country,
    state,
    city,
    customer_segment,
    acquisition_channel,
    lifetime_value,
    is_active,
    created_at
FROM {{ ref('stg_customers') }} 

{% endsnapshot %}