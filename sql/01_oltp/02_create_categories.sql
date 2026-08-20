USE CommercePulse_OLTP;
GO

CREATE TABLE Categories
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL,
    Department VARCHAR(100) NOT NULL
);
GO

SELECT *
FROM Categories;