-- Query to retrieve all bookings with user, property, and payment details

EXPLAIN
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
LEFT JOIN Payment pay ON b.booking_id = pay.booking_id
WHERE b.status = 'confirmed'
  AND p.city = 'New York'
ORDER BY b.booking_date DESC;
