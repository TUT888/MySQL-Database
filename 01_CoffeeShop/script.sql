DROP DATABASE IF EXISTS CoffeeShop;

CREATE DATABASE CoffeeShop;
USE CoffeeShop;

CREATE TABLE product (
	id CHAR(4),
    product_name VARCHAR(30) NOT NULL,
    price INTEGER NOT NULL,
    unit ENUM('kg', 'g') NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT ck_product_price CHECK (price >= 0)
);

CREATE TABLE customer (
	id CHAR(4),
    customer_name VARCHAR(50) NOT NULL,
    gender CHAR(1),
    phone CHAR(10),
    PRIMARY KEY (id)
);

CREATE TABLE shop (
	id CHAR(4),
    location VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE stock (
	shop_id CHAR(4),
    product_id CHAR(4),
    amount INTEGER NOT NULL,
    PRIMARY KEY (shop_id, product_id),
    CONSTRAINT fk_stock_product_id FOREIGN KEY (product_id) REFERENCES product (id),
    CONSTRAINT ck_stock_amount CHECK (amount >= 0)
);

CREATE TABLE customer_order (
	id CHAR(4),
    customer_id CHAR(4) NOT NULL,
    shop_id CHAR(4) NOT NULL,
    order_time DATETIME NOT NULL,
    total INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_customer_order_customer_id FOREIGN KEY (customer_id) REFERENCES customer (id),
    CONSTRAINT fk_customer_order_shop_id FOREIGN KEY (shop_id) REFERENCES shop (id),
    CONSTRAINT ck_customer_order_total CHECK (total > 0),
    CONSTRAINT ck_customer_order_quantity CHECK (quantity > 0)
);

CREATE TABLE order_items (
	order_id CHAR(4),
    product_id CHAR(4),
    product_price INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    PRIMARY KEY (order_id, product_id),
    CONSTRAINT fk_order_items_order_id FOREIGN KEY (order_id) REFERENCES customer_order (id),
    CONSTRAINT fk_order_items_product_id FOREIGN KEY (product_id) REFERENCES product (id),
    CONSTRAINT ck_order_items_quantity CHECK (quantity > 0),
    CONSTRAINT ck_order_items_product_price CHECK (product_price >= 0)
);

INSERT INTO product VALUES 
('P001', 'Robusta', 2, 'kg'),
('P002', 'Arabica', 3, 'kg'),
('P003', 'Matcha', 2.5, 'kg');

INSERT INTO customer VALUES
('C001', 'John', 'M', '1234567890'),
('C002', 'Mary', 'F', '1234567890');

INSERT INTO shop VALUES
('S001', 'Melbourne'),
('S002', 'Sydney');

INSERT INTO stock VALUES
('S001', 'P001', 10),
('S001', 'P003', 18),
('S002', 'P002', 21);

INSERT INTO customer_order VALUES
('O001', 'C001', 'S001', '2025-07-28 8:30:00', 12, 3),
('O002', 'C002', 'S002', '2025-07-29 12:21:00', 10, 1);

INSERT INTO order_items VALUES
('O001', 'P001', 2, 1),
('O001', 'P003', 3, 2),
('O002', 'P002', 2, 1);