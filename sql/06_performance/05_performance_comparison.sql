USE CommercePulse_DW;
GO
-- BEFORE INDEX
-- Logical reads: 24
-- Physical reads: 1
-- Elapsed time: 8 ms
-- Execution plan: Clustered Index Scan + Hash Match
-- AFTER INDEX
-- Logical reads: 10
-- Physical reads: 1
-- Elapsed time: 2 ms
-- Execution plan: Nonclustered Index Scan + Stream Aggregate
-- INDEX SEEK TEST
-- StoreKey = 2
-- Rows accessed: 250 of 2500
-- Execution plan: Nonclustered Index Seek + Stream Aggregate
-- COVERING INDEX
-- Key Lookup: None
-- StoreKey and SalesAmount are available from the index
GO