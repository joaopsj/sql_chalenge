WITH
  UserOrder AS (
  SELECT
    u.id AS user_id,
    u.first_name AS user_name,
    u.email AS user_email,
    u.state AS user_state,
    COUNT(o.order_id) AS total_orders,
    SUM(CASE
        WHEN o.status = 'Cancelled' THEN 1
      ELSE
      0
    END
      ) AS cancelled_orders
  FROM
    `bigquery-public-data.thelook_ecommerce.users` AS u
  LEFT JOIN
    `bigquery-public-data.thelook_ecommerce.orders` AS o
  ON
    u.id = o.user_id
  GROUP BY
    u.id,
    u.first_name,
    u.email,
    u.state )
SELECT
  user_name,
  user_email,
  user_state,
  CASE
    WHEN total_orders = 0 THEN 0
  ELSE
  (cancelled_orders / total_orders ) * 100.0
END
  AS percent_cancelled_orders
FROM
  UserOrder
ORDER BY
  percent_cancelled_orders;
