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

        String sql = "select p.ProductID, p.ProductName, Color, Size, Price, quantity, ImageURL\n"
                + "from Stock s, Products p, Cart cart, ProductImages pi\n"
                + "where s.ProductID = p.ProductID and s.StockID = cart.StockID and "
                + "pi.StockID = s.StockID and cart.AccountID = ?";

        ShoppingCartItem cartItem = null;
        List<ShoppingCartItem> cartItems = new ArrayList<>();

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, accountID);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int productID = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                String color = rs.getString("Color");
                int size = rs.getInt("Size");
                double price = rs.getDouble("Price");
                int quantity = rs.getInt("quantity");
                String imageURL = rs.getString("ImageURL");

                cartItem = new ShoppingCartItem(productID, productName, color, size, price, quantity, imageURL);
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
