CREATE DATABASE smart_ecommerce_recommendation;
USE smart_ecommerce_recommendation;
CREATE TABLE `USER` (
    user_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    role VARCHAR(20) NOT NULL
);
CREATE TABLE CATEGORY (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);
CREATE TABLE PRODUCT (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    brand VARCHAR(100),
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    description VARCHAR(255),

    CONSTRAINT fk_product_category
        FOREIGN KEY (category_id)
        REFERENCES CATEGORY(category_id),

    CONSTRAINT chk_product_price
        CHECK (price >= 0),

    CONSTRAINT chk_product_stock
        CHECK (stock_quantity >= 0)
);
CREATE TABLE CART (
    cart_id INT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_cart_user
        FOREIGN KEY (user_id)
        REFERENCES `USER`(user_id)
);
CREATE TABLE ORDERS (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    order_status VARCHAR(30) NOT NULL,

    CONSTRAINT fk_orders_user
        FOREIGN KEY (user_id)
        REFERENCES `USER`(user_id),

    CONSTRAINT chk_order_total
        CHECK (total_amount >= 0)
);
CREATE TABLE ORDER_ITEM (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_order_item_order
        FOREIGN KEY (order_id)
        REFERENCES ORDERS(order_id),

    CONSTRAINT fk_order_item_product
        FOREIGN KEY (product_id)
        REFERENCES PRODUCT(product_id),

    CONSTRAINT chk_order_item_quantity
        CHECK (quantity > 0),

    CONSTRAINT chk_order_item_price
        CHECK (unit_price >= 0)
);
CREATE TABLE PRODUCT_INTERACTION (
    interaction_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    interaction_type VARCHAR(30) NOT NULL,
    interaction_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_interaction_user
        FOREIGN KEY (user_id)
        REFERENCES `USER`(user_id),

    CONSTRAINT fk_interaction_product
        FOREIGN KEY (product_id)
        REFERENCES PRODUCT(product_id),

    CONSTRAINT chk_interaction_type
        CHECK (
            interaction_type IN
            ('VIEW', 'CART', 'WISHLIST', 'PURCHASE')
        )
);
CREATE TABLE REVIEW (
    review_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL,
    comment VARCHAR(500),
    review_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_review_user
        FOREIGN KEY (user_id)
        REFERENCES `USER`(user_id),

    CONSTRAINT fk_review_product
        FOREIGN KEY (product_id)
        REFERENCES PRODUCT(product_id),

    CONSTRAINT chk_review_rating
        CHECK (rating BETWEEN 1 AND 5)
);
SHOW TABLES;
DESCRIBE `USER`;
DESCRIBE CATEGORY;
DESCRIBE PRODUCT;
DESCRIBE CART;
DESCRIBE ORDERS;
DESCRIBE ORDER_ITEM;
DESCRIBE PRODUCT_INTERACTION;
DESCRIBE REVIEW;
SHOW TABLES;
INSERT INTO `USER`
(user_id, name, email, password, phone, role)
VALUES
(101, 'Rahul Sharma', 'rahul@gmail.com', 'Rahul@123', '9876543210', 'Customer'),
(102, 'Priya Reddy', 'priya@gmail.com', 'Priya@123', '9876543211', 'Customer'),
(103, 'Arjun Kumar', 'arjun@gmail.com', 'Arjun@123', '9876543212', 'Customer'),
(104, 'Sneha Patel', 'sneha@gmail.com', 'Sneha@123', '9876543213', 'Customer'),
(105, 'Vikram Singh', 'vikram@gmail.com', 'Vikram@123', '9876543214', 'Customer'),
(106, 'Ananya Rao', 'ananya@gmail.com', 'Ananya@123', '9876543215', 'Customer'),
(107, 'Karthik Reddy', 'karthik@gmail.com', 'Karthik@123', '9876543216', 'Customer'),
(108, 'Neha Sharma', 'neha@gmail.com', 'Neha@123', '9876543217', 'Customer'),
(109, 'Aditya Verma', 'aditya@gmail.com', 'Aditya@123', '9876543218', 'Customer'),
(110, 'Meera Das', 'meera@gmail.com', 'Meera@123', '9876543219', 'Customer');
SELECT * FROM `USER`;
INSERT INTO CATEGORY
(category_id, category_name, description)
VALUES
(1, 'Electronics', 'Electronic devices and accessories'),
(2, 'Laptops', 'Laptops and portable computers'),
(3, 'Mobile Phones', 'Smartphones and mobile devices'),
(4, 'Audio', 'Headphones, speakers and audio accessories'),
(5, 'Wearables', 'Smartwatches and wearable devices'),
(6, 'Home Appliances', 'Appliances and smart home products'),
(7, 'Gaming', 'Gaming consoles and accessories'),
(8, 'Accessories', 'Computer and mobile accessories');
SELECT * FROM CATEGORY;
INSERT INTO PRODUCT
(product_id, product_name, category_id, brand, price, stock_quantity, description)
VALUES
(201, 'Galaxy S25', 3, 'Samsung', 74999.00, 25, 'Premium Android smartphone'),
(202, 'iPhone 16', 3, 'Apple', 79999.00, 20, 'Latest Apple smartphone'),
(203, 'OnePlus 13', 3, 'OnePlus', 69999.00, 30, 'Flagship Android smartphone'),

(204, 'MacBook Air M3', 2, 'Apple', 99999.00, 15, 'Lightweight laptop with Apple M3 chip'),
(205, 'Dell Inspiron 14', 2, 'Dell', 64999.00, 18, 'Everyday productivity laptop'),
(206, 'HP Pavilion 15', 2, 'HP', 58999.00, 22, 'Versatile performance laptop'),

(207, 'Sony WH-1000XM5', 4, 'Sony', 29999.00, 25, 'Premium noise cancelling headphones'),
(208, 'AirPods Pro 2', 4, 'Apple', 24999.00, 35, 'Wireless noise cancelling earbuds'),
(209, 'JBL Flip 6', 4, 'JBL', 11999.00, 40, 'Portable Bluetooth speaker'),

(210, 'Apple Watch Series 10', 5, 'Apple', 46999.00, 18, 'Advanced smartwatch'),
(211, 'Galaxy Watch 7', 5, 'Samsung', 32999.00, 20, 'Smartwatch with health tracking'),

(212, 'Samsung Smart TV 55', 6, 'Samsung', 54999.00, 12, '55-inch 4K smart television'),
(213, 'LG Air Conditioner', 6, 'LG', 44999.00, 10, 'Energy efficient split air conditioner'),

(214, 'PlayStation 5', 7, 'Sony', 54999.00, 8, 'Next generation gaming console'),
(215, 'Xbox Series X', 7, 'Microsoft', 52999.00, 9, 'High performance gaming console'),
(216, 'Logitech G502 Mouse', 7, 'Logitech', 7999.00, 30, 'Gaming performance mouse'),

(217, 'Samsung 65W Charger', 8, 'Samsung', 2999.00, 50, 'Fast charging adapter'),
(218, 'Anker Power Bank', 8, 'Anker', 3499.00, 45, 'Portable high capacity power bank'),
(219, 'Logitech K380 Keyboard', 8, 'Logitech', 2999.00, 35, 'Wireless compact keyboard'),
(220, 'Apple MagSafe Charger', 8, 'Apple', 4499.00, 40, 'Magnetic wireless charger');
SELECT * FROM PRODUCT;
INSERT INTO CART
(cart_id, user_id, created_at, updated_at)
VALUES
(301, 101, '2026-09-20 09:15:00', '2026-09-20 09:15:00'),
(302, 102, '2026-09-21 10:30:00', '2026-09-21 10:30:00'),
(303, 103, '2026-09-22 11:45:00', '2026-09-22 11:45:00'),
(304, 104, '2026-09-23 12:20:00', '2026-09-23 12:20:00'),
(305, 105, '2026-09-24 14:10:00', '2026-09-24 14:10:00'),
(306, 106, '2026-09-25 15:35:00', '2026-09-25 15:35:00'),
(307, 107, '2026-09-26 16:40:00', '2026-09-26 16:40:00'),
(308, 108, '2026-09-27 17:25:00', '2026-09-27 17:25:00'),
(309, 109, '2026-09-28 18:50:00', '2026-09-28 18:50:00'),
(310, 110, '2026-09-29 19:15:00', '2026-09-29 19:15:00');
SELECT * FROM CART;
INSERT INTO ORDERS
(order_id, user_id, order_date, total_amount, order_status)
VALUES
(401, 101, '2026-09-20 10:30:00', 74999.00, 'Delivered'),
(402, 102, '2026-09-21 14:20:00', 24999.00, 'Delivered'),
(403, 103, '2026-09-22 16:45:00', 99999.00, 'Shipped'),
(404, 104, '2026-09-23 11:15:00', 11999.00, 'Delivered'),
(405, 105, '2026-09-24 18:30:00', 46999.00, 'Processing'),
(406, 106, '2026-09-25 13:10:00', 64999.00, 'Delivered'),
(407, 107, '2026-09-26 15:40:00', 54999.00, 'Shipped'),
(408, 108, '2026-09-27 17:25:00', 7999.00, 'Delivered'),
(409, 109, '2026-09-28 12:50:00', 69999.00, 'Processing'),
(410, 110, '2026-09-29 19:10:00', 3499.00, 'Delivered'),

