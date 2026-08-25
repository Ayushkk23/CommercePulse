USE CommercePulse_DW;
GO

CREATE TABLE DimProduct
(
    ProductKey INT IDENTITY(1,1) NOT NULL,
    ProductID INT NOT NULL,
    ProductName VARCHAR(200) NOT NULL,
    Brand VARCHAR(100) NULL,
    CategoryID INT NOT NULL,
    SubCategory VARCHAR(100) NULL,
    UnitCost DECIMAL(12,2) NOT NULL,
    SupplierID INT NULL,

    CONSTRAINT PK_DimProduct
        PRIMARY KEY (ProductKey)
);
GO


SELECT *
FROM DimProduct;

sp_help DimProduct;