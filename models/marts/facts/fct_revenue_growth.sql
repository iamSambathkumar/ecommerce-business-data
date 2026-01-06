WITH yearly AS (

    SELECT
        YEAR(order_date) AS year,
        SUM(total_amount) AS revenue
    FROM {{ ref('fct_orders') }}
    GROUP BY year

),

lagged AS (

    SELECT
        year,
        revenue,
        LAG(revenue) OVER (ORDER BY year) AS prev_revenue
    FROM yearly

)

SELECT
    year,
    revenue,
    {{ percent_growth('prev_revenue', 'revenue') }} AS revenue_growth_pct
FROM lagged
