-- Create the database if it does not exist
IF DB_ID('ECommerceStore') IS NULL
BEGIN
    CREATE DATABASE ECommerceStore;
END
GO

-- Use the database
USE ECommerceStore;
GO

-- Drop all foreign key constraints and tables if the database already exists
IF DB_ID('ECommerceStore') IS NOT NULL
BEGIN
    DECLARE @sql NVARCHAR(MAX) = N'';

    -- Build dynamic SQL to drop all foreign key constraints
    SELECT @sql += 'ALTER TABLE ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + 
                   ' DROP CONSTRAINT ' + QUOTENAME(CONSTRAINT_NAME) + ';'
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE CONSTRAINT_TYPE = 'FOREIGN KEY';

    -- Execute the dynamic SQL to drop foreign key constraints
    EXEC sp_executesql @sql;

    -- Reset the SQL variable for dropping tables
    SET @sql = N'';

    -- Build dynamic SQL to drop all tables
    SELECT @sql += 'DROP TABLE ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + ';'
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_TYPE = 'BASE TABLE';

    -- Execute the dynamic SQL to drop tables
    EXEC sp_executesql @sql;
END
GO

-- Use the database
USE ECommerceStore;
GO

CREATE TABLE Accounts(
    AccountID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(100) NOT NULL, 
	Name NVARCHAR(800) NOT NULL, 
    Hash TEXT NOT NULL,
    PhoneNumber NVARCHAR(20) NULL,
    Email NVARCHAR(100) UNIQUE NULL,
    Address NVARCHAR(200) NULL,
    Role INT NOT NULL,
    Salt TEXT NOT NULL,
	Status BIT DEFAULT 1
);
GO

-- Create Categories table
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
	CategoryStatus int  null 
);
GO

-- Create Brand table
CREATE TABLE Brand (
    BrandID INT IDENTITY(1,1) PRIMARY KEY,
    BrandName NVARCHAR(100) NOT NULL , 
	BrandStatus int  null 
);
GO

-- Create Products table
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(200) NOT NULL,
    Origin NVARCHAR(100) NULL,
    Material NVARCHAR(100) NULL,
    Price DECIMAL(18,2) NOT NULL,
    TotalQuantity INT NULL,
    CategoryID INT NULL,
    BrandID INT NULL,
    ImageID INT NULL,
	ProductStatus BIT NOT NULL,
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    CONSTRAINT FK_Products_Brand FOREIGN KEY (BrandID) REFERENCES Brand(BrandID)
);
GO

-- Create ProductStockImport table
CREATE TABLE ProductStockImport (
    ImportID INT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT NOT NULL,
    ImportDate DATETIME DEFAULT GETDATE() NOT NULL,
	ImportAction  int  NOT NULL,
	SupplierName  NVARCHAR(50) NOT NULL
);
GO

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT NULL,
    OrderDate DATE NULL,
    Status int NULL,
    CONSTRAINT FK_Orders_Accounts FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);
GO

-- Create Stock table with Size as INT and Color as NVARCHAR
CREATE TABLE Stock (
    StockID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    Size INT NOT NULL,
    Color NVARCHAR(50) NOT NULL,
    StockQuantity INT NOT NULL,
    ImportID INT NULL,
    CONSTRAINT FK_Stock_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- Create StockImportDetail table, referencing StockID instead of ProductID, Size, and Color
CREATE TABLE StockImportDetail (
    StockImportDetailID INT IDENTITY(1,1) PRIMARY KEY,
    StockID INT NOT NULL,
    ImportID INT NOT NULL,
    StockQuantity INT NOT NULL,
    CONSTRAINT FK_StockImportDetail_Stock FOREIGN KEY (StockID) REFERENCES Stock(StockID),
    CONSTRAINT FK_StockImportDetail_ProductStockImport FOREIGN KEY (ImportID) REFERENCES ProductStockImport(ImportID)
);
GO

-- Create Cart table, referencing StockID instead of ProductID, Size, and Color
CREATE TABLE Cart (
    cart_id INT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT NOT NULL,
    StockID INT NOT NULL,
    quantity INT NOT NULL,
    DiscountID INT NOT NULL,
    date_added DATE DEFAULT GETDATE() NOT NULL,
    CONSTRAINT FK_Cart_Accounts FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    CONSTRAINT FK_Cart_Stock FOREIGN KEY (StockID) REFERENCES Stock(StockID)
);
GO

-- Create Discounts table, removing Size and Color
CREATE TABLE Discounts (
    discount_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT NOT NULL,
    discount_amount DECIMAL(5,2) NOT NULL,
    CONSTRAINT FK_Discounts_Products FOREIGN KEY (product_id) REFERENCES Products(ProductID)
);
GO

-- Create Feedback table, referencing StockID instead of ProductID, Size, and Color
CREATE TABLE Feedback (
    feedback_id INT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT NOT NULL,
    StockID INT NOT NULL,
    rating INT NULL,
    comment TEXT NULL,
    created_at DATE DEFAULT GETDATE() NULL,
    CONSTRAINT FK_Feedback_Accounts FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    CONSTRAINT FK_Feedback_Stock FOREIGN KEY (StockID) REFERENCES Stock(StockID)
);
GO

-- Create OrderDetails table, referencing StockID instead of ProductID, Size, and Color
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NULL,
    StockID INT NOT NULL,
    Quantity INT NOT NULL,
    SalePrice DECIMAL(18,2) NOT NULL,
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_OrderDetails_Stock FOREIGN KEY (StockID) REFERENCES Stock(StockID)
);
GO

