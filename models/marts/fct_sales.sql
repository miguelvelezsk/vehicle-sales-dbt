WITH staging AS (
    SELECT * FROM {{ ref('stg_sales') }}
),

category_metrics AS (
    SELECT * FROM {{ ref('int_sales_by_category') }}
),

final AS (
    SELECT
        s.*,
        c.percentage_share_by_category,

        date_trunc('month', s.order_date) AS order_month,
        date_trunc('quarter', s.order_date) AS order_quarter,
        date_trunc('year', s.order_date) AS order_year,
        extract('month' from s.order_date) AS order_month_number,
        dayname(s.order_date) AS order_day_of_week

    FROM staging s
    LEFT JOIN category_metrics c
        ON s.order_id = c.order_id
        AND s.product_id = c.product_id
)

SELECT * FROM final

