-- This test fails if any order_date is later than the current time.
-- dbt looks for any rows returned by this query.
SELECT
    order_id,
    order_date
FROM {{ ref('stg_orders') }}
WHERE order_date > CURRENT_TIMESTAMP()