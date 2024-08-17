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

    public List<Product> getProductStocks(int productID) {

        String sql = "select s.StockID, p.ProductID, p.ProductName, Size, Color, StockQuantity\n"
                + "from Products p, Stock s\n"
                + "where p.ProductID = s.ProductID and p.productID = ?";

        Product product = null;
        List<Product> productsStocksList = new ArrayList<>();

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productID);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                product = new Product(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getInt(4),
                        rs.getString(5), rs.getInt(6));
                productsStocksList.add(product);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getProductsStocks(): " + e);
        }

        return productsStocksList;
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
    public List<Product> getFilteredProducts(List<Integer> brandIds, List<Integer> categoryIds, List<String> colors, List<Integer> sizes, List<String> materials) {
    List<Product> products = new ArrayList<>();
    StringBuilder sql = new StringBuilder("SELECT p.ProductID, p.ProductName, p.Origin, p.Material, p.Price, p.TotalQuantity, ");
    sql.append("c.CategoryName, b.BrandName, pi.ImageURL ");
    sql.append("FROM Products p ");
    sql.append("LEFT JOIN Categories c ON p.CategoryID = c.CategoryID ");
    sql.append("LEFT JOIN Brand b ON p.BrandID = b.BrandID ");
    sql.append("LEFT JOIN Stock s ON p.ProductID = s.ProductID ");
    sql.append("LEFT JOIN ProductImages pi ON s.StockID = pi.StockID WHERE 1=1");

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

    try {
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery(sql.toString());
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
        st.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return products;
}

}
