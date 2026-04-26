-- ============================================================
-- BUSINESS INTELLIGENCE & ANALYTICAL DEEP DIVE
-- Project: Customer Transaction Analytics (5-Table Schema)
-- ============================================================

-- 1. List all payments made VIA UPI
SELECT * FROM payments WHERE payment_method='UPI';

-- 2. Count total number of products per category
SELECT category, COUNT(product_id) as no_of_products 
FROM products 
GROUP BY category;

-- 3. List all failed payments with their order details
SELECT * FROM orders o 
JOIN payments p on o.order_id = p.order_id
WHERE payment_status = 'Failed';

-- 4. Total Items sold per category
SELECT p.category, SUM(oi.quantity) as items_sold_category 
FROM order_items oi 
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY items_sold_category DESC;

-- 5. Revenue Collected by payment methods
SELECT p.payment_method, SUM(o.amount) as total_revenue_method
FROM payments p 
JOIN orders o ON p.order_id = o.order_id
GROUP BY p.payment_method
ORDER BY total_revenue_method DESC;

-- 6. TOP 10 products by revenue generation (Completed Orders Only)
SELECT TOP 10 
    p.product_id, 
    p.product_name, 
    SUM(oi.quantity * p.price) as product_revenue, 
    p.category,
    ROW_NUMBER() OVER(ORDER BY SUM(oi.quantity * p.price) DESC) as rank
FROM order_items oi 
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY p.product_id, p.product_name, p.category;

-- 7. Revenue contribution by product category
SELECT p.category, SUM(oi.quantity * p.price) as revenue
FROM order_items oi 
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY p.category
ORDER BY revenue DESC;

-- 8. Payment Failure rate by city (Identifying the ₹39K Leakage)
SELECT 
    c.city, 
    COUNT(p.payment_id) as total_no_of_orders,
    COUNT(CASE WHEN p.payment_status = 'Failed' THEN 1 END) as no_of_failed_orders,
    CAST(COUNT(CASE WHEN p.payment_status = 'Failed' THEN 1 END) * 100.0 / COUNT(p.payment_id) AS DECIMAL(10,2)) as failure_rate
FROM payments p 
JOIN orders o ON p.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.city
ORDER BY failure_rate DESC;

-- 9. Average Basket Size (items per order) by membership
WITH avg_basket_size AS (
    SELECT c.membership, o.order_id, COUNT(oi.order_item_id) as items_in_order
    FROM customers c 
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.membership, o.order_id
)
SELECT 
    membership, 
    CAST(AVG(CAST(items_in_order AS DECIMAL(10,2))) AS DECIMAL(10,2)) as avg_basket
FROM avg_basket_size
GROUP BY membership
ORDER BY avg_basket ASC;

-- 10. Revenue lost due to Failed Payments
SELECT SUM(o.amount) as revenue_lost_failed
FROM payments p 
JOIN orders o ON p.order_id = o.order_id
WHERE p.payment_status = 'Failed';

-- 11. Revenue Generated Per Product
SELECT p.product_id, p.product_name, SUM(oi.quantity * p.price) as revenue_per_product
FROM order_items oi 
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
GROUP BY p.product_id, p.product_name
ORDER BY revenue_per_product DESC;

-- 12. Customer Segmentation based on Membership
SELECT 
    name, 
    CASE 
        WHEN membership = 'Gold' THEN 'Premium Customer'
        WHEN membership = 'Silver' THEN 'Regular Customer'
        ELSE 'Occasional Customer'
    END as customer_type
FROM customers;