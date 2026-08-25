USE CommercePulse_DW;
GO

DECLARE @StartDate DATE = '2024-01-01';
DECLARE @EndDate DATE = '2026-12-31';

;WITH DateSeries AS
(
    SELECT @StartDate AS FullDate

    UNION ALL

    SELECT DATEADD(DAY, 1, FullDate)
    FROM DateSeries
    WHERE FullDate < @EndDate
)
INSERT INTO DimDate
(
    DateKey,
    FullDate,
    [Year],
    QuarterNumber,
    MonthNumber,
    MonthName,
    WeekOfYear,
    DayOfMonth,
    DayName,
    IsWeekend
)
SELECT
    CONVERT(INT, CONVERT(VARCHAR(8), FullDate, 112)) AS DateKey,
    FullDate,
    YEAR(FullDate),
    DATEPART(QUARTER, FullDate),
    MONTH(FullDate),
    DATENAME(MONTH, FullDate),
    DATEPART(WEEK, FullDate),
    DAY(FullDate),
    DATENAME(WEEKDAY, FullDate),
    CASE
        WHEN DATEPART(WEEKDAY, FullDate) IN (1, 7) THEN 1
        ELSE 0
    END
FROM DateSeries
OPTION (MAXRECURSION 0);
GO


SELECT COUNT(*) AS DateCount
FROM DimDate;
GO

SELECT TOP 5 *
FROM DimDate
ORDER BY FullDate;
GO
SELECT TOP 5 *
FROM DimDate
ORDER BY FullDate DESC;
GO