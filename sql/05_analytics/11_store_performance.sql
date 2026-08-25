USE CommercePulse_DW;
GO
SELECT S.StoreName,S.City,S.Region,COUNT(DISTINCT F.OrderID) AS OrderCount,SUM(F.Quantity) AS UnitsSold,
SUM(F.SalesAmount) AS TotalRevenue,SUM(F.SalesAmount)/COUNT(DISTINCT F.OrderID) AS AverageOrderValue
FROM FactSales F
INNER JOIN DimStore S ON F.StoreKey=S.StoreKey
GROUP BY S.StoreName,S.City,S.Region
ORDER BY TotalRevenue DESC;
GO