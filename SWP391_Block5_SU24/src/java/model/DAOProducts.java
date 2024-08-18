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
