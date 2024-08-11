package model;

import entity.Product;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOProducts extends MyDAO {

    public DAOProducts() {
        super();
    }

    // Method to get product name by product ID
    public String getProductNameByID(int productID) {
        String productName = null;
        xSql = "SELECT ProductName FROM Products WHERE ProductID = ?";
        
        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, productID);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                productName = rs.getString("ProductName");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error getting product name for ID: " + productID + ". Error: " + e.getMessage());
        } finally {
            closeResources();
        }
        return productName;
    }

    // Method to get products by name
    public List<Product> getProductsByName(String productName) {
        List<Product> productList = new ArrayList<>();
        xSql = "SELECT * FROM Products WHERE ProductName LIKE ?";
        
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, "%" + productName + "%");
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setOrigin(rs.getString("Origin"));
                product.setMaterial(rs.getString("Material"));
                product.setPrice(rs.getBigDecimal("Price"));
                product.setTotalQuantity(rs.getInt("TotalQuantity"));
                product.setCategoryID(rs.getInt("CategoryID"));
                product.setBrandID(rs.getInt("BrandID"));
                product.setImageID(rs.getInt("ImageID"));
                
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error getting products by name: " + productName + ". Error: " + e.getMessage());
        } finally {
            closeResources();
        }
        return productList;
    }

    // Method to close resources
    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
