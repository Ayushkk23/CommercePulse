USE CommercePulse_DW;
GO

WITH SalesByOrder AS
(
    SELECT
        OrderID,
        SUM(SalesAmount) AS TotalSales
    FROM FactSales
    GROUP BY OrderID
),
PaymentsByOrder AS
(
    SELECT
        OrderID,
        SUM(
            CASE
                WHEN PaymentStatus = 'Success'
                THEN PaymentAmount
                ELSE 0
            END
        ) AS SuccessfulPayments
    FROM FactPayment
    GROUP BY OrderID
)
SELECT
    S.OrderID,
    S.TotalSales,
    P.SuccessfulPayments,
    P.SuccessfulPayments - S.TotalSales AS PaymentDifference
FROM SalesByOrder S
INNER JOIN PaymentsByOrder P
    ON S.OrderID = P.OrderID
WHERE P.SuccessfulPayments > S.TotalSales
ORDER BY PaymentDifference DESC;
GO


USE CommercePulse_DW;
GO

WITH SalesByOrder AS
(
    SELECT
        OrderID,
        SUM(SalesAmount) AS TotalSales
    FROM FactSales
    GROUP BY OrderID
),
PaymentsByOrder AS
(
    SELECT
        OrderID,
        SUM(
            CASE
                WHEN PaymentStatus = 'Success'
                THEN PaymentAmount
                ELSE 0
            END
        ) AS SuccessfulPayments
    FROM FactPayment
    GROUP BY OrderID
),
Reconciliation AS
(
    SELECT
        S.OrderID,
        S.TotalSales,
        P.SuccessfulPayments,
        P.SuccessfulPayments - S.TotalSales AS PaymentDifference
    FROM SalesByOrder S
    INNER JOIN PaymentsByOrder P
        ON S.OrderID = P.OrderID
)
SELECT
    COUNT(*) AS OrdersChecked,

    SUM(
        CASE
            WHEN SuccessfulPayments > TotalSales
            THEN 1
            ELSE 0
        END
    ) AS OrdersWithPaymentExceptions,

    SUM(TotalSales) AS TotalSales,

    SUM(SuccessfulPayments) AS TotalSuccessfulPayments,

    SUM(
        CASE
            WHEN SuccessfulPayments > TotalSales
            THEN PaymentDifference
            ELSE 0
        END
    ) AS TotalExcessPayment

FROM Reconciliation;
GO