-- Indexes for User table
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
