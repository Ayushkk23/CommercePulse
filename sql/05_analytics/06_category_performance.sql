USE CommercePulse_DW;
GO
SELECT
    C.CategoryName,
    COUNT(DISTINCT F.OrderID) AS OrderCount,
    SUM(F.Quantity) AS UnitsSold,
    SUM(F.SalesAmount) AS TotalRevenue,
    SUM(F.SalesAmount) /
        COUNT(DISTINCT F.OrderID) AS AverageOrderValue
FROM FactSales F
INNER JOIN DimProduct P
    ON F.ProductKey = P.ProductKey
INNER JOIN CommercePulse_OLTP.dbo.Categories C
    ON P.CategoryID = C.CategoryID
GROUP BY
    C.CategoryName
ORDER BY
    TotalRevenue DESC;
GO