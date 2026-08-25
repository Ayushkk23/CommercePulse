USE CommercePulse_DW;
GO
CREATE NONCLUSTERED INDEX IX_FactSales_StoreKey
ON FactSales(StoreKey)
INCLUDE(SalesAmount);
GO


SET STATISTICS IO ON;
SET STATISTICS TIME ON;
SELECT StoreKey,SUM(SalesAmount) AS TotalRevenue
FROM FactSales
GROUP BY StoreKey;
GO
SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;


USE CommercePulse_DW;
GO
SELECT StoreKey,SUM(SalesAmount) AS TotalRevenue
FROM FactSales
GROUP BY StoreKey;
GO