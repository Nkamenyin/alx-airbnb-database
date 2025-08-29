-- find the total number of bookings made by each user

SELECT user_id,
       COUNT(*) AS total_bookings
FROM bookings
GROUP BY user_id;



-- Using window function (ROW_NUMBER, RANK) to rank properties based on bookings

SELECT 
    property_id,
    COUNT(*) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS booking_rank
FROM bookings
GROUP BY property_id;
