SELECT 
    c.first_name, 
    o.order_id, 
    o.order_date, 
    o.total_price AS amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

SELECT 
    c.first_name, 
    SUM(o.total_price) AS total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.first_name;

SELECT 
    c.customer_id, 
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

SELECT 
    c.first_name, 
    o.order_id, 
    o.order_date, 
    o.total_price
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= '2023-08-12';
