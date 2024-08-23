/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Product;
import entity.ShoppingCartItem;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class ProductStocksImportDAO extends DBConnect {

    //User activity logging functions
    public void logAccount(int accountID, String supplierName) {

        String sql = "insert into ProductStockImport(AccountID, ImportDate, ImportAction, SupplierName)\n"
                + "values (?, getdate(), 0, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, accountID);
            ps.setString(2, supplierName);

            ResultSet rs = ps.executeQuery();

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("logAccount(): " + e);
        }
    }

    public int logAccountAndGetImportID(int accountID, String supplierName) {
        logAccount(accountID, supplierName);

        String sql = "select top 1 ImportID, AccountID\n"
                + "from ProductStockImport\n"
                + "order by ImportID desc";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);

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
            System.out.println("logAccountAndGetImportID(): " + e);
        }

        return -1;
    }

    public void logUserUpdateActivity(int stockID, int importID, int stockQuantity) {

        String sql = "insert into StockImportDetail(StockID, ImportID, StockQuantity)\n"
                + "values (?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, stockID);
            ps.setInt(2, importID);
            ps.setInt(3, stockQuantity);

            ResultSet rs = ps.executeQuery();
            
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("logUserUpdateActivity(): " + e);
        }
    }

    public void logUpdatedProducts(int accountID, String supplierName, List<Product> loggedProducts) {
        int importID = logAccountAndGetImportID(accountID, supplierName );
        //Debugging
        System.out.println("logUpdatedProducts(): " + "accountID: " + accountID);
        System.out.println("logUpdatedProducts(): " + "importID: " + importID);
        for (Product product : loggedProducts) {
            int stockID = product.getStockID();
            int stockQuantity = product.getStockQuantity();
            logUserUpdateActivity(stockID, importID, stockQuantity);
        }
    }

    public void logUpdatedProducts(int accountID, int importID, List<Product> loggedProducts) {
        //Debugging
        System.out.println("logUpdatedProducts(): " + "accountID: " + accountID);
        System.out.println("logUpdatedProducts(): " + "importID: " + importID);
        for (Product product : loggedProducts) {
            int stockID = product.getStockID();
            int productID = product.getProductId();
            int size = product.getSize();
            String color = product.getColor();
            int stockQuantity = product.getStockQuantity();
            logUserUpdateActivity(stockID, importID, stockQuantity);
        }
    }

}
