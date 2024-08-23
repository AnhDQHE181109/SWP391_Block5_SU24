/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Brand;
import entity.Category;
import entity.Feedback;
import entity.Order;
import entity.Product;
import entity.ProductDetails;
import entity.ProductStockDetails;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.util.stream.Collectors;

/**
 *
 * @author ASUS
 */
public class ProductDetailsDAO extends DBConnect {

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT p.ProductID, p.ProductName, p.Origin, p.Material, p.Price, p.TotalQuantity, "
                    + "c.CategoryName, b.BrandName, pi.ImageURL "
                    + "FROM Products p "
                    + "LEFT JOIN Categories c ON p.CategoryID = c.CategoryID "
                    + "LEFT JOIN Brand b ON p.BrandID = b.BrandID "
                    + "LEFT JOIN Stock s ON p.ProductID = s.ProductID "
                    + "LEFT JOIN ProductImages pi ON s.StockID = pi.StockID";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("ProductID"));
                p.setProductName(rs.getString("ProductName"));
                p.setOrigin(rs.getString("Origin"));
                p.setMaterial(rs.getString("Material"));
                p.setPrice(rs.getDouble("Price"));
                p.setTotalQuantity(rs.getInt("TotalQuantity"));
                p.setCategoryName(rs.getString("CategoryName"));
                p.setBrandName(rs.getString("BrandName"));
                p.setImageUrl(rs.getString("ImageURL")); // Add this line
                products.add(p);
            }
            rs.close();
            st.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return products;
    }

    public List<Brand> getAllBrands() {
        List<Brand> list = new ArrayList<>();
        String sql = "SELECT * FROM Brand";
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Brand brand = new Brand();
                brand.setBrandId(rs.getInt("BrandId"));
                brand.setBrandName(rs.getString("BrandName"));
                list.add(brand);
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Categories";
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("CategoryId"));
                category.setCategoryName(rs.getString("CategoryName"));
                list.add(category);
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addProduct(Product product) {
        boolean isSuccess = false;
        try {
            String sql = "INSERT INTO Products (ProductName, Origin, Material, Price, CategoryID, BrandID) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, product.getProductName());
            ps.setString(2, product.getOrigin());
            ps.setString(3, product.getMaterial());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getCategoryId());
            ps.setInt(6, product.getBrandId());

            int rowsAffected = ps.executeUpdate(); // Execute the update and get the number of affected rows
            if (rowsAffected > 0) {
                isSuccess = true; // If one or more rows were affected, the insert was successful
            }

            ps.close();
        } catch (Exception e) {
            System.out.println("Error inserting product: " + e.getMessage());
        }
        return isSuccess;
    }

    public boolean updateProduct(Product product) {
        String sql = "UPDATE Products SET productName = ?, origin = ?, material = ?, price = ?, brandId = ?, categoryId = ? WHERE productId = ?";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, product.getProductName());
            ps.setString(2, product.getOrigin());
            ps.setString(3, product.getMaterial());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getBrandId());
            ps.setInt(6, product.getCategoryId());
            ps.setInt(7, product.getProductId());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