-- Create ProductImages table with ImageURL
CREATE TABLE ProductImages (
    ImageID INT IDENTITY(1,1) PRIMARY KEY,
    StockID INT NOT NULL,
    ImageURL NVARCHAR(255) NOT NULL,
	CONSTRAINT FK_ProductImages_Stock FOREIGN KEY (StockID) REFERENCES Stock(StockID)
);
GO
--Create NotificationAlert table
CREATE TABLE NotificationAlert (
    notiID INT IDENTITY(0,1) PRIMARY KEY,
	accountID INT,
	notidate DATE DEFAULT GETDATE(),
	noti_message TEXT,
	noti_status BIT DEFAULT 0,
	noti_path TEXT,
	FOREIGN KEY (accountID) REFERENCES Accounts(accountID)
);
-- Create Wishlist table, referencing StockID instead of ProductID
CREATE TABLE Wishlist (
    WishlistID INT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT NOT NULL,
    StockID INT NOT NULL,
    DateAdded DATETIME DEFAULT GETDATE() NOT NULL,
    CONSTRAINT FK_Wishlist_Accounts FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    CONSTRAINT FK_Wishlist_Stock FOREIGN KEY (StockID) REFERENCES Stock(StockID)
);
GO
-- Create ReturnRequests table
CREATE TABLE ReturnRequests (
    RequestID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    AccountID INT NOT NULL,
    Reason NVARCHAR(255) NOT NULL,
    Description TEXT NOT NULL,
    RefundAmount DECIMAL(18,2) NOT NULL,
    DateSubmitted DATETIME DEFAULT GETDATE() NOT NULL,
    Status NVARCHAR(50) DEFAULT 'Pending',
    CONSTRAINT FK_ReturnRequests_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_ReturnRequests_Accounts FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);
GO
USE ECommerceStore;
GO

-- Insert data into Accounts
INSERT INTO Accounts (Username, Name, Hash, PhoneNumber, Email, Address, Role, Salt, Status)
VALUES 
('johndoe', 'John Doe', 'NqmCu0KLyfdegTojOpWmaAC8gODT1EfFxKtyJ9tfwUDneUmaWlo7TiaWJYzGnaWaYcWsUtytBL/iqltP+MLvVA==', '0984567890', 'johndoe@example.com', '123 Main St, Anytown, USA', 1, 'jMxFrhzK+pkZRnCz7jEkew==',1),
('janedoe', 'Jane Doe', 'NqmCu0KLyfdegTojOpWmaAC8gODT1EfFxKtyJ9tfwUDneUmaWlo7TiaWJYzGnaWaYcWsUtytBL/iqltP+MLvVA==', '0936543210', 'janedoe@example.com', '456 Elm St, Othertown, USA', 2, 'jMxFrhzK+pkZRnCz7jEkew==',1),
('alice', 'Alice Doe', 'NqmCu0KLyfdegTojOpWmaAC8gODT1EfFxKtyJ9tfwUDneUmaWlo7TiaWJYzGnaWaYcWsUtytBL/iqltP+MLvVA==', '0971234567', 'alice@example.com', '789 Maple St, Sometown, USA', 3, 'jMxFrhzK+pkZRnCz7jEkew==',1),
('long', 'Long Vu', 'NqmCu0KLyfdegTojOpWmaAC8gODT1EfFxKtyJ9tfwUDneUmaWlo7TiaWJYzGnaWaYcWsUtytBL/iqltP+MLvVA==', '0961234567', 'long@example.com', '789 Maple St, Sometown, USA', 4, 'jMxFrhzK+pkZRnCz7jEkew==',1);



-- Insert data into Categories
INSERT INTO Categories (CategoryName,CategoryStatus)
VALUES 
('Athletic Shoes', 0),
('running shoes ' ,0),
('High Heels',0),
('Sandals',0),
('sports',0);

-- Insert data into Brand
INSERT INTO Brand (BrandName,BrandStatus)
VALUES 
('Nike',0),
('Adidas',0),
('Puma',0),
('Bittis',0),
('Converse ',0);

