DATABASE NORMALIZATION TO 34F
Schema Recap

Entities:

User(user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)

Property(property_id, host_id → User.user_id, name, description, location, pricepernight, created_at, updated_at)

Booking(booking_id, property_id → Property.property_id, user_id → User.user_id, start_date, end_date, total_price, status, created_at)

Payment(payment_id, booking_id → Booking.booking_id, amount, payment_date, payment_method)

Review(review_id, property_id → Property.property_id, user_id → User.user_id, rating, comment, created_at)

Message(message_id, sender_id → User.user_id, recipient_id → User.user_id, message_body, sent_at


1) First Normal Form (1NF)

Rule: Each table has a primary key, and every field is atomic (no repeating groups, no arrays in a single column).

Assessment:

All tables have single-column primary keys (UUIDs).

Attributes are atomic.

Potential consideration: Property.location is a free-form string. If it contains multiple data points (e.g., "City, State, Country"), it can still be treated as atomic but may lead to inconsistency.

Conclusion: Schema satisfies 1NF.

2) Second Normal Form (2NF)

Rule: No partial dependencies of non-key attributes on part of a composite key. (Only relevant if primary keys are composite.)

Assessment:

All primary keys are single-column (*_id), so partial dependency cannot occur.

onclusion: Schema satisfies 2NF.

3) Third Normal Form (3NF)

Rule: No transitive dependencies; every non-key attribute must depend on the key, the whole key, and nothing but the key.

RESULT:
* Original schema is already in 1NF and 2NF.
* The only 3NF concern is Booking.total_price.

To fix this, replace total_price with snapshot components (nightly_rate_at_booking, fees, tax, etc.).

We have this:

CREATE TABLE Booking (
 booking_id UUID PRIMARY KEY,
 property_id UUID NOT NULL REFERENCES Property(property_id),
 user_id UUID NOT NULL REFERENCES "User"(user_id),
 start_date DATE NOT NULL,
 end_date DATE NOT NULL,
 nightly_rate_at_booking DECIMAL NOT NULL,
 cleaning_fee DECIMAL DEFAULT 0 NOT NULL,
 service_fee DECIMAL DEFAULT 0 NOT NULL,
 tax_amount DECIMAL DEFAULT 0 NOT NULL,
 discount_amount DECIMAL DEFAULT 0 NOT NULL,
 status ENUM('pending','confirmed','canceled') NOT NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 CONSTRAINT chk_booking_dates CHECK (start_date < end_date)
 );


 CREATE VIEW booking_with_total AS
 SELECT
 b.*,
 (b.nightly_rate_at_booking * GREATEST(DATEDIFF(b.end_date, b.start_date), 0)
 + b.cleaning_fee + b.service_fee + b.tax_amount - b.discount_amount) AS computed_total_price
 FROM Booking b;
