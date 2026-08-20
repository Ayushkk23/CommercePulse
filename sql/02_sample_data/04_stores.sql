USE CommercePulse_OLTP;
GO

INSERT INTO Stores
    (StoreName, City, State, Country, Region, StoreType)
VALUES
    ('CommercePulse Pune Central', 'Pune', 'Maharashtra', 'India', 'West', 'Retail'),
    ('CommercePulse Mumbai Hub', 'Mumbai', 'Maharashtra', 'India', 'West', 'Retail'),
    ('CommercePulse Bengaluru Tech', 'Bengaluru', 'Karnataka', 'India', 'South', 'Retail'),
    ('CommercePulse Delhi Central', 'Delhi', 'Delhi', 'India', 'North', 'Retail'),
    ('CommercePulse Hyderabad Hub', 'Hyderabad', 'Telangana', 'India', 'South', 'Retail'),
    ('CommercePulse Chennai Store', 'Chennai', 'Tamil Nadu', 'India', 'South', 'Retail'),
    ('CommercePulse Kolkata East', 'Kolkata', 'West Bengal', 'India', 'East', 'Retail'),
    ('CommercePulse Ahmedabad Plaza', 'Ahmedabad', 'Gujarat', 'India', 'West', 'Retail'),
    ('CommercePulse Nagpur Central', 'Nagpur', 'Maharashtra', 'India', 'West', 'Retail'),
    ('CommercePulse Jaipur Store', 'Jaipur', 'Rajasthan', 'India', 'North', 'Retail');
GO


SELECT COUNT(*) AS StoreCount
FROM Stores;