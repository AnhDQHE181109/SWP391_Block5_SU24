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

-- Create Categories table
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL
);
GO

INSERT INTO Categories (CategoryName)
VALUES (N'Sneaker'), (N'Athletic shoes'), (N'Boots'), (N'Sandals');

-- Create Brand table
CREATE TABLE Brand (
    BrandID INT IDENTITY(1,1) PRIMARY KEY,
    BrandName NVARCHAR(100) NOT NULL
);
GO

INSERT INTO Brand(BrandName)
VALUES (N'Niko'), (N'Adidos'), (N'Jordan'), (N'Puma');

-- Create Products table
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(200) NOT NULL,
    Origin NVARCHAR(100) NULL,
    Material NVARCHAR(100) NULL,
    Price DECIMAL(18,2) NOT NULL,
    TotalQuantity INT NOT NULL,
    CategoryID INT NULL,
    BrandID INT NULL,
    ImportID INT NULL,
    ImageID INT NULL,
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    CONSTRAINT FK_Products_Brand FOREIGN KEY (BrandID) REFERENCES Brand(BrandID)
);
GO

-- Create ProductStockImport table
CREATE TABLE ProductStockImport (
    ImportID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    ImportDate DATETIME NOT NULL,
    CONSTRAINT FK_ProductStockImport_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

CREATE TABLE Accounts(
    AccountID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(100) NOT NULL, 
    Hash TEXT NOT NULL,
    PhoneNumber NVARCHAR(20) NULL,
    Email NVARCHAR(100) UNIQUE NULL,
    Address NVARCHAR(200) NULL,
    Salt TEXT NOT NULL,
    Role INT NOT NULL
);
GO

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT NULL,
    OrderDate DATETIME NULL,
    Status NVARCHAR(50) NULL,
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
    CONSTRAINT FK_Stock_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- Create Cart table
CREATE TABLE Cart (
    cart_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    color NVARCHAR(50) NOT NULL,
    size INT NOT NULL,
    quantity INT NOT NULL,
    discount DECIMAL(5,2) DEFAULT 0.00 NOT NULL,
    date_added DATETIME DEFAULT GETDATE() NOT NULL,
    CONSTRAINT FK_Cart_Accounts FOREIGN KEY (customer_id) REFERENCES Accounts(AccountID),
    CONSTRAINT FK_Cart_Products FOREIGN KEY (product_id) REFERENCES Products(ProductID)
);
GO

-- Create Discounts table
CREATE TABLE Discounts (
    discount_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT NOT NULL,
    color NVARCHAR(50) NOT NULL,
    size INT NOT NULL,
    discount_amount DECIMAL(5,2) NOT NULL,
    CONSTRAINT FK_Discounts_Products FOREIGN KEY (product_id) REFERENCES Products(ProductID)
);
GO

-- Create Feedback table
CREATE TABLE Feedback (
    feedback_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NULL,
    comment TEXT NULL,
    created_at DATETIME DEFAULT GETDATE() NULL,
    CONSTRAINT FK_Feedback_Accounts FOREIGN KEY (customer_id) REFERENCES Accounts(AccountID),
    CONSTRAINT FK_Feedback_Products FOREIGN KEY (product_id) REFERENCES Products(ProductID)
);
GO

-- Create OrderDetails table
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NULL,
    ProductID INT NULL,
    Quantity INT NOT NULL,
    SalePrice DECIMAL(18,2) NOT NULL,
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- Create ProductImages table with ImageURL
CREATE TABLE ProductImages (
    ImageID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    Color NVARCHAR(50) NOT NULL,
    ImageURL NVARCHAR(255) NOT NULL,
    CONSTRAINT FK_ProductImages_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- Create Wishlist table
CREATE TABLE Wishlist (
    WishlistID INT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT NOT NULL,
    ProductID INT NOT NULL,
    DateAdded DATETIME DEFAULT GETDATE() NOT NULL,
    CONSTRAINT FK_Wishlist_Accounts FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    CONSTRAINT FK_Wishlist_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- Insert sample data into Products
INSERT INTO Products(ProductName, Origin, Material, Price, TotalQuantity, CategoryID, BrandID, ImportID) 
VALUES 
('Men Taja Commissioner', 'USA', 'Leather', 19.99, 100, 2, 2, NULL),
('Air Force 1', 'China', 'Suede', 29.99, 200, 1, 1, NULL);