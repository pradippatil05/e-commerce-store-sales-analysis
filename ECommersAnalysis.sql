-- 1. Create Sample E-Commerce Database

CREATE DATABASE ECommerceDB;
USE ECommerceDB;

-- 2. Create Tables for Analysis
-- Customers Table

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    location VARCHAR(100),
    registration_date DATE DEFAULT CURDATE()
);

-- Products Table

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL
);

-- Orders Table

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE DEFAULT CURDATE(),
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE
);

-- Order_Items Table

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);

-- 3. Inserting Sample Data
-- Insert Data Into Customers Table

INSERT INTO Customers (name, email, location, registration_date) VALUES
('Prathmesh Shinde', 'prathmesh@example.com', 'Kolhapur', '2023-06-15'),
('Pradip Patil', 'pradip@example.com', 'Sangli', '2023-07-10'),
('Yogesh Sawairam', 'yogesh@example.com', 'Shirala', '2023-08-05'),
('Indrajeet Patil', 'indrajeet@example.com', 'Tandulwadi', '2023-09-20'),
('Pravin Chavan', 'pravin@example.com', 'Talsande', '2023-10-01');

-- Insert Data Into Products Table

INSERT INTO Products (product_name, category, price, stock_quantity) VALUES
('Smartphone', 'Electronics', 699.99, 50),
('Laptop', 'Electronics', 999.99, 30),
('Headphones', 'Accessories', 199.99, 100),
('Gaming Console', 'Electronics', 499.99, 25),
('Smartwatch', 'Wearable', 249.99, 40);

-- Insert Data Into Orders Table

INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
(1, '2024-01-10', 1699.97),
(2, '2024-01-15', 699.99),
(3, '2024-02-01', 1249.98),
(4, '2024-02-10', 499.99),
(5, '2024-02-15', 999.99);

-- Insert Data Into Order_Items Table

INSERT INTO Order_Items (order_id, product_id, quantity, subtotal) VALUES
(1, 1, 2, 1399.98),
(1, 3, 1, 199.99),
(2, 2, 1, 699.99),
(3, 4, 2, 999.98),
(3, 5, 1, 249.99),
(4, 4, 1, 499.99),
(5, 2, 1, 999.99);

-- 4. Analysis Queries
-- Total Sales and Revenue

SELECT SUM(total_amount) AS total_revenue, COUNT(order_id) AS total_orders  
FROM Orders;

-- Top Selling Products

SELECT p.product_name, SUM(oi.quantity) AS total_sold  
FROM Order_Items oi  
JOIN Products p ON oi.product_id = p.product_id  
GROUP BY p.product_name  
ORDER BY total_sold DESC  
LIMIT 10;

-- Monthly Sales Trend

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(total_amount) AS monthly_revenue  
FROM Orders  
GROUP BY month  
ORDER BY month;

-- Customer with the Highest Purchases

SELECT c.name, SUM(o.total_amount) AS total_spent  
FROM Customers c  
JOIN Orders o ON c.customer_id = o.customer_id  
GROUP BY c.name  
ORDER BY total_spent DESC  
LIMIT 1;

-- Product Category Performance

SELECT p.category, SUM(oi.quantity) AS total_sold, SUM(oi.subtotal) AS total_revenue  
FROM Order_Items oi  
JOIN Products p ON oi.product_id = p.product_id  
GROUP BY p.category  
ORDER BY total_revenue DESC;




