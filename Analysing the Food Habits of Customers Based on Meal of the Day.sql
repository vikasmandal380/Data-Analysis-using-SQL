SELECT 
    r.restaurant_id, 
    r.restaurant_name, 
    COUNT(f.item_id) AS food_item_count, 
    RANK() OVER (ORDER BY COUNT(f.item_id) DESC) AS ranking
FROM restaurants r
JOIN food_items f ON r.restaurant_id = f.restaurant_id
GROUP BY r.restaurant_id, r.restaurant_name
ORDER BY ranking;

WITH RankedFood AS (
    SELECT 
        f.restaurant_id, 
        f.item_id, 
        f.item_name, 
        SUM(orders_items.quantity) AS total_quantity, 
        RANK() OVER (PARTITION BY o.restaurant_id ORDER BY SUM(orders_items.quantity) DESC) AS ranking
    FROM orders o
    JOIN food_items f ON o.item_id = f.item_id
    GROUP BY f.restaurant_id, f.item_id, f.item_name
)
SELECT 
    restaurant_id, 
    item_id, 
    item_name, 
    total_quantity, 
    ranking
FROM RankedFood
WHERE ranking <= 3
ORDER BY restaurant_id, ranking;

SELECT 
    c.customer_id, 
    c.first_name, 
    SUM(o.total_price) AS total_spent,
    CASE 
        WHEN SUM(o.total_price) < 100 THEN 'Low'
        WHEN SUM(o.total_price) BETWEEN 100 AND 500 THEN 'Medium'
        ELSE 'High'
    END AS spending_category
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name;

WITH ClassifiedOrders AS (
    SELECT 
        order_id,
        delivered_time,
        CASE 
            WHEN TIMESTAMPDIFF(MINUTE, '00:00:00', delivered_time) < 30 THEN 'Fast'
            WHEN TIMESTAMPDIFF(MINUTE, '00:00:00', delivered_time) BETWEEN 30 AND 60 THEN 'Medium'
            ELSE 'Slow'
        END AS delivery_category
    FROM orders
)
SELECT 
    delivery_category, 
    COUNT(*) AS delivery_count
FROM ClassifiedOrders
WHERE delivery_category = 'Fast'
GROUP BY delivery_category;