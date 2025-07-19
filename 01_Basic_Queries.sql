-- Basic Questions 
-- Q1) Retrieve the total number of orders placed.
SELECT 
    COUNT(ORDER_ID) AS TOTAL_ORDERS
FROM
    ORDERS;

-- Q2)Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(ORDER_DETAILS.QUANTITY * PIZZAS.PRICE),
            2) AS TOTAL_SALES
FROM
    ORDER_DETAILS
        JOIN
    PIZZAS ON PIZZAS.PIZZA_ID = ORDER_DETAILS.PIZZA_ID;

-- Q3) Identify the highest-priced pizza.
SELECT 
    pizza_types.name, pizzas.size, pizzas.price
FROM
    pizzas
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- Q4) Identify the most common pizza size ordered.
SELECT 
    pizzas.size, COUNT(*) AS total_orders
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizzas.size
ORDER BY total_orders DESC
LIMIT 1;

-- Q5) List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name,
    SUM(order_details.quantity) AS total_quantity
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
ORDER BY SUM(order_details.quantity) DESC
LIMIT 5;


