IF DB_ID('ECommerceStore') IS NULL
BEGIN
-- Create the database if it does not exist
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

-- Create Colors table
CREATE TABLE Colors (
    ColorID INT IDENTITY(1,1) PRIMARY KEY,
    ColorName NVARCHAR(50) NOT NULL
);
GO

-- Create Sizes table
CREATE TABLE Sizes (
    SizeID INT IDENTITY(1,1) PRIMARY KEY,
    size_int INT NULL
);
GO

-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NULL,
    PhoneNumber NVARCHAR(20) NULL,
    Address NVARCHAR(200) NULL
);
GO

-- Create Categories table
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL
);
GO

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NULL,
    OrderDate DATETIME NULL,
    Status NVARCHAR(50) NULL,
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
GO

-- Create Products table
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    Price DECIMAL(18,2) NOT NULL,
    StockQuantity INT NOT NULL,
    CategoryID INT NULL,
    SizeID INT NULL,
    ColorID INT NULL,
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    CONSTRAINT FK_Products_Sizes FOREIGN KEY (SizeID) REFERENCES Sizes(SizeID),
    CONSTRAINT FK_Products_Colors FOREIGN KEY (ColorID) REFERENCES Colors(ColorID)
);
GO

-- Create ProductVariants table
CREATE TABLE ProductVariants (
    VariantID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NULL,
    SizeID INT NULL,
    ColorID INT NULL,
    StockQuantity INT NOT NULL,
    CONSTRAINT FK_ProductVariants_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    CONSTRAINT FK_ProductVariants_Sizes FOREIGN KEY (SizeID) REFERENCES Sizes(SizeID),
    CONSTRAINT FK_ProductVariants_Colors FOREIGN KEY (ColorID) REFERENCES Colors(ColorID)
);
GO

-- Create Cart table
CREATE TABLE Cart (
    cart_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    color_id INT NOT NULL,
    size_id INT NOT NULL,
    quantity INT NOT NULL,
    discount DECIMAL(5,2) DEFAULT 0.00 NOT NULL,
    date_added DATETIME DEFAULT GETDATE() NOT NULL,
    CONSTRAINT FK_Cart_Customers FOREIGN KEY (customer_id) REFERENCES Customers(CustomerID),
    CONSTRAINT FK_Cart_Products FOREIGN KEY (product_id) REFERENCES Products(ProductID),
    CONSTRAINT FK_Cart_Colors FOREIGN KEY (color_id) REFERENCES Colors(ColorID),
    CONSTRAINT FK_Cart_Sizes FOREIGN KEY (size_id) REFERENCES Sizes(SizeID)
);
GO

-- Create Discounts table
CREATE TABLE Discounts (
    discount_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT NOT NULL,
    color_id INT NOT NULL,
    size_id INT NOT NULL,
    discount_amount DECIMAL(5,2) NOT NULL,
    CONSTRAINT FK_Discounts_Products FOREIGN KEY (product_id) REFERENCES Products(ProductID),
    CONSTRAINT FK_Discounts_Colors FOREIGN KEY (color_id) REFERENCES Colors(ColorID),
    CONSTRAINT FK_Discounts_Sizes FOREIGN KEY (size_id) REFERENCES Sizes(SizeID)
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
    CONSTRAINT FK_Feedback_Customers FOREIGN KEY (customer_id) REFERENCES Customers(CustomerID),
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
    VariantID INT NULL,
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    CONSTRAINT FK_OrderDetails_Variants FOREIGN KEY (VariantID) REFERENCES ProductVariants(VariantID)
);
GO

-- Create ProductImages table
CREATE TABLE ProductImages (
    ImageID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    ColorID INT NOT NULL,
    CONSTRAINT FK_ProductImages_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    CONSTRAINT FK_ProductImages_Colors FOREIGN KEY (ColorID) REFERENCES Colors(ColorID)
);
GO

-- Create Wishlist table
CREATE TABLE Wishlist (
    WishlistID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    VariantID INT NOT NULL,
    DateAdded DATETIME DEFAULT GETDATE() NOT NULL,
    CONSTRAINT FK_Wishlist_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    CONSTRAINT FK_Wishlist_Variants FOREIGN KEY (VariantID) REFERENCES ProductVariants(VariantID)
);
GO
