-- Experiment 4: Integrity Constraints (MySQL)
DROP DATABASE IF EXISTS ConstraintsLabDB;
CREATE DATABASE ConstraintsLabDB;
USE ConstraintsLabDB;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(60) NOT NULL,
    email VARCHAR(80) NOT NULL UNIQUE,
    city VARCHAR(40) DEFAULT 'Chennai'
) ENGINE=InnoDB;

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    sku VARCHAR(20) NOT NULL UNIQUE,
    product_name VARCHAR(60) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    CONSTRAINT chk_price CHECK (price > 0),
    CONSTRAINT chk_stock CHECK (stock >= 0)
) ENGINE=InnoDB;

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    order_status VARCHAR(12) NOT NULL DEFAULT 'Pending',
    order_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    CONSTRAINT fk_order_product FOREIGN KEY (product_id) REFERENCES Products(product_id),
    CONSTRAINT chk_quantity CHECK (quantity > 0),
    CONSTRAINT chk_status CHECK (order_status IN ('Pending','Confirmed','Cancelled'))
) ENGINE=InnoDB;

INSERT INTO Customers VALUES
(201,'Asha','asha@example.com','Chennai'),
(202,'Bala','bala@example.com','Hyderabad'),
(203,'Charu','charu@example.com','Bengaluru');
INSERT INTO Products VALUES
(301,'KB-01','Keyboard',850,25),
(302,'MS-02','Mouse',450,40),
(303,'HD-03','Hard Drive',4200,10);
INSERT INTO Orders(order_id,customer_id,product_id,quantity,order_status) VALUES
(401,201,301,2,'Pending'),
(402,202,302,3,'Confirmed'),
(403,203,303,1,'Pending');

INSERT INTO Customers(customer_id,customer_name,email) VALUES
(204,'Deepa','deepa@example.com');

-- Validation attempts (each invalid statement is expected to fail)
-- INSERT INTO Customers VALUES (201,'Duplicate','duplicate@example.com','Chennai');
-- INSERT INTO Customers VALUES (205,'Esha','asha@example.com','Chennai');
-- INSERT INTO Customers(customer_id,email) VALUES (205,'esha@example.com');
-- INSERT INTO Products VALUES (304,'BAD-04','Invalid Product',-10,5);
-- INSERT INTO Orders(order_id,customer_id,product_id,quantity) VALUES (404,999,301,1);

SELECT * FROM Customers ORDER BY customer_id;
SELECT * FROM Orders ORDER BY order_id;
SHOW CREATE TABLE Orders;
