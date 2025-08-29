--Writing queries for properties with above 4.0 ratings


SELECT id, name
FROM properties
WHERE id IN (
	    SELECT property_id
	    FROM reviews
	    GROUP BY property_id
	    HAVING AVG(rating) > 4.0
);

--writing a correlated query to find users who made over 3 bookings

SELECT id, name
FROM users
WHERE (
	SELECT COUNT(*)
	FROM bookings
	WHERE bookings.user_id = users.id
) > 3;
