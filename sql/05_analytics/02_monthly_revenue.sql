USE CommercePulse_DW;
GO

SELECT
    D.Year,
    D.MonthNumber,
    D.MonthName,

    SUM(F.SalesAmount) AS TotalRevenue,

    COUNT(DISTINCT F.OrderID) AS OrderCount,

    SUM(F.SalesAmount) /
        COUNT(DISTINCT F.OrderID) AS AverageOrderValue

FROM FactSales F

INNER JOIN DimDate D
    ON F.DateKey = D.DateKey

GROUP BY
    D.Year,
    D.MonthNumber,
    D.MonthName

ORDER BY
    D.Year,
    D.MonthNumber;
GO