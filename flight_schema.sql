
-- DATABASE : Flight Booking System

CREATE DATABASE IF NOT EXISTS flight_booking;
USE flight_booking;


-- 1. User Table

CREATE TABLE User (
    id INT AUTO_INCREMENT PRIMARY KEY,   -- Unique and not null ID for each user
    password VARCHAR(128) NOT NULL,
    username VARCHAR(150) UNIQUE NOT NULL --column must have a value and that value must be different from all other rows.
);

-- Sample Users
INSERT INTO User (password, username)
VALUES 
('pzxcvbnm1', 'roja'),
('pxcbkdf2', 'ayush'),
('pasxdcvb3', 'admin');


-- 2. Place Table

CREATE TABLE Place (
    id INT AUTO_INCREMENT PRIMARY KEY,  --AUTO_INCREMENT : automatically each new row increased by 1
    city VARCHAR(64) NOT NULL,
    airport VARCHAR(64) NOT NULL,
    code CHAR(3) NOT NULL,
    country VARCHAR(64) NOT NULL
);

-- Sample Places
INSERT INTO Place (city, airport, code, country) VALUES
('Hyderabad', 'Rajiv Gandhi Intl Airport', 'HYD', 'India'),
('Delhi', 'Indira Gandhi Intl Airport', 'DEL', 'India'),
('Mumbai', 'Chhatrapati Shivaji Intl Airport', 'BOM', 'India'),
('Dubai', 'Dubai Intl Airport', 'DXB', 'UAE');


-- 3. Week Table

CREATE TABLE Week (
    id INT AUTO_INCREMENT PRIMARY KEY,
    number INT NOT NULL,
    name VARCHAR(16) NOT NULL
);

-- Sample Weekdays
INSERT INTO Week (number, name) VALUES
(1, 'Monday'),
(2, 'Tuesday'),
(3, 'Wednesday'),
(4, 'Thursday'),
(5, 'Friday'),
(6, 'Saturday'),
(7, 'Sunday');

-- 4. Flight Table

CREATE TABLE Flight (
    id INT AUTO_INCREMENT PRIMARY KEY,
    origin_id INT NOT NULL,
    destination_id INT NOT NULL,
    depart_time TIME NOT NULL,
    duration BIGINT NULL,
    arrival_time TIME NOT NULL,
    plane VARCHAR(24) NOT NULL,
    airline VARCHAR(64) NOT NULL,
    economy_fare FLOAT NULL,
    business_fare FLOAT NULL,
    first_fare FLOAT NULL,
    FOREIGN KEY (origin_id) REFERENCES Place(id) ON DELETE CASCADE,
    FOREIGN KEY (destination_id) REFERENCES Place(id) ON DELETE CASCADE
);

-- Sample Flights
INSERT INTO Flight (origin_id, destination_id, depart_time, duration, arrival_time, plane, airline, economy_fare, business_fare, first_fare)
VALUES
(1, 2, '08:30:00', 7200, '10:30:00', 'A320', 'Air India', 5500, 9500, 13500),
(2, 3, '15:45:00', 5400, '17:15:00', 'B737', 'IndiGo', 4800, 8800, 12000),
(3, 4, '23:00:00', 16200, '02:30:00', 'B777', 'Emirates', 14500, 24500, 38500);


--Flight ↔ Week

CREATE TABLE Flight_depart_day (
    id INT AUTO_INCREMENT PRIMARY KEY,
    flight_id INT NOT NULL,
    week_id INT NOT NULL,
    FOREIGN KEY (flight_id) REFERENCES Flight(id) ON DELETE CASCADE,
    FOREIGN KEY (week_id) REFERENCES Week(id) ON DELETE CASCADE,
    UNIQUE (flight_id, week_id)
);

-- Sample Flight-Day Mappings
INSERT INTO Flight_depart_day (flight_id, week_id) VALUES
(1, 1), (1, 3), (1, 5),   -- Flight 1 on Mon, Wed, Fri
(2, 2), (2, 4), (2, 6),   -- Flight 2 on Tue, Thu, Sat
(3, 7);                   -- Flight 3 on Sunday


--5. Passenger Table

CREATE TABLE Passenger (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(64),
    last_name VARCHAR(64),
    gender ENUM('male', 'female')
);

-- Sample Passengers
INSERT INTO Passenger (first_name, last_name, gender) VALUES
('Ravi', 'Kumar', 'male'),
('Sita', 'Reddy', 'female'),
('Aarav', 'Sharma', 'male'),
('Priya', 'Patel', 'female');

--6. Ticket Table

CREATE TABLE Ticket (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NULL,
    ref_no CHAR(6) UNIQUE NOT NULL,
    flight_id INT NULL,
    flight_ddate DATE NULL,
    flight_adate DATE NULL,
    flight_fare FLOAT NULL,
    other_charges FLOAT NULL,
    coupon_used VARCHAR(15),
    coupon_discount FLOAT DEFAULT 0.0,
    total_fare FLOAT NULL,
    seat_class ENUM('economy', 'business', 'first') NOT NULL,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    mobile VARCHAR(20),
    email VARCHAR(45),
    status ENUM('PENDING', 'CONFIRMED', 'CANCELLED') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE,
    FOREIGN KEY (flight_id) REFERENCES Flight(id) ON DELETE CASCADE
);