(411, 101, '2026-09-24 09:45:00', 29999.00, 'Delivered'),
(412, 102, '2026-09-25 12:30:00', 2999.00, 'Delivered'),
(413, 103, '2026-09-26 18:15:00', 52999.00, 'Shipped'),
(414, 104, '2026-09-28 10:20:00', 44999.00, 'Processing'),
(415, 105, '2026-09-29 16:50:00', 4499.00, 'Delivered');
SELECT * FROM ORDERS;
INSERT INTO ORDER_ITEM
(order_item_id, order_id, product_id, quantity, unit_price)
VALUES
(501, 401, 201, 1, 74999.00),
(502, 402, 208, 1, 24999.00),
(503, 403, 204, 1, 99999.00),
(504, 404, 209, 1, 11999.00),
(505, 405, 210, 1, 46999.00),
(506, 406, 205, 1, 64999.00),
(507, 407, 214, 1, 54999.00),
(508, 408, 216, 1, 7999.00),
(509, 409, 203, 1, 69999.00),
(510, 410, 218, 1, 3499.00),

(511, 411, 207, 1, 29999.00),
(512, 412, 219, 1, 2999.00),
(513, 413, 215, 1, 52999.00),
(514, 414, 213, 1, 44999.00),
(515, 415, 220, 1, 4499.00),

(516, 401, 217, 2, 2999.00),
(517, 402, 209, 1, 11999.00),
(518, 403, 206, 1, 58999.00),
(519, 404, 218, 1, 3499.00),
(520, 405, 211, 1, 32999.00),

(521, 406, 219, 1, 2999.00),
(522, 407, 216, 2, 7999.00),
(523, 408, 220, 1, 4499.00),
(524, 409, 202, 1, 79999.00),
(525, 410, 217, 1, 2999.00);
DELETE FROM ORDER_ITEM;
SELECT * FROM ORDER_ITEM;
DELETE FROM ORDER_ITEM
WHERE order_item_id > 0;
SELECT * FROM ORDER_ITEM;
UPDATE ORDERS
SET total_amount = CASE order_id
    WHEN 401 THEN 80997.00
    WHEN 402 THEN 36998.00
    WHEN 403 THEN 158998.00
    WHEN 404 THEN 15498.00
    WHEN 405 THEN 79998.00
    WHEN 406 THEN 67998.00
    WHEN 407 THEN 70997.00
    WHEN 408 THEN 12498.00
    WHEN 409 THEN 149998.00
    WHEN 410 THEN 6498.00
    WHEN 411 THEN 29999.00
    WHEN 412 THEN 2999.00
    WHEN 413 THEN 52999.00
    WHEN 414 THEN 44999.00
    WHEN 415 THEN 4499.00
END
WHERE order_id BETWEEN 401 AND 415;
INSERT INTO ORDER_ITEM
(order_item_id, order_id, product_id, quantity, unit_price)
VALUES
(501, 401, 201, 1, 74999.00),
(502, 402, 208, 1, 24999.00),
(503, 403, 204, 1, 99999.00),
(504, 404, 209, 1, 11999.00),
(505, 405, 210, 1, 46999.00),
(506, 406, 205, 1, 64999.00),
(507, 407, 214, 1, 54999.00),
(508, 408, 216, 1, 7999.00),
(509, 409, 203, 1, 69999.00),
(510, 410, 218, 1, 3499.00),

(511, 411, 207, 1, 29999.00),
(512, 412, 219, 1, 2999.00),
(513, 413, 215, 1, 52999.00),
(514, 414, 213, 1, 44999.00),
(515, 415, 220, 1, 4499.00),

(516, 401, 217, 2, 2999.00),
(517, 402, 209, 1, 11999.00),
(518, 403, 206, 1, 58999.00),
(519, 404, 218, 1, 3499.00),
(520, 405, 211, 1, 32999.00),

(521, 406, 219, 1, 2999.00),
(522, 407, 216, 2, 7999.00),
(523, 408, 220, 1, 4499.00),
(524, 409, 202, 1, 79999.00),
(525, 410, 217, 1, 2999.00);
SELECT * FROM ORDER_ITEM;
SELECT
    o.order_id,
    o.total_amount AS order_total,
    SUM(oi.quantity * oi.unit_price) AS calculated_total
FROM ORDERS o
JOIN ORDER_ITEM oi
    ON o.order_id = oi.order_id
GROUP BY o.order_id, o.total_amount
ORDER BY o.order_id;
INSERT INTO PRODUCT_INTERACTION
(interaction_id, user_id, product_id, interaction_type, interaction_date)
VALUES

-- User 101
(601, 101, 201, 'VIEW',      '2026-09-19 09:10:00'),
(602, 101, 201, 'CART',      '2026-09-19 09:20:00'),
(603, 101, 201, 'PURCHASE',  '2026-09-20 10:30:00'),
(604, 101, 207, 'VIEW',      '2026-09-22 11:15:00'),
(605, 101, 207, 'PURCHASE',  '2026-09-24 09:45:00'),
(606, 101, 217, 'VIEW',      '2026-09-23 14:20:00'),

-- User 102
(607, 102, 208, 'VIEW',      '2026-09-20 13:10:00'),
(608, 102, 208, 'CART',      '2026-09-20 13:30:00'),
(609, 102, 208, 'PURCHASE',  '2026-09-21 14:20:00'),
(610, 102, 209, 'VIEW',      '2026-09-21 15:10:00'),
(611, 102, 209, 'PURCHASE',  '2026-09-25 12:30:00'),
(612, 102, 219, 'WISHLIST',  '2026-09-23 16:00:00'),

-- User 103
(613, 103, 204, 'VIEW',      '2026-09-21 10:20:00'),
(614, 103, 204, 'CART',      '2026-09-21 10:40:00'),
(615, 103, 204, 'PURCHASE',  '2026-09-22 16:45:00'),
(616, 103, 206, 'VIEW',      '2026-09-23 12:10:00'),
(617, 103, 206, 'WISHLIST',  '2026-09-23 12:30:00'),
(618, 103, 215, 'VIEW',      '2026-09-25 18:20:00'),

-- User 104
(619, 104, 209, 'VIEW',      '2026-09-22 10:15:00'),
(620, 104, 209, 'CART',      '2026-09-22 10:25:00'),
(621, 104, 209, 'PURCHASE',  '2026-09-23 11:15:00'),
(622, 104, 213, 'VIEW',      '2026-09-27 09:30:00'),
(623, 104, 213, 'CART',      '2026-09-27 09:45:00'),
(624, 104, 213, 'WISHLIST',  '2026-09-27 10:00:00'),

-- User 105
(625, 105, 210, 'VIEW',      '2026-09-23 14:10:00'),
(626, 105, 210, 'CART',      '2026-09-23 14:20:00'),
(627, 105, 210, 'PURCHASE',  '2026-09-24 18:30:00'),
(628, 105, 211, 'VIEW',      '2026-09-25 11:30:00'),
(629, 105, 211, 'WISHLIST',  '2026-09-25 11:45:00'),
(630, 105, 220, 'VIEW',      '2026-09-28 17:10:00'),

-- User 106
(631, 106, 205, 'VIEW',      '2026-09-24 10:20:00'),
(632, 106, 205, 'CART',      '2026-09-24 10:35:00'),
(633, 106, 205, 'PURCHASE',  '2026-09-25 13:10:00'),
(634, 106, 219, 'VIEW',      '2026-09-26 15:20:00'),
(635, 106, 219, 'CART',      '2026-09-26 15:35:00'),
(636, 106, 219, 'PURCHASE',  '2026-09-27 12:15:00'),

-- User 107
(637, 107, 214, 'VIEW',      '2026-09-25 14:10:00'),
(638, 107, 214, 'CART',      '2026-09-25 14:25:00'),
(639, 107, 214, 'PURCHASE',  '2026-09-26 15:40:00'),
(640, 107, 216, 'VIEW',      '2026-09-26 16:20:00'),
(641, 107, 216, 'CART',      '2026-09-26 16:35:00'),
(642, 107, 216, 'PURCHASE',  '2026-09-27 10:45:00'),

-- User 108
(643, 108, 216, 'VIEW',      '2026-09-26 11:20:00'),
(644, 108, 216, 'WISHLIST',  '2026-09-26 11:35:00'),
(645, 108, 216, 'PURCHASE',  '2026-09-27 17:25:00'),
(646, 108, 220, 'VIEW',      '2026-09-28 13:10:00'),
(647, 108, 220, 'CART',      '2026-09-28 13:25:00'),
(648, 108, 220, 'PURCHASE',  '2026-09-29 09:30:00'),

-- User 109
(649, 109, 203, 'VIEW',      '2026-09-27 10:10:00'),
(650, 109, 203, 'CART',      '2026-09-27 10:25:00'),
(651, 109, 203, 'PURCHASE',  '2026-09-28 12:50:00'),
(652, 109, 202, 'VIEW',      '2026-09-28 13:20:00'),
(653, 109, 202, 'WISHLIST',  '2026-09-28 13:35:00'),
(654, 109, 202, 'PURCHASE',  '2026-09-29 16:20:00'),

-- User 110
(655, 110, 218, 'VIEW',      '2026-09-28 15:10:00'),
(656, 110, 218, 'CART',      '2026-09-28 15:25:00'),
(657, 110, 218, 'PURCHASE',  '2026-09-29 19:10:00'),
(658, 110, 217, 'VIEW',      '2026-09-29 19:30:00'),
(659, 110, 217, 'WISHLIST',  '2026-09-29 19:45:00'),
(660, 110, 219, 'VIEW',      '2026-09-30 10:15:00');
SELECT * FROM PRODUCT_INTERACTION
ORDER BY interaction_id;
INSERT INTO REVIEW
(review_id, user_id, product_id, rating, comment, review_date)
VALUES
(701, 101, 201, 5, 'Excellent smartphone with great performance and camera.', '2026-09-21 12:10:00'),
(702, 101, 207, 5, 'Very comfortable headphones with excellent noise cancellation.', '2026-09-25 10:20:00'),

(703, 102, 208, 5, 'Great sound quality and very comfortable for daily use.', '2026-09-22 15:30:00'),
(704, 102, 209, 4, 'Good portable speaker with clear audio.', '2026-09-26 11:40:00'),

(705, 103, 204, 5, 'Very fast laptop with excellent battery life.', '2026-09-23 17:15:00'),
(706, 103, 206, 4, 'Good laptop for productivity and everyday work.', '2026-09-24 13:25:00'),

(707, 104, 209, 4, 'Compact speaker with good sound quality.', '2026-09-24 14:10:00'),
(708, 104, 213, 5, 'Efficient air conditioner with good cooling performance.', '2026-09-29 09:50:00'),

(709, 105, 210, 5, 'Excellent smartwatch with useful features and display.', '2026-09-25 19:20:00'),
(710, 105, 211, 4, 'Good smartwatch with accurate health tracking.', '2026-09-26 12:15:00'),

(711, 106, 205, 4, 'Reliable laptop for work and study.', '2026-09-26 14:30:00'),
(712, 106, 219, 5, 'Compact keyboard with a comfortable typing experience.', '2026-09-28 10:40:00'),

(713, 107, 214, 5, 'Excellent gaming console with impressive performance.', '2026-09-27 16:20:00'),
(714, 107, 216, 5, 'Very responsive gaming mouse with excellent controls.', '2026-09-28 11:30:00'),

(715, 108, 216, 4, 'Good gaming mouse with useful customization options.', '2026-09-28 14:15:00'),
(716, 108, 220, 5, 'Convenient charger and works very well with Apple devices.', '2026-09-30 10:20:00'),

(717, 109, 203, 5, 'Fast and powerful smartphone with a great display.', '2026-09-29 13:10:00'),
(718, 109, 202, 5, 'Excellent phone with a premium design and camera.', '2026-09-30 17:25:00'),

(719, 110, 218, 4, 'Useful power bank with good capacity and portability.', '2026-09-30 11:30:00'),
(720, 110, 217, 4, 'Compact charger with fast charging support.', '2026-09-30 12:10:00');
SELECT * FROM REVIEW
ORDER BY review_id;
SELECT * FROM `USER`;
SELECT * FROM PRODUCT;
SELECT
    product_id,
    product_name,
    brand,
    price
FROM PRODUCT;SELECT
    product_name,
    brand,
    price
FROM PRODUCT
WHERE price > 50000;
SELECT
    product_name,
    stock_quantity
FROM PRODUCT
WHERE stock_quantity > 20;
SELECT
    product_name,
    price
FROM PRODUCT
ORDER BY price ASC;
SELECT
    product_name,
    brand,
    price
FROM PRODUCT
ORDER BY price DESC
LIMIT 5;
SELECT DISTINCT brand
FROM PRODUCT
ORDER BY brand;
SELECT *
FROM ORDERS
WHERE order_status = 'Delivered';
SELECT
    review_id,
    user_id,
    product_id,
    rating,
    comment
FROM REVIEW
WHERE rating = 5;
SELECT COUNT(*) AS total_users
FROM `USER`;
SELECT COUNT(*) AS total_products
FROM PRODUCT;
SELECT ROUND(AVG(price), 2) AS average_product_price
FROM PRODUCT;
SELECT MAX(price) AS highest_price
FROM PRODUCT;
SELECT MIN(price) AS lowest_price
FROM PRODUCT;
SELECT SUM(total_amount) AS total_order_value
FROM ORDERS;
SELECT ROUND(AVG(total_amount), 2) AS average_order_value
FROM ORDERS;
SELECT
    category_id,
    COUNT(*) AS product_count
FROM PRODUCT
GROUP BY category_id
ORDER BY product_count DESC;
SELECT
    user_id,
    COUNT(*) AS order_count
FROM ORDERS
GROUP BY user_id
ORDER BY order_count DESC;
SELECT
    user_id,
    SUM(total_amount) AS total_spent
FROM ORDERS
GROUP BY user_id
ORDER BY total_spent DESC;
SELECT
    order_status,
    COUNT(*) AS order_count
FROM ORDERS
GROUP BY order_status;
SELECT
    ROUND(AVG(rating), 2) AS average_rating
FROM REVIEW;
SELECT
    product_id,
    ROUND(AVG(rating), 2) AS average_rating
FROM REVIEW
GROUP BY product_id
ORDER BY average_rating DESC;
SELECT
    product_id,
    COUNT(*) AS review_count
FROM REVIEW
GROUP BY product_id
ORDER BY review_count DESC;
SELECT
    user_id,
    COUNT(*) AS order_count
FROM ORDERS
GROUP BY user_id
HAVING COUNT(*) > 1;
SELECT
    product_id,
    ROUND(AVG(rating), 2) AS average_rating
FROM REVIEW
GROUP BY product_id
HAVING AVG(rating) >= 4;
SELECT
    u.user_id,
    u.name,
    o.order_id,
    o.order_date,
    o.total_amount,
    o.order_status
FROM `USER` u
INNER JOIN ORDERS o
    ON u.user_id = o.user_id
ORDER BY u.user_id, o.order_id;
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.brand,
    p.price
FROM PRODUCT p
INNER JOIN CATEGORY c
    ON p.category_id = c.category_id
ORDER BY c.category_name, p.product_name;
SELECT
    o.order_id,
    u.name AS customer_name,
    o.order_date,
    o.total_amount,
    o.order_status
FROM ORDERS o
INNER JOIN `USER` u
    ON o.user_id = u.user_id
ORDER BY o.order_date;
SELECT
    o.order_id,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS item_total
FROM ORDERS o
INNER JOIN ORDER_ITEM oi
    ON o.order_id = oi.order_id
INNER JOIN PRODUCT p
    ON oi.product_id = p.product_id
ORDER BY o.order_id;
SELECT
    o.order_id,
    u.name AS customer_name,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS item_total,
    o.order_status
