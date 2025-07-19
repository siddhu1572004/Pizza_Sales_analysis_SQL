-- Intermediate Queries: 
-- Q1) Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS total_quantity
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category
ORDER BY SUM(order_details.quantity) DESC;

-- Q2) Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(orders.order_time) AS order_hour,
    COUNT(*) AS total_orders
FROM
    orders
GROUP BY HOUR(orders.order_time)
ORDER BY order_hour;

-- Q3) Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS total_quantity
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category
ORDER BY SUM(order_details.quantity) DESC;

-- Q4) Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    orders.order_date,
    SUM(order_details.quantity) AS total_pizzas
FROM
    orders
        JOIN
    order_details ON orders.order_id = order_details.order_id
GROUP BY orders.order_date
ORDER BY orders.order_date;

-- Q5) Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
ORDER BY total_revenue DESC
LIMIT 3;

