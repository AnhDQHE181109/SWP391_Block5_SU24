/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.ProductStockDetails;
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
public class ShoppingCartDAO extends DBConnect {

    public List<ShoppingCartItem> getCartItemsByAccountID(int accountID) {

        String sql = "select p.ProductID, s.StockID, p.ProductName, Color, Size, Price, quantity, discount_amount, ImageURL\n"
                + "from Stock s, Products p, Cart cart, ProductImages pi, Discounts dis\n"
                + "where s.ProductID = p.ProductID and s.StockID = cart.StockID and\n"
                + "pi.StockID = s.StockID and p.ProductID = dis.product_id and cart.AccountID = ?";

        ShoppingCartItem cartItem = null;
        List<ShoppingCartItem> cartItems = new ArrayList<>();

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, accountID);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int productID = rs.getInt("ProductID");
                int stockID = rs.getInt("StockID");
                String productName = rs.getString("ProductName");
                String color = rs.getString("Color");
                int size = rs.getInt("Size");
                double price = rs.getDouble("Price");
                int quantity = rs.getInt("quantity");
                double discountAmount = rs.getDouble("discount_amount");
                String imageURL = rs.getString("ImageURL");

                cartItem = new ShoppingCartItem(productID, stockID, productName, color, size, price, quantity, discountAmount, imageURL);
                cartItems.add(cartItem);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getCartItemsByAccountID(): " + e);
        }

        return cartItems;
    }

    public void addProductToCart(int accountID, int stockID, int quantity, int productID) {

        int discountID = getDiscountIDbyProductID(productID);

        String sql = "insert into Cart(AccountID, StockID, quantity, DiscountID, date_added)\n"
                + "values (?, ?, ?, ?, getdate())";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, accountID);
            ps.setInt(2, stockID);
            ps.setInt(3, quantity);
            ps.setInt(4, discountID);

            ResultSet rs = ps.executeQuery();

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("addProductToWishlist(): " + e);
        }
    }

    public int getProductIDbyStockID(int stockID) {

        String sql = "select ProductID, StockID\n"
                + "from Stock\n"
                + "where StockID = ?";

        int productID = -1;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, stockID);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                productID = rs.getInt(1);
                return productID;
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getProductIDbyStockID(): " + e);
        }

        return productID;
    }

    public int getDiscountIDbyProductID(int productID) {

        String sql = "select discount_id, product_id, discount_amount\n"
                + "from Discounts \n"
                + "where product_id = ?";

        int discountID = 0;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productID);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                discountID = rs.getInt(1);
                return discountID;
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getDiscountIDbyProductID(): " + e);
        }

        return discountID;
    }

    public int getCartQuantityOfStockID(int accountID, int stockID) {

        String sql = "select StockID, quantity\n"
                + "from Cart\n"
                + "where AccountID = ? and StockID = ?";

        int quantity = -1;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, accountID);
            ps.setInt(2, stockID);

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
            System.out.println("getCartQuantityOfStockID(): " + e);
        }

        return quantity;
    }

    public int getStockQuantityOfStockID(int stockID) {

        String sql = "select StockID, StockQuantity \n"
                + "from Stock s\n"
                + "where StockID = ?";

        int quantity = -1;

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
            System.out.println("getStockQuantityOfStockID(): " + e);
        }

        return quantity;
    }

    public void setCartQuantity(int quantity, int accountID, int stockID) {

        String sql = "update Cart\n"
                + "set quantity = ?\n"
                + "where AccountID = ? and StockID = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, accountID);
            ps.setInt(3, stockID);

            ResultSet rs = ps.executeQuery();

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("setCartQuantity(): " + e);
        }
    }

    public void removeProductFromCart(int accountID, int stockID) {

        String sql = "delete\n"
                + "from Cart\n"
                + "where AccountID = ? and StockID = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, accountID);
            ps.setInt(2, stockID);

            ResultSet rs = ps.executeQuery();

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("removeProductFromCart(): " + e);
        }
    }

}
