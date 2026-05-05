WITH staging AS (
    SELECT 
        product_id,
        status,
        product_line,
        total_sales_amount 
    FROM {{ ref('stg_sales') }}
),

get_category_sales AS (
    SELECT
        product_id,
        product_line,
        total_sales_amount,
        SUM(total_sales_amount) OVER (
            PARTITION BY product_line
        ) AS category_total_sales
    FROM staging
    WHERE status = 'Shipped'
),

calculate_share AS (
    SELECT 
        *,
        ROUND((total_sales_amount / category_total_sales) * 100, 2) AS percentage_share_by_category
    FROM get_category_sales
)

SELECT
    product_id,
    product_line,
    total_sales_amount,
    percentage_share_by_category
FROM calculate_share
ORDER BY percentage_share_by_category DESC