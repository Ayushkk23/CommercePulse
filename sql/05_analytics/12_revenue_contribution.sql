USE CommercePulse_DW;
GO
WITH RegionRevenue AS
(
SELECT S.Region,SUM(F.SalesAmount) AS TotalRevenue
FROM FactSales F
INNER JOIN DimStore S ON F.StoreKey=S.StoreKey
GROUP BY S.Region
)
SELECT Region,TotalRevenue,TotalRevenue/SUM(TotalRevenue) OVER()*100 AS RevenueContributionPercent
FROM RegionRevenue
ORDER BY RevenueContributionPercent DESC;
GO