FROM ORDERS o
INNER JOIN `USER` u
    ON o.user_id = u.user_id
INNER JOIN ORDER_ITEM oi
    ON o.order_id = oi.order_id
INNER JOIN PRODUCT p
    ON oi.product_id = p.product_id
ORDER BY o.order_id;
SELECT
    u.user_id,
    u.name,
    c.cart_id,
    c.created_at,
    c.updated_at
FROM `USER` u
INNER JOIN CART c
    ON u.user_id = c.user_id
ORDER BY u.user_id;
SELECT
    pi.interaction_id,
    u.name AS user_name,
    p.product_name,
    pi.interaction_type,
    pi.interaction_date
FROM PRODUCT_INTERACTION pi
INNER JOIN `USER` u
    ON pi.user_id = u.user_id
INNER JOIN PRODUCT p
    ON pi.product_id = p.product_id
ORDER BY pi.interaction_date;
SELECT
    r.review_id,
    u.name AS customer_name,
    p.product_name,
    r.rating,
    r.comment,
    r.review_date
FROM REVIEW r
INNER JOIN `USER` u
    ON r.user_id = u.user_id
INNER JOIN PRODUCT p
    ON r.product_id = p.product_id
ORDER BY r.review_id;
SELECT
    p.product_name,
    r.rating,
    r.comment
FROM PRODUCT p
INNER JOIN REVIEW r
    ON p.product_id = r.product_id
ORDER BY p.product_name;
SELECT
    c.category_id,
    c.category_name,
    p.product_name
FROM CATEGORY c
LEFT JOIN PRODUCT p
    ON c.category_id = p.category_id
ORDER BY c.category_id, p.product_name;
SELECT
    u.user_id,
    u.name,
    o.order_id,
    o.total_amount
FROM `USER` u
LEFT JOIN ORDERS o
    ON u.user_id = o.user_id
ORDER BY u.user_id;
SELECT
    u.user_id,
    u.name,
    pi.interaction_type,
    p.product_name,
    pi.interaction_date
FROM `USER` u
LEFT JOIN PRODUCT_INTERACTION pi
    ON u.user_id = pi.user_id
LEFT JOIN PRODUCT p
    ON pi.product_id = p.product_id
ORDER BY u.user_id, pi.interaction_date;
SELECT
    c.category_name,
    COUNT(p.product_id) AS product_count
FROM CATEGORY c
LEFT JOIN PRODUCT p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY product_count DESC;
SELECT
    u.user_id,
    u.name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM `USER` u
LEFT JOIN ORDERS o
    ON u.user_id = o.user_id
GROUP BY u.user_id, u.name
ORDER BY total_spent DESC;
SELECT
    p.product_id,
    p.product_name,
    ROUND(AVG(r.rating), 2) AS average_rating,
    COUNT(r.review_id) AS review_count
FROM PRODUCT p
LEFT JOIN REVIEW r
    ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
ORDER BY average_rating DESC;
SELECT
    p.product_id,
    p.product_name,
    COUNT(pi.interaction_id) AS interaction_count
FROM PRODUCT p
LEFT JOIN PRODUCT_INTERACTION pi
    ON p.product_id = pi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY interaction_count DESC;
SELECT
    p.product_name,
    pi.interaction_type,
    COUNT(*) AS interaction_count
FROM PRODUCT p
INNER JOIN PRODUCT_INTERACTION pi
    ON p.product_id = pi.product_id
GROUP BY p.product_id, p.product_name, pi.interaction_type
ORDER BY p.product_name, interaction_count DESC;
SELECT
    u.user_id,
    u.name,
    COUNT(pi.interaction_id) AS total_interactions
FROM `USER` u
LEFT JOIN PRODUCT_INTERACTION pi
    ON u.user_id = pi.user_id
GROUP BY u.user_id, u.name
ORDER BY total_interactions DESC;
SELECT
    u.name AS customer_name,
    p.product_name,
    c.category_name,
    pi.interaction_type,
    pi.interaction_date
FROM PRODUCT_INTERACTION pi
INNER JOIN `USER` u
    ON pi.user_id = u.user_id
INNER JOIN PRODUCT p
    ON pi.product_id = p.product_id
INNER JOIN CATEGORY c
    ON p.category_id = c.category_id
ORDER BY u.name, pi.interaction_date;
SELECT
    product_id,
    product_name,
    price
FROM PRODUCT
WHERE price > (
    SELECT AVG(price)
    FROM PRODUCT
)
ORDER BY price DESC;
SELECT
    product_id,
    product_name,
    price
FROM PRODUCT
WHERE price < (
    SELECT AVG(price)
    FROM PRODUCT
)
ORDER BY price ASC;
SELECT
    order_id,
    user_id,
    total_amount,
    order_status
FROM ORDERS
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM ORDERS
)
ORDER BY total_amount DESC;
SELECT
    p.product_id,
    p.product_name,
    ROUND(AVG(r.rating), 2) AS average_rating
FROM PRODUCT p
INNER JOIN REVIEW r
    ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
HAVING AVG(r.rating) > (
    SELECT AVG(rating)
    FROM REVIEW
)
ORDER BY average_rating DESC;
SELECT
    u.user_id,
    u.name,
    COUNT(o.order_id) AS order_count
FROM `USER` u
INNER JOIN ORDERS o
    ON u.user_id = o.user_id
GROUP BY u.user_id, u.name
HAVING COUNT(o.order_id) > (
    SELECT AVG(order_count)
    FROM (
        SELECT COUNT(*) AS order_count
        FROM ORDERS
        GROUP BY user_id
    ) AS user_orders
)
ORDER BY order_count DESC;
SELECT
    product_id,
    product_name,
    price
FROM PRODUCT
WHERE product_id IN (
    SELECT product_id
    FROM PRODUCT_INTERACTION
    WHERE user_id = 101
      AND interaction_type = 'PURCHASE'
);
SELECT
    product_id,
    product_name,
    price
FROM PRODUCT
WHERE product_id IN (
    SELECT product_id
    FROM PRODUCT_INTERACTION
    WHERE user_id = 101
      AND interaction_type = 'VIEW'
);
SELECT
    product_id,
    product_name,
    price
FROM PRODUCT
WHERE product_id IN (
    SELECT product_id
    FROM PRODUCT_INTERACTION
    WHERE user_id = 105
      AND interaction_type = 'WISHLIST'
);
SELECT
    product_id,
    product_name,
    price
FROM PRODUCT
WHERE product_id IN (
    SELECT DISTINCT product_id
    FROM PRODUCT_INTERACTION
    WHERE interaction_type = 'PURCHASE'
)
ORDER BY price DESC;
SELECT
    product_id,
    product_name,
    price
FROM PRODUCT
WHERE product_id IN (
    SELECT DISTINCT product_id
    FROM PRODUCT_INTERACTION
    WHERE interaction_type = 'PURCHASE'
)
ORDER BY price DESC;
SELECT
    product_id,
    product_name,
    price
FROM PRODUCT
WHERE product_id NOT IN (
    SELECT DISTINCT product_id
    FROM PRODUCT_INTERACTION
    WHERE interaction_type = 'PURCHASE'
)
ORDER BY product_id;
SELECT
    u.user_id,
    u.name
FROM `USER` u
WHERE EXISTS (
    SELECT 1
    FROM PRODUCT_INTERACTION pi
    WHERE pi.user_id = u.user_id
      AND pi.interaction_type = 'PURCHASE'
);
SELECT
    u.user_id,
    u.name
FROM `USER` u
WHERE EXISTS (
    SELECT 1
    FROM REVIEW r
    WHERE r.user_id = u.user_id
);
SELECT
    p.product_id,
    p.product_name
FROM PRODUCT p
WHERE EXISTS (
    SELECT 1
    FROM REVIEW r
    WHERE r.product_id = p.product_id
);
SELECT
    p.product_id,
    p.product_name
FROM PRODUCT p
WHERE NOT EXISTS (
    SELECT 1
    FROM REVIEW r
    WHERE r.product_id = p.product_id
);
SELECT
    u.user_id,
    u.name
FROM `USER` u
WHERE NOT EXISTS (
    SELECT 1
    FROM ORDERS o
    WHERE o.user_id = u.user_id
);
SELECT
    product_id,
    product_name,
    brand,
    price
FROM PRODUCT
WHERE price = (
    SELECT MAX(price)
    FROM PRODUCT
);
SELECT
    product_id,
    product_name,
    brand,
    price