//        return false;
        }
        return false;
    }

    public boolean deleteProduct(int productId) {
        String deleteCartSql = "DELETE FROM Cart WHERE StockID IN (SELECT StockID FROM Stock WHERE productId = ?)";
        String deleteStockImportDetailSql = "DELETE FROM StockImportDetail WHERE StockID IN (SELECT StockID FROM Stock WHERE productId = ?)";
        String deleteStockSql = "DELETE FROM Stock WHERE productId = ?";
        String deleteProductSql = "DELETE FROM Products WHERE productId = ?";
        DBConnect dbConnect = null;

        try {
            // Initialize DBConnect and get the connection
            dbConnect = new DBConnect();
            dbConnect.conn.setAutoCommit(false);  // Start transaction

            // Delete from Cart table
            try (PreparedStatement deleteCartStmt = dbConnect.conn.prepareStatement(deleteCartSql)) {
                deleteCartStmt.setInt(1, productId);
                deleteCartStmt.executeUpdate();
            }

            // Delete from StockImportDetail table
            try (PreparedStatement deleteStockImportDetailStmt = dbConnect.conn.prepareStatement(deleteStockImportDetailSql)) {
                deleteStockImportDetailStmt.setInt(1, productId);
                deleteStockImportDetailStmt.executeUpdate();
            }

            // Delete from Stock table
            try (PreparedStatement deleteStockStmt = dbConnect.conn.prepareStatement(deleteStockSql)) {
                deleteStockStmt.setInt(1, productId);
                deleteStockStmt.executeUpdate();
            }

            // Delete from Products table
            try (PreparedStatement deleteProductStmt = dbConnect.conn.prepareStatement(deleteProductSql)) {
                deleteProductStmt.setInt(1, productId);

                int rowsDeleted = deleteProductStmt.executeUpdate();
                dbConnect.conn.commit();  // Commit transaction
                return rowsDeleted > 0;
            }

        } catch (SQLException e) {
            if (dbConnect != null && dbConnect.conn != null) {
                try {
                    dbConnect.conn.rollback();  // Rollback transaction if an error occurs
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            e.printStackTrace();
        }
        return false;
    }

    public Product getProductById(int productId) {
        Product product = null;
        try {
            String sql = "SELECT * FROM Products WHERE ProductID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                product = new Product();
                product.setProductId(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setOrigin(rs.getString("Origin"));
                product.setMaterial(rs.getString("Material"));
                product.setPrice(rs.getDouble("Price"));
                product.setCategoryId(rs.getInt("CategoryID"));
                product.setBrandId(rs.getInt("BrandID"));
                // Set other fields if necessary
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    public boolean isProductNameExists(String productName, int productId) {
        boolean exists = false;
        String sql = "SELECT COUNT(*) FROM Products WHERE productName = ? AND productId != ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, productName);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exists;
    }

    public boolean isProductNameExists(String productName) {
        boolean exists = false;
        String sql = "SELECT COUNT(*) FROM Products WHERE productName = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, productName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exists;
    }

    public ProductDetails getProductDetails(int productID) {

        String sql = "select ProductID, ProductName, Origin, Material, Price, TotalQuantity, CategoryName, BrandName, discount_amount, ProductStatus\n"
                + "from Products p, Categories cat, Brand b, Discounts dis\n"
                + "where p.CategoryID = cat.CategoryID and p.BrandID = b.BrandID and "
                + "p.ProductID = dis.discount_id and p.ProductID = ?";

        ProductDetails productDetails = null;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productID);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String productName = rs.getString("ProductName");
                String origin = rs.getString("Origin");
                String material = rs.getString("Material");
                double price = rs.getDouble("Price");
                int totalQuantity = rs.getInt("TotalQuantity");
                String categoryName = rs.getString("CategoryName");
                String brandName = rs.getString("BrandName");
                double discountAmount = rs.getDouble("discount_amount");
                int productStatus = rs.getInt("ProductStatus");

                productDetails = new ProductDetails(productID, productName, origin, material, price,
                        totalQuantity, categoryName, brandName, discountAmount, productStatus);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getProductDetails(): " + e);
        }

        return productDetails;
    }

    public List<ProductStockDetails> getProductStocks(int productID) {

        String sql = "select ProductID, Size, Color, StockQuantity, ImageURL\n"
                + "from Stock s, ProductImages pi\n"
                + "where s.StockID = pi.StockID and s.ProductID = ?";

        ProductStockDetails productStock = null;
        List<ProductStockDetails> productsStocksList = new ArrayList<>();

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productID);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int size = rs.getInt("Size");
                String color = rs.getString("Color");
                int stockQuantity = rs.getInt("StockQuantity");
                String imageURL = rs.getString("ImageURL");

                productStock = new ProductStockDetails(productID, size, color, stockQuantity,
                        imageURL);
                productsStocksList.add(productStock);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getProductStocks(): " + e);
        }

        return productsStocksList;
    }

    public List<ProductStockDetails> getProductColors(int productID) {

        String sql = "select distinct Color, s.ProductID, ImageURL\n"
                + "from Stock s, ProductImages pi\n"
                + "where s.StockID = pi.StockID and s.ProductID = ?";

        ProductStockDetails productColor = null;
        List<ProductStockDetails> productColors = new ArrayList<>();

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productID);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String color = rs.getString("Color");
                String imageURL = rs.getString("ImageURL");

                productColor = new ProductStockDetails(productID, color, imageURL);
                productColors.add(productColor);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getProductColors(): " + e);
        }

        return productColors;
    }

    public List<ProductStockDetails> getSizesByColorAndProductID(int productID, String color) {

        String sql = "select Size, StockQuantity\n"
                + "from Stock s\n"
                + "where Color = ? and s.ProductID = ?";

        ProductStockDetails productSize = null;
        List<ProductStockDetails> productSizes = new ArrayList<>();

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, color);
            ps.setInt(2, productID);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int size = rs.getInt("Size");
                int stockQuantity = rs.getInt("StockQuantity");

                productSize = new ProductStockDetails(size, stockQuantity);
                productSizes.add(productSize);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getSizesByColorAndProductID(): " + e);
        }

        return productSizes;
    }

    public void addProductToWishlist(int accountID, int stockID) {

        String sql = "insert into Wishlist(AccountID, StockID, DateAdded)\n"
                + "values (?, ?, getdate())";

        ProductStockDetails productSize = null;
        List<ProductStockDetails> productSizes = new ArrayList<>();

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, accountID);
            ps.setInt(2, stockID);

            ResultSet rs = ps.executeQuery();

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("addProductToWishlist(): " + e);
        }
    }

    public int getStockIDbyColorAndSizeAndProductID(String color, int size, int productID) {

        String sql = "select StockID\n"
                + "from Stock\n"
                + "where Color = ? and Size = ? and ProductID = ?";

        int stockID = 0;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, color);
            ps.setInt(2, size);
            ps.setInt(3, productID);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("StockID");
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getStockIDbyColorAndSizeAndProductID(): " + e);
        }

        return stockID;
    }

    public boolean getWishlistItemExists(int accountID, int stockID) {

        String sql = "select AccountID, StockID\n"
                + "from Wishlist\n"
                + "where AccountID = ? and StockID = ?";

        boolean wishlistItemExists = false;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, accountID);
            ps.setInt(2, stockID);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getWishlistItemExists(): " + e);
        }

        return wishlistItemExists;
    }

    public int getCartItemsCount(int accountID) {

        String sql = "select count(*) as 'cartItemsCount'\n"
                + "from Cart\n"
                + "where AccountID = ?";

        int cartItemsCount = 0;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, accountID);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getCartItemsCount(): " + e);
        }

        return cartItemsCount;
    }

    public List<Feedback> getFeedbacksForProductID(int productID) {

        String sql = "select ProductID, acc.AccountID, Username, Color, Size, rating, comment, created_at\n"
                + "from Feedback fb, Stock s, Accounts acc\n"
                + "where fb.StockID = s.StockID and acc.AccountID = fb.AccountID and ProductID = ?";

        Feedback feedback = null;
        List<Feedback> feedbacksList = new ArrayList<>();

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productID);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int accountID = rs.getInt("AccountID");
                String username = rs.getString("Username");
                String color = rs.getString("Color");
                int size = rs.getInt("Size");
                int rating = rs.getInt("rating");
                String comment = rs.getString("comment");
                java.sql.Date createdAt = rs.getDate("created_at");

                feedback = new Feedback(productID, accountID, username, color, size,
                        rating, comment, createdAt);
                feedbacksList.add(feedback);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getFeedbacksForProductID(): " + e);
        }

        return feedbacksList;
    }

    public List<String> getAllColors() {
        List<String> colors = new ArrayList<>();
        String sql = "SELECT DISTINCT Color FROM Stock";
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                colors.add(rs.getString("Color"));
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return colors;
    }

    public List<String> getAllMaterials() {
        List<String> materials = new ArrayList<>();
        String sql = "SELECT DISTINCT Material FROM Products";
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                materials.add(rs.getString("Material"));
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return materials;
    }

    public List<Integer> getAllSizes() {
        List<Integer> sizes = new ArrayList<>();
        String sql = "SELECT DISTINCT Size FROM Stock";
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                sizes.add(rs.getInt("Size"));
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sizes;
    }

    public List<Product> getFilteredProducts(List<Integer> brandIds, List<Integer> categoryIds, List<String> colors, List<Integer> sizes, List<String> materials, String query) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT p.ProductID, p.ProductName, p.Origin, p.Material, p.Price, p.TotalQuantity, ");
        sql.append("c.CategoryName, b.BrandName, MIN(pi.ImageURL) AS ImageURL ");
        sql.append("FROM Products p ");
        sql.append("LEFT JOIN Categories c ON p.CategoryID = c.CategoryID ");
        sql.append("LEFT JOIN Brand b ON p.BrandID = b.BrandID ");
        sql.append("LEFT JOIN Stock s ON p.ProductID = s.ProductID ");
        sql.append("LEFT JOIN ProductImages pi ON s.StockID = pi.StockID ");
        sql.append("WHERE p.ProductStatus = 1 "); // Ensure only active products are included

        // Add filtering conditions based on selected filters
        if (!brandIds.isEmpty()) {
            sql.append(" AND p.BrandID IN (").append(brandIds.stream().map(String::valueOf).collect(Collectors.joining(","))).append(")");
        }
        if (!categoryIds.isEmpty()) {
            sql.append(" AND p.CategoryID IN (").append(categoryIds.stream().map(String::valueOf).collect(Collectors.joining(","))).append(")");
        }
        if (!colors.isEmpty()) {
            sql.append(" AND s.Color IN (").append(colors.stream().map(c -> "'" + c + "'").collect(Collectors.joining(","))).append(")");
        }
        if (!sizes.isEmpty()) {
            sql.append(" AND s.Size IN (").append(sizes.stream().map(String::valueOf).collect(Collectors.joining(","))).append(")");
        }
        if (!materials.isEmpty()) {
            sql.append(" AND p.Material IN (").append(materials.stream().map(m -> "'" + m + "'").collect(Collectors.joining(","))).append(")");
        }
        if (query != null && !query.isEmpty()) {
            sql.append(" AND p.ProductName LIKE ?"); // Filter by product name
        }

        sql.append(" GROUP BY p.ProductID, p.ProductName, p.Origin, p.Material, p.Price, p.TotalQuantity, ");
        sql.append("c.CategoryName, b.BrandName"); // Grouping to ensure only main product data is retrieved

        try {
            PreparedStatement ps = conn.prepareStatement(sql.toString());

            // If there's a search query, set it in the PreparedStatement
            if (query != null && !query.isEmpty()) {
                ps.setString(1, "%" + query + "%");
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("ProductID"));
                p.setProductName(rs.getString("ProductName"));
                p.setOrigin(rs.getString("Origin"));
                p.setMaterial(rs.getString("Material"));
                p.setPrice(rs.getDouble("Price"));
                p.setTotalQuantity(rs.getInt("TotalQuantity"));
                p.setCategoryName(rs.getString("CategoryName"));
                p.setBrandName(rs.getString("BrandName"));
                p.setImageURL(rs.getString("ImageURL"));
                products.add(p);
            }
            rs.close();
            ps.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getNewArrivals() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.ProductID, p.ProductName, p.Origin, p.Material, p.Price, p.TotalQuantity, "
                + "c.CategoryName, b.BrandName, MIN(pi.ImageURL) AS ImageURL "
                + "FROM Products p "
                + "JOIN Stock s ON p.ProductID = s.ProductID "
                + "JOIN ProductStockImport psi ON s.ImportID = psi.ImportID "
                + "LEFT JOIN Categories c ON p.CategoryID = c.CategoryID "
                + "LEFT JOIN Brand b ON p.BrandID = b.BrandID "
                + "LEFT JOIN ProductImages pi ON s.StockID = pi.StockID "
                + "WHERE p.ProductStatus = 1 " // Only include active products
                + "AND psi.ImportDate IN (SELECT TOP (5) ImportDate FROM ProductStockImport ORDER BY ImportDate DESC) "
                + "GROUP BY p.ProductID, p.ProductName, p.Origin, p.Material, p.Price, p.TotalQuantity, "
                + "c.CategoryName, b.BrandName";  // Grouping to ensure only main product data is retrieved

        try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setOrigin(rs.getString("Origin"));
                product.setMaterial(rs.getString("Material"));
                product.setPrice(rs.getDouble("Price"));
                product.setTotalQuantity(rs.getInt("TotalQuantity"));
                product.setCategoryName(rs.getString("CategoryName"));
                product.setBrandName(rs.getString("BrandName"));
                product.setImageURL(rs.getString("ImageURL"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getBestSellers() {
        List<Product> bestSellers = new ArrayList<>();
        String sql = "SELECT p.ProductID, p.ProductName, p.Price, MIN(pi.ImageURL) AS ImageURL, SUM(od.Quantity) AS TotalQuantity "
                + "FROM OrderDetails od "
                + "JOIN Stock s ON od.StockID = s.StockID "
                + "JOIN Products p ON s.ProductID = p.ProductID "
                + "LEFT JOIN ProductImages pi ON s.StockID = pi.StockID "
                + "WHERE p.ProductStatus = 1 " // Ensure only active products are included
                + "AND od.OrderID IN (SELECT OrderID FROM Orders WHERE Status = 1) " // Ensure only completed orders are considered
                + "GROUP BY p.ProductID, p.ProductName, p.Price "
                + "ORDER BY TotalQuantity DESC";

        try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setPrice(rs.getDouble("Price"));
                product.setImageURL(rs.getString("ImageURL"));
                bestSellers.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bestSellers;
    }

    public int addProductImage(String imageUrl) {
        int imageId = -1;
        try {
            String sql = "INSERT INTO ProductImages (ImageURL) VALUES (?)";
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, imageUrl);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                imageId = rs.getInt(1); // Get the generated ImageID
            }

            rs.close();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return imageId;
    }

    public List<Order> getAllOrdersByCustomerId(int accountId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.OrderID, p.ProductName, od.SalePrice, i.ImageURL, od.Quantity, "
                + "(od.SalePrice * od.Quantity) AS ProductTotal, "
                + "SUM(od.SalePrice * od.Quantity) OVER (PARTITION BY o.OrderID) AS OrderTotal "
                + "FROM Orders o "
                + "JOIN OrderDetails od ON o.OrderID = od.OrderID "
                + "JOIN Stock s ON od.StockID = s.StockID "
                + "JOIN Products p ON s.ProductID = p.ProductID "
                + "LEFT JOIN ProductImages i ON s.StockID = i.StockID "
                + "WHERE o.AccountID = ? "
                + "ORDER BY o.OrderID";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getInt("OrderID"));
                order.setProductName(rs.getString("ProductName"));
                order.setSalePrice(rs.getDouble("SalePrice"));
                order.setImageUrl(rs.getString("ImageURL"));
                order.setQuantity(rs.getInt("Quantity"));
                order.setProducttotal(rs.getDouble("ProductTotal"));
                order.setOrdertotal(rs.getDouble("OrderTotal"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

}
