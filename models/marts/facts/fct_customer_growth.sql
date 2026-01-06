WITH yearly AS (

    SELECT
        customer_id,
        YEAR(created_at) AS year,
        SUM(lifetime_value) AS total_value
    FROM {{ ref('stg_customers') }}
    GROUP BY customer_id, year

),

lagged AS (

    SELECT
        customer_id,
        year,
        total_value,
        LAG(total_value) OVER (
            PARTITION BY customer_id
            ORDER BY year
        ) AS prev_year_value
    FROM yearly

)

SELECT
    customer_id,
    year,
    total_value,
    {{ percent_growth('prev_year_value', 'total_value') }} AS yoy_growth_pct
FROM lagged