FROM PRODUCT
WHERE price = (
    SELECT MIN(price)
    FROM PRODUCT
);
SELECT
    u.user_id,
    u.name
FROM `USER` u
WHERE u.user_id IN (
    SELECT user_id
    FROM PRODUCT_INTERACTION
    WHERE product_id = 201
      AND interaction_type = 'PURCHASE'
);
SELECT DISTINCT
    u.user_id,
    u.name
FROM `USER` u
WHERE u.user_id IN (
    SELECT pi.user_id
    FROM PRODUCT_INTERACTION pi
    WHERE pi.product_id IN (
        SELECT product_id
        FROM PRODUCT
        WHERE category_id = 7
    )
);
SELECT
    p.product_id,
    p.product_name,
    ROUND(AVG(r.rating), 2) AS average_rating
FROM PRODUCT p
INNER JOIN REVIEW r
    ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
HAVING AVG(r.rating) > (
    SELECT AVG(rating)
    FROM REVIEW
);
CREATE VIEW customer_order_summary AS
SELECT
    u.user_id,
    u.name AS customer_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    COALESCE(AVG(o.total_amount), 0) AS average_order_value
FROM `USER` u
LEFT JOIN ORDERS o
    ON u.user_id = o.user_id
GROUP BY
    u.user_id,
    u.name;
    SELECT *
FROM customer_order_summary;
CREATE VIEW product_catalog AS
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.brand,
    p.price,
    p.stock_quantity,
    p.description
FROM PRODUCT p
INNER JOIN CATEGORY c
    ON p.category_id = c.category_id;
    SELECT *
FROM product_catalog;
CREATE VIEW product_rating_summary AS
SELECT
    p.product_id,
    p.product_name,
    ROUND(AVG(r.rating), 2) AS average_rating,
    COUNT(r.review_id) AS review_count
FROM PRODUCT p
LEFT JOIN REVIEW r
    ON p.product_id = r.product_id
GROUP BY
    p.product_id,
    p.product_name;
    SELECT *
FROM product_rating_summary
ORDER BY average_rating DESC;
CREATE VIEW user_interaction_history AS
SELECT
    pi.interaction_id,
    u.user_id,
    u.name AS customer_name,
    p.product_id,
    p.product_name,
    c.category_name,
    pi.interaction_type,
    pi.interaction_date
FROM PRODUCT_INTERACTION pi
INNER JOIN `USER` u
    ON pi.user_id = u.user_id
INNER JOIN PRODUCT p
    ON pi.product_id = p.product_id
INNER JOIN CATEGORY c
    ON p.category_id = c.category_id;
    SELECT *
FROM user_interaction_history
ORDER BY user_id, interaction_date;
CREATE VIEW product_popularity AS
SELECT
    p.product_id,
    p.product_name,
    COUNT(pi.interaction_id) AS total_interactions,
    SUM(
        CASE
            WHEN pi.interaction_type = 'VIEW' THEN 1
            ELSE 0
        END
    ) AS views,
    SUM(
        CASE
            WHEN pi.interaction_type = 'CART' THEN 1
            ELSE 0
        END
    ) AS cart_actions,
    SUM(
        CASE
            WHEN pi.interaction_type = 'WISHLIST' THEN 1
            ELSE 0
        END
    ) AS wishlist_actions,
    SUM(
        CASE
            WHEN pi.interaction_type = 'PURCHASE' THEN 1
            ELSE 0
        END
    ) AS purchases
FROM PRODUCT p
LEFT JOIN PRODUCT_INTERACTION pi
    ON p.product_id = pi.product_id
GROUP BY
    p.product_id,
    p.product_name;
    SELECT *
FROM product_popularity
ORDER BY total_interactions DESC;
SELECT
    product_id,
    product_name,
    total_interactions
FROM product_popularity
ORDER BY total_interactions DESC
LIMIT 5;
SELECT
    product_name,
    purchases
FROM product_popularity
WHERE purchases > 0
ORDER BY purchases DESC;
SELECT
    product_name,
    wishlist_actions
FROM product_popularity
WHERE wishlist_actions > 0
ORDER BY wishlist_actions DESC;
SHOW FULL TABLES
WHERE Table_type = 'VIEW';
DELIMITER $$

CREATE PROCEDURE get_user_orders(IN p_user_id INT)
BEGIN
    SELECT
        o.order_id,
        o.order_date,
        o.total_amount,
        o.order_status
    FROM ORDERS o
    WHERE o.user_id = p_user_id
    ORDER BY o.order_date DESC;
END $$

DELIMITER ;
CALL get_user_orders(101);
DELIMITER $$

CREATE PROCEDURE get_user_interactions(IN p_user_id INT)
BEGIN
    SELECT
        pi.interaction_id,
        p.product_name,
        c.category_name,
        pi.interaction_type,
        pi.interaction_date
    FROM PRODUCT_INTERACTION pi
    INNER JOIN PRODUCT p
        ON pi.product_id = p.product_id
    INNER JOIN CATEGORY c
        ON p.category_id = c.category_id
    WHERE pi.user_id = p_user_id
    ORDER BY pi.interaction_date DESC;
END $$

DELIMITER ;
CALL get_user_interactions(101);
DELIMITER $$

CREATE PROCEDURE get_product_details(IN p_product_id INT)
BEGIN
    SELECT
        p.product_id,
        p.product_name,
        c.category_name,
        p.brand,
        p.price,
        p.stock_quantity,
        p.description
    FROM PRODUCT p
    INNER JOIN CATEGORY c
        ON p.category_id = c.category_id
    WHERE p.product_id = p_product_id;
END $$

DELIMITER ;
CALL get_product_details(201);
DELIMITER $$

CREATE PROCEDURE get_products_by_category(IN p_category_id INT)
BEGIN
    SELECT
        p.product_id,
        p.product_name,
        p.brand,
        p.price,
        p.stock_quantity
    FROM PRODUCT p
    WHERE p.category_id = p_category_id
    ORDER BY p.price ASC;
END $$

DELIMITER ;
CALL get_products_by_category(3);
SHOW PROCEDURE STATUS
WHERE Db = 'smart_ecommerce_recommendation';
DELIMITER $$

