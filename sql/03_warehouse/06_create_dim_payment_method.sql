USE CommercePulse_DW;
GO

CREATE TABLE DimPaymentMethod
(
    PaymentMethodKey INT IDENTITY(1,1) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,

    CONSTRAINT PK_DimPaymentMethod
        PRIMARY KEY (PaymentMethodKey),

    CONSTRAINT UQ_DimPaymentMethod
        UNIQUE (PaymentMethod)
);
GO

SELECT *
FROM DimPaymentMethod;
GO