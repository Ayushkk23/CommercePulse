USE CommercePulse_DW;
GO
WITH ProductRevenue AS
(
SELECT P.ProductKey,P.ProductName,P.CategoryID,SUM(F.SalesAmount) AS TotalRevenue
FROM FactSales F
INNER JOIN DimProduct P ON F.ProductKey=P.ProductKey
GROUP BY P.ProductKey,P.ProductName,P.CategoryID
),
RankedProducts AS
(
SELECT ProductKey,ProductName,CategoryID,TotalRevenue,RANK() OVER(PARTITION BY CategoryID ORDER BY TotalRevenue DESC) AS ProductRank
FROM ProductRevenue
)
SELECT R.ProductKey,R.ProductName,C.CategoryName,R.TotalRevenue,R.ProductRank
FROM RankedProducts R
INNER JOIN CommercePulse_OLTP.dbo.Categories C ON R.CategoryID=C.CategoryID
WHERE R.ProductRank<=3
ORDER BY C.CategoryName,R.ProductRank;
GO