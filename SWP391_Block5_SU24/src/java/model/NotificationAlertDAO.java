/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import entity.NotificationAlert;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class NotificationAlertDAO extends MyDAO {

    // Method to get notifications by account ID
    public List<NotificationAlert> getNotificationByAccountID(int accountID) {
        List<NotificationAlert> notifications = new ArrayList<>();
        String sql = "SELECT notiID, accountID, notidate, noti_message, noti_status, noti_path "
                + "FROM NotificationAlert "
                + "WHERE accountID = ? "
                + "ORDER BY notidate DESC";  // Sorting by date (most recent first)

        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, accountID);
            rs = ps.executeQuery();

            while (rs.next()) {
                NotificationAlert notification = new NotificationAlert(
                        rs.getInt("notiID"),
                        rs.getInt("accountID"),
                        rs.getDate("notidate"),
                        rs.getString("noti_message"),
                        rs.getBoolean("noti_status"),
                        rs.getString("noti_path")
                );
                notifications.add(notification);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return notifications;
    }

    // Method to add a new notification
    public void send(int id, String mes, String path) {
        String sql = "INSERT INTO NotificationAlert (accountID, noti_message, noti_path) "
                + "VALUES (?, ?, ?)";

        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.setString(2, mes);
            ps.setString(3, path);
            int rowsAffected = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void markAllAsRead(int accountId) {
        String sql = "UPDATE NotificationAlert SET noti_status = 1 WHERE accountID = ? AND noti_status = 0";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, accountId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Method to delete all notifications that have been read
    public void deleteReadNotifications(int accountId) {
        String sql = "DELETE FROM NotificationAlert WHERE accountID = ? AND noti_status = 1";
        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, accountId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
