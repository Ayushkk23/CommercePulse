USE CommercePulse_DW;
GO
WITH MonthlyRevenue AS
(
SELECT D.Year,D.MonthNumber,D.MonthName,SUM(F.SalesAmount) AS TotalRevenue
FROM FactSales F
INNER JOIN DimDate D ON F.DateKey=D.DateKey
GROUP BY D.Year,D.MonthNumber,D.MonthName
)
SELECT Year,MonthNumber,MonthName,TotalRevenue,RANK() OVER(ORDER BY TotalRevenue DESC) AS RevenueRank
FROM MonthlyRevenue
ORDER BY RevenueRank;
GO