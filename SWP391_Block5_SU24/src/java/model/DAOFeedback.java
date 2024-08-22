package model;

import entity.Feedback;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO class for accessing Feedback data
 */
public class DAOFeedback extends MyDAO {

    /**
     * Retrieves a list of feedback records from the Feedback table with a limit.
     * 
     * @param limit Number of feedback records to retrieve
     * @return List of Feedback objects
     */
    public List<Feedback> getTopFeedbacks(int limit) {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT TOP (?) [feedback_id], [AccountID], [StockID], [rating], [comment], [created_at] " +
                     "FROM [ECommerceStore].[dbo].[Feedback]";

        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, limit); // Set the limit parameter
            rs = ps.executeQuery();

            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackId(rs.getInt("feedback_id"));
                feedback.setAccountID(rs.getInt("AccountID"));
                feedback.setStockID(rs.getInt("StockID"));
                feedback.setRating(rs.getInt("rating"));
                feedback.setComment(rs.getString("comment"));
                feedback.setCreatedAt(rs.getDate("created_at"));

                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return feedbackList;
    }
    
    /**
     * Retrieves all feedback records from the Feedback table.
     * 
     * @return List of Feedback objects
     */
    public List<Feedback> getAllFeedbacks() {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT * " +
                     "FROM [ECommerceStore].[dbo].[Feedback]";

        try {
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackId(rs.getInt("feedback_id"));
                feedback.setAccountID(rs.getInt("AccountID"));
                feedback.setStockID(rs.getInt("StockID"));
                feedback.setRating(rs.getInt("rating"));
                feedback.setComment(rs.getString("comment"));
                feedback.setCreatedAt(rs.getDate("created_at"));

                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return feedbackList;
    }

    /**
     * Adds a new feedback record to the Feedback table.
     * 
     * @param feedback The Feedback object containing the feedback details
     * @return boolean indicating success or failure
     */
    public boolean addFeedback(Feedback feedback) {
        boolean isSuccess = false;
        String sql = "INSERT INTO [ECommerceStore].[dbo].[Feedback] ([AccountID], [StockID], [rating], [comment], [created_at]) " +
                     "VALUES (?, ?, ?, ?, ?)";

        try {
            ps = con.prepareStatement(sql);
            ps.setInt(1, feedback.getAccountID());
            ps.setInt(2, feedback.getStockID());
            ps.setInt(3, feedback.getRating());
            ps.setString(4, feedback.getComment());
            ps.setDate(5, feedback.getCreatedAt());

            int rowsAffected = ps.executeUpdate();
            isSuccess = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (ps != null) ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return isSuccess;
    }
}