-- Insert data into Products with ProductStatus = 1
INSERT INTO Products (ProductName, Origin, Material, Price, TotalQuantity, CategoryID, BrandID, ImageID, ProductStatus)
VALUES 
-- Nike Products
('Nike Air Max 270', 'Vietnam', 'Mesh', 150.00, 50, 1, 1, NULL, 1),
('Nike Air Force 1', 'Vietnam', 'Leather', 120.00, 75, 1, 1, NULL, 1),
('Nike Free RN', 'Vietnam', 'Flyknit', 130.00, 60, 4, 1, NULL, 1),

-- Adidas Products
('Adidas Ultraboost 22', 'Germany', 'Primeknit', 180.00, 80, 1, 2, NULL, 1),
('Adidas Stan Smith', 'Vietnam', 'Leather', 100.00, 100, 2, 2, NULL, 1),
('Adidas NMD R1', 'Vietnam', 'Mesh', 140.00, 70, 4, 2, NULL, 1),

-- Puma Products
('Puma RS-X', 'Vietnam', 'Mesh', 110.00, 90, 1, 3, NULL, 1),
('Puma Suede Classic', 'Vietnam', 'Suede', 95.00, 85, 2, 3, NULL, 1),
('Puma Future Rider', 'Vietnam', 'Nylon', 125.00, 65, 4, 3, NULL, 1),

-- Reebok Products
('Reebok Classic Leather', 'Vietnam', 'Leather', 110.00, 55, 1, 4, NULL, 1),
('Reebok Zig Kinetica', 'Vietnam', 'Mesh', 160.00, 40, 4, 4, NULL, 1),

-- Under Armour Products
('Under Armour HOVR Phantom', 'Vietnam', 'Mesh', 140.00, 45, 1, 5, NULL, 1),
('Under Armour Charged Assert 8', 'Vietnam', 'Mesh', 90.00, 60, 2, 5, NULL, 1);


-- Insert data into ProductStockImport
INSERT INTO ProductStockImport (AccountID, ImportDate,ImportAction,SupplierName)
VALUES 
(1, '12/3/2024',1,'johndoe' ),
(2, '12/12/2024',0,'janedoe'),
(3, '5/5/2024',2,'alice');

-- Insert data into Stock
INSERT INTO Stock (ProductID, Size, Color, StockQuantity, ImportID)
VALUES 
(1, 42, 'Red', 50, 1),
(1, 42, 'Blue', 30, 2),
(2, 42, 'White', 100, 3),
(2, 40, 'Black', 60, 3),
(3, 40, 'Black', 75, 4),
(3, 41, 'Green', 20, 5),
(4, 39, 'Yellow', 80, 5),
(4, 38, 'Blue', 40, 6),
(5, 42, 'Pink', 90, 7),
(5, 40, 'Gray', 25, 8),
(6, 38, 'Brown', 100, 9),
(7, 42, 'Orange', 50, 10),
(8, 42, 'Purple', 15, 11),
(9, 40, 'White', 70, 12),
(10, 39, 'Red', 45, 13);


-- Insert data into StockImportDetail
INSERT INTO StockImportDetail (StockID, ImportID, StockQuantity)
VALUES 
(1, 1, 50),
(2, 1, 50),
(3, 2, 100),
(4, 2, 75);

-- Insert data into Orders
INSERT INTO Orders (AccountID, OrderDate, Status)
VALUES 
-- Orders for AccountID 1 (johndoe)
(1, '2024-08-01', 1),  -- OrderID 1
(1, '2024-08-05', 0),  -- OrderID 2
(1, '2024-08-10', 1),  -- OrderID 3
(1, '2024-08-15', 0),  -- OrderID 4
(1, '2024-08-20', 1),  -- OrderID 5

-- Orders for AccountID 2 (janedoe)
(2, '2024-04-22', 1),  -- OrderID 6
(2, '2024-04-24', 0),  -- OrderID 7
(2, '2024-04-20', 1),  -- OrderID 8
(2, '2024-04-01', 0),  -- OrderID 9
(2, '2024-04-05', 1),  -- OrderID 10

-- Orders for AccountID 3 (alice)
(3, '2023-12-07', 1),  -- OrderID 11
(3, '2023-12-10', 0),  -- OrderID 12
(3, '2023-12-15', 1),  -- OrderID 13
(3, '2023-12-20', 0),  -- OrderID 14
(3, '2023-12-25', 1),  -- OrderID 15

-- Orders for AccountID 4 (long)
(4, '2024-10-01', 1),  -- OrderID 16
(4, '2024-10-05', 0),  -- OrderID 17
(4, '2024-10-10', 1),  -- OrderID 18
(4, '2024-10-15', 0),  -- OrderID 19
(4, '2024-10-20', 1);  -- OrderID 20

