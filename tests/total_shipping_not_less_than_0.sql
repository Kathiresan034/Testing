-- dbt tests pass if the query returns ZERO rows.
-- If this query returns any rows, the test fails.
SELECT
    order_id,
    total_shipping
FROM {{ ref('stg_orders') }}
WHERE total_shipping < 0