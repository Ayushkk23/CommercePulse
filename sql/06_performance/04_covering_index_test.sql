USE CommercePulse_DW;
GO
SELECT StoreKey,SUM(SalesAmount) AS TotalRevenue
FROM FactSales
WHERE StoreKey=2
GROUP BY StoreKey;
GO