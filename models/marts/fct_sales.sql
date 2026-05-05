WITH staging AS (
    SELECT * FROM {{ ref('stg_sales') }}
),

category_metrics AS (
    SELECT * FROM {{ ref('int_sales_by_category') }}
),

final AS (
    SELECT
        s.*,
        c.percentage_share_by_category
    FROM staging s
    LEFT JOIN category_metrics c
        ON s.order_id = c.order_id
        AND s.product_id = c.product_id
)

SELECT * FROM final
ORDER BY percentage_share_by_category DESC

