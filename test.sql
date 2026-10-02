--設問１
SELECT * FROM users;

--設問2
SELECT name
FROM users
WHERE created_at BETWEEN '2024-01-01' AND '2024-12-31';

--設問3
SELECT age, gender
FROM users
WHERE age<30 AND gender = 'female';

--設問4
SELECT product_name, price
FROM products;

--設問5
SELECT name, order_date
FROM users
JOIN orders
ON orders.user_id = users.id;

--設問6
SELECT p.product_name, oi.quantity, p.price, p.price * oi.quantity AS amount
FROM products AS p
JOIN order_items AS oi
ON oi.product_id = p.id;

--設問7
SELECT u.name, COUNT(o.id) AS order_count
FROM users AS u
LEFT JOIN orders AS o
ON o.user_id = u.id
GROUP BY u.name;

--設問8　
SELECT u.name, SUM(p.price * oi.quantity) AS total_amount
FROM users AS u
JOIN orders AS o
ON o.user_id = u.id
JOIN order_items AS oi
ON oi.order_id = o.id
JOIN products AS p
ON p.id = oi.product_id
GROUP BY u.name;

--設問9
SELECT u.name, SUM(p.price * oi.quantity) AS total_amount
FROM users AS u
JOIN orders AS o
ON o.user_id = u.id
JOIN order_items AS oi
ON oi.order_id = o.id
JOIN products AS p
ON p.id = oi.product_id
GROUP BY u.name
ORDER BY total_amount DESC
LIMIT 1;

--設問10
SELECT p.product_name, COUNT(oi.id) AS order_count
FROM products AS p
LEFT JOIN order_items AS oi
ON oi.product_id = p.id
GROUP BY product_name;

--設問11
SELECT u.name
FROM users AS u
LEFT JOIN orders AS o
ON o.user_id = u.id
WHERE o.id IS NULL;

--設問12
SELECT order_id
FROM order_items
GROUP BY order_id
HAVING COUNT(DISTINCT product_id) >= 2;

--設問13
SELECT u.name
FROM users AS u
JOIN orders AS o
ON o.user_id = u.id
JOIN order_items AS oi
ON oi.order_id = o.id
JOIN products AS p
ON p.id = oi.product_id
WHERE u.name = 'テレビ';

--設問14
SELECT o.order_date, u.name, p.product_name, oi.quantity, p.price * oi.quantity AS amount
FROM orders AS o
JOIN users AS u
ON o.user_id = u.id
JOIN order_items AS oi
ON oi.order_id = o.id
JOIN products AS p
ON p.id = oi.product_id;

--設問15
SELECT p.product_name
FROM order_items AS oi
JOIN products AS p
ON p.id = oi.product_id
GROUP BY p.product_name
ORDER BY SUM(oi.quantity) DESC
LIMIT 1;

--設問16
SELECT DATE_FORMAT(order_date,'%Y-%m') AS order_month, COUNT(id) AS order_count
FROM orders
GROUP BY order_month
ORDER BY order_month DESC;

--設問17
SELECT p.product_name
FROM products AS p
LEFT JOIN order_items AS oi
ON oi.product_id = p.id
WHERE oi.product_id IS NULL;

--設問18
CREATE INDEX idx_product_id ON order_items(product_id);

--設問19
SELECT u.name, AVG(total_orders.order_amount) AS average_amount
FROM users AS u
JOIN orders AS o
ON o.user_id = u.id
JOIN(
    SELECT oi.order_id, SUM(p.price * oi.quantity) AS order_amount
    FROM order_items AS oi
    JOIN products AS p
    ON oi.product_id = p.id
    GROUP BY oi.order_id
)AS total_orders
ON total_orders.order_id = o.id
GROUP BY u.name;

--設問20
SELECT u.name, MAX(o.order_date) AS latest_order_date
FROM users AS u
JOIN orders AS o
ON o.user_id = u.id
GROUP BY u.name;

--設問21
INSERT INTO users(id, name, age, gender, created_at)
VALUES(6, '中村愛', 25, 'female', '2025-06-01');

--設問22
INSERT INTO products(id, product_name, price)
VALUES(6, 'エアコン', 60000);

--設問23
INSERT INTO orders(id, user_id, order_date)
VALUES(10, 1, '2025-06-10');

--設問24
INSERT INTO order_items(id, order_id, product_id, quantity)
VALUES(10, 10, 6, 1);

--設問25
UPDATE users
SET age = 24
WHERE id = 4;

--設問26
UPDATE products
SET price = price * 1.1;

--設問27
UPDATE orders
SET order_date = '2024-05-01'
WHERE order_date < '2024-05-01';

--設問28
ALTER TABLE orders
DROP FOREIGN KEY orders_ibfk_1;

ALTER TABLE orders
ADD CONSTRAINT orders_ibfk_1
FOREIGN KEY (user_id)
REFERENCES users(id)
ON DELETE SET NULL;

DELETE FROM users
WHERE id = 5;

--設問29
DELETE FROM order_items
WHERE order_id = 5;

--設問30
DELETE p
FROM products AS p
LEFT JOIN order_items AS oi
ON oi.product_id = p.id
WHERE oi.order_id IS NULL;