USE CommercePulse_DW;
GO
WITH CustomerRevenue AS
(
SELECT C.CustomerID,MAX(C.CustomerName) AS CustomerName,SUM(F.SalesAmount) AS TotalRevenue,COUNT(DISTINCT F.OrderID) AS OrderCount
FROM FactSales F
INNER JOIN DimCustomer C ON F.CustomerKey=C.CustomerKey
GROUP BY C.CustomerID
)
SELECT CustomerID,CustomerName,OrderCount,TotalRevenue,
CASE
WHEN TotalRevenue>=5000000 THEN 'High Value'
WHEN TotalRevenue>=2000000 THEN 'Medium Value'
ELSE 'Low Value'
END AS CustomerSegment
FROM CustomerRevenue
ORDER BY TotalRevenue DESC;
GO