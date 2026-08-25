USE CommercePulse_DW;
GO

SELECT TOP 10
    C.CustomerID,
    MAX(C.CustomerName) AS CustomerName,
    COUNT(DISTINCT F.OrderID) AS OrderCount,
    SUM(F.Quantity) AS UnitsPurchased,
    SUM(F.SalesAmount) AS TotalRevenue
FROM FactSales F
INNER JOIN DimCustomer C
    ON F.CustomerKey = C.CustomerKey
GROUP BY
   C.CustomerID
ORDER BY
    TotalRevenue DESC;
GO