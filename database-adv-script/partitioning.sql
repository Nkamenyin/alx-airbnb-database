-- Partitioning script for Booking table (PostgreSQL)
-- Assumptions:
-- 1) You're using PostgreSQL 11+ (declarative partitioning). Adjust syntax for other DBs.
-- 2) Booking table has a 'start_date' column of type DATE (or TIMESTAMP/date-compatible).
-- 3) Test in a staging environment before running in production. This script moves data
--    from the existing Booking table into a new partitioned Booking table.
-- 4) Adjust partition ranges based on your data distribution (monthly/quarterly/yearly).

BEGIN;

	-- 1) Rename existing table to keep a safe copy (no data is lost yet)
	ALTER TABLE Booking RENAME TO booking_old;

	-- 2) Create a new partitioned parent table (schema should match existing Booking table)
	CREATE TABLE Booking (
		    booking_id BIGINT PRIMARY KEY,
		    user_id BIGINT NOT NULL,
		    property_id BIGINT NOT NULL,
		    booking_date TIMESTAMP,
		    start_date DATE NOT NULL,
		    end_date DATE,
		    check_in_date DATE,
		    check_out_date DATE,
		    status TEXT,
		    -- add other columns here as needed...
		        -- foreign key constraints can be re-created after migration if desired
			    created_at TIMESTAMP,
			    updated_at TIMESTAMP
		) PARTITION BY RANGE (start_date);

		-- 3) Create partitions (example: yearly partitions). Add more as needed.
	CREATE TABLE Booking_2022 PARTITION OF Booking
		FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

	CREATE TABLE Booking_2023 PARTITION OF Booking
		FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

	CREATE TABLE Booking_2024 PARTITION OF Booking
		FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

	CREATE TABLE Booking_2025 PARTITION OF Booking
		FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

	-- Default partition to catch older/newer dates outside the explicit ranges
	CREATE TABLE Booking_default PARTITION OF Booking DEFAULT;

	-- 5) Migrate data from old table to the new partitioned table.
-- This INSERT routes rows into the appropriate partitions automatically.
INSERT INTO Booking
SELECT * FROM booking_old;
