To identify high-usage columns in your User, Booking, and Property tables, you want to look at the columns that are most frequently referenced in WHERE, JOIN, and ORDER BY clauses

1. User Table

Common high-usage columns:

user_id (Primary key, used in JOIN with Booking and Property)

email (Often used in WHERE lookups for login/authentication)

username (Sometimes used in search/filter queries)

created_at (Used in ORDER BY for showing latest users)

2. Booking Table

Common high-usage columns:

booking_id (Primary key)

user_id (Foreign key, frequently used in JOIN with User)

property_id (Foreign key, frequently used in JOIN with Property)

booking_date / check_in_date / check_out_date
(Used in WHERE to filter bookings by date, also used in ORDER BY)

status (Used in WHERE to filter e.g., confirmed, pending, cancelled)

3. Property Table

Common high-usage columns:

property_id (Primary key, used in JOIN with Booking)

owner_id (Foreign key, used in JOIN with User)

location / city / country (Used in WHERE filters for searching properties)

price_per_night (Used in WHERE filters and ORDER BY for sorting results)

created_at (Used in ORDER BY for showing latest listings)


Writing an SQL CREATE INDEX commands to create appropriate indexes for those columns and saved on database_index.sql
Here are the codes for that. -- Indexes for User table
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_username ON User(username);
CREATE INDEX idx_user_created_at ON User(created_at);

-- Indexes for Booking table
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_booking_date ON Booking(booking_date);
CREATE INDEX idx_booking_check_in_date ON Booking(check_in_date);
CREATE INDEX idx_booking_check_out_date ON Booking(check_out_date);
CREATE INDEX idx_booking_status ON Booking(status);

-- Indexes for Property table
CREATE INDEX idx_property_owner_id ON Property(owner_id);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_city ON Property(city);
CREATE INDEX idx_property_country ON Property(country);
CREATE INDEX idx_property_price_per_night ON Property(price_per_night);
CREATE INDEX idx_property_created_at ON Property(created_at);


Measuring the query performance before and after adding indexes using EXPLAIN or ANALYZE
1. Without Indexes

Run your query before creating the indexes:

EXPLAIN ANALYZE
SELECT b.booking_id, u.username, p.property_id, p.city
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
WHERE p.city = 'Lagos'
  AND b.check_in_date >= '2025-09-01'
  ORDER BY b.check_in_date DESC;


The output will show:
* Whether the database is doing sequential scans (Seq Scan)
* High cost estimates and execution time

2. Add Indexes

Apply the indexes from database_index.sql (for this example, the relevant ones are on Booking(check_in_date), Property(city), and foreign keys).

-- Example of specific helpful indexes
CREATE INDEX idx_booking_check_in_date ON Booking(check_in_date);
CREATE INDEX idx_property_city ON Property(city);
CREATE INDEX idx_booking_user_id_property_id ON Booking(user_id, property_id);

3. After Indexes

Run the same query again:

EXPLAIN ANALYZE
SELECT b.booking_id, u.username, p.property_id, p.city
FROM Booking b
JOIN User u ON b.user_id = u.user_id
JOIN Property p ON b.property_id = p.property_id
WHERE p.city = 'Lagos'
  AND b.check_in_date >= '2025-09-01'
  ORDER BY b.check_in_date DESC;

Now the output should show:
* Index Scan instead of Seq Scan
* Nested Loop with Indexes instead of Hash Joins / Sequential scans
* Reduced execution time
