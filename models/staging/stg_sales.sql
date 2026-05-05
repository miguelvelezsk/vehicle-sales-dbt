WITH 

source AS (
    SELECT * FROM {{ source('raw_store_data', 'ext_sales') }}
),

renamed AS (
    SELECT
        ORDERNUMBER AS order_id,
        PRODUCTCODE AS product_id,
        CUSTOMERNAME AS customer_name,
        QUANTITYORDERED AS quantity,
        PRICEEACH AS unit_price,
        SALES AS total_sales_amount,
        PRODUCTLINE AS product_line,

        strptime(ORDERDATE, '%m/%d/%Y %H:%M')::DATE AS order_date,

        STATUS AS status,
        CITY AS city,
        COUNTRY AS country

    FROM source
)

SELECT * FROM renamed