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
        List<Product> productsStocksList = smDAO.getProductsStocks();
        for (Product product : productsStocksList) {
            System.out.println(product);
        }
    }

    public List<Product> getAllProducts() {

        String sql = "select p.ProductID, ProductName, ImageURL\n"
                + "from Products p, ProductImages pi\n"
                + "where p.ProductID = pi.ProductID";

        Product product = null;
        List<Product> list = new ArrayList<>();

        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                product = new Product(rs.getInt(1), rs.getString(2), rs.getString(3));
                list.add(product);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }

    public List<Product> getProductsStocks() {

        String sql = "select p.ProductID, p.ProductName, Size, Color, StockQuantity\n"
                + "from Products p, Stock s\n"
                + "where p.ProductID = s.ProductID";

        Product product = null;
        List<Product> productsStocksList = new ArrayList<>();

        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                product = new Product(rs.getInt(1), rs.getString(2), rs.getInt(3),
                        rs.getString(4), rs.getInt(5));
                productsStocksList.add(product);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return productsStocksList;
    }

    public void setProductStock(int productID, int quantity) {

        String sql = "update Stock\n"
                + "set StockQuantity = ?\n"
                + "where ProductID = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, productID);

            ResultSet rs = ps.executeQuery();

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Product getProductStockByID(int productID) {

        String sql = "select p.ProductID, Size, Color\n"
                + "from Products p, Stock s\n"
                + "where p.ProductID = s.ProductID and p.ProductID = ?";

        Product product = null;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productID);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                product = new Product(rs.getInt(1), rs.getInt(2), rs.getString(3));
                return product;
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println(e);
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
            System.out.println(e);
        }

        return null;
    }

    public int getProductStockQuantityByID(int productID) {

        String sql = "select p.ProductID, StockQuantity\n"
                + "from Products p, Stock s\n"
                + "where p.ProductID = s.ProductID and p.ProductID = ?";

        Product product = null;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productID);

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
            System.out.println(e);
        }

        return 0;
    }
}
