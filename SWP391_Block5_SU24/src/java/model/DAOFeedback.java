/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;


import entity.Feedback;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.MyDAO;

public class DAOFeedback extends MyDAO {

    // Method to get feedback with related stock information
    public List<Feedback> getAllFeedbacksWithStockInfo() {
        List<Feedback> feedbackList = new ArrayList<>();
        xSql = "SELECT " +
               "S.StockID, S.ProductID, S.Size, S.Color, S.StockQuantity, S.ImportID, " +
               "F.feedback_id, F.AccountID, F.rating, F.comment, F.created_at " +
               "FROM Stock S " +
               "JOIN Feedback F ON S.StockID = F.StockID";

        try {
            ps = con.prepareStatement(xSql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Feedback feedback = new Feedback(
                    rs.getInt("ProductID"),
                    rs.getInt("AccountID"),
                    null, // Username can be fetched from another query if necessary
                    rs.getString("Color"),
                    rs.getInt("Size"),
                    rs.getInt("rating"),
                    rs.getString("comment"),
                    rs.getDate("created_at")
                );
                feedback.setFeedbackId(rs.getInt("feedback_id"));
                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return feedbackList;
    }

    // Method to close resources
    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
