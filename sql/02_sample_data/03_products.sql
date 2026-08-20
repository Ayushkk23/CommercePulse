USE CommercePulse_OLTP;
GO

WITH Numbers AS
(
    SELECT 1 AS N
    UNION ALL SELECT 2
    UNION ALL SELECT 3
    UNION ALL SELECT 4
    UNION ALL SELECT 5
    UNION ALL SELECT 6
    UNION ALL SELECT 7
    UNION ALL SELECT 8
    UNION ALL SELECT 9
    UNION ALL SELECT 10
),
ProductData AS
(
    SELECT
        C.CategoryID,
        C.CategoryName,
        N.N AS ProductNumber
    FROM Categories C
    CROSS JOIN Numbers N
)
INSERT INTO Products
    (ProductName, Brand, CategoryID, SubCategory, UnitCost, SupplierID)
SELECT
    CASE CategoryName
        WHEN 'Laptops'
            THEN CONCAT('Performance Laptop ', ProductNumber)
        WHEN 'Smartphones'
            THEN CONCAT('Smartphone ', ProductNumber)
        WHEN 'Tablets'
            THEN CONCAT('Tablet ', ProductNumber)
        WHEN 'Accessories'
            THEN CONCAT('Computer Accessory ', ProductNumber)
        WHEN 'Televisions'
            THEN CONCAT('Smart TV ', ProductNumber)
        WHEN 'Men Clothing'
            THEN CONCAT('Men Casual Wear ', ProductNumber)
        WHEN 'Women Clothing'
            THEN CONCAT('Women Fashion Wear ', ProductNumber)
        WHEN 'Footwear'
            THEN CONCAT('Footwear ', ProductNumber)
        WHEN 'Furniture'
            THEN CONCAT('Furniture Item ', ProductNumber)
        WHEN 'Home Appliances'
            THEN CONCAT('Home Appliance ', ProductNumber)
    END AS ProductName,

    CASE (ProductNumber % 10)
        WHEN 1 THEN 'Samsung'
        WHEN 2 THEN 'Apple'
        WHEN 3 THEN 'Sony'
        WHEN 4 THEN 'Dell'
        WHEN 5 THEN 'HP'
        WHEN 6 THEN 'LG'
        WHEN 7 THEN 'Lenovo'
        WHEN 8 THEN 'Nike'
        WHEN 9 THEN 'Adidas'
        ELSE 'Philips'
    END AS Brand,

    CategoryID,

    CASE CategoryName
        WHEN 'Laptops' THEN 'Computers'
        WHEN 'Smartphones' THEN 'Mobile Phones'
        WHEN 'Tablets' THEN 'Portable Devices'
        WHEN 'Accessories' THEN 'Computer Accessories'
        WHEN 'Televisions' THEN 'Smart TVs'
        WHEN 'Men Clothing' THEN 'Men Fashion'
        WHEN 'Women Clothing' THEN 'Women Fashion'
        WHEN 'Footwear' THEN 'Shoes'
        WHEN 'Furniture' THEN 'Home Furniture'
        WHEN 'Home Appliances' THEN 'Kitchen Appliances'
    END AS SubCategory,

    CAST(
        CASE CategoryName
            WHEN 'Laptops' THEN 45000 + (ProductNumber * 2500)
            WHEN 'Smartphones' THEN 12000 + (ProductNumber * 3000)
            WHEN 'Tablets' THEN 15000 + (ProductNumber * 2000)
            WHEN 'Accessories' THEN 500 + (ProductNumber * 250)
            WHEN 'Televisions' THEN 25000 + (ProductNumber * 3500)
            WHEN 'Men Clothing' THEN 800 + (ProductNumber * 200)
            WHEN 'Women Clothing' THEN 900 + (ProductNumber * 250)
            WHEN 'Footwear' THEN 1200 + (ProductNumber * 300)
            WHEN 'Furniture' THEN 5000 + (ProductNumber * 1500)
            WHEN 'Home Appliances' THEN 3000 + (ProductNumber * 1000)
        END
        AS DECIMAL(12,2)
    ) AS UnitCost,

    NULL AS SupplierID

FROM ProductData;
GO









SELECT COUNT(*) AS CategoryCount
FROM Categories;
GO

SELECT COUNT(*) AS ProductCount
FROM Products;
GO

SELECT
    MIN(ProductID) AS FirstProductID,
    MAX(ProductID) AS LastProductID
FROM Products;


SELECT
    (SELECT COUNT(*) FROM Categories) AS Categories,
    (SELECT COUNT(*) FROM Customers) AS Customers,
    (SELECT COUNT(*) FROM Products) AS Products;