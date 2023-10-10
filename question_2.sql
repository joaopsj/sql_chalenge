WITH ValidOrders AS (
    SELECT
        DISTINCT(oi.user_id) AS unique_users,
        o.order_id AS order_id,
        o.user_id,
        oi.product_id,
        o.num_of_item AS num_of_item,
        o.gender
    FROM
        `bigquery-public-data.thelook_ecommerce.orders` o
    JOIN
        `bigquery-public-data.thelook_ecommerce.order_items` oi ON o.order_id = oi.order_id
    JOIN
        `bigquery-public-data.thelook_ecommerce.users` u ON o.user_id = u.id
    WHERE
        o.status NOT IN ('cancelled', 'returned')
),

ProductSummary AS (
    SELECT
        p.id AS product_id,
        p.name AS product_name,
        p.retail_price,
        SUM(vo.num_of_item) AS total_sold,
        COUNT(unique_users) AS unique_users,
        (CASE WHEN vo.gender = "F" THEN 1 ELSE 0 END) AS female_users
    FROM
        `bigquery-public-data.thelook_ecommerce.products` p
    LEFT JOIN
        ValidOrders vo ON p.id = vo.product_id
    GROUP BY
        p.id, p.name, p.retail_price, vo.gender
)

SELECT
    ps.product_id,
    ps.product_name,
    (ps.retail_price * ps.total_sold) as total_profit,
    ps.unique_users,
    CASE
        WHEN ps.unique_users > 0 THEN (ps.female_users * 100.0) / ps.unique_users
        ELSE 0
    END AS percentage_female_users
FROM
    ProductSummary ps
#WHERE (CASE WHEN ps.unique_users > 0 THEN (ps.female_users / ps.unique_users) *100 ELSE 0 END)  < 80 
GROUP BY ps.unique_users, ps.female_users,ps.product_id, ps.product_name, ps.retail_price, ps.total_sold   
#ORDER BY percentage_female_users desc
LIMIT
    100;
