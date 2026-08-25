USE CommercePulse_DW;
GO

INSERT INTO DimStore
(
    StoreID,
    StoreName,
    City,
    State,
    Country,
    Region,
    StoreType
)
SELECT
    StoreID,
    StoreName,
    City,
    State,
    Country,
    Region,
    StoreType
FROM CommercePulse_OLTP.dbo.Stores;
GO

SELECT COUNT(*) AS DimStoreCount
FROM DimStore;
GO 

SELECT *
FROM DimStore
ORDER BY StoreKey;
GO