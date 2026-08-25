USE CommercePulse_DW;
GO

INSERT INTO FactSales
(
    OrderID,
    OrderItemID,
    CustomerKey,
    ProductKey,
    DateKey,
    StoreKey,
    Quantity,
    UnitPrice,
    Discount,
    SalesAmount
)
SELECT
    O.OrderID,
    OI.OrderItemID,

    DC.CustomerKey,

    DP.ProductKey,

    DD.DateKey,

    DS.StoreKey,

    OI.Quantity,
    OI.UnitPrice,
    OI.Discount,

    OI.Quantity
        * OI.UnitPrice
        * (1 - OI.Discount) AS SalesAmount

FROM CommercePulse_OLTP.dbo.Orders O

INNER JOIN CommercePulse_OLTP.dbo.OrderItems OI
    ON O.OrderID = OI.OrderID

INNER JOIN CommercePulse_DW.dbo.DimCustomer DC
    ON O.CustomerID = DC.CustomerID
    AND O.OrderDate >= DC.EffectiveDate
    AND (
        O.OrderDate < DC.EndDate
        OR DC.EndDate IS NULL
    )

INNER JOIN CommercePulse_DW.dbo.DimProduct DP
    ON OI.ProductID = DP.ProductID

INNER JOIN CommercePulse_DW.dbo.DimDate DD
    ON CAST(O.OrderDate AS DATE) = DD.FullDate

INNER JOIN CommercePulse_DW.dbo.DimStore DS
    ON O.StoreID = DS.StoreID;
GO


SELECT COUNT(*) AS FactSalesCount
FROM FactSales;
GO

SELECT TOP 10
    SalesKey,
    OrderID,
    OrderItemID,
    CustomerKey,
    ProductKey,
    DateKey,
    StoreKey,
    Quantity,
    UnitPrice,
    Discount,
    SalesAmount
FROM FactSales
ORDER BY SalesKey;
GO


USE CommercePulse_DW;
GO

DELETE FROM FactSales;
GO

UPDATE DimCustomer
SET EffectiveDate = '2025-01-01'
WHERE CustomerID <> 101
  AND IsCurrent = 1;
GO

SELECT
    COUNT(*) AS CustomersWith2025EffectiveDate
FROM DimCustomer
WHERE EffectiveDate = '2025-01-01'
  AND IsCurrent = 1;
  GO


  SELECT
    CustomerKey,
    CustomerID,
    City,
    EffectiveDate,
    EndDate,
    IsCurrent
FROM DimCustomer
WHERE CustomerID = 101
ORDER BY EffectiveDate;
GO

SELECT COUNT(*) AS FactSalesCount
FROM FactSales;


USE CommercePulse_DW;
GO

INSERT INTO FactSales
(
    OrderID,
    OrderItemID,
    CustomerKey,
    ProductKey,
    DateKey,
    StoreKey,
    Quantity,
    UnitPrice,
    Discount,
    SalesAmount
)
SELECT
    O.OrderID,
    OI.OrderItemID,
    DC.CustomerKey,
    DP.ProductKey,
    DD.DateKey,
    DS.StoreKey,
    OI.Quantity,
    OI.UnitPrice,
    OI.Discount,
    OI.Quantity * OI.UnitPrice * (1 - OI.Discount) AS SalesAmount
FROM CommercePulse_OLTP.dbo.Orders O
INNER JOIN CommercePulse_OLTP.dbo.OrderItems OI
    ON O.OrderID = OI.OrderID
INNER JOIN CommercePulse_DW.dbo.DimCustomer DC
    ON O.CustomerID = DC.CustomerID
    AND O.OrderDate >= DC.EffectiveDate
    AND (
        O.OrderDate < DC.EndDate
        OR DC.EndDate IS NULL
    )
INNER JOIN CommercePulse_DW.dbo.DimProduct DP
    ON OI.ProductID = DP.ProductID
INNER JOIN CommercePulse_DW.dbo.DimDate DD
    ON CAST(O.OrderDate AS DATE) = DD.FullDate
INNER JOIN CommercePulse_DW.dbo.DimStore DS
    ON O.StoreID = DS.StoreID;
GO

SELECT COUNT(*) AS FactSalesCount
FROM FactSales;
