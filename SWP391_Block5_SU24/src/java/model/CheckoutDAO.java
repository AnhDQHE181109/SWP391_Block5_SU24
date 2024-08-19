/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.CheckoutItem;
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
public class CheckoutDAO extends DBConnect {

    public List<CheckoutItem> getCartItems(int accountID) {

        String sql = "select p.ProductID, s.StockID, p.ProductName, Color, Size, Price, quantity, discount_amount, ImageURL\n"
                + "from Stock s, Products p, Cart cart, ProductImages pi, Discounts dis\n"
                + "where s.ProductID = p.ProductID and s.StockID = cart.StockID and\n"
                + "pi.StockID = s.StockID and p.ProductID = dis.product_id and cart.AccountID = ?";

        ShoppingCartItem cartItem = null;
        List<CheckoutItem> cartItems = new ArrayList<>();

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

}
