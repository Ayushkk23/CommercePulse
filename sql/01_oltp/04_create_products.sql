USE CommercePulse_OLTP;
GO

CREATE TABLE Products
(
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(200) NOT NULL,
    Brand VARCHAR(100),
    CategoryID INT NOT NULL,
    SubCategory VARCHAR(100),
    UnitCost DECIMAL(12,2) NOT NULL,
    SupplierID INT,

    CONSTRAINT FK_Products_Categories
        FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID)
);
GO


SELECT *
FROM Products;