-- Insert data into Cart
INSERT INTO Cart (AccountID, StockID, quantity, DiscountID, date_added)
VALUES 
(1, 1, 2, 1, GETDATE()),
(2, 3, 1, 2, GETDATE());

-- Insert data into Discounts
INSERT INTO Discounts (product_id, discount_amount)
VALUES 
(1, 15.00),
(2, 20.00);

-- Insert data into Feedback
INSERT INTO Feedback (AccountID, StockID, rating, comment, created_at)
VALUES 
(1, 1, 5, 'Great product!', GETDATE()),
(2, 3, 4, 'Comfortable and stylish.', GETDATE());

-- Insert data into OrderDetails
INSERT INTO OrderDetails (OrderID, StockID, Quantity, SalePrice)
VALUES 
-- Details for OrderID 1 (johndoe)
(1, 1, 2, 150.00),  -- Nike Air Max 270
(1, 3, 1, 130.00),  -- Nike Free RN

-- Details for OrderID 2 (johndoe)
(2, 2, 1, 120.00),  -- Nike Air Force 1
(2, 4, 2, 180.00),  -- Adidas Ultraboost 22

-- Details for OrderID 3 (johndoe)
(3, 5, 1, 110.00),  -- Puma RS-X
(3, 6, 2, 95.00),   -- Puma Suede Classic

-- Details for OrderID 4 (johndoe)
(4, 7, 1, 160.00),  -- Reebok Zig Kinetica
(4, 8, 1, 90.00),   -- Under Armour Charged Assert 8

-- Details for OrderID 5 (johndoe)
(5, 1, 2, 150.00),  -- Nike Air Max 270
(5, 2, 1, 120.00),  -- Nike Air Force 1

-- Details for OrderID 6 (janedoe)
(6, 3, 1, 130.00),  -- Nike Free RN
(6, 4, 2, 180.00),  -- Adidas Ultraboost 22

-- Details for OrderID 7 (janedoe)
(7, 5, 1, 110.00),  -- Puma RS-X
(7, 6, 2, 95.00),   -- Puma Suede Classic

-- Details for OrderID 8 (janedoe)
(8, 7, 1, 160.00),  -- Reebok Zig Kinetica
(8, 8, 1, 90.00),   -- Under Armour Charged Assert 8

-- Details for OrderID 9 (janedoe)
(9, 1, 2, 150.00),  -- Nike Air Max 270
(9, 3, 1, 130.00),  -- Nike Free RN

-- Details for OrderID 10 (janedoe)
(10, 2, 1, 120.00), -- Nike Air Force 1
(10, 4, 2, 180.00), -- Adidas Ultraboost 22

-- Details for OrderID 11 (alice)
(11, 5, 1, 110.00), -- Puma RS-X
(11, 6, 2, 95.00),  -- Puma Suede Classic

-- Details for OrderID 12 (alice)
(12, 7, 1, 160.00), -- Reebok Zig Kinetica
(12, 8, 1, 90.00),  -- Under Armour Charged Assert 8

-- Details for OrderID 13 (alice)
(13, 1, 2, 150.00), -- Nike Air Max 270
(13, 2, 1, 120.00), -- Nike Air Force 1

-- Details for OrderID 14 (alice)
(14, 3, 1, 130.00), -- Nike Free RN
(14, 4, 2, 180.00), -- Adidas Ultraboost 22

-- Details for OrderID 15 (alice)
(15, 5, 1, 110.00), -- Puma RS-X
(15, 6, 2, 95.00), -- Puma Suede Classic

-- Details for OrderID 16 (long)
(16, 7, 1, 160.00), -- Reebok Zig Kinetica
(16, 8, 1, 90.00),  -- Under Armour Charged Assert 8

-- Details for OrderID 17 (long)
(17, 1, 2, 150.00), -- Nike Air Max 270
(17, 3, 1, 130.00),-- Nike Free RN

-- Details for OrderID 18 (long)
(18, 2, 1, 120.00), -- Nike Air Force 1
(18, 4, 2, 180.00),-- Adidas Ultraboost 22

-- Details for OrderID 19 (long)
(19, 5, 1, 110.00), -- Puma RS-X
(19, 6, 2, 95.00), -- Puma Suede Classic

-- Details for OrderID 20 (long)
(20, 7, 1, 160.00), -- Reebok Zig Kinetica
(20, 8, 1, 90.00); -- Under Armour Charged Assert 8

-- Insert data into ProductImages (now using StockID)
INSERT INTO ProductImages (StockID, ImageURL)
VALUES 
(1, 'images/airmax_red.jpg'),
(2, 'images/airmax_blue.jpg'),
(3, 'images/ultraboost_white.jpg'),
(4, 'images/suede_black.jpg');

-- Insert data into Wishlist
INSERT INTO Wishlist (AccountID, StockID, DateAdded)
VALUES 
(1, 2, GETDATE()),
(2, 3, GETDATE());

