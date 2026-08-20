USE CommercePulse_OLTP;
GO

CREATE TABLE OrderItems
(
    OrderItemID BIGINT IDENTITY(1,1) PRIMARY KEY,
    OrderID BIGINT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(12,2) NOT NULL,
    Discount DECIMAL(12,2) NOT NULL DEFAULT 0,

    CONSTRAINT FK_OrderItems_Orders
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID),

    CONSTRAINT FK_OrderItems_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);
GO

SELECT *
FROM OrderItems;