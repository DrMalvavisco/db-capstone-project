-- Cuisine
INSERT INTO littlelemon_db.cuisine(Title) VALUES ('Greek'), ('Italian'), 
('Turkish'), ('Chinese'),
('Mexican'), ('Japanese');

-- Type
INSERT INTO littlelemon_db.type(Name) VALUES ('Starters'), ('Main Courses'), 
('Drinks'), ('Desserts');

-- MenuItem
INSERT INTO littlelemon_db.menuitem(Name, TypeID , Price) VALUES
('Olives',1, 5), 
('Flatbread',1, 5),
('Minestrone',1, 8), 
('Tomato bread',1, 8), 
('Falafel', 1, 7), 
('Hummus', 1, 5), 
('Greek salad', 2, 15), 
('Bean soup', 2, 12), 
('Pizza', 2, 15), 
('Greek yoghurt',4, 7), 
('Ice cream', 4, 6),
('Cheesecake', 4, 4), 
('Athens White wine', 3, 25), 
('Corfu Red Wine', 3, 30), 
('Turkish Coffee', 3, 10), 
('Turkish Coffee', 3, 10), 
('Kabasa', 2, 17);

-- Roles
INSERT INTO littlelemon_db.roles(Title) VALUES
('Waiter'), ('Delivery Crew'), ('Cheff'), 
('General Manager'), ('Kitchen Manager'), ('Assistan Manager'),
('Orders Cooker'), ('Kitchen Assistant'), ('Server') ;

-- Staff
INSERT INTO littlelemon_db.staff(RoleID, Salary, FullName) VALUES
(1, 12, 'Linda Gomez'),
(1, 12, 'Javier Lopah'),
(2, 9, 'Luka Rikti'),
(2, 8, 'Omar Chabelle'),
(3, 20, 'Rikolini Comidini'),
(4, 200, 'Luis Zanabria'),
(5, 70, 'Gustave Gustou'),
(6, 15, 'Raccaconie the raccon'),
(7, 14, 'Jordan Maiquel'),
(7, 16, 'Lupe Esparza'),
(8, 13, 'Juan Camaney'),
(9, 17, 'Albertano SantaCruz');

-- Customers
INSERT INTO littlelemon_db.customers(FullName, Email, ContactNumber) VALUES
('Luka Cardeline', 'luka_cardeline@mail.com', 11111), ('Pal Ross', 'pal_ross@mail.com', 22222), 
('Javi Noble', 'javi_noble@mail.com', 33333), ('Cuauthemoc Blanco', 'cuauthemoc_blanco@mail.com', 44444), 
('Lionel Messi', 'lionel_messi@mail.com', 55555), ('Cristiano Ronaldo', 'siuuuuuu@mail.com', 66666);

-- Booking 
INSERT INTO littlelemon_db.bookings(TableNo, BookingDate, NoGuests, CustomerID, StaffID) VALUES
(10, '2023-10-10', 5, 5, 12),
(10, '2023-10-11', 2, 5, 6),
(7, '2023-10-12', 3, 6, 6),
(20, '2023-10-13', 2, 1, 12),
(4, '2023-10-14', 3, 3, 8),
(3, '2023-10-15', 8, 2, 8),
(14, '2023-10-16', 2, 4, 12);

-- Menu
INSERT INTO littlelemon_db.menu(CuisineID, ItemID) VALUES (1, 1), 
(1, 2), (1, 3), (2, 4), (2, 5), 
(2, 6), (2, 7), (3, 8), (3, 9), 
(3, 10), (3, 11), (3, 12), (3, 13), 
(4, 14), (4, 15), (4, 16), (4, 17);

-- Orders
INSERT INTO littlelemon_db.orders(OrderDate, Quantity, TotalCost, CustomerID, MenuID) VALUES
('2023-02-03', 3, 15, 4, 1),
('2023-02-03', 2, 10, 1, 2),
('2023-02-03', 4, 32, 3, 3),
('2023-02-03', 1, 8, 5, 4),
('2023-02-03', 2, 14, 2, 5);

-- OrderStatus
INSERT INTO littlelemon_db.orderstatus(OrderID, DeliveryDate, Status) VALUES
(1, '2023-02-03', 'Delivered'),
(2, '2023-02-04', 'Pending'),
(3, '2023-02-05', 'Pending'),
(4, '2023-02-05', 'Pending'),
(5, '2023-02-03', 'Delivered');
