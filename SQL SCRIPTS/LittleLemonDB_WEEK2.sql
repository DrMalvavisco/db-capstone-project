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