-- Sample Tickets
INSERT INTO Ticket (user_id, ref_no, flight_id, flight_ddate, flight_adate, flight_fare, other_charges, coupon_used, coupon_discount, total_fare, seat_class, mobile, email, status)
VALUES
(1, 'A1B2C3', 1, '2025-10-15', '2025-10-15', 5500, 200, 'DIWALI50', 500, 5200, 'economy', '9876543210', 'roja@gmail.com', 'CONFIRMED'),
(2, 'D4E5F6', 2, '2025-10-18', '2025-10-18', 4800, 100, '', 0, 4900, 'business', '9123456780', 'ayush@gmail.com', 'PENDING'),
(3, 'G7H8I9', 3, '2025-10-20', '2025-10-21', 14500, 300, 'FESTIVE10', 1450, 13350, 'first', '9001234567', 'admin@flight.com', 'CONFIRMED');


-- Ticket ↔ Passenger

CREATE TABLE Ticket_passengers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id INT NOT NULL,
    passenger_id INT NOT NULL,
    FOREIGN KEY (ticket_id) REFERENCES Ticket(id) ON DELETE CASCADE,
    FOREIGN KEY (passenger_id) REFERENCES Passenger(id) ON DELETE CASCADE,
    UNIQUE (ticket_id, passenger_id)
);

-- Sample Ticket-Passenger Relations
INSERT INTO Ticket_passengers (ticket_id, passenger_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4);


-- RELATIONSHIP SUMMARY

-- User ↔ Ticket  → 1-to-Many
-- Place ↔ Flight → 1-to-Many (origin/destination)
-- Flight ↔ Week  → Many-to-Many (depart_day)
-- Ticket ↔ Passenger → Many-to-Many (passengers)






--task:Practice all SQL queries (insert, update, joins, transactions, constraints, etc.).


-- SELECT, INSERT, UPDATE, DELETE

-- View all flights
SELECT * FROM Flight;

-- Insert a new passenger
INSERT INTO Passenger (first_name, last_name, gender)
VALUES ('Raj', 'Verma', 'male');

-- Update passenger info
UPDATE Passenger
SET last_name = 'Naidu'
WHERE id = 1;

-- Delete a cancelled ticket
DELETE FROM Ticket
WHERE status = 'CANCELLED';


-- Get all confirmed tickets sorted by fare
SELECT * FROM Ticket
WHERE status = 'CONFIRMED'
ORDER BY total_fare DESC;

-- Get flights from India only
SELECT * FROM Place
WHERE country = 'India';



--3. JOINS (INNER, LEFT, RIGHT)

-- INNER JOIN: Tickets with user and flight details
SELECT 
    t.ref_no, u.username, f.airline, f.origin_id, f.destination_id, t.total_fare
FROM Ticket t
INNER JOIN User u ON t.user_id = u.id
INNER JOIN Flight f ON t.flight_id = f.id;

-- LEFT JOIN: All users and their tickets (if any)
SELECT 
    u.username, t.ref_no, t.status
FROM User u
LEFT JOIN Ticket t ON u.id = t.user_id;

-- RIGHT JOIN: All tickets and their user (even if user missing)
SELECT 
    u.username, t.ref_no, t.status
FROM User u
RIGHT JOIN Ticket t ON u.id = t.user_id;




-- 4. AGGREGATE FUNCTIONS (COUNT, SUM, AVG, MAX, MIN)

-- Total passengers
SELECT COUNT(*) AS total_passengers FROM Passenger;

-- Average economy fare
SELECT AVG(economy_fare) AS avg_economy FROM Flight;

-- Most expensive first class fare
SELECT MAX(first_fare) AS max_first_fare FROM Flight;

-- Total revenue from confirmed tickets
SELECT SUM(total_fare) AS total_revenue
FROM Ticket
WHERE status = 'CONFIRMED';

-- Count flights per airline
SELECT airline, COUNT(*) AS total_flights
FROM Flight
GROUP BY airline
ORDER BY total_flights DESC;


-- CHECK


-- Add a CHECK constraint to ensure fare > 0
ALTER TABLE Ticket
ADD CONSTRAINT chk_fare CHECK (total_fare >= 0);

-- Add a CHECK on gender values (MySQL 8+)
ALTER TABLE Passenger
ADD CONSTRAINT chk_gender CHECK (gender IN ('male', 'female'));

-- GROUP BY
SELECT * FROM Ticket LIMIT 3;
-- Airlines with more than 1 flight
SELECT airline, COUNT(*) AS total_flights
FROM Flight
GROUP BY airline
HAVING total_flights > 1;


-- 6. TRANSACTIONS (COMMIT, ROLLBACK, SAVEPOINT)


-- Example transaction: booking a new ticket
START TRANSACTION;

INSERT INTO Ticket (user_id, ref_no, flight_id, flight_ddate, flight_adate, flight_fare, other_charges, total_fare, seat_class, mobile, email, status)
VALUES (1, 'Z9Y8X7', 1, '2025-10-25', '2025-10-25', 5500, 200, 5700, 'economy', '9998887777', 'demo@flight.com', 'PENDING');

SAVEPOINT before_confirm;

-- Update ticket to confirm booking
UPDATE Ticket
SET status = 'CONFIRMED'
WHERE ref_no = 'Z9Y8X7';

-- Rollback if mistake
ROLLBACK TO before_confirm;

-- Commit transaction finally
COMMIT;


