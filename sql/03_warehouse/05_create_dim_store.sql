USE CommercePulse_DW;
GO

CREATE TABLE DimStore
(
    StoreKey INT IDENTITY(1,1) NOT NULL,
    StoreID INT NOT NULL,
    StoreName VARCHAR(150) NOT NULL,
    City VARCHAR(100) NULL,
    State VARCHAR(100) NULL,
    Country VARCHAR(100) NULL,
    Region VARCHAR(100) NULL,
    StoreType VARCHAR(50) NULL,

    CONSTRAINT PK_DimStore
        PRIMARY KEY (StoreKey)
);
GO


SELECT *
FROM DimStore;
GO

sp_help DimStore;
GO