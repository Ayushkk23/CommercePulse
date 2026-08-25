USE CommercePulse_DW;
GO

CREATE TABLE FactSales
(
    SalesKey INT IDENTITY(1,1) NOT NULL,

    OrderID INT NOT NULL,
    OrderItemID INT NOT NULL,

    CustomerKey INT NOT NULL,
    ProductKey INT NOT NULL,
    DateKey INT NOT NULL,
    StoreKey INT NOT NULL,

    Quantity INT NOT NULL,
    UnitPrice DECIMAL(12,2) NOT NULL,
    Discount DECIMAL(12,2) NOT NULL,
    SalesAmount DECIMAL(14,2) NOT NULL,

    CONSTRAINT PK_FactSales
        PRIMARY KEY (SalesKey),

    CONSTRAINT FK_FactSales_DimCustomer
        FOREIGN KEY (CustomerKey)
        REFERENCES DimCustomer(CustomerKey),

    CONSTRAINT FK_FactSales_DimProduct
        FOREIGN KEY (ProductKey)
        REFERENCES DimProduct(ProductKey),

    CONSTRAINT FK_FactSales_DimDate
        FOREIGN KEY (DateKey)
        REFERENCES DimDate(DateKey),

    CONSTRAINT FK_FactSales_DimStore
        FOREIGN KEY (StoreKey)
        REFERENCES DimStore(StoreKey)
);
GO

SELECT *
FROM FactSales;
GO

sp_help FactSales;
GO



USE CommercePulse_DW;
GO

