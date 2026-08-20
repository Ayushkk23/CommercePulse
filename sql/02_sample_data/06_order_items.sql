USE CommercePulse_OLTP;
GO

WITH Numbers AS
(
    SELECT 1 AS N
    UNION ALL SELECT 2
    UNION ALL SELECT 3
),
OrderList AS
(
    SELECT
        OrderID,
        ROW_NUMBER() OVER (ORDER BY OrderID) AS OrderRow
    FROM Orders
),
ProductList AS
(
    SELECT
        ProductID,
        UnitCost,
        ROW_NUMBER() OVER (ORDER BY ProductID) AS ProductRow
    FROM Products
),
OrderLines AS
(
    SELECT
        O.OrderID,
        O.OrderRow,
        N.N AS LineNumber
    FROM OrderList O
    CROSS JOIN Numbers N
    WHERE
        (O.OrderRow <= 500 AND N.N <= 3)
        OR
        (O.OrderRow > 500 AND N.N <= 2)
)
INSERT INTO OrderItems
    (OrderID, ProductID, Quantity, UnitPrice, Discount)
SELECT
    OL.OrderID,

    P.ProductID,

    1 + ((OL.OrderRow + OL.LineNumber) % 5) AS Quantity,

    CAST(
        P.UnitCost *
        (
            1.15 +
            ((OL.LineNumber * 5) / 100.0)
        )
        AS DECIMAL(12,2)
    ) AS UnitPrice,

    CAST(
        CASE
            WHEN OL.OrderRow % 10 = 0 THEN 0.10
            WHEN OL.OrderRow % 5 = 0 THEN 0.05
            ELSE 0.00
        END
        AS DECIMAL(12,2)
    ) AS Discount

FROM OrderLines OL

INNER JOIN ProductList P
    ON P.ProductRow =
       ((OL.OrderRow * 3 + OL.LineNumber) % 100) + 1;
GO

SELECT COUNT(*) AS OrderItemCount
FROM OrderItems;
GO
SELECT
    COUNT(*) AS OrderItemCount,
    COUNT(DISTINCT OrderID) AS OrdersWithItems,
    COUNT(DISTINCT ProductID) AS ProductsUsed
FROM OrderItems;
GO
SELECT TOP 10
    OI.OrderItemID,
    OI.OrderID,
    OI.ProductID,
    P.ProductName,
    OI.Quantity,
    OI.UnitPrice,
    OI.Discount
FROM OrderItems OI
JOIN Products P
    ON OI.ProductID = P.ProductID
ORDER BY OI.OrderItemID;
GO