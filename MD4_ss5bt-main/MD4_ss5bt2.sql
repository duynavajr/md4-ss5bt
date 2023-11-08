CREATE DATABASE demo_database;
USE demo_database;
CREATE TABLE Products (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    productCode VARCHAR(255) UNIQUE,
    productName VARCHAR(255),
    productPrice DECIMAL(10, 2),
    productAmount INT,
    productDescription TEXT,
    productStatus VARCHAR(50)
);

INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES ('P001', 'Product 1', 50.00, 100, 'Description 1', 'Active'),
       ('P002', 'Product 2', 75.50, 150, 'Description 2', 'Active'),
       ('P003', 'Product 3', 100.25, 200, 'Description 3', 'Inactive');
       
       -- Tạo Unique Index trên cột productCode
CREATE UNIQUE INDEX idx_productCode ON Products (productCode);

-- Tạo Composite Index trên cột productName và productPrice
CREATE INDEX idx_productName_price ON Products (productName, productPrice);

-- Sử dụng câu lệnh EXPLAIN để kiểm tra câu truy vấn trước và sau khi tạo index
EXPLAIN SELECT * FROM Products WHERE productCode = 'P001';
EXPLAIN SELECT * FROM Products WHERE productName = 'Product 1' AND productPrice = 50.00;

-- Tạo view
CREATE VIEW ProductView AS
SELECT productCode, productName, productPrice, productStatus
FROM Products;

-- Sửa đổi view
CREATE OR REPLACE VIEW ProductView AS
SELECT productCode, productName, productPrice, productAmount
FROM Products WHERE productStatus = 'Active';

-- Xoá view
DROP VIEW ProductView;
-- Tạo store procedure lấy tất cả thông tin của tất cả sản phẩm
DELIMITER //
CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM Products;
END //
DELIMITER ;

-- Tạo store procedure thêm một sản phẩm mới
DELIMITER //
CREATE PROCEDURE AddProduct(IN p_productCode VARCHAR(255), IN p_productName VARCHAR(255), 
                            IN p_productPrice DECIMAL(10, 2), IN p_productAmount INT, 
                            IN p_productDescription TEXT, IN p_productStatus VARCHAR(50))
BEGIN
    INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES (p_productCode, p_productName, p_productPrice, p_productAmount, p_productDescription, p_productStatus);
END //
DELIMITER ;

-- Tạo store procedure sửa thông tin sản phẩm theo Id
DELIMITER //
CREATE PROCEDURE UpdateProduct(IN p_id INT, IN p_productCode VARCHAR(255), IN p_productName VARCHAR(255), 
                               IN p_productPrice DECIMAL(10, 2), IN p_productAmount INT, 
                               IN p_productDescription TEXT, IN p_productStatus VARCHAR(50))
BEGIN
    UPDATE Products
    SET productCode = p_productCode, productName = p_productName, productPrice = p_productPrice,
        productAmount = p_productAmount, productDescription = p_productDescription, productStatus = p_productStatus
    WHERE Id = p_id;
END //
DELIMITER ;

-- Tạo store procedure xoá sản phẩm theo Id
DELIMITER //
CREATE PROCEDURE DeleteProduct(IN p_id INT)
BEGIN
    DELETE FROM Products WHERE Id = p_id;
END //
DELIMITER ;


