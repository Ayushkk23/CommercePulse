USE CommercePulse_OLTP;
GO

INSERT INTO Categories
    (CategoryName, Department)
VALUES
    ('Laptops', 'Electronics'),
    ('Smartphones', 'Electronics'),
    ('Tablets', 'Electronics'),
    ('Accessories', 'Electronics'),
    ('Televisions', 'Electronics'),
    ('Men Clothing', 'Fashion'),
    ('Women Clothing', 'Fashion'),
    ('Footwear', 'Fashion'),
    ('Furniture', 'Home'),
    ('Home Appliances', 'Home');
GO

SELECT *
FROM Categories;
GO

SELECT COUNT(*) AS CategoryCount
FROM Categories;
GO