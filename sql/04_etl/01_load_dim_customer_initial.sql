USE CommercePulse_DW;
GO

INSERT INTO DimCustomer
(
    CustomerID,
    CustomerName,
    Email,
    Phone,
    City,
    State,
    Country,
    DateOfBirth,
    EffectiveDate,
    EndDate,
    IsCurrent
)
SELECT
    CustomerID,
    CustomerName,
    Email,
    Phone,
    City,
    State,
    Country,
    DateOfBirth,

    CAST(GETDATE() AS DATE) AS EffectiveDate,

    NULL AS EndDate,

    1 AS IsCurrent

FROM CommercePulse_OLTP.dbo.Customers;
GO

SELECT COUNT(*) AS DimCustomerCount
FROM DimCustomer;
GO
SELECT TOP 10
    CustomerKey,
    CustomerID,
    CustomerName,
    City,
    EffectiveDate,
    EndDate,
    IsCurrent
FROM DimCustomer
ORDER BY CustomerKey;
GO