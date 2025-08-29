--Using inner joins

SELECT bookings.id AS booking_id,
       bookings.item,
       users.name AS user_name
FROM bookings
INNER JOIN users ON bookings.user_id = users.id;



--Using Left joins

SELECT properties.id AS property_id,
       properties.name AS property_name,
       reviews.review_text
FROM properties
LEFT JOIN reviews ON properties.id = reviews.property_id; 


-- Using full outer joins

SELECT users.id AS user_id,
       users.name AS user_name,
       bookings.id AS booking_id,
       bookings.item
FROM users
FULL OUTER JOIN bookings ON users.id = bookings.user_id;
