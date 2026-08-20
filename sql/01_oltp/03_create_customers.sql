USE CommercePulse_OLTP;
GO

CREATE TABLE Customers
(
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName VARCHAR(150) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Phone VARCHAR(20),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    DateOfBirth DATE,
    Gender VARCHAR(20)
);
GO

SELECT *
FROM Customers;