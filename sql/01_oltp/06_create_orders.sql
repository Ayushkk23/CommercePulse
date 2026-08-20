USE CommercePulse_OLTP;
GO

CREATE TABLE Orders
(
    OrderID BIGINT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME2 NOT NULL,
    StoreID INT NOT NULL,

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID),

    CONSTRAINT FK_Orders_Stores
        FOREIGN KEY (StoreID)
        REFERENCES Stores(StoreID)
);
GO

SELECT *
FROM Orders;