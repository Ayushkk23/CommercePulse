CREATE DATABASE CommercePulse_DW;
GO

SELECT
    name,
    create_date
FROM sys.databases
WHERE name = 'CommercePulse_DW';



USE CommercePulse_DW;
GO

UPDATE DimCustomer
SET
    EndDate = CAST(GETDATE() AS DATE),
    IsCurrent = 0
WHERE CustomerID = 101
  AND IsCurrent = 1;
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
WHERE CustomerID = 101;


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