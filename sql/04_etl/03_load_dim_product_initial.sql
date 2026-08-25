USE CommercePulse_DW;
GO

INSERT INTO DimProduct
(
    ProductID,
    ProductName,
    Brand,
    CategoryID,
    SubCategory,
    UnitCost,
    SupplierID
)
SELECT
    ProductID,
    ProductName,
    Brand,
    CategoryID,
    SubCategory,
    UnitCost,
    SupplierID
FROM CommercePulse_OLTP.dbo.Products;
GO


SELECT COUNT(*) AS DimProductCount
FROM DimProduct;

SELECT TOP 10
    ProductKey,
    ProductID,
    ProductName,
    Brand,
    CategoryID,
    UnitCost
FROM DimProduct
ORDER BY ProductKey;