USE CommercePulse_DW;
GO

INSERT INTO FactPayment
(
    PaymentID,
    OrderID,
    CustomerKey,
    DateKey,
    PaymentMethodKey,
    PaymentAmount,
    PaymentStatus
)
SELECT
    P.PaymentID,
    P.OrderID,

    DC.CustomerKey,

    DD.DateKey,

    DPM.PaymentMethodKey,

    P.PaymentAmount,
    P.PaymentStatus

FROM CommercePulse_OLTP.dbo.Payments P

INNER JOIN CommercePulse_OLTP.dbo.Orders O
    ON P.OrderID = O.OrderID

INNER JOIN CommercePulse_DW.dbo.DimCustomer DC
    ON O.CustomerID = DC.CustomerID
    AND O.OrderDate >= DC.EffectiveDate
    AND (
        O.OrderDate < DC.EndDate
        OR DC.EndDate IS NULL
    )

INNER JOIN CommercePulse_DW.dbo.DimDate DD
    ON CAST(P.PaymentDate AS DATE) = DD.FullDate

INNER JOIN CommercePulse_DW.dbo.DimPaymentMethod DPM
    ON P.PaymentMethod = DPM.PaymentMethod;
GO


SELECT COUNT(*) AS FactPaymentCount
FROM FactPayment;
GO




SELECT
    PaymentStatus,
    COUNT(*) AS PaymentCount,
    SUM(PaymentAmount) AS TotalAmount
FROM CommercePulse_OLTP.dbo.Payments
GROUP BY PaymentStatus
ORDER BY PaymentStatus;


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
    SUM(S.TotalSales) AS TotalSales,
    SUM(P.SuccessfulPayments) AS SuccessfulPayments,
    SUM(P.SuccessfulPayments) - SUM(S.TotalSales) AS Difference
FROM SalesByOrder S
INNER JOIN PaymentsByOrder P
    ON S.OrderID = P.OrderID;