USE CommercePulse_OLTP;
GO

WITH FirstNames AS
(
    SELECT 'Rahul' AS FirstName
    UNION ALL SELECT 'Priya'
    UNION ALL SELECT 'Amit'
    UNION ALL SELECT 'Sneha'
    UNION ALL SELECT 'Rohan'
    UNION ALL SELECT 'Neha'
    UNION ALL SELECT 'Arjun'
    UNION ALL SELECT 'Pooja'
    UNION ALL SELECT 'Vikram'
    UNION ALL SELECT 'Ananya'
),
LastNames AS
(
    SELECT 'Sharma' AS LastName
    UNION ALL SELECT 'Patil'
    UNION ALL SELECT 'Deshmukh'
    UNION ALL SELECT 'Kulkarni'
    UNION ALL SELECT 'Joshi'
    UNION ALL SELECT 'Shinde'
    UNION ALL SELECT 'Pawar'
    UNION ALL SELECT 'Mehta'
    UNION ALL SELECT 'Kapoor'
    UNION ALL SELECT 'Nair'
),
CustomersToInsert AS
(
    SELECT
        ROW_NUMBER() OVER (ORDER BY FirstName, LastName) AS RowNum,
        CONCAT(FirstName, ' ', LastName) AS CustomerName
    FROM FirstNames
    CROSS JOIN LastNames
)
INSERT INTO Customers
    (CustomerName, Email, Phone, City, State, Country, DateOfBirth)
SELECT
    CustomerName,

    LOWER(REPLACE(CustomerName, ' ', '.'))
        + RIGHT('00' + CONVERT(VARCHAR(10), RowNum), 2)
        + '@commercepulse.test',

    '900000' + RIGHT('0000' + CONVERT(VARCHAR(10), RowNum), 4),

    CASE
        WHEN RowNum <= 10 THEN 'Pune'
        WHEN RowNum <= 20 THEN 'Mumbai'
        WHEN RowNum <= 30 THEN 'Bengaluru'
        WHEN RowNum <= 40 THEN 'Delhi'
        WHEN RowNum <= 50 THEN 'Hyderabad'
        WHEN RowNum <= 60 THEN 'Chennai'
        WHEN RowNum <= 70 THEN 'Kolkata'
        WHEN RowNum <= 80 THEN 'Ahmedabad'
        WHEN RowNum <= 90 THEN 'Nagpur'
        WHEN RowNum = 91 THEN 'London'
        WHEN RowNum = 92 THEN 'Dubai'
        WHEN RowNum = 93 THEN 'Singapore'
        WHEN RowNum = 94 THEN 'Toronto'
        WHEN RowNum = 95 THEN 'Sydney'
        WHEN RowNum = 96 THEN 'New York'
        WHEN RowNum = 97 THEN 'Berlin'
        WHEN RowNum = 98 THEN 'Paris'
        WHEN RowNum = 99 THEN 'Tokyo'
        ELSE 'Melbourne'
    END,

    CASE
        WHEN RowNum <= 20 THEN 'Maharashtra'
        WHEN RowNum <= 30 THEN 'Karnataka'
        WHEN RowNum <= 40 THEN 'Delhi'
        WHEN RowNum <= 50 THEN 'Telangana'
        WHEN RowNum <= 60 THEN 'Tamil Nadu'
        WHEN RowNum <= 70 THEN 'West Bengal'
        WHEN RowNum <= 80 THEN 'Gujarat'
        WHEN RowNum <= 90 THEN 'Maharashtra'
        ELSE 'International'
    END,

    CASE
        WHEN RowNum <= 90 THEN 'India'
        WHEN RowNum = 91 THEN 'United Kingdom'
        WHEN RowNum = 92 THEN 'United Arab Emirates'
        WHEN RowNum = 93 THEN 'Singapore'
        WHEN RowNum = 94 THEN 'Canada'
        WHEN RowNum = 95 THEN 'Australia'
        WHEN RowNum = 96 THEN 'United States'
        WHEN RowNum = 97 THEN 'Germany'
        WHEN RowNum = 98 THEN 'France'
        WHEN RowNum = 99 THEN 'Japan'
        ELSE 'Australia'
    END,

    DATEADD(
        DAY,
        -(RowNum * 137) % 12000,
        CAST('2025-01-01' AS DATE)
    )

FROM CustomersToInsert;
GO

SELECT COUNT(*) AS CustomerCount
FROM Customers; 
GO 

SELECT TOP 10 *
FROM Customers
ORDER BY CustomerID
GO 

sp_help Products;