USE CommercePulse_DW;
GO

UPDATE DW
SET
    DW.EndDate = CAST(GETDATE() AS DATE),
    DW.IsCurrent = 0
FROM CommercePulse_DW.dbo.DimCustomer DW
INNER JOIN CommercePulse_OLTP.dbo.Customers SRC
    ON DW.CustomerID = SRC.CustomerID
WHERE DW.IsCurrent = 1
  AND (
        ISNULL(DW.CustomerName, '') <> ISNULL(SRC.CustomerName, '')
        OR ISNULL(DW.Email, '') <> ISNULL(SRC.Email, '')
        OR ISNULL(DW.Phone, '') <> ISNULL(SRC.Phone, '')
        OR ISNULL(DW.City, '') <> ISNULL(SRC.City, '')
        OR ISNULL(DW.State, '') <> ISNULL(SRC.State, '')
        OR ISNULL(DW.Country, '') <> ISNULL(SRC.Country, '')
        OR ISNULL(DW.DateOfBirth, '1900-01-01')
           <> ISNULL(SRC.DateOfBirth, '1900-01-01')
      );
GO

SELECT
    CustomerKey,
    CustomerID,
    CustomerName,
    City,
    EffectiveDate,
    EndDate,
    IsCurrent
FROM DimCustomer
WHERE CustomerID = 101
ORDER BY CustomerKey;


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
    SRC.CustomerID,
    SRC.CustomerName,
    SRC.Email,
    SRC.Phone,
    SRC.City,
    SRC.State,
    SRC.Country,
    SRC.DateOfBirth,
    CAST(GETDATE() AS DATE),
    NULL,
    1
FROM CommercePulse_OLTP.dbo.Customers SRC
LEFT JOIN CommercePulse_DW.dbo.DimCustomer DW
    ON SRC.CustomerID = DW.CustomerID
    AND DW.IsCurrent = 1
WHERE DW.CustomerKey IS NULL;
GO

SELECT
    CustomerKey,
    CustomerID,
    CustomerName,
    City,
    EffectiveDate,
    EndDate,
    IsCurrent
FROM DimCustomer
WHERE CustomerID = 101
ORDER BY CustomerKey;





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
    'Pune',
    State,
    Country,
    DateOfBirth,
    '2025-01-01',
    '2025-07-01',
    0
FROM CommercePulse_OLTP.dbo.Customers
WHERE CustomerID = 101;

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
    'Mumbai',
    State,
    Country,
    DateOfBirth,
    '2025-07-01',
    NULL,
    1
FROM CommercePulse_OLTP.dbo.Customers
WHERE CustomerID = 101;
GO


SELECT
    CustomerKey,
    CustomerID,
    CustomerName,
    City,
    EffectiveDate,
    EndDate,
    IsCurrent
FROM DimCustomer
WHERE CustomerID = 101
ORDER BY EffectiveDate;