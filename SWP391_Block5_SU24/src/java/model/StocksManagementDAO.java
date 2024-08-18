/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Product;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

/**
 *
 * @author ASUS
 */
public class StocksManagementDAO extends DBConnect {

    public static void main(String[] args) {
        StocksManagementDAO smDAO = new StocksManagementDAO();
//        List<Product> productsStocksList = smDAO.getProductsStocks();
//        for (Product product : productsStocksList) {
//            System.out.println(product);
//        }
//        smDAO.logAccount(3);

        List<Product> loggedProducts = new ArrayList<>();
        Product prod = new Product(5, 1, 45, "White", 20);
        loggedProducts.add(prod);
        smDAO.logUpdatedProducts(3, loggedProducts);
    }

    public List<Product> getAllProducts() {

        String sql = "select p.ProductID, BrandName, ProductName, CategoryName, ImageURL\n"
                + "from Products p, ProductImages pi, Brand b, Categories c\n"
                + "where p.ImageID = pi.ImageID and b.BrandID = p.BrandID and c.CategoryID = p.CategoryID";

        Product product = null;
        List<Product> list = new ArrayList<>();

        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                product = new Product(rs.getInt(1), rs.getString(2), rs.getString(3), 
                        rs.getString(4), rs.getString(5));
                list.add(product);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getAllProducts(): " + e);
        }

        return list;
    }

    public List<Product> getProductsStocks() {

        String sql = "select s.StockID, p.ProductID, p.ProductName, Size, Color, StockQuantity\n"
                + "from Products p, Stock s\n"
                + "where p.ProductID = s.ProductID";

        Product product = null;
        List<Product> productsStocksList = new ArrayList<>();

        try {
            PreparedStatement ps = conn.prepareStatement(sql);

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

    public void setProductStock(int stockID, int quantity) {

        String sql = "update Stock\n"
                + "set StockQuantity = ?\n"
                + "where StockID = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, stockID);

            ResultSet rs = ps.executeQuery();

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("setProductStock(): " + e);
        }
    }

    public Product getProductStockByStockID(int stockID) {

        String sql = "select s.StockID, p.ProductID, Size, Color, StockQuantity\n"
                + "from Products p, Stock s\n"
                + "where p.ProductID = s.ProductID and s.StockID = ?";

        Product product = null;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, stockID);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                product = new Product(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getString(4),
                        rs.getInt(5));
                return product;
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getProductStockByStockID(): " + e);
        }

        return product;
    }

    public String getProductNameByID(int productID) {

        String sql = "select ProductName\n"
                + "from Products\n"
                + "where ProductID = ?";

        Product product = null;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productID);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getProductNameByID(): " + e);
        }

        return null;
    }

    public int getProductStockQuantityByID(int stockID) {

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
            System.out.println("getProductStockQuantityByID(): " + e);
        }

        return 0;
    }

    public void addNewProductVariant(int productID, int size, String color, int quantity, int importID) {

        String sql = "insert into Stock(ProductID, Size, Color, StockQuantity, ImportID) \n"
                + "values (?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productID);
            ps.setInt(2, size);
            ps.setString(3, color);
            ps.setInt(4, quantity);
            ps.setInt(5, importID);

            ResultSet rs = ps.executeQuery();

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("addNewProductVariant(): " + e);
        }
    }

    public Boolean checkIfStockExists(int size, String color) {

        String sql = "select Size, Color\n"
                + "from Stock\n"
                + "where Size = ? and Color = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, size);
            ps.setString(2, color);

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
            System.out.println("checkIfStockExists(): " + e);
        }

        return false;
    }

    //User activity logging functions
    public void logAccount(int accountID) {

        String sql = "insert into ProductStockImport(AccountID, ImportDate) \n"
                + "values (?, getdate())";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, accountID);

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

    public int logAccountAndGetImportID(int accountID) {
        logAccount(accountID);

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

    public void logUpdatedProducts(int accountID, List<Product> loggedProducts) {
        int importID = logAccountAndGetImportID(accountID);
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
