/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import model.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author xeban
 */
public class MyDAO extends DBConnect {
  public Connection con = null;
  public PreparedStatement ps = null;
  public ResultSet rs = null;
  public String xSql = null;

  public MyDAO() {
     con = conn;
  }
  
   // Phương thức lấy tên sản phẩm theo ID sản phẩm
    public String getProductNameById(int productId) {
        String productName = null;
        xSql = "SELECT product_name FROM Products WHERE product_id = ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, productId);
            rs = ps.executeQuery();

            if (rs.next()) {
                productName = rs.getString("product_name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return productName;
    }
  
  public void finalize() {
     try {
        if(con != null) con.close();
     }
     catch(Exception e) {
        e.printStackTrace();
     }
  }
  
  // Method to update discount amounts by both CategoryID and BrandID
    public boolean updateDiscountByBoth(int categoryID, int brandID, double newDiscountAmount) {
        boolean isSuccess = false;
        
        try {
            // First, find all products with the given CategoryID and BrandID
            String sqlFindProducts = "SELECT ProductID FROM Products WHERE CategoryID = ? AND BrandID = ?";
            ps = con.prepareStatement(sqlFindProducts);
            ps.setInt(1, categoryID);
            ps.setInt(2, brandID);
            rs = ps.executeQuery();

            List<Integer> productIDs = new ArrayList<>();
            while (rs.next()) {
                productIDs.add(rs.getInt("ProductID"));
            }

            // If no products found for this CategoryID and BrandID, exit
            if (productIDs.isEmpty()) {
                return false;
            }

            // Now, update discount amounts for these products
            String sqlUpdateDiscounts = "UPDATE Discounts SET discount_amount = ? WHERE product_id = ?";
            ps = con.prepareStatement(sqlUpdateDiscounts);

            for (int productID : productIDs) {
                ps.setDouble(1, newDiscountAmount);
                ps.setInt(2, productID);
                ps.addBatch();
            }

            int[] rowsAffected = ps.executeBatch();
            isSuccess = (rowsAffected.length > 0);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return isSuccess;
    }

}
