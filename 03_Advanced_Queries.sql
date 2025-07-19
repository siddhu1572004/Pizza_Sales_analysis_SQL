-- Advanced_Queries: 
-- Q1) Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS total_revenue,
    ROUND(SUM(order_details.quantity * pizzas.price) * 100 / (SELECT 
                    SUM(order_details.quantity * pizzas.price)
                FROM
                    order_details
                        JOIN
                    pizzas ON order_details.pizza_id = pizzas.pizza_id),
            2) AS percentage_contribution
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
ORDER BY percentage_contribution DESC;

-- Q2) Analyze the cumulative revenue generated over time.
SELECT 
    daily_revenue.order_date,
    ROUND(daily_revenue.daily_total_revenue, 2) AS daily_total_revenue,
    ROUND(
        SUM(daily_revenue.daily_total_revenue) OVER (ORDER BY daily_revenue.order_date),
        2
    ) AS cumulative_revenue
FROM (
    SELECT 
        orders.order_date,
        SUM(order_details.quantity * pizzas.price) AS daily_total_revenue
    FROM orders
    JOIN order_details ON orders.order_id = order_details.order_id
    JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
    GROUP BY orders.order_date
) AS daily_revenue
ORDER BY daily_revenue.order_date;

-- Q3) Determine the top 3 most ordered pizza types based on revenue for each pizza category.
WITH pizza_revenue AS (
    SELECT 
        pizza_types.category,
        pizza_types.name AS pizza_name,
        SUM(order_details.quantity * pizzas.price) AS total_revenue,
        ROW_NUMBER() OVER (
            PARTITION BY pizza_types.category
            ORDER BY SUM(order_details.quantity * pizzas.price) DESC
        ) AS rank_within_category
    FROM order_details
    JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
    JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
    GROUP BY pizza_types.category, pizza_types.name
)
SELECT category, pizza_name, ROUND(total_revenue, 2) AS total_revenue
FROM pizza_revenue
WHERE rank_within_category <= 3
ORDER BY category, total_revenue DESC;