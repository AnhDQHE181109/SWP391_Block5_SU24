package model;

import entity.Products;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOProduct extends MyDAO {

    // Method to get all products
    public List<Products> getAllProducts() {
        List<Products> products = new ArrayList<>();
        xSql = "SELECT * FROM Products"; // Adjust table name and columns as per your database

        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Products product = new Products(
                    rs.getInt("productId"),
                    rs.getString("productName"),
                    rs.getString("Origin"),
                    rs.getString("Material"),
                    rs.getDouble("Price"),
                    rs.getInt("TotalQuantity"),
                    rs.getInt("CategoryID"),
                    rs.getInt("BrandID"),
                    rs.getInt("ImageID"),
                    rs.getInt("ProductStatus")
                );
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return products;
    }

    // Method to get a product by ID
    public Products getProductById(int productId) {
        Products product = null;
        xSql = "SELECT * FROM Products WHERE productId = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, productId);
            rs = ps.executeQuery();
            if (rs.next()) {
                product = new Products(
                    rs.getInt("productID"),
                    rs.getString("productName"),
                    rs.getString("Origin"),
                    rs.getString("Material"),
                    rs.getDouble("Price"),
                    rs.getInt("TotalQuantity"),
                    rs.getInt("CategoryID"),
                    rs.getInt("BrandID"),
                    rs.getInt("ImageID"),
                    rs.getInt("ProductStatus")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return product;
    }

    // Method to add a new product
    public boolean addProduct(Products product) {
        xSql = "INSERT INTO Products (productName, Origin, Material, Price, TotalQuantity, CategoryID, BrandID, ImageID, ProductStatus, Gender) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, product.getProductName());
            ps.setString(2, product.getOrigin());
            ps.setString(3, product.getMaterial());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getTotalQuantity());
            ps.setInt(6, product.getCategoryID());
            ps.setInt(7, product.getBrandID());
            ps.setInt(8, product.getImageID());
            ps.setInt(9, product.getProductStatus());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Method to update an existing product
    public boolean updateProduct(Products product) {
        xSql = "UPDATE Products SET productName = ?, Origin = ?, Material = ?, Price = ?, TotalQuantity = ?, CategoryID = ?, BrandID = ?, ImageID = ?, ProductStatus = ?, Gender = ? WHERE productId = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, product.getProductName());
            ps.setString(2, product.getOrigin());
            ps.setString(3, product.getMaterial());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getTotalQuantity());
            ps.setInt(6, product.getCategoryID());
            ps.setInt(7, product.getBrandID());
            ps.setInt(8, product.getImageID());
            ps.setInt(9, product.getProductStatus());
            ps.setInt(11, product.getProductId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Method to delete a product by ID
    public boolean deleteProduct(int productId) {
        xSql = "DELETE FROM Products WHERE productId = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, productId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
        // New method to get product name by ID
    public String getProductNameById(int productId) {
        String productName = null;
        xSql = "SELECT productName  FROM Products WHERE productId = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, productId);
            rs = ps.executeQuery();
            if (rs.next()) {
                productName = rs.getString("productName");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return productName;
    }
}
