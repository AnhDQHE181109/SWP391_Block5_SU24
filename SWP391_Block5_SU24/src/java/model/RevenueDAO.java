/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException; 
/**
 *
 * @author nobbe
 */
public class RevenueDAO extends MyDAO{
     public double getTotalRevenue() {
        double totalRevenue = 0;
        xSql = "SELECT SUM(SalePrice * Quantity) AS TotalRevenue FROM OrderDetails";

        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();

            if (rs.next()) {
                totalRevenue = rs.getDouble("TotalRevenue");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return totalRevenue;
    }

    // Method to get revenue for the last N months
    public double getRevenueForLastMonths(int months) {
        double revenue = 0;
        xSql = "SELECT SUM(SalePrice * Quantity) AS Revenue FROM OrderDetails od "
                + "JOIN Orders o ON od.OrderID = o.OrderID "
                + "WHERE o.OrderDate >= DATEADD(MONTH, -?, GETDATE())";

        try {
            ps = con.prepareStatement(xSql);
            ps.setInt(1, months);
            rs = ps.executeQuery();

            if (rs.next()) {
                revenue = rs.getDouble("Revenue");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return revenue;
    }
}
