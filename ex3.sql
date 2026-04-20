---1
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.total_price) AS total_revenue,
    COUNT(o.order_id) AS order_count
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_price) > 2000;

---2
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.total_price) AS total_revenue
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_price) > (
    SELECT AVG(customer_revenue)
    FROM (
        SELECT
            customer_id,
            SUM(total_price) AS customer_revenue
        FROM orders
        GROUP BY customer_id
    ) t
);


---3
SELECT
    c.city,
    SUM(o.total_price) AS total_revenue
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_price) = (
    SELECT MAX(city_revenue)
    FROM (
        SELECT
            c2.city,
            SUM(o2.total_price) AS city_revenue
        FROM customers c2
        INNER JOIN orders o2
            ON c2.customer_id = o2.customer_id
        GROUP BY c2.city
    ) t
);
