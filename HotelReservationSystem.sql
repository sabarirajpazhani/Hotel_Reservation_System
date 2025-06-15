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

--Joins & Real-Time Logic
-- 1. Write a query to display CustomerName, HotelName, RoomTypeName, BookingDate, and CheckInDate for all bookings.
select c.CustomerName, h.HotelName, rt.RoomTypeName, b.BookingDate, b.CheckInDate
from Bookings b
inner join Customers c on b.CustomerID = c.CustomerID
inner join Rooms r on b.RoomID = r.RoomID
inner join Hotels h on r.HotelID = h.HotelID
inner join RoomTypes rt on r.RoomTypeID = rt.RoomTypeID

--2. Write a query to find total revenue per hotel using Payment, Bookings, and Hotels tables.
select h.HotelName, sum(p.AmountPaid) as Revenue
from Payment p
inner join Bookings b  on p.BookingID = b.BookingID 
inner join Rooms r on r.RoomID = b.RoomID
inner join Hotels h on h.HotelID = r.HotelID
group by h.HotelName;

--3. Get the names of customers who stayed in Deluxe rooms at The Grand hotel.
select c.CustomerName from Customers c
join Bookings b on b.CustomerID = c.CustomerID
join Rooms r on r.RoomID = b.RoomID
join RoomTypes rt on rt.RoomTypeID = r.RoomTypeID
join Hotels h on h.HotelID = r.HotelID
where rt.RoomTypeName = 'Deluxe' and h.HotelName = 'The Grand' 

--4. Find customers who have made more than one booking.
select c.CustomerName , Count(*) as NumberOfBooking from Bookings b
inner join Customers c  on c.CustomerID = b.CustomerID
Group by c.CustomerName 
having Count(*) >1;

--5.List customers who paid via UPI and whose payment was successful.
select c.CustomerName , pt.PaymentName, ps.Status from Customers c
inner join Payment p on p.CustomerID = c.CustomerID
inner join PaymentType pt on p.PaymentTypeID = pt.PaymentTypeID
inner join PaymentStatus ps on ps.PaymentID = p.PaymentID
where pt.PaymentName = 'UPI' and ps.Status ='Success'

--Aggregation & Grouping
--6. Display number of rooms booked per hotel with hotel name.
select h.HotelName , count(*) as TotalRoomBooked from Bookings b
inner join Rooms r on r.RoomID = b.RoomID
inner join Hotels h on h.HotelID  = r.HotelID
group by h.HotelName

--7. Show total amount collected from each payment type.
select pt.PaymentName , sum(p.AmountPaid) as TotalAmount from Payment p 
inner join PaymentType pt  on p.PaymentTypeID = pt.PaymentTypeID
group by pt.PaymentName;

--8. List hotels that received more than 1 feedback from customers.
select h.HotelName , Count(*) as NumberOfFeedBack from CustomerFeedback f
inner join Hotels h on f.HotelID = h.HotelID
group by h.HotelName 
having count(*) > 1;

--Subqueries & Filtering
--9. List customers who have never given feedback.
insert into Customers values 
(4, 'Lakshmi',  'lakshmi@gmail.com', '9988776644', 'Cuddalore')

select c.CustomerName from Customers c
where c.CustomerID not in (Select f.CustomerID from CustomerFeedback f);

--10. Find the highest room price available in Pondicherry.
select Max(r.PerDayPrice) as HighestPrice from Rooms r
join Hotels h on r.HotelID = h.HotelID
where h.Location = 'Pondicherry'

--11. Display the customer who made the maximum total payment.
select top 1 c.CustomerName , sum(p.AmountPaid) from Payment p
inner join Customers c on p.CustomerID = c.CustomerID 
group by c.CustomerName 
order by sum(p.AmountPaid) desc;


--Views, Functions, Stored Procedures
--12. Create a view: vw_CustomerBookingDetails with CustomerName, RoomID, HotelName, AmountPaid.
create view vw_CustomerBookingDetails
as
	select c.CustomerName, r.RoomID, h.HotelName, b.Amount from Bookings b
	inner join Customers c on b.CustomerID = c.CustomerID 
	inner join Rooms r on b.RoomID = r.RoomID
	inner join Hotels h on r.HotelID = h.HotelID

select * from vw_CustomerBookingDetails;

--13.Create a scalar function fn_TotalRoomsAvailable(@HotelID) to return available rooms count.
create function fn_TotalRoomsAvailable(
	@HotelID varchar(80)
)
returns int
as
begin
	declare @Count int
	 select @Count = count(*) from Rooms
	 where HotelID = @HotelID and Status = 'Available';
	return @Count
end

select dbo.fn_TotalRoomsAvailable(1);
