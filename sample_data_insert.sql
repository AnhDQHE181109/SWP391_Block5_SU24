--Purging existing data
DELETE FROM Categories
DELETE FROM Accounts
DELETE FROM Discounts
DELETE FROM Feedback
DELETE FROM Stock
DELETE FROM ProductStockImport
DELETE FROM Cart
DELETE FROM ProductImages
DELETE FROM OrderDetails
DELETE FROM Feedback
DELETE FROM Orders
DELETE FROM Wishlist
DELETE FROM Products
DELETE FROM Accounts
DELETE FROM Brand

-- Insert data into Accounts
INSERT INTO Accounts (Username, Hash, PhoneNumber, Email, Address, Role, Salt) VALUES
('johndoe', 'NqmCu0KLyfdegTojOpWmaAC8gODT1EfFxKtyJ9tfwUDneUmaWlo7TiaWJYzGnaWaYcWsUtytBL/iqltP+MLvVA==', '123-456-7890', 'johndoe@example.com', '123 Main St, Anytown, USA', 1, 'jMxFrhzK+pkZRnCz7jEkew=='),
('janedoe', 'NqmCu0KLyfdegTojOpWmaAC8gODT1EfFxKtyJ9tfwUDneUmaWlo7TiaWJYzGnaWaYcWsUtytBL/iqltP+MLvVA==', '987-654-3210', 'janedoe@example.com', '456 Elm St, Othertown, USA', 2, 'jMxFrhzK+pkZRnCz7jEkew=='),
('alice', 'NqmCu0KLyfdegTojOpWmaAC8gODT1EfFxKtyJ9tfwUDneUmaWlo7TiaWJYzGnaWaYcWsUtytBL/iqltP+MLvVA==', '555-123-4567', 'alice@example.com', '789 Maple St, Sometown, USA', 1, 'jMxFrhzK+pkZRnCz7jEkew==');

-- Insert data into Categories
INSERT INTO Categories (CategoryName) VALUES
('Electronics'),
('Clothing'),
('Home Goods');

-- Insert data into Brand
INSERT INTO Brand (BrandName) VALUES
('Acme Corp'),
('Gadgetron'),
('Fashionista');

-- Insert data into Products
INSERT INTO Products (ProductName, Origin, Material, Price, TotalQuantity, CategoryID, BrandID) VALUES
('Smartphone', 'China', 'Plastic', 499.99, 100, 1, 2),
('T-shirt', 'Vietnam', 'Cotton', 19.99, 200, 2, 3),
('Blender', 'USA', 'Metal', 89.99, 150, 3, 1),
('Smartphone', 'China', 'Metal', 500.99, 120, 1, 2),
('Smartphone', 'China', 'Titanium', 450.00, 50, 1, 2);

-- Insert data into ProductStockImport
INSERT INTO ProductStockImport (ProductID, ImportDate) VALUES
(1, '2023-07-01'),
(2, '2023-07-15'),
(3, '2023-08-01');

-- Insert data into Orders
INSERT INTO Orders (AccountID, OrderDate, Status) VALUES
(1, '2023-08-05', 'Pending'),
(2, '2023-08-06', 'Completed'),
(3, '2023-08-07', 'Shipped');

-- Insert data into Stock
INSERT INTO Stock (ProductID, Size, Color, StockQuantity) VALUES
(1, 0, 'Black', 50),
(2, 42, 'Blue', 100),
(3, 0, 'Red', 30),
(4, 42, 'Light Blue', 100),
(5, 42, 'Grey', 200);

-- Insert data into Cart
INSERT INTO Cart (customer_id, product_id, color, size, quantity, discount, date_added) VALUES
(1, 1, 'Black', 0, 1, 10.00, '2023-08-01'),
(2, 2, 'Blue', 42, 2, 0.00, '2023-08-02'),
(3, 3, 'Red', 0, 1, 5.00, '2023-08-03');

-- Insert data into Discounts
INSERT INTO Discounts (product_id, color, size, discount_amount) VALUES
(1, 'Black', 0, 15.00),
(2, 'Blue', 42, 5.00),
(3, 'Red', 0, 10.00);

-- Insert data into Feedback
INSERT INTO Feedback (customer_id, product_id, rating, comment, created_at) VALUES
(1, 1, 5, 'Great product!', '2023-08-05'),
(2, 2, 4, 'Good quality', '2023-08-06'),
(3, 3, 3, 'Decent for the price', '2023-08-07');

-- Insert data into OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, SalePrice) VALUES
(1, 1, 1, 489.99),
(2, 2, 2, 39.98),
(3, 3, 1, 84.99);

-- Insert data into ProductImages
INSERT INTO ProductImages (ProductID, Color, ImageURL) VALUES
(1, 'Black', 'http://example.com/images/smartphone_black.jpg'),
(2, 'Blue', 'http://example.com/images/tshirt_blue.jpg'),
(3, 'Red', 'http://example.com/images/blender_red.jpg');

-- Insert data into Wishlist
INSERT INTO Wishlist (AccountID, ProductID, DateAdded) VALUES
(1, 2, '2023-08-04'),
(2, 3, '2023-08-05'),
(3, 1, '2023-08-06');
