-- Insert Users
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
('11111111-1111-1111-1111-111111111111', 'Alice', 'Johnson', 'alice@example.com', 'hash1', '1234567890', 'guest'),
('22222222-2222-2222-2222-222222222222', 'Bob', 'Smith', 'bob@example.com', 'hash2', '2345678901', 'host'),
('33333333-3333-3333-3333-333333333333', 'Charlie', 'Brown', 'charlie@example.com', 'hash3', '3456789012', 'host'),
('44444444-4444-4444-4444-444444444444', 'Diana', 'Prince', 'diana@example.com', 'hash4', '4567890123', 'guest');

-- Insert Properties
INSERT INTO Property (property_id, host_id, name, description, location, price_per_night)
VALUES
('aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '22222222-2222-2222-2222-222222222222', 'Cozy Apartment', 'A nice city apartment near downtown.', 'New York, USA', 120.00),
('aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '33333333-3333-3333-3333-333333333333', 'Beach House', 'Beautiful beach house with ocean view.', 'Miami, USA', 250.00);

-- Insert Bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, booked_price_per_night, status)
VALUES
('bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1', 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '11111111-1111-1111-1111-111111111111', '2025-06-01', '2025-06-05', 120.00, 'confirmed'),
('bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbb2', 'aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '44444444-4444-4444-4444-444444444444', '2025-07-10', '2025-07-15', 250.00, 'pending');

-- Insert Payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
('ccccccc1-cccc-cccc-cccc-ccccccccccc1', 'bbbbbbb1-bbbb-bbbb-bbbb-bbbbbbbbbbb1', 480.00, 'credit_card');

-- Insert Reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
('ddddddd1-dddd-dddd-dddd-ddddddddddd1', 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaa1', '11111111-1111-1111-1111-111111111111', 5, 'Amazing stay! Very comfortable and close to everything.'),
('ddddddd2-dddd-dddd-dddd-ddddddddddd2', 'aaaaaaa2-aaaa-aaaa-aaaa-aaaaaaaaaaa2', '44444444-4444-4444-4444-444444444444', 4, 'Great view, but the check-in was a bit late.');

-- Insert Messages
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
('eeeeeee1-eeee-eeee-eeee-eeeeeeeeeee1', '11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', 'Hi Bob, I’m interested in your apartment. Is it available?'),
('eeeeeee2-eeee-eeee-eeee-eeeeeeeeeee2', '22222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', 'Hi Alice, yes it is available for your dates!');

