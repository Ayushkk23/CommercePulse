USE CommercePulse_OLTP;
GO

WITH OrderTotals AS
(
    SELECT
        O.OrderID,
        O.OrderDate,
        SUM(
            OI.Quantity
            * OI.UnitPrice
            * (1 - OI.Discount)
        ) AS OrderTotal
    FROM Orders O
    INNER JOIN OrderItems OI
        ON O.OrderID = OI.OrderID
    GROUP BY
        O.OrderID,
        O.OrderDate
),
OrderList AS
(
    SELECT
        OrderID,
        OrderDate,
        OrderTotal,
        ROW_NUMBER() OVER (ORDER BY OrderID) AS OrderRow
    FROM OrderTotals
),
PaymentNumbers AS
(
    SELECT 1 AS PaymentNumber
    UNION ALL SELECT 2
    UNION ALL SELECT 3
    UNION ALL SELECT 4
    UNION ALL SELECT 5
    UNION ALL SELECT 6
    UNION ALL SELECT 7
    UNION ALL SELECT 8
    UNION ALL SELECT 9
    UNION ALL SELECT 10
),
PaymentRows AS
(
    SELECT
        O.OrderID,
        O.OrderDate,
        O.OrderTotal,
        O.OrderRow,
        P.PaymentNumber
    FROM OrderList O
    CROSS JOIN PaymentNumbers P
    WHERE
        P.PaymentNumber = 1
        OR
        (
            P.PaymentNumber = 2
            AND O.OrderRow <= 200
        )
)
INSERT INTO Payments
    (OrderID, PaymentMethod, PaymentDate, PaymentAmount, PaymentStatus)
SELECT
    OrderID,

    CASE PaymentNumber % 5
        WHEN 1 THEN 'UPI'
        WHEN 2 THEN 'Credit Card'
        WHEN 3 THEN 'Debit Card'
        WHEN 4 THEN 'Net Banking'
        ELSE 'Cash on Delivery'
    END AS PaymentMethod,

    DATEADD(
        MINUTE,
        PaymentNumber * 15,
        OrderDate
    ) AS PaymentDate,

    CAST(OrderTotal AS DECIMAL(12,2)) AS PaymentAmount,

    CASE
        WHEN PaymentNumber = 2 THEN
            CASE
                WHEN OrderRow % 4 = 0 THEN 'Failed'
                WHEN OrderRow % 7 = 0 THEN 'Pending'
                ELSE 'Success'
            END
        ELSE
            CASE
                WHEN OrderRow % 20 = 0 THEN 'Pending'
                ELSE 'Success'
            END
    END AS PaymentStatus

FROM PaymentRows;
GO


SELECT COUNT(*) AS PaymentCount
FROM Payments;
GO
SELECT
    COUNT(*) AS PaymentCount,
    COUNT(DISTINCT OrderID) AS OrdersWithPayments,
    COUNT(DISTINCT PaymentMethod) AS PaymentMethods,
    COUNT(DISTINCT PaymentStatus) AS PaymentStatuses
FROM Payments;
GO

SELECT TOP 15
    P.PaymentID,
    P.OrderID,
    P.PaymentMethod,
    P.PaymentDate,
    P.PaymentAmount,
    P.PaymentStatus
FROM Payments P
ORDER BY P.PaymentID;
GO