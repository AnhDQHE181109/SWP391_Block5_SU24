/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Product;
import entity.ProductStockImport;
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

    public int getProductStockQuantityByStockID(int stockID) {

        String sql = "select s.StockID, StockQuantity\n"
                + "from Products p, Stock s\n"
                + "where p.ProductID = s.ProductID and s.StockID = ?";

        Product product = null;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, stockID);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(2);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getProductStockQuantityByStockID(): " + e);
        }

        return 0;
    }

    public List<ProductStockImport> findProductsByCriteria(String criteria) {

        String sql = "select ProductID, ProductName, imageURL\n"
                + "from Products p, ProductImages pi\n"
                + "where p.ImageID = pi.ImageID and ProductName like ?";

        ProductStockImport productStock = null;
        List<ProductStockImport> resultsList = new ArrayList<>();

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + criteria + "%");

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int productID = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                String imageURL = rs.getString("imageURL");

                productStock = new ProductStockImport(productID, imageURL, productName);
                resultsList.add(productStock);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("findProductsByCriteria(): " + e);
        }

        return resultsList;
    }

    public int getProductIDbyProductName(String productName) {

        String sql = "select ProductID, ProductName\n"
                + "from Products\n"
                + "where ProductName = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, productName);

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
            System.out.println("getProductIDbyProductName(): " + e);
        }

        return 0;
    }

    public String getImageURLbyProductID(int productID) {

        String sql = "select ProductID, ProductName, ImageURL\n"
                + "from Products p, ProductImages pi\n"
                + "where p.ImageID = pi.ImageID and p.ProductID = ?";

        String imageURL = null;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productID);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                imageURL = rs.getString("ImageURL");
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getImageURLbyProductID(): " + e);
        }

        return imageURL;
    }

    public int getStockIDbyColorSizeProductID(String color, int size, int productID) {

        String sql = "select s.StockID, StockQuantity\n"
                + "from Products p, Stock s\n"
                + "where p.ProductID = s.ProductID and s.Color = ? and s.Size = ? and s.ProductID = ?";

        int stockID = 0;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, color);
            ps.setInt(2, size);
            ps.setInt(3, productID);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                stockID = rs.getInt(1);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getStockIDbyColorSizeProductID(): " + e);
        }

        return stockID;
    }

    public int getStockQuantityByColorSizeProductID(String color, int size, int productID) {

        String sql = "select s.StockID, StockQuantity\n"
                + "from Products p, Stock s\n"
                + "where p.ProductID = s.ProductID and s.Color = ? and s.Size = ? and s.ProductID = ?";

        int stockQuantity = 0;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, color);
            ps.setInt(2, size);
            ps.setInt(3, productID);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                stockQuantity = rs.getInt(2);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getStockQuantityByColorSizeProductID(): " + e);
        }

        return stockQuantity;
    }

    public void incrementQuantityToStockID(int quantity, int stockID) {

        int stockQuantity = getProductStockQuantityByStockID(stockID);

        String sql = "update Stock\n"
                + "set StockQuantity = ?\n"
                + "where StockID = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, stockQuantity + quantity);
            ps.setInt(2, stockID);

            ResultSet rs = ps.executeQuery();

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("incrementQuantityToStockID(): " + e);
        }

    }

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

    public void logUpdatedProducts(int accountID, String supplierName, List<ProductStockImport> loggedProducts) {
        int importID = logAccountAndGetImportID(accountID, supplierName);

        //Debugging
        System.out.println("logUpdatedProducts(): " + "accountID: " + accountID);
        System.out.println("logUpdatedProducts(): " + "importID: " + importID);

        for (ProductStockImport productStock : loggedProducts) {
            int productID = getProductIDbyProductName(productStock.getProductName());
            String color = productStock.getProductColor();
            int size = productStock.getProductSize();
            int stockID = getStockIDbyColorSizeProductID(color, size, productID);

            int stockQuantity = getStockQuantityByColorSizeProductID(color, size, productID);

            logUserUpdateActivity(stockID, importID, stockQuantity + productStock.getQuantity());
        }
    }

    public void logUpdatedProducts(int accountID, int importID, List<ProductStockImport> loggedProducts) {
        //Debugging
        System.out.println("logUpdatedProducts(): " + "accountID: " + accountID);
        System.out.println("logUpdatedProducts(): " + "importID: " + importID);

        for (ProductStockImport productStock : loggedProducts) {
            int productID = getProductIDbyProductName(productStock.getProductName());
            String color = productStock.getProductColor();
            int size = productStock.getProductSize();
            int stockID = getStockIDbyColorSizeProductID(color, size, productID);

            int stockQuantity = getStockQuantityByColorSizeProductID(color, size, productID);

            logUserUpdateActivity(stockID, importID, stockQuantity + productStock.getQuantity());
        }
    }

}
