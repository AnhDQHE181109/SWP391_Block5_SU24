/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Brand;
import entity.Category;
import entity.Product;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;

/**
 *
 * @author ASUS
 */
public class ProductDetailsDAO extends DBConnect {

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT p.ProductID, p.ProductName, p.Origin, p.Material, p.Price, p.TotalQuantity, "
                    + "c.CategoryName, b.BrandName, p.ImageID "
                    + "FROM Products p "
                    + "LEFT JOIN Categories c ON p.CategoryID = c.CategoryID "
                    + "LEFT JOIN Brand b ON p.BrandID = b.BrandID";
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
                p.setImageId(rs.getInt("ImageID"));
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
}
