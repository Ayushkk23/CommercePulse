USE CommercePulse_DW;
GO

CREATE TABLE DimCustomer
(
    CustomerKey INT IDENTITY(1,1) NOT NULL,
    CustomerID INT NOT NULL,
    CustomerName VARCHAR(150) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Phone VARCHAR(20) NULL,
    City VARCHAR(100) NULL,
    State VARCHAR(100) NULL,
    Country VARCHAR(100) NULL,
    DateOfBirth DATE NULL,

    EffectiveDate DATE NOT NULL,
    EndDate DATE NULL,
    IsCurrent BIT NOT NULL,

    CONSTRAINT PK_DimCustomer
        PRIMARY KEY (CustomerKey)
);
GO

SELECT *
FROM DimCustomer;
GO

sp_help DimCustomer;
GO