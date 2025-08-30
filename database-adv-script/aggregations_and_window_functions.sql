-- find the total number of bookings made by each user

SELECT user_id,
       COUNT(*) AS total_bookings
FROM bookings
GROUP BY user_id;



-- Using window function (ROW_NUMBER, RANK) to rank properties based on bookings

SELECT 
    properties.id AS property_id,
    properties.name AS property_name,
    COUNT(bookings.id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(bookings.id) DESC) AS row_number_rank,
    RANK() OVER (ORDER BY COUNT(bookings.id) DESC) AS rank_with_ties
FROM properties properties
LEFT JOIN bookings 
    ON properties.id = bookings.property_id
GROUP BY properties.id, properties.name
ORDER BY total_bookings DESC;
