USE CommercePulse_OLTP;
GO

CREATE TABLE Payments
(
    PaymentID BIGINT IDENTITY(1,1) PRIMARY KEY,
    OrderID BIGINT NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    PaymentDate DATETIME2 NOT NULL,
    PaymentAmount DECIMAL(12,2) NOT NULL,
    PaymentStatus VARCHAR(50) NOT NULL,

    CONSTRAINT FK_Payments_Orders
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID)
);
GO


SELECT *
FROM Payments;