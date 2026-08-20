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
OrderNumbers AS
(
    SELECT
        ROW_NUMBER() OVER (ORDER BY A.N, B.N, C.N) AS OrderNumber
    FROM Numbers A
    CROSS JOIN Numbers B
    CROSS JOIN Numbers C
),
CustomerList AS
(
    SELECT
        CustomerID,
        ROW_NUMBER() OVER (ORDER BY CustomerID) AS CustomerRow
    FROM Customers
),
StoreList AS
(
    SELECT
        StoreID,
        ROW_NUMBER() OVER (ORDER BY StoreID) AS StoreRow
    FROM Stores
)
INSERT INTO Orders
    (CustomerID, OrderDate, StoreID)
SELECT
    C.CustomerID,

    DATEADD(
        MINUTE,
        (O.OrderNumber * 137) % 525600,
        CAST('2025-01-01' AS datetime2)
    ) AS OrderDate,

    S.StoreID

FROM OrderNumbers O

INNER JOIN CustomerList C
    ON C.CustomerRow =
       ((O.OrderNumber - 1) % 100) + 1

INNER JOIN StoreList S
    ON S.StoreRow =
       ((O.OrderNumber - 1) % 10) + 1;
GO

SELECT
    COUNT(*) AS CustomerCount,
    MIN(CustomerID) AS MinCustomerID,
    MAX(CustomerID) AS MaxCustomerID
FROM Customers;
GO 
SELECT COUNT(*) AS OrderCount
FROM Orders;
GO

SELECT TOP 10
    O.OrderID,
    O.CustomerID,
    C.CustomerName,
    O.OrderDate,
    O.StoreID,
    S.StoreName
FROM Orders O
JOIN Customers C
    ON O.CustomerID = C.CustomerID
JOIN Stores S
    ON O.StoreID = S.StoreID
ORDER BY O.OrderID;