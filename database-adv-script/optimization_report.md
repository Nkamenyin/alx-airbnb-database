Here’s the query again:
SELECT
    b.booking_id,
    b.booking_date,
    b.check_in_date,
    b.check_out_date,
    b.status,
    u.user_id,
    u.username,
    u.email,
    p.property_id,
    p.city,
    p.country,
    p.price_per_night,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_status
    FROM Booking b
    JOIN User u ON b.user_id = u.user_id
    JOIN Property p ON b.property_id = p.property_id
    LEFT JOIN Payment pay ON b.booking_id = pay.booking_id;


    Then RUN EXPLAIN
Problems in Original Query

* Unnecessary columns: selecting everything from User, Property, Payment → larger result set and slower joins.
* Unconditional joins: always joining all tables, even if not needed.
* No filtering: fetching all rows always forces full scans (even with indexes)

Refactored Query (Optimized)

Here’s a leaner query that:
* Selects only useful columns
* Uses indexed join keys
Allows filtering by status, date, or city (common business queries)


-- Optimized query with fewer columns and filtering
SELECT
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    b.status,
    u.username,
    p.city,
    p.price_per_night,
    pay.amount,
    pay.payment_status
    FROM Booking b
    JOIN User u 
    ON b.user_id = u.user_id
    JOIN Property p 
    ON b.property_id = p.property_id
    LEFT JOIN Payment pay 
    ON b.booking_id = pay.booking_id
    WHERE b.status = 'confirmed'
    AND p.city = 'Lagos'
    AND b.check_in_date >= CURRENT_DATE
    ORDER BY b.check_in_date DESC;
