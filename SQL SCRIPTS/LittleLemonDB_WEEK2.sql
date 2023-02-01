-- WEEK 1 PART I
-- TASK 1 CREATING A VIEW
DROP VIEW IF EXISTS OrdersView;

CREATE VIEW OrdersView AS
SELECT OrderID, Quantity, TotalCost
FROM Orders
WHERE Quantity > 2;

SELECT * FROM OrdersView;

-- TASK 2 JOINS
SELECT CustomerID, FullName, OrderID, TotalCost, mi.Name AS MenuName, t.Name AS CourseName
FROM Customers AS c JOIN ORDERS AS o USING(CustomerID)
JOIN Menu AS m USING(MenuID)
JOIN Cuisine AS cu USING(CuisineID)
JOIN MenuItem AS mi USING(ItemID)
JOIN Type AS t USING(TypeID)
WHERE TotalCost > 10.00;

-- TASK 3 SUBQUERIES
CREATE VIEW MenuView AS
SELECT  MenuID, Title AS Cuisine, mi.Name, t.Name AS Type, Price
FROM Menu AS m JOIN MenuItem AS mi USING (ItemID)
JOIN Cuisine AS c USING(CuisineID)
JOIN Type AS t USING(TypeID);

SELECT Name 
FROM  MenuView
WHERE MenuID = ANY (
	SELECT MenuID
    FROM Orders
    WHERE Quantity > 2);

-- CREATING PROCEDURE GetMaxQuantity
CREATE PROCEDURE GetMaxQuantity()
SELECT MAX(Quantity) 
FROM Orders;

CALL GetMaxQuantity();

-- PREPARED STATEMENT
DEALLOCATE PREPARE GetOrderDetail;
PREPARE GetOrderDetail FROM
'SELECT OrderID, Quantity, TotalCost FROM Orders WHERE CustomerID = ?';

SET @id = 1;
EXECUTE GetOrderDetail USING @id;

-- CANCEL ORDER PROCEDURE
SELECT * FROM Orders;
SELECT * FROM OrderStatus;

DROP PROCEDURE IF EXISTS CancelOrder;

DELIMITER //
CREATE PROCEDURE CancelOrder(IN order_id INT)
BEGIN
DELETE FROM Orders
WHERE OrderID = order_id;
SET @confirmation_msg = CONCAT('Order ',order_id,' is cancelled');
SELECT @confirmation_msg AS Confirmation;
END //
DELIMITER ;

CALL CancelOrder(5);

-- WEEK 2 PART II

-- TASK 1 INSERT
INSERT INTO bookings(TableNo, BookingDate, NoGuests, CustomerID, StaffID) VALUES
(5, '2022-10-10', 2, 1, 6),
(3, '2022-11-12', 1, 3, 9),
(2, '2022-10-11', 4, 2, 9),
(2, '2022-10-13', 7, 1, 6);

SELECT * FROM bookings
WHERE YEAR(BookingDate) = 2022;

-- TASK 2 PROCEDURE CheckBooking
DROP PROCEDURE IF EXISTS CheckBooking;

DELIMITER //
CREATE PROCEDURE CheckBooking(IN booking_date DATE, IN table_no SMALLINT)
BEGIN
SET @is_booked = 0;
SELECT EXISTS (SELECT * FROM Bookings WHERE BookingDate = booking_date AND TableNo = table_no) INTO @is_booked;

SELECT
CASE
	WHEN @is_booked THEN CONCAT('Table ',table_no,' is already booked')
    ELSE CONCAT('Table ',table_no,' is available for booking')
END AS BookingStatus;
END //
DELIMITER ;


CALL CheckBooking('2022-11-12', 2);
CALL CheckBooking('2022-11-12', 3);

-- TASK 3 AddValidBooking
DROP PROCEDURE IF EXISTS AddValidBooking;

DELIMITER //
CREATE PROCEDURE AddValidBooking(IN booking_date DATE, IN table_no SMALLINT)
BEGIN
START TRANSACTION;
INSERT INTO Bookings(TableNo, BookingDate, NoGuests, CustomerID, StaffID) VALUES
(table_no, booking_date, 1, 1, 6);
IF EXISTS(SELECT * FROM Bookings WHERE BookingDate = booking_date AND TableNo = table_no) THEN ROLLBACK;
ELSE COMMIT;
END IF;
END //
DELIMITER ;

CALL CheckBooking('2022-11-12', 3);
CALL AddValidBooking('2022-11-12', 3);
SELECT * FROM Bookings;

CALL CheckBooking('2022-11-12', 2);
CALL AddValidBooking('2022-11-12', 2);
CALL CheckBooking('2022-11-12', 2);

-- WEEK 2 PART III 
 
-- TASK 1 AddBooking
DROP PROCEDURE IF EXISTS AddBooking;

DELIMITER //
CREATE PROCEDURE AddBooking(IN no_guests INT, IN customer_id INT, IN booking_date DATE, IN table_no SMALLINT)
BEGIN
INSERT INTO Bookings(TableNo, BookingDate, NoGuests, CustomerID, StaffID) VALUES
(table_no, booking_date, no_guests, customer_id, 6);
SELECT 'New booking added' AS Confirmation;
END //
DELIMITER ;

CALL AddBooking(10, 5, '2024-10-13', 10);

-- TASK 2 UpdateBooking
DROP PROCEDURE IF EXISTS UpdateBooking;

DELIMITER //
CREATE PROCEDURE UpdateBooking(IN booking_id INT, IN booking_date DATE)
BEGIN
UPDATE Bookings SET BookingDate = booking_date
WHERE BookingID = booking_id;
SELECT CONCAT('Booking ',booking_id,' updated') AS Confirmation;
END //
DELIMITER ;

SELECT * FROM Bookings;
CALL UpdateBooking(18,'2024-12-14');

-- TASK 3 CancelBooking
DROP PROCEDURE IF EXISTS CancelBooking;

DELIMITER //
CREATE PROCEDURE CancelBooking(IN booking_id INT)
BEGIN
DELETE FROM Bookings
WHERE BookingID = booking_id;
SELECT CONCAT('Booking ',booking_id,' cancelled') AS Confirmation;
END //
DELIMITER ;

SELECT * FROM Bookings;
CALL CancelBooking(18);
SELECT * FROM Bookings;

