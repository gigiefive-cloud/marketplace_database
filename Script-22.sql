create database marketplace_db; 
use marketplace_db;

CREATE TABLE user (
    user_id    INT PRIMARY KEY AUTO_INCREMENT,
    username   VARCHAR(100) NOT NULL,
    email      VARCHAR(255) NOT NULL UNIQUE,
    password   VARCHAR(255) NOT NULL,
    role       VARCHAR(50) NOT NULL DEFAULT 'buyer'
);

CREATE TABLE product_category (
    category_id    INT PRIMARY KEY AUTO_INCREMENT,
    category_name  VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS order_detail;
DROP TABLE IF EXISTS `order`;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS product_category;
DROP TABLE IF EXISTS user;

CREATE TABLE user (
    user_id    INT PRIMARY KEY AUTO_INCREMENT,
    username   VARCHAR(100) NOT NULL,
    email      VARCHAR(255) NOT NULL UNIQUE,
    password   VARCHAR(255) NOT NULL,
    role       VARCHAR(50) NOT NULL DEFAULT 'buyer'
);

DROP TABLE IF EXISTS order_detail;
DROP TABLE IF EXISTS `order`;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS product_category;
DROP TABLE IF EXISTS user;

DROP TABLE IF EXISTS order_detail;
DROP TABLE IF EXISTS `order`;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS product_category;
DROP TABLE IF EXISTS user;

CREATE TABLE user (
    user_id    INT PRIMARY KEY AUTO_INCREMENT,
    username   VARCHAR(100) NOT NULL,
    email      VARCHAR(255) NOT NULL UNIQUE,
    password   VARCHAR(255) NOT NULL,
    role       VARCHAR(50) NOT NULL DEFAULT 'buyer'
);

CREATE TABLE product_category (
    category_id    INT PRIMARY KEY AUTO_INCREMENT,
    category_name  VARCHAR(100) NOT NULL
);

CREATE TABLE product (
    product_id    INT PRIMARY KEY AUTO_INCREMENT,
    seller_id     INT NOT NULL,
    category_id   INT NOT NULL,
    product_name  VARCHAR(255) NOT NULL,
    description   TEXT,
    price         DECIMAL(15,2) NOT NULL,
    stock         INT NOT NULL DEFAULT 0,
    FOREIGN KEY (seller_id)   REFERENCES user(user_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

CREATE TABLE `order` (
    order_id      INT PRIMARY KEY AUTO_INCREMENT,
    user_id       INT NOT NULL,
    total_price   DECIMAL(15,2) NOT NULL,
    created_at    DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE order_detail (
    order_detail_id  INT PRIMARY KEY AUTO_INCREMENT,
    order_id         INT NOT NULL,
    product_id       INT NOT NULL,
    price            DECIMAL(15,2) NOT NULL,
    quantity         INT NOT NULL DEFAULT 1,
    FOREIGN KEY (order_id)   REFERENCES `order`(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

INSERT INTO user (username, email, password, role) VALUES
('regie_seller',   'regie@mail.com',    'hash1', 'seller'),
('rina_seller',   'rina@mail.com',    'hash2', 'seller'),
('doni_seller',   'doni@mail.com',    'hash3', 'seller'),
('sari_buyer',    'sari@mail.com',    'hash4', 'buyer'),
('andi_buyer',    'andi@mail.com',    'hash5', 'buyer'),
('dewi_buyer',    'dewi@mail.com',    'hash6', 'buyer'),
('reza_buyer',    'reza@mail.com',    'hash7', 'buyer'),
('tono_buyer',    'tono@mail.com',    'hash8', 'buyer'),
('lina_buyer',    'lina@mail.com',    'hash9', 'buyer'),
('hani_buyer',    'hani@mail.com',    'hash10','buyer');

INSERT INTO product_category (category_name) VALUES
('E-Book'),
('Template Design'),
('Source Code'),
('Foto & Ilustrasi'),
('Audio & Musik');

INSERT INTO product (seller_id, category_id, product_name, description, price, stock) VALUES
(1, 1, 'E-Book Belajar SQL',        'Panduan SQL dari dasar',       75000,  50),
(1, 2, 'Template CV Modern',         'Template ATS-friendly',        50000, 100),
(2, 3, 'Source Code Toko Online',    'Laravel + MySQL lengkap',     350000,  20),
(2, 1, 'E-Book Python Pemula',       'Belajar Python dari nol',      85000,  60),
(3, 4, 'Paket Ikon UI 500pcs',       'Format SVG & PNG',            120000,  80),
(3, 2, 'Template Presentasi Bisnis', 'PowerPoint 30 slide',          65000, 150),
(1, 5, 'Paket SFX Podcast',          '100 sound effect HQ',         180000,  40),
(2, 3, 'Script Bot WhatsApp',         'NodeJS + Baileys',            250000,  15),
(3, 1, 'E-Book Digital Marketing',   'Strategi sosmed 2024',         95000,  70),
(1, 4, 'Preset Lightroom 50pcs',     'Preset foto aesthetic',        55000, 200),
(2, 2, 'Template Invoice Keren',     'Format Excel & Word',          35000,   0),
(3, 5, 'Loop Musik Lo-Fi',           '20 track tanpa copyright',    600000,  10);

INSERT INTO `order` (user_id, total_price) VALUES
(4,  125000),
(5,  350000),
(6,  170000),
(7,  250000),
(8,  600000),
(9,   85000),
(10, 215000),
(4,  120000),
(5,   65000),
(6,  180000);

INSERT INTO order_detail (order_id, product_id, price, quantity) VALUES
(1,  1,  75000, 1),
(1,  2,  50000, 1),
(2,  3, 350000, 1),
(3,  5, 120000, 1),
(3,  6,  65000, 1),
(4,  8, 250000, 1),
(5, 12, 600000, 1),
(6,  4,  85000, 1),
(7,  5, 120000, 1),
(7,  7,  95000, 1),
(8,  2,  50000, 1),
(8, 10,  55000, 1),
(9,  6,  65000, 1),
(10, 7, 180000, 1);

SELECT * FROM product;

SELECT product_name, price FROM product;

SELECT * FROM product
WHERE price BETWEEN 50000 AND 200000;

SELECT * FROM product
WHERE stock = 0 OR price > 500000;

SELECT * FROM product
ORDER BY price DESC
LIMIT 5;

SELECT COUNT(*) AS total_user FROM user;

SELECT COUNT(*) AS total_produk FROM product;

SELECT pc.category_name, COUNT(p.product_id) AS jumlah_produk
FROM product_category pc
LEFT JOIN product p ON pc.category_id = p.category_id
GROUP BY pc.category_name;

SELECT pc.category_name, AVG(p.price) AS rata_harga
FROM product_category pc
LEFT JOIN product p ON pc.category_id = p.category_id
GROUP BY pc.category_name;

SELECT pc.category_name, COUNT(p.product_id) AS jumlah_produk
FROM product_category pc
LEFT JOIN product p ON pc.category_id = p.category_id
GROUP BY pc.category_name
HAVING COUNT(p.product_id) > 3;

-- ===========joint==============

SELECT p.product_name, pc.category_name
FROM product p
INNER JOIN product_category pc ON p.category_id = pc.category_id;

SELECT pc.category_name, p.product_name
FROM product_category pc
LEFT JOIN product p ON pc.category_id = p.category_id;

SELECT u.username, o.order_id, o.total_price
FROM user u
LEFT JOIN `order` o ON u.user_id = o.user_id;

SELECT o.order_id, u.username AS buyer, o.total_price, o.created_at
FROM `order` o
INNER JOIN user u ON o.user_id = u.user_id;

SELECT p.product_name, u.username AS seller, p.price
FROM product p
INNER JOIN user u ON p.seller_id = u.user_id;

