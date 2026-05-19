-- dbt tests pass if the query returns ZERO rows.
-- If this query returns any rows, the test fails.
SELECT
    order_id,
    shipping_amount
FROM {{ ref('stg_orders') }}
WHERE shipping_amount < 30