CREATE FUNCTION get_user_total_spent(p_user_id INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE total_spent DECIMAL(12,2);

    SELECT COALESCE(SUM(total_amount), 0)
    INTO total_spent
    FROM ORDERS
    WHERE user_id = p_user_id;

    RETURN total_spent;
END $$

DELIMITER ;
SELECT get_user_total_spent(101) AS total_spent;
DELIMITER $$

CREATE FUNCTION get_product_average_rating(p_product_id INT)
RETURNS DECIMAL(4,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE avg_rating DECIMAL(4,2);

    SELECT COALESCE(ROUND(AVG(rating), 2), 0)
    INTO avg_rating
    FROM REVIEW
    WHERE product_id = p_product_id;

    RETURN avg_rating;
END $$

DELIMITER ;
SELECT
    product_id,
    product_name,
    get_product_average_rating(product_id) AS average_rating
FROM PRODUCT;
DELIMITER $$

CREATE FUNCTION get_product_interaction_count(p_product_id INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE interaction_count INT;

    SELECT COUNT(*)
    INTO interaction_count
    FROM PRODUCT_INTERACTION
    WHERE product_id = p_product_id;

    RETURN interaction_count;
END $$

DELIMITER ;
SELECT
    product_id,
    product_name,
    get_product_interaction_count(product_id) AS total_interactions
FROM PRODUCT
ORDER BY total_interactions DESC;
SHOW FUNCTION STATUS
WHERE Db = 'smart_ecommerce_recommendation';
DELIMITER $$

CREATE TRIGGER trg_cart_before_update
BEFORE UPDATE ON CART
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END $$

DELIMITER ;
SELECT
    cart_id,
    user_id,
    created_at,
    updated_at
FROM CART
WHERE cart_id = 301;
UPDATE CART
SET user_id = user_id
WHERE cart_id = 301;
SELECT
    cart_id,
    user_id,
    created_at,
    updated_at
FROM CART
WHERE cart_id = 301;
DELIMITER $$

CREATE TRIGGER trg_order_item_after_insert
AFTER INSERT ON ORDER_ITEM
FOR EACH ROW
BEGIN
    UPDATE ORDERS
    SET total_amount = (
        SELECT COALESCE(SUM(quantity * unit_price), 0)
        FROM ORDER_ITEM
        WHERE order_id = NEW.order_id
    )
    WHERE order_id = NEW.order_id;
END $$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER trg_order_item_after_update
AFTER UPDATE ON ORDER_ITEM
FOR EACH ROW
BEGIN
    UPDATE ORDERS
    SET total_amount = (
        SELECT COALESCE(SUM(quantity * unit_price), 0)
        FROM ORDER_ITEM
        WHERE order_id = NEW.order_id
    )
    WHERE order_id = NEW.order_id;
END $$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER trg_order_item_after_delete
AFTER DELETE ON ORDER_ITEM
FOR EACH ROW
BEGIN
    UPDATE ORDERS
    SET total_amount = (
        SELECT COALESCE(SUM(quantity * unit_price), 0)
        FROM ORDER_ITEM
        WHERE order_id = OLD.order_id
    )
    WHERE order_id = OLD.order_id;
END $$

DELIMITER ;
SHOW TRIGGERS
FROM smart_ecommerce_recommendation;
SHOW TRIGGERS
FROM smart_ecommerce_recommendation;
SELECT
    c.category_id,
    c.category_name,
    SUM(
        CASE pi.interaction_type
            WHEN 'VIEW' THEN 1
            WHEN 'CART' THEN 3
            WHEN 'WISHLIST' THEN 4
            WHEN 'PURCHASE' THEN 5
            ELSE 0
        END
    ) AS preference_score
FROM PRODUCT_INTERACTION pi
INNER JOIN PRODUCT p
    ON pi.product_id = p.product_id
INNER JOIN CATEGORY c
    ON p.category_id = c.category_id
WHERE pi.user_id = 101
GROUP BY c.category_id, c.category_name
ORDER BY preference_score DESC;
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.brand,
    p.price
FROM PRODUCT p
INNER JOIN CATEGORY c
    ON p.category_id = c.category_id
WHERE p.product_id NOT IN (
    SELECT product_id
    FROM PRODUCT_INTERACTION
    WHERE user_id = 101
)
ORDER BY p.price;
WITH user_category_preferences AS (
    SELECT
        p.category_id,
        SUM(
            CASE pi.interaction_type
                WHEN 'VIEW' THEN 1
                WHEN 'CART' THEN 3
                WHEN 'WISHLIST' THEN 4
                WHEN 'PURCHASE' THEN 5
                ELSE 0
            END
        ) AS preference_score
    FROM PRODUCT_INTERACTION pi
    INNER JOIN PRODUCT p
        ON pi.product_id = p.product_id
    WHERE pi.user_id = 101
    GROUP BY p.category_id
),

product_popularity AS (
    SELECT
        product_id,
        SUM(
            CASE interaction_type
                WHEN 'VIEW' THEN 1
                WHEN 'CART' THEN 3
                WHEN 'WISHLIST' THEN 4
                WHEN 'PURCHASE' THEN 5
                ELSE 0
            END
        ) AS popularity_score
    FROM PRODUCT_INTERACTION
    GROUP BY product_id
)

SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.brand,
    p.price,
    ucp.preference_score,
    COALESCE(pp.popularity_score, 0) AS popularity_score,

    (
        ucp.preference_score * 10
        + COALESCE(pp.popularity_score, 0)
    ) AS recommendation_score

FROM PRODUCT p

INNER JOIN user_category_preferences ucp
    ON p.category_id = ucp.category_id

LEFT JOIN product_popularity pp
    ON p.product_id = pp.product_id

INNER JOIN CATEGORY c
    ON p.category_id = c.category_id

WHERE p.product_id NOT IN (
    SELECT product_id
    FROM PRODUCT_INTERACTION
    WHERE user_id = 101
)

ORDER BY recommendation_score DESC
LIMIT 5;
DELIMITER $$

CREATE PROCEDURE get_recommendations(IN p_user_id INT)
BEGIN

    WITH user_category_preferences AS (
        SELECT
            p.category_id,
            SUM(
                CASE pi.interaction_type
                    WHEN 'VIEW' THEN 1
                    WHEN 'CART' THEN 3
                    WHEN 'WISHLIST' THEN 4
                    WHEN 'PURCHASE' THEN 5
                    ELSE 0
                END
            ) AS preference_score
        FROM PRODUCT_INTERACTION pi
        INNER JOIN PRODUCT p
            ON pi.product_id = p.product_id
        WHERE pi.user_id = p_user_id
        GROUP BY p.category_id
    ),

    product_popularity AS (
        SELECT
            product_id,
            SUM(
                CASE interaction_type
                    WHEN 'VIEW' THEN 1
                    WHEN 'CART' THEN 3
                    WHEN 'WISHLIST' THEN 4
                    WHEN 'PURCHASE' THEN 5
                    ELSE 0
                END
            ) AS popularity_score
        FROM PRODUCT_INTERACTION
        GROUP BY product_id
    )

    SELECT
        p.product_id,
        p.product_name,
        c.category_name,
        p.brand,
        p.price,
        ucp.preference_score,
        COALESCE(pp.popularity_score, 0) AS popularity_score,

        (
            ucp.preference_score * 10
            + COALESCE(pp.popularity_score, 0)
        ) AS recommendation_score

    FROM PRODUCT p

    INNER JOIN user_category_preferences ucp
        ON p.category_id = ucp.category_id

    LEFT JOIN product_popularity pp
        ON p.product_id = pp.product_id

    INNER JOIN CATEGORY c
        ON p.category_id = c.category_id

    WHERE p.product_id NOT IN (
        SELECT product_id
        FROM PRODUCT_INTERACTION
        WHERE user_id = p_user_id
    )

    ORDER BY recommendation_score DESC
    LIMIT 5;

END $$

DELIMITER ;
CALL get_recommendations(101);
CALL get_recommendations(105);
SHOW PROCEDURE STATUS
WHERE Db = 'smart_ecommerce_recommendation';
SELECT
    c.category_id,
    c.category_name,
    SUM(
        CASE pi.interaction_type
            WHEN 'VIEW' THEN 1
            WHEN 'CART' THEN 3
            WHEN 'WISHLIST' THEN 4
            WHEN 'PURCHASE' THEN 5
            ELSE 0
        END
    ) AS preference_score
FROM PRODUCT_INTERACTION pi
INNER JOIN PRODUCT p
    ON pi.product_id = p.product_id
INNER JOIN CATEGORY c
    ON p.category_id = c.category_id
WHERE pi.user_id = 101
GROUP BY c.category_id, c.category_name
ORDER BY preference_score DESC;
WITH user_category_preferences AS (
    SELECT
        p.category_id,
        SUM(
            CASE pi.interaction_type
                WHEN 'VIEW' THEN 1
                WHEN 'CART' THEN 3
                WHEN 'WISHLIST' THEN 4
                WHEN 'PURCHASE' THEN 5
                ELSE 0
            END
        ) AS preference_score
    FROM PRODUCT_INTERACTION pi
    INNER JOIN PRODUCT p
        ON pi.product_id = p.product_id
    WHERE pi.user_id = 101
    GROUP BY p.category_id
),

product_ratings AS (
    SELECT
        product_id,
        ROUND(AVG(rating), 2) AS average_rating,
        COUNT(review_id) AS review_count
    FROM REVIEW
    GROUP BY product_id
)

SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.brand,
    p.price,
    ucp.preference_score,
    COALESCE(pr.average_rating, 0) AS average_rating,
    COALESCE(pr.review_count, 0) AS review_count,

    (
        ucp.preference_score * 10
        + COALESCE(pr.average_rating, 0) * 2
    ) AS recommendation_score

FROM PRODUCT p

INNER JOIN user_category_preferences ucp
    ON p.category_id = ucp.category_id

INNER JOIN CATEGORY c
    ON p.category_id = c.category_id

LEFT JOIN product_ratings pr
    ON p.product_id = pr.product_id

WHERE p.product_id NOT IN (
    SELECT product_id
    FROM PRODUCT_INTERACTION
    WHERE user_id = 101
)

ORDER BY recommendation_score DESC
LIMIT 5;
DELIMITER $$

CREATE PROCEDURE get_category_recommendations(IN p_user_id INT)
BEGIN

    WITH user_category_preferences AS (
        SELECT
            p.category_id,
            SUM(
                CASE pi.interaction_type
                    WHEN 'VIEW' THEN 1
                    WHEN 'CART' THEN 3
                    WHEN 'WISHLIST' THEN 4
                    WHEN 'PURCHASE' THEN 5
                    ELSE 0
                END
            ) AS preference_score
        FROM PRODUCT_INTERACTION pi
        INNER JOIN PRODUCT p
            ON pi.product_id = p.product_id
        WHERE pi.user_id = p_user_id
        GROUP BY p.category_id
    ),

    product_ratings AS (
        SELECT
            product_id,
            ROUND(AVG(rating), 2) AS average_rating,
            COUNT(review_id) AS review_count
        FROM REVIEW
        GROUP BY product_id
    )

    SELECT
        p.product_id,
        p.product_name,
        c.category_name,
        p.brand,
        p.price,
        ucp.preference_score,
        COALESCE(pr.average_rating, 0) AS average_rating,
        COALESCE(pr.review_count, 0) AS review_count,

        (
            ucp.preference_score * 10
            + COALESCE(pr.average_rating, 0) * 2
        ) AS recommendation_score

    FROM PRODUCT p

    INNER JOIN user_category_preferences ucp
        ON p.category_id = ucp.category_id

    INNER JOIN CATEGORY c
        ON p.category_id = c.category_id

    LEFT JOIN product_ratings pr
        ON p.product_id = pr.product_id

    WHERE p.product_id NOT IN (
        SELECT product_id
        FROM PRODUCT_INTERACTION
        WHERE user_id = p_user_id
    )

    ORDER BY recommendation_score DESC
    LIMIT 5;

END $$

DELIMITER ;
CALL get_category_recommendations(101);
CALL get_category_recommendations(105);
SHOW PROCEDURE STATUS
WHERE Db = 'smart_ecommerce_recommendation';
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    COUNT(pi.interaction_id) AS total_interactions,

    SUM(
        CASE pi.interaction_type
            WHEN 'VIEW' THEN 1
            WHEN 'CART' THEN 3
            WHEN 'WISHLIST' THEN 4
            WHEN 'PURCHASE' THEN 5
            ELSE 0
        END
    ) AS popularity_score

FROM PRODUCT p

INNER JOIN CATEGORY c
    ON p.category_id = c.category_id

LEFT JOIN PRODUCT_INTERACTION pi
    ON p.product_id = pi.product_id

GROUP BY
    p.product_id,
    p.product_name,
    c.category_name

ORDER BY popularity_score DESC;
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.brand,
    p.price,

    COUNT(pi.interaction_id) AS total_interactions,

    SUM(
        CASE pi.interaction_type
            WHEN 'VIEW' THEN 1
            WHEN 'CART' THEN 3
            WHEN 'WISHLIST' THEN 4
            WHEN 'PURCHASE' THEN 5
            ELSE 0
        END
    ) AS popularity_score

FROM PRODUCT p

INNER JOIN CATEGORY c
    ON p.category_id = c.category_id

LEFT JOIN PRODUCT_INTERACTION pi
    ON p.product_id = pi.product_id

GROUP BY
    p.product_id,
    p.product_name,
    c.category_name,
    p.brand,
    p.price

ORDER BY popularity_score DESC

LIMIT 5;
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.brand,
    p.price,

    COUNT(pi.interaction_id) AS total_interactions,

    SUM(
        CASE pi.interaction_type
            WHEN 'VIEW' THEN 1
            WHEN 'CART' THEN 3
            WHEN 'WISHLIST' THEN 4
            WHEN 'PURCHASE' THEN 5
            ELSE 0
        END
    ) AS popularity_score

FROM PRODUCT p

INNER JOIN CATEGORY c
    ON p.category_id = c.category_id

LEFT JOIN PRODUCT_INTERACTION pi
    ON p.product_id = pi.product_id

WHERE p.product_id NOT IN (
    SELECT product_id
    FROM PRODUCT_INTERACTION
    WHERE user_id = 101
)

GROUP BY
    p.product_id,
    p.product_name,
    c.category_name,
    p.brand,
    p.price

ORDER BY popularity_score DESC

LIMIT 5;
DELIMITER $$

CREATE PROCEDURE get_popular_recommendations(IN p_user_id INT)
BEGIN

    SELECT
        p.product_id,
        p.product_name,
        c.category_name,
        p.brand,
        p.price,

        COUNT(pi.interaction_id) AS total_interactions,

        SUM(
            CASE pi.interaction_type
                WHEN 'VIEW' THEN 1
                WHEN 'CART' THEN 3
                WHEN 'WISHLIST' THEN 4
                WHEN 'PURCHASE' THEN 5
                ELSE 0
            END
        ) AS popularity_score

    FROM PRODUCT p

    INNER JOIN CATEGORY c
        ON p.category_id = c.category_id

    LEFT JOIN PRODUCT_INTERACTION pi
        ON p.product_id = pi.product_id

    WHERE p.product_id NOT IN (
        SELECT product_id
        FROM PRODUCT_INTERACTION
        WHERE user_id = p_user_id
    )

    GROUP BY
        p.product_id,
        p.product_name,
        c.category_name,
        p.brand,
        p.price

    ORDER BY popularity_score DESC

    LIMIT 5;

END $$

DELIMITER ;
CALL get_popular_recommendations(101);
CALL get_popular_recommendations(105);
SHOW PROCEDURE STATUS
WHERE Db = 'smart_ecommerce_recommendation';
SELECT
    pi2.user_id AS similar_user_id,
    u.name AS similar_user_name,
    COUNT(DISTINCT pi1.product_id) AS common_products
FROM PRODUCT_INTERACTION pi1
INNER JOIN PRODUCT_INTERACTION pi2
    ON pi1.product_id = pi2.product_id
    AND pi1.user_id <> pi2.user_id
INNER JOIN `USER` u
    ON pi2.user_id = u.user_id
WHERE pi1.user_id = 101
GROUP BY
    pi2.user_id,
    u.name
ORDER BY common_products DESC;
SELECT
    pi2.product_id,
    p.product_name,
    c.category_name,
    COUNT(DISTINCT pi2.user_id) AS users_interacted,
    COUNT(*) AS interaction_count
FROM PRODUCT_INTERACTION pi1
INNER JOIN PRODUCT_INTERACTION pi2
    ON pi1.product_id = pi2.product_id
    AND pi1.user_id <> pi2.user_id
INNER JOIN PRODUCT p
    ON pi2.product_id = p.product_id
INNER JOIN CATEGORY c
    ON p.category_id = c.category_id
WHERE pi1.user_id = 101
AND pi2.product_id NOT IN (
    SELECT product_id
    FROM PRODUCT_INTERACTION
    WHERE user_id = 101
)
GROUP BY
    pi2.product_id,
    p.product_name,
    c.category_name
ORDER BY
    users_interacted DESC,
    interaction_count DESC
LIMIT 5;
DELIMITER $$

CREATE PROCEDURE get_similar_user_recommendations(IN p_user_id INT)
BEGIN

    SELECT
        pi2.product_id,
        p.product_name,
        c.category_name,
        COUNT(DISTINCT pi2.user_id) AS users_interacted,
        COUNT(*) AS interaction_count

    FROM PRODUCT_INTERACTION pi1

    INNER JOIN PRODUCT_INTERACTION pi2
        ON pi1.product_id = pi2.product_id
        AND pi1.user_id <> pi2.user_id

    INNER JOIN PRODUCT p
        ON pi2.product_id = p.product_id

    INNER JOIN CATEGORY c
        ON p.category_id = c.category_id

    WHERE pi1.user_id = p_user_id

    AND pi2.product_id NOT IN (
        SELECT product_id
        FROM PRODUCT_INTERACTION
        WHERE user_id = p_user_id
    )

    GROUP BY
        pi2.product_id,
        p.product_name,
        c.category_name

    ORDER BY
        users_interacted DESC,
        interaction_count DESC

    LIMIT 5;

END $$

DELIMITER ;
CALL get_similar_user_recommendations(101);
CALL get_similar_user_recommendations(105);
SHOW PROCEDURE STATUS
WHERE Db = 'smart_ecommerce_recommendation';
WITH user_category_preferences AS (
    SELECT
        p.category_id,
        SUM(
            CASE pi.interaction_type
                WHEN 'VIEW' THEN 1
                WHEN 'CART' THEN 3
                WHEN 'WISHLIST' THEN 4
                WHEN 'PURCHASE' THEN 5
                ELSE 0
            END
        ) AS preference_score
    FROM PRODUCT_INTERACTION pi
    INNER JOIN PRODUCT p
        ON pi.product_id = p.product_id
    WHERE pi.user_id = 101
    GROUP BY p.category_id
),

product_popularity AS (
    SELECT
        product_id,
        SUM(
            CASE interaction_type
                WHEN 'VIEW' THEN 1
                WHEN 'CART' THEN 3
                WHEN 'WISHLIST' THEN 4
                WHEN 'PURCHASE' THEN 5
                ELSE 0
            END
        ) AS popularity_score
    FROM PRODUCT_INTERACTION
    GROUP BY product_id
),

similar_user_activity AS (
    SELECT
        pi2.product_id,
        COUNT(DISTINCT pi2.user_id) AS similar_users
    FROM PRODUCT_INTERACTION pi1
    INNER JOIN PRODUCT_INTERACTION pi2
        ON pi1.product_id = pi2.product_id
        AND pi1.user_id <> pi2.user_id
    WHERE pi1.user_id = 101
    GROUP BY pi2.product_id
),

product_ratings AS (
    SELECT
        product_id,
        ROUND(AVG(rating), 2) AS average_rating
    FROM REVIEW
    GROUP BY product_id
)

SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.brand,
    p.price,

    ucp.preference_score,

    COALESCE(pp.popularity_score, 0) AS popularity_score,

    COALESCE(sua.similar_users, 0) AS similar_users,

    COALESCE(pr.average_rating, 0) AS average_rating,

    (
        ucp.preference_score * 10
        + COALESCE(pp.popularity_score, 0) * 2
        + COALESCE(sua.similar_users, 0) * 5
        + COALESCE(pr.average_rating, 0) * 2
    ) AS hybrid_score

FROM PRODUCT p

INNER JOIN user_category_preferences ucp
    ON p.category_id = ucp.category_id

INNER JOIN CATEGORY c
    ON p.category_id = c.category_id

LEFT JOIN product_popularity pp
    ON p.product_id = pp.product_id

LEFT JOIN similar_user_activity sua
    ON p.product_id = sua.product_id

LEFT JOIN product_ratings pr
    ON p.product_id = pr.product_id

WHERE p.product_id NOT IN (
    SELECT product_id
    FROM PRODUCT_INTERACTION
    WHERE user_id = 101
)

ORDER BY hybrid_score DESC

LIMIT 5;
DELIMITER $$

CREATE PROCEDURE get_hybrid_recommendations(IN p_user_id INT)
BEGIN

    WITH user_category_preferences AS (
        SELECT
            p.category_id,
            SUM(
                CASE pi.interaction_type
                    WHEN 'VIEW' THEN 1
                    WHEN 'CART' THEN 3
                    WHEN 'WISHLIST' THEN 4
                    WHEN 'PURCHASE' THEN 5
                    ELSE 0
                END
            ) AS preference_score
        FROM PRODUCT_INTERACTION pi
        INNER JOIN PRODUCT p
            ON pi.product_id = p.product_id
        WHERE pi.user_id = p_user_id
        GROUP BY p.category_id
    ),

    product_popularity AS (
        SELECT
            product_id,
            SUM(
                CASE interaction_type
                    WHEN 'VIEW' THEN 1
                    WHEN 'CART' THEN 3
                    WHEN 'WISHLIST' THEN 4
                    WHEN 'PURCHASE' THEN 5
                    ELSE 0
                END
            ) AS popularity_score
        FROM PRODUCT_INTERACTION
        GROUP BY product_id
    ),

    similar_user_activity AS (
        SELECT
            pi2.product_id,
            COUNT(DISTINCT pi2.user_id) AS similar_users
        FROM PRODUCT_INTERACTION pi1
        INNER JOIN PRODUCT_INTERACTION pi2
            ON pi1.product_id = pi2.product_id
            AND pi1.user_id <> pi2.user_id
        WHERE pi1.user_id = p_user_id
        GROUP BY pi2.product_id
    ),

    product_ratings AS (
        SELECT
            product_id,
            ROUND(AVG(rating), 2) AS average_rating
        FROM REVIEW
        GROUP BY product_id
    )

    SELECT
        p.product_id,
        p.product_name,
        c.category_name,
        p.brand,
        p.price,

        ucp.preference_score,

        COALESCE(pp.popularity_score, 0) AS popularity_score,

        COALESCE(sua.similar_users, 0) AS similar_users,

        COALESCE(pr.average_rating, 0) AS average_rating,

        (
            ucp.preference_score * 10
            + COALESCE(pp.popularity_score, 0) * 2
            + COALESCE(sua.similar_users, 0) * 5
            + COALESCE(pr.average_rating, 0) * 2
        ) AS hybrid_score

    FROM PRODUCT p

    INNER JOIN user_category_preferences ucp
        ON p.category_id = ucp.category_id

    INNER JOIN CATEGORY c
        ON p.category_id = c.category_id

    LEFT JOIN product_popularity pp
        ON p.product_id = pp.product_id

    LEFT JOIN similar_user_activity sua
        ON p.product_id = sua.product_id

    LEFT JOIN product_ratings pr
        ON p.product_id = pr.product_id

    WHERE p.product_id NOT IN (
        SELECT product_id
        FROM PRODUCT_INTERACTION
        WHERE user_id = p_user_id
    )

    ORDER BY hybrid_score DESC

    LIMIT 5;

END $$

DELIMITER ;
CALL get_hybrid_recommendations(101);
CALL get_hybrid_recommendations(105);
SHOW PROCEDURE STATUS
WHERE Db = 'smart_ecommerce_recommendation';
SELECT
    u.user_id,
    u.name,
    COUNT(pi.interaction_id) AS interaction_count
FROM `USER` u
LEFT JOIN PRODUCT_INTERACTION pi
    ON u.user_id = pi.user_id
WHERE u.user_id = 101
GROUP BY
    u.user_id,
    u.name;
    DELIMITER $$

CREATE PROCEDURE get_cold_start_recommendations(IN p_user_id INT)
BEGIN

    SELECT
        p.product_id,
        p.product_name,
        c.category_name,
        p.brand,
        p.price,
        COALESCE(AVG(r.rating), 0) AS average_rating,
        COUNT(DISTINCT pi.interaction_id) AS total_interactions,

        (
            COALESCE(AVG(r.rating), 0) * 5
            +
            COUNT(DISTINCT pi.interaction_id)
        ) AS recommendation_score

    FROM PRODUCT p

    INNER JOIN CATEGORY c
        ON p.category_id = c.category_id

    LEFT JOIN REVIEW r
        ON p.product_id = r.product_id

    LEFT JOIN PRODUCT_INTERACTION pi
        ON p.product_id = pi.product_id

    WHERE NOT EXISTS (
        SELECT 1
        FROM PRODUCT_INTERACTION user_pi
        WHERE user_pi.user_id = p_user_id
    )

    GROUP BY
        p.product_id,
        p.product_name,
        c.category_name,
        p.brand,
        p.price

    ORDER BY recommendation_score DESC

    LIMIT 5;

END $$

DELIMITER ;
SELECT
    u.user_id,
    u.name,
    COUNT(pi.interaction_id) AS interaction_count
FROM `USER` u
LEFT JOIN PRODUCT_INTERACTION pi
    ON u.user_id = pi.user_id
GROUP BY
    u.user_id,
    u.name
ORDER BY u.user_id;
CALL get_cold_start_recommendations(111);
CALL get_hybrid_recommendations(101);
CALL get_hybrid_recommendations(105);
CALL get_cold_start_recommendations(111);
SELECT
    p.product_id,
    p.product_name
FROM PRODUCT p
WHERE p.product_id NOT IN (
    SELECT product_id
    FROM PRODUCT_INTERACTION
    WHERE user_id = 101
);
SELECT
    interaction_type,
    COUNT(*) AS interaction_count
FROM PRODUCT_INTERACTION
GROUP BY interaction_type
ORDER BY interaction_count DESC;
SELECT
    p.product_id,
    p.product_name,
    COUNT(pi.interaction_id) AS total_interactions
FROM PRODUCT p
LEFT JOIN PRODUCT_INTERACTION pi
    ON p.product_id = pi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_interactions DESC
LIMIT 10;
SELECT
    p.product_id,
    p.product_name,
    ROUND(AVG(r.rating), 2) AS average_rating,
    COUNT(r.review_id) AS review_count
FROM PRODUCT p
LEFT JOIN REVIEW r
    ON p.product_id = r.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY average_rating DESC;