package model;

import entity.OrderDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DAOOrderDetail extends MyDAO {

    public DAOOrderDetail() {
        super();
    }

    // Create or Insert a new OrderDetail
    public boolean insertOrderDetail(OrderDetail orderDetail) {
        boolean result = false;
        String sql = "INSERT INTO OrderDetail (orderID, stockID, quantity, salePrice) VALUES (?, ?, ?, ?)";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, orderDetail.getOrderID());
            ps.setInt(2, orderDetail.getStockID());
            ps.setInt(3, orderDetail.getQuantity());
            ps.setDouble(4, orderDetail.getSalePrice());
            int rowsAffected = ps.executeUpdate();
            result = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // Read or Retrieve an OrderDetail by its ID
    public OrderDetail getOrderDetailById(int orderDetailID) {
        OrderDetail orderDetail = null;
        String sql = "SELECT * FROM OrderDetails WHERE orderDetailID = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, orderDetailID);
            rs = ps.executeQuery();
            if (rs.next()) {
                orderDetail = new OrderDetail(
                    rs.getInt("orderDetailID"),
                    rs.getInt("orderID"),
                    rs.getInt("stockID"),
                    rs.getInt("quantity"),
                    rs.getDouble("salePrice")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetail;
    }

    // Update an existing OrderDetail
    public boolean updateOrderDetail(OrderDetail orderDetail) {
        boolean result = false;
        String sql = "UPDATE OrderDetail SET orderID = ?, stockID = ?, quantity = ?, salePrice = ? WHERE orderDetailID = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, orderDetail.getOrderID());
            ps.setInt(2, orderDetail.getStockID());
            ps.setInt(3, orderDetail.getQuantity());
            ps.setDouble(4, orderDetail.getSalePrice());
            ps.setInt(5, orderDetail.getOrderDetailID());
            int rowsAffected = ps.executeUpdate();
            result = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // Delete an OrderDetail by its ID
    public boolean deleteOrderDetail(int orderDetailID) {
        boolean result = false;
        String sql = "DELETE FROM OrderDetails WHERE orderDetailID = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, orderDetailID);
            int rowsAffected = ps.executeUpdate();
            result = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    // Get all OrderDetails for a specific orderID
    public List<OrderDetail> getOrderDetailsByOrderId(int orderID) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT * FROM OrderDetails WHERE orderID = ?";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, orderID);
            rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetail orderDetail = new OrderDetail(
                    rs.getInt("orderDetailID"),
                    rs.getInt("orderID"),
                    rs.getInt("stockID"),
                    rs.getInt("quantity"),
                    rs.getDouble("salePrice")
                );
                orderDetails.add(orderDetail);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetails;
    }
}
