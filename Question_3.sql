WITH EventsOrder AS(

SELECT
        e.user_id AS user,
        o.order_id AS orders,
        MIN(e.created_at) AS acquisition_date,
        e.traffic_source AS acquisition_channel,
        oi.sale_price AS sales,
        SUM(oi.sale_price) AS total_sales

    FROM
        `bigquery-public-data.thelook_ecommerce.events` AS e
    JOIN
        `bigquery-public-data.thelook_ecommerce.orders` AS o ON e.user_id = o.user_id
    JOIN 
         `bigquery-public-data.thelook_ecommerce.order_items` AS oi ON o.order_id = oi.order_id   
    WHERE
        EXTRACT(YEAR FROM e.created_at) = 2021 AND e.user_id IS NOT NULL
    GROUP BY
        e.traffic_source, e.user_id, o.order_id, oi.sale_price 

)

SELECT 
        eo.acquisition_channel,
        COUNT(DISTINCT(eo.user)) AS total_users,
        COUNT(eo.orders) AS total_orders,
        SUM(eo.sales) AS revenue,
        ROUND(SUM(eo.total_sales * 100.0/(SELECT SUM(eo.total_sales) FROM EventsOrder AS eo)),2) AS percent_revenue
FROM

EventsOrder AS eo

GROUP BY eo.acquisition_channel

ORDER BY percent_revenue DESC; 
