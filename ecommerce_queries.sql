-- 1. Total number of users
SELECT COUNT(*) AS total_users FROM users;

-- 2. Top 10 most expensive products
SELECT name, category, price
FROM products
ORDER BY price DESC
LIMIT 10;

-- 3. Total number of orders
SELECT COUNT(*) AS total_orders FROM orders;

-- 4. Total revenue generated
SELECT SUM(total_amount) AS total_revenue FROM orders;

-- 5. Most popular 10 product by quantity sold
SELECT p.name, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.name
ORDER BY total_quantity DESC
LIMIT 10;

-- 6. Revenue by product category
SELECT p.category, SUM(od.price * od.quantity) AS category_revenue
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;

-- 7. Top 10 users by spending
SELECT u.name, SUM(o.total_amount) AS total_spent
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id
ORDER BY total_spent DESC
LIMIT 10;

-- 8. Monthly order count
SELECT strftime('%Y-%m', order_date) AS month, COUNT(*) AS orders
FROM orders
GROUP BY month
ORDER BY month;

-- 9. Users who placed more than 10 orders
SELECT u.name, COUNT(o.order_id) AS order_count
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id
HAVING order_count > 10
ORDER BY order_count DESC;

-- 10. Create a view for user order summary
CREATE VIEW IF NOT EXISTS user_order_summary AS
SELECT u.user_id, u.name, COUNT(o.order_id) AS total_orders, SUM(o.total_amount) AS total_spent
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id;
-- VIEW
SELECT * FROM user_order_summary ORDER BY total_spent DESC LIMIT 5;

