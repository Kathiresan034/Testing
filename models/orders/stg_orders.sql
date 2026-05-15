
{{ config(
    materialized='table',
    alias='stg_orders_1'
) }}

WITH raw_orders AS (
    SELECT * FROM {{ source('snowflake_raw', 'orders') }}
),

transformed_orders AS (
    SELECT
        -- 1. Ensure IDs are cast correctly
        CAST(order_id AS INT) AS order_id,
        CAST(customer_id AS INT) AS customer_id,

        -- 2. Standardize date format
        CAST(order_date AS DATE) AS order_date,

        -- 3. Standardize status (lowercase prevents "Pending" vs "pending" issues)
        LOWER(status) AS order_status,

        -- 4. Handle currency/numeric precision
        CAST(total_tax AS NUMBER(12,2)) AS tax_amount,
        CAST(total_shipping AS NUMBER(12,2)) AS shipping_amount,

        -- 5. Add a simple transformation (Calculated Column)
        (total_tax + total_shipping) AS total_fees_amount

    FROM raw_orders
)

SELECT * FROM transformed_orders