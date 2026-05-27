-- Create Database 
CREATE DATABASE IF NOT EXISTS DataDigger;
USE DataDigger;

-- =============================
-- 1. CUSTOMERS TABLE
-- =============================
CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Address VARCHAR(255)
);

INSERT INTO Customers (Name, Email, Address) VALUES
('Alice', 'alice@gmail.com', 'Mumbai'),
('Bob', 'bob@gmail.com', 'Delhi'),
('Charlie', 'charlie@gmail.com', 'Pune'),
('David', 'david@gmail.com', 'Ahmedabad'),
('Eve', 'eve@gmail.com', 'Bangalore');

SELECT * FROM Customers;

UPDATE Customers
SET Address = 'Surat'
WHERE CustomerID = 1;

DELETE FROM Customers
WHERE CustomerID = 5;

SELECT * FROM Customers WHERE Name = 'Alice';

-- =============================
-- 2. ORDERS TABLE
-- =============================
CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, CURDATE(), 1500),
(2, CURDATE(), 2500),
(3, CURDATE(), 1000),
(1, CURDATE(), 3000),
(4, CURDATE(), 2000);

SELECT * FROM Orders;

SELECT * FROM Orders WHERE CustomerID = 1;

UPDATE Orders SET TotalAmount = 1800 WHERE OrderID = 1;

DELETE FROM Orders WHERE OrderID = 3;

SELECT * FROM Orders
WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;

SELECT MAX(TotalAmount), MIN(TotalAmount), AVG(TotalAmount)
FROM Orders;

-- =============================
-- 3. PRODUCTS TABLE
-- =============================
CREATE TABLE IF NOT EXISTS Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT
);

INSERT INTO Products (ProductName, Price, Stock) VALUES
('Laptop', 50000, 10),
('Mobile', 20000, 20),
('Headphones', 1500, 0),
('Keyboard', 800, 15),
('Mouse', 500, 25);

SELECT * FROM Products ORDER BY Price DESC;

UPDATE Products SET Price = 55000 WHERE ProductID = 1;

DELETE FROM Products WHERE Stock = 0;

SELECT * FROM Products WHERE Price BETWEEN 500 AND 2000;

SELECT MAX(Price), MIN(Price) FROM Products;

-- =============================
-- 4. ORDER DETAILS TABLE
-- =============================
CREATE TABLE IF NOT EXISTS OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    SubTotal DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, SubTotal) VALUES
(1, 1, 1, 50000),
(2, 2, 2, 40000),
(4, 2, 3, 60000),
(5, 4, 2, 1600),
(1, 5, 5, 2500);

SELECT * FROM OrderDetails WHERE OrderID = 1;

SELECT SUM(SubTotal) AS TotalRevenue FROM OrderDetails;

SELECT ProductID, COUNT(*) AS TotalOrders
FROM OrderDetails
GROUP BY ProductID
ORDER BY TotalOrders DESC
LIMIT 3;

SELECT ProductID, COUNT(*) AS TimesSold
FROM OrderDetails
WHERE ProductID = 1
GROUP BY ProductID;