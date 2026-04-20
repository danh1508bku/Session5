---1
SELECT
    c.customer_name AS customer_name,
    o.order_date AS order_date,
    o.total_amount AS total_amount
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id;

---2
SELECT
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_order_value,
    MAX(total_amount) AS max_order_value,
    MIN(total_amount) AS min_order_value,
    COUNT(order_id) AS order_count
FROM orders;

---3
SELECT
    c.city,
    SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 10000;

---4
SELECT
    c.customer_name,
    o.order_date,
    oi.product_name,
    oi.quantity,
    oi.price
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id;

---5
SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) = (
    SELECT MAX(total_revenue)
    FROM (
        SELECT
            customer_id,
            SUM(total_amount) AS total_revenue
        FROM orders
        GROUP BY customer_id
    ) t
);
