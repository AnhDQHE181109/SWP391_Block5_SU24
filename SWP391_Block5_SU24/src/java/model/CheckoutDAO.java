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

    public CheckoutItem getBillingDetails(int accountID) {

        String sql = "select Name, Address, Email, PhoneNumber\n"
                + "from Accounts\n"
                + "where AccountID = ?";

        CheckoutItem checkoutItem = null;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, accountID);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String name = rs.getString("Name");
                String address = rs.getString("Address");
                String email = rs.getString("Email");
                String phoneNumber = rs.getString("PhoneNumber");

                checkoutItem = new CheckoutItem(name, address, email, phoneNumber);
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getBillingDetails(): " + e);
        }

        return checkoutItem;
    }

    public void addToOrders(int accountID) {

        String sql = "insert into Orders(AccountID, OrderDate, Status)\n"
                + "values (?, getdate(), 0)";

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
            System.out.println("addToOrders(): " + e);
        }

    }

    public int getLatestOrderIDbyAccountID(int accountID) {

        String sql = "select top 1 OrderID, AccountID\n"
                + "from Orders\n"
                + "where AccountID = ?\n"
                + "order by OrderID desc";

        int orderID = -1;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, accountID);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("OrderID");
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getLatestOrderIDbyAccountID(): " + e);
        }

        return orderID;
    }

    public void addToOrderDetails(int orderID, int stockID, int quantity, double salePrice) {

        String sql = "insert into OrderDetails(OrderID, StockID, Quantity, SalePrice)\n"
                + "values (?, ?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderID);
            ps.setInt(2, stockID);
            ps.setInt(3, quantity);
            ps.setDouble(4, salePrice);

            ResultSet rs = ps.executeQuery();

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("addToOrderDetails(): " + e);
        }

    }

    public void clearShoppingCart(int accountID) {

        String sql = "delete\n"
                + "from Cart\n"
                + "where AccountID = ?";

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
            System.out.println("clearShoppingCart(): " + e);
        }

    }

    public void addCartToOrder(int accountID) {
        ShoppingCartDAO scDAO = new ShoppingCartDAO();

        List<ShoppingCartItem> cartItems = scDAO.getCartItemsByAccountID(accountID);
        
        addToOrders(accountID);
        int orderID = getLatestOrderIDbyAccountID(accountID);

        for (ShoppingCartItem cartItem : cartItems) {
            int stockID = cartItem.getStockID();
            int quantity = cartItem.getQuantity();
            double discountedPrice = cartItem.getPrice() - ((cartItem.getPrice() * cartItem.getDiscountAmount()) / 100);
            double salePrice = discountedPrice * quantity;

            addToOrderDetails(orderID, stockID, quantity, salePrice);
        }

        clearShoppingCart(accountID);
    }

    public String getNameByAccountID(int accountID) {

        String sql = "select AccountID, Name\n"
                + "from Accounts\n"
                + "where AccountID = ?";

        String name = null;

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, accountID);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("Name");
            }

            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
        } catch (SQLException e) {
            System.out.println("getNameByAccountID(): " + e);
        }

        return name;
    }

}
