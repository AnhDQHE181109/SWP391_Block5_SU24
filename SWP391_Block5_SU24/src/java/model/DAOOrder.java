/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.Order;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DAOOrder extends MyDAO {

    // Method to add a new order
    public int addOrder(Order order) {
        int result = 0;
        try {
            xSql = "INSERT INTO Orders (orderID, accountID, orderDate, status) VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(xSql);
            ps.setInt(1, order.getOrderID());
            ps.setInt(2, order.getAccountID());
            ps.setDate(3, new java.sql.Date(order.getOrderDate().getTime()));
            ps.setString(4, order.getStatus());
            result = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    // Method to update an existing order
    public int updateOrder(Order order) {
        int result = 0;
        try {
            xSql = "UPDATE Orders SET accountID = ?, orderDate = ?, status = ? WHERE orderID = ?";
            ps = con.prepareStatement(xSql);
            ps.setInt(1, order.getAccountID());
            ps.setDate(2, new java.sql.Date(order.getOrderDate().getTime()));
            ps.setString(3, order.getStatus());
            ps.setInt(4, order.getOrderID());
            result = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    // Method to delete an order by ID
    public int deleteOrder(int orderID) {
        int result = 0;
        try {
            xSql = "DELETE FROM Orders WHERE orderID = ?";
            ps = con.prepareStatement(xSql);
            ps.setInt(1, orderID);
            result = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    // Method to retrieve an order by ID
    public Order getOrderById(int orderID) {
        Order order = null;
        try {
            xSql = "SELECT * FROM Orders WHERE orderID = ?";
            ps = con.prepareStatement(xSql);
            ps.setInt(1, orderID);
            rs = ps.executeQuery();
            if (rs.next()) {
                int accountID = rs.getInt("accountID");
                Date orderDate = rs.getDate("orderDate");
                String status = rs.getString("status");
                order = new Order(orderID, accountID, orderDate, status);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return order;
    }

    // Method to retrieve all orders
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        try {
            xSql = "SELECT * FROM Orders";
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int orderID = rs.getInt("orderID");
                int accountID = rs.getInt("accountID");
                Date orderDate = rs.getDate("orderDate");
                String status = rs.getString("status");
                orders.add(new Order(orderID, accountID, orderDate, status));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return orders;
    }

    public List<Order> getOrdersByUsername(String username) {
        List<Order> orders = new ArrayList<>();
        // Use % for partial matching in SQL
        xSql = "SELECT o.* FROM Orders o JOIN Accounts a ON o.AccountID = a.AccountID WHERE a.username LIKE ?";
        
        try {
            ps = con.prepareStatement(xSql);
            // Add % wildcard characters to allow partial matching
            ps.setString(1, "%" + username + "%");
            rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getInt("OrderID"));
                order.setAccountID(rs.getInt("AccountID"));
                order.setOrderDate(rs.getDate("OrderDate")); // Adjust as necessary
                order.setStatus(rs.getString("status")); // Adjust as necessary

                // Set other fields...
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return orders;
    }


    public List<Order> getOrdersByDate(String orderDate) {
        List<Order> orders = new ArrayList<>();
        xSql = "SELECT * FROM Orders WHERE OrderDate = ?";
        
        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, orderDate);
            rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getInt("OrderID"));
                order.setAccountID(rs.getInt("AccountID"));
                order.setOrderDate(rs.getDate("OrderDate")); // Adjust as necessary
                order.setStatus(rs.getString("status")); // Adjust as necessary
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return orders;
    }
    
    public List<Order> getOrdersByStatus(String status) {
    List<Order> orders = new ArrayList<>();
    xSql = "SELECT * FROM Orders WHERE status = ?";
    
    try {
        ps = con.prepareStatement(xSql);
        ps.setString(1, status);
        rs = ps.executeQuery();

        while (rs.next()) {
            Order order = new Order();
            order.setOrderID(rs.getInt("OrderID"));
            order.setAccountID(rs.getInt("AccountID"));
            order.setOrderDate(rs.getDate("OrderDate"));
            order.setStatus(rs.getString("status"));
            orders.add(order);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        closeResources();
    }
    return orders;
}

public List<Order> getOrdersByDateRange(String startDate, String endDate) {
    List<Order> orders = new ArrayList<>();
    xSql = "SELECT * FROM Orders WHERE OrderDate BETWEEN ? AND ?";
    
    try {
        ps = con.prepareStatement(xSql);
        ps.setString(1, startDate);
        ps.setString(2, endDate);
        rs = ps.executeQuery();

        while (rs.next()) {
            Order order = new Order();
            order.setOrderID(rs.getInt("OrderID"));
            order.setAccountID(rs.getInt("AccountID"));
            order.setOrderDate(rs.getDate("OrderDate"));
            order.setStatus(rs.getString("status"));
            orders.add(order);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        closeResources();
    }
    return orders;
}

        private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
        // Method to update the status of an order by orderID
public int updateOrderStatus(int orderID, String newStatus) {
    int result = 0;
    try {
        xSql = "UPDATE Orders SET status = ? WHERE orderID = ?";
        ps = con.prepareStatement(xSql);
        ps.setString(1, newStatus);
        ps.setInt(2, orderID);
        result = ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        closeResources();
    }
    return result;
}

        
}