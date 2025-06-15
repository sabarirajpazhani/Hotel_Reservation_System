create database HotelReservation;

use HotelReservation;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    CustomerEmail VARCHAR(100),
    CustomerPhone VARCHAR(20),
    CustomerAddress VARCHAR(255)
);

INSERT INTO Customers VALUES
(1, 'Neha', 'neha@gmail.com', '9999999999', 'Chennai'),
(2, 'Raj', 'raj@gmail.com', '8888888888', 'Coimbatore'),
(3, 'Priya', 'priya@gmail.com', '7777777777', 'Madurai');


CREATE TABLE Hotels (
    HotelID INT PRIMARY KEY,
    HotelName VARCHAR(100),
    Location VARCHAR(100),
    HotelPhone VARCHAR(20)
);

INSERT INTO Hotels VALUES
(1, 'The Grand', 'Chennai', '1234567890'),
(2, 'Sea Breeze', 'Pondicherry', '2345678901');

CREATE TABLE RoomTypes (
    RoomTypeID INT PRIMARY KEY,
    RoomTypeName VARCHAR(50)
);

INSERT INTO RoomTypes VALUES
(1, 'Deluxe'),
(2, 'Suite'),
(3, 'Standard');

CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY,
    HotelID INT,
    RoomTypeID INT,
    Capacity INT,
    PerDayPrice DECIMAL(10,2),
    Status VARCHAR(50)
);

INSERT INTO Rooms VALUES
(101, 1, 1, 2, 2500, 'Available'),
(102, 1, 2, 4, 4000, 'Occupied'),
(103, 2, 1, 2, 2800, 'Available'),
(104, 2, 3, 3, 2000, 'Available');

CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY,
    CustomerID INT,
    RoomID INT,
    BookingDate DATE,
    CheckInDate DATE,
	CheckOutDate date,
	Amount decimal(10,2)
);

INSERT INTO Bookings VALUES
(201, 1, 101, '2025-06-01', '2025-06-05', '2025-06-08',6500),
(202, 2, 102, '2025-06-03', '2025-06-06','2025-06-09',7500),
(203, 3, 103, '2025-06-04', '2025-06-08','2025-06-10',6500);

CREATE TABLE BookingRooms (
    BookingRoomID INT PRIMARY KEY,
    BookingID INT,
    RoomID INT
);

INSERT INTO BookingRooms VALUES
(1, 201, 101),
(2, 202, 102),
(3, 203, 103);

CREATE TABLE PaymentType (
    PaymentTypeID INT PRIMARY KEY,
    PaymentName VARCHAR(50)
);

INSERT INTO PaymentType VALUES
(1, 'Card'),
(2, 'UPI'),
(3, 'Cash');

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    CustomerID INT,
    PaymentTypeID INT,
    BookingID INT,
    AmountPaid DECIMAL(10,2)
);

INSERT INTO Payment VALUES
(301, 1, 1, 201, 5000),
(302, 2, 2, 202, 8000),
(303, 3, 3, 203, 5600);

CREATE TABLE PaymentStatus (
    PaymentStatusID INT PRIMARY KEY,
    PaymentID INT,
    Status VARCHAR(50)
);

INSERT INTO PaymentStatus VALUES
(1, 301, 'Success'),
(2, 302, 'Pending'),
(3, 303, 'Success');

CREATE TABLE CustomerFeedback (
    FeedbackID INT PRIMARY KEY,
    CustomerID INT,
    HotelID INT,
    Feedback VARCHAR(255)
);

INSERT INTO CustomerFeedback VALUES
(401, 1, 1, 'Wonderful experience.'),
(402, 2, 1, 'Great service and food.'),
(403, 3, 2, 'Nice view and clean rooms.');




SELECT * FROM Customers;
SELECT * FROM Hotels;
SELECT * FROM RoomTypes;
SELECT * FROM Rooms;
SELECT * FROM Bookings;
SELECT * FROM BookingRooms;
SELECT * FROM PaymentType;
SELECT * FROM Payment;
SELECT * FROM PaymentStatus;
SELECT * FROM CustomerFeedback;


-- 1. Write a query to display CustomerName, HotelName, RoomTypeName, BookingDate, and CheckInDate for all bookings.
select c.CustomerName, h.HotelName, rt.RoomTypeName, b.BookingDate, b.CheckInDate
from Bookings b
inner join Customers c on b.CustomerID = c.CustomerID
inner join Rooms r on b.RoomID = r.RoomID
inner join Hotels h on r.HotelID = h.HotelID
inner join RoomTypes rt on r.RoomTypeID = rt.RoomTypeID

