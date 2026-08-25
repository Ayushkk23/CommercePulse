USE CommercePulse_DW;
GO

CREATE TABLE FactPayment
(
    PaymentKey INT IDENTITY(1,1) NOT NULL,

    PaymentID INT NOT NULL,
    OrderID INT NOT NULL,

    CustomerKey INT NOT NULL,
    DateKey INT NOT NULL,
    PaymentMethodKey INT NOT NULL,

    PaymentAmount DECIMAL(14,2) NOT NULL,
    PaymentStatus VARCHAR(30) NOT NULL,

    CONSTRAINT PK_FactPayment
        PRIMARY KEY (PaymentKey),

    CONSTRAINT FK_FactPayment_DimCustomer
        FOREIGN KEY (CustomerKey)
        REFERENCES DimCustomer(CustomerKey),

    CONSTRAINT FK_FactPayment_DimDate
        FOREIGN KEY (DateKey)
        REFERENCES DimDate(DateKey),

    CONSTRAINT FK_FactPayment_DimPaymentMethod
        FOREIGN KEY (PaymentMethodKey)
        REFERENCES DimPaymentMethod(PaymentMethodKey)
);
GO


SELECT *
FROM FactPayment;
GO

sp_help FactPayment;
GO

SELECT COUNT(*) AS PaymentCount
FROM CommercePulse_OLTP.dbo.Payments;