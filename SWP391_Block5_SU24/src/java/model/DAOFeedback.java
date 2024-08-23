package model;

import entity.Feedback;
import entity.Product;
import entity.Stock;
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
     * Retrieves feedback records for a specific username from the Feedback table.
     * 
     * @param username The username to search for
     * @return List of Feedback objects for the specified username
     */
    public List<Feedback> getFeedbackByUsername(String username) {
        List<Feedback> feedbackList = new ArrayList<>();
        String sql = "SELECT f.[feedback_id], f.[AccountID], f.[StockID], f.[rating], f.[comment], f.[created_at], " +
                     "a.[Username] " +
                     "FROM [ECommerceStore].[dbo].[Feedback] f " +
                     "JOIN [ECommerceStore].[dbo].[Accounts] a ON f.[AccountID] = a.[AccountID] " +
                     "WHERE a.[Username] LIKE ?";

        try {
            ps = con.prepareStatement(sql);
            ps.setString(1,  "%" + username + "%"); // Set the username parameter
            rs = ps.executeQuery();

  
            
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackId(rs.getInt("feedback_id"));
                feedback.setAccountID(rs.getInt("AccountID"));
                feedback.setStockID(rs.getInt("StockID"));
                feedback.setRating(rs.getInt("rating"));
                feedback.setComment(rs.getString("comment"));
                feedback.setCreatedAt(rs.getDate("created_at"));
                feedback.setUsername(rs.getString("Username")); // Added to match Feedback entity

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
    
    
    
    // Method to get feedbacks by product name
    public List<Feedback> getFeedbackByProductName(String productName) {
        List<Feedback> feedbackList = new ArrayList<>();
        xSql = "SELECT Feedback.*, Stock.*, Products.* " +
               "FROM Feedback " +
               "JOIN Stock ON Feedback.stockID = Stock.stockID " +
               "JOIN Products ON Stock.productID = Products.productID " +
               "WHERE Products.productName LIKE ?";

        try {
            ps = con.prepareStatement(xSql);
            ps.setString(1, "%" + productName + "%");
            rs = ps.executeQuery();

            while (rs.next()) {
                Feedback feedback = new Feedback();
                Stock stock = new Stock();
                Product product = new Product();

                // Populate feedback object
                feedback.setFeedbackId(rs.getInt("feedback_id"));
                feedback.setAccountID(rs.getInt("accountID"));
                feedback.setStockID(rs.getInt("stockID"));
                feedback.setRating(rs.getInt("rating"));
                feedback.setComment(rs.getString("comment"));
                feedback.setCreatedAt(rs.getDate("created_at"));

                // Populate stock object
                stock.setStockID(rs.getInt("stockID"));
                stock.setProductID(rs.getInt("productID"));
                // Populate other stock fields as needed

                // Populate product object
                product.setProductId(rs.getInt("productID"));
                product.setProductName(rs.getString("ProductName"));
                // Populate other product fields as needed

                // Add the feedback to the list
                feedbackList.add(feedback);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return feedbackList;
    }
    
    public List<Feedback> getFeedbacksSorted(String sortBy) {
           List<Feedback> feedbackList = new ArrayList<>();
           String xSql;

           // Xác định câu lệnh SQL dựa trên loại sắp xếp
           switch (sortBy) {
               case "rating_desc":
                   xSql = "SELECT * FROM Feedback ORDER BY rating DESC";
                   break;
               case "rating_asc":
                   xSql = "SELECT * FROM Feedback ORDER BY rating ASC";
                   break;
               case "created_at_desc":
                   xSql = "SELECT * FROM Feedback ORDER BY created_at DESC";
                   break;
               case "created_at_asc":
                   xSql = "SELECT * FROM Feedback ORDER BY created_at ASC";
                   break;
               default:
                   xSql = "SELECT * FROM Feedback"; // Không sắp xếp nếu không có tiêu chí
                   break;
           }

           try {
               ps = con.prepareStatement(xSql);
               rs = ps.executeQuery();

               while (rs.next()) {
                   Feedback feedback = new Feedback();
                   feedback.setFeedbackId(rs.getInt("feedback_id"));
                   feedback.setAccountID(rs.getInt("accountID"));
                   feedback.setStockID(rs.getInt("stockID"));
                   feedback.setRating(rs.getInt("rating"));
                   feedback.setComment(rs.getString("comment"));
                   feedback.setCreatedAt(rs.getDate("created_at"));
                   feedbackList.add(feedback);
               }
           } catch (Exception e) {
               e.printStackTrace();
           } finally {
               try {
                   if (rs != null) rs.close();
                   if (ps != null) ps.close();
               } catch (Exception e) {
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
    
public List<Feedback> getallfbyFeedbackID(int feedbackId) {
    List<Feedback> feedbackList = new ArrayList<>();
    String sql = "SELECT f.feedback_id, f.rating, f.comment, f.created_at, " +
                 "a.AccountID, a.Username, a.Fullname, a.Email, a.PhoneNumber, " +
                 "p.ProductID, p.ProductName, p.Origin, p.Material, p.Price, " +
                 "s.StockID, s.Size, s.Color, s.StockQuantity " +
                 "FROM [ECommerceStore].[dbo].[Feedback] f " +
                 "JOIN [ECommerceStore].[dbo].[Accounts] a ON f.AccountID = a.AccountID " +
                 "JOIN [ECommerceStore].[dbo].[Stock] s ON f.StockID = s.StockID " +
                 "JOIN [ECommerceStore].[dbo].[Products] p ON s.ProductID = p.ProductID " +
                 "WHERE f.feedback_id = ?";

    try {
        ps = con.prepareStatement(sql);
        ps.setInt(1, feedbackId); // Set the feedback ID parameter
        rs = ps.executeQuery();

        while (rs.next()) {
            // Create Feedback object
            Feedback feedback = new Feedback();
            
            // Populate feedback object with values from the ResultSet
            feedback.setFeedbackId(rs.getInt("feedback_id"));
            feedback.setAccountID(rs.getInt("AccountID"));
            feedback.setRating(rs.getInt("rating"));
            feedback.setComment(rs.getString("comment"));
            feedback.setCreatedAt(rs.getDate("created_at"));
            
            // Set Account details (if needed, add them to your Feedback entity or process them separately)

            // Create Stock object and set its properties
            Stock stock = new Stock();
            stock.setStockID(rs.getInt("StockID"));
            stock.setProductID(rs.getInt("ProductID"));
            stock.setSize(rs.getInt("Size"));
            stock.setColor(rs.getString("Color"));
            stock.setStockQuantity(rs.getInt("StockQuantity"));

            // Set Stock in Feedback object if your Feedback entity supports it
            feedback.setStockID(stock.getStockID()); // Make sure the Feedback class supports this

            // Create Product object and set its properties
            Product product = new Product();
            product.setProductId(rs.getInt("ProductID"));
            product.setProductName(rs.getString("ProductName"));
            product.setOrigin(rs.getString("Origin"));
            product.setMaterial(rs.getString("Material"));
            product.setPrice(rs.getDouble("Price"));

            // Set Product in Feedback object if your Feedback entity supports it
            feedback.setProductID(product.getProductId()); // Make sure the Feedback class supports this

            // Add feedback to the list
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

    
}
