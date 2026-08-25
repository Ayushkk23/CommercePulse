USE CommercePulse_DW;
GO

SELECT TOP 10
    P.ProductKey,
    P.ProductName,
    P.Brand,

    SUM(F.Quantity) AS UnitsSold,

    COUNT(DISTINCT F.OrderID) AS OrderCount,

    SUM(F.SalesAmount) AS TotalRevenue,

    SUM(F.SalesAmount) /
        NULLIF(SUM(F.Quantity), 0) AS RevenuePerUnit

FROM FactSales F

INNER JOIN DimProduct P
    ON F.ProductKey = P.ProductKey

GROUP BY
    P.ProductKey,
    P.ProductName,
    P.Brand

ORDER BY
    TotalRevenue DESC;
GO