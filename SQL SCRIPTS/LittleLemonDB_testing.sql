-- Cuisine
SELECT * FROM littlelemon_db.Cuisine;

-- Type
SELECT * FROM littlelemon_db.Type;

-- MenuItem
SELECT * FROM littlelemon_db.MenuItem;

-- JOIN MenuItem with Type
SELECT mi.ItemID, mi.Name, t.Name as Type, mi.Price 
FROM littlelemon_db.MenuItem AS mi JOIN littlelemon_db.Type as t 
ON mi.TypeID = t.TypeID
ORDER BY mi.ItemID;

-- Roles
SELECT * FROM littlelemon_db.Roles;

-- Staff
SELECT * FROM littlelemon_db.Staff;

-- Join Staff  with Role
SELECT StaffID, r.title AS Position, Salary, FullName 
FROM littlelemon_db.Staff AS s 
JOIN littlelemon_db.Roles AS r
ON s.RoleID = r.RoleID;

-- Customers
SELECT * FROM littlelemon_db.Customers;

-- Bookings
SELECT * FROM littlelemon_db.Bookings;

-- Join Bookings, Customers and Staff(Joined with Roles)
SELECT BookingID, TableNo, BookingDate, NoGuests, c.FullName AS CustomerName, s.FullName AS Employee, s.Position
FROM littlelemon_db.Bookings AS b JOIN littlelemon_db.Customers AS c
ON  b.CustomerId = c.CustomerID
JOIN (
	SELECT StaffID, r.title AS Position, Salary, FullName 
	FROM littlelemon_db.Staff AS s 
	JOIN littlelemon_db.Roles AS r
	ON s.RoleID = r.RoleID
    ) AS s
ON b.StaffID = s.StaffID;

-- Menu
SELECT * FROM littlelemon_db.menu;

-- JOIN Menu, Cuisine and MenuItem
SELECT MenuID, mi.Name, t.Name as Type, c.Title as Cuisine, mi.Price
FROM littlelemon_db.Menu AS m JOIN littlelemon_db.MenuItem AS mi
ON m.ItemID = mi.ItemID
JOIN littlelemon_db.Type AS t
ON mi.TypeID = t.TypeID
JOIN littlelemon_db.Cuisine as c
ON m.CuisineID = c.CuisineID;

-- Orders
SELECT * FROM littlelemon_db.Orders;

-- JOIN Order, Customer
SELECT OrderID, OrderDate, Quantity, TotalCost, c.FullName AS CustomerName, MenuID
FROM littlelemon_db.Orders AS o JOIN littlelemon_db.Customers AS c
ON o.CustomerID = c.CustomerID;

-- Order Status
SELECT * FROM littlelemon_db.OrderStatus;

-- JOIN Order with Status
SELECT o.OrderID, OrderDate, DeliveryDate, Quantity, TotalCost, CustomerID, MenuID, Status
FROM littlelemon_db.Orders AS o JOIN littlelemon_db.OrderStatus AS os
ON o.OrderID = os.OrderID; 
		