USE CommercePulse_DW;
GO

INSERT INTO DimPaymentMethod
(
    PaymentMethod
)
SELECT DISTINCT
    PaymentMethod
FROM CommercePulse_OLTP.dbo.Payments
WHERE PaymentMethod IS NOT NULL;
GO

SELECT *
FROM DimPaymentMethod
ORDER BY PaymentMethodKey;
GO

SELECT COUNT(*) AS PaymentMethodCount
FROM DimPaymentMethod;
